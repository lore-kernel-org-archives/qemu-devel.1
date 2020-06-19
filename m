Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA83C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D372078D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="C8mhMan+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D372078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHzt-000676-7G
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmHw8-0001ha-Bb; Fri, 19 Jun 2020 10:24:08 -0400
Received: from mout.web.de ([212.227.17.12]:48159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmHw5-0006ms-SW; Fri, 19 Jun 2020 10:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592576639;
 bh=jTYgnLTcA1b4xag4e2EeI+/pze8dVIAdp39LDVhEhhQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=C8mhMan+zhEBeVb/FCe0sfRG8oxS1AToP2uvzqYT8ngBTt7UVfUPQG74Hf6UvBjAT
 BlPtwbnlQBnn1qh6BTVgY2qYg4xFrbZDNPBrmDCS9RjQES404UjkaBFu3H72jIqfpA
 1tIQGK5Qr1PmRrBHJzal7WuhmUbxDlAhn2CXtFWs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.165]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GN8-1jalbF10Tm-00Cf7s; Fri, 19
 Jun 2020 16:23:59 +0200
Date: Fri, 19 Jun 2020 16:23:50 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH v4 1/4] Introduce yank feature
Message-ID: <20200619162350.5a1cb518@luklap>
In-Reply-To: <20200616143957.GF550360@redhat.com>
References: <cover.1590421341.git.lukasstraub2@web.de>
 <dc2724aead900db8fb3bed0a066f7c7e2654edb0.1590421341.git.lukasstraub2@web.de>
 <20200616143957.GF550360@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DaMAwGF/S0Eh5XQLd8Kofq/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:SyICsNIVNBd2nt1X5QYEJBpAejag7Qdb+5djTRKiwk9HYdfz9Gl
 c9ekERku40EX5m6I7fPX6EA5I1MIhVujcDvX7oa0SknbbtIVgS7SDpmTDdQttbDBpcWRln7
 lxGX10LDE1hOzrIn2WIvvwLUIMEwbHSYEzzDVOz5b+yh/yn8C6y6XeRd80UtfCI8afQoyxC
 8oXQAtvuj5uYonrwCCeCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XmP0UyFnRdU=:uVzqOKX+1vS9QIVp7TEHbC
 SxBDd21XO6Op6PxaDcUn3GwB12NYbq7bJqyjDgYATeBy44howwwDUQ1Y4l9IxcLJVQ494sF+O
 uF5ieGu1m1sOv2YE/rwrFjlYf+A+g2uDwUPlrEIAC4cAt5T6UUq1JVpOQeSmaG+YyNwuc7XZI
 PhIS9SirAfu/k7YLk84Tkz2bfSBdCdTdhUz64TaAuMzGQg7G8lZ3ScnBnhb4XCoRxOHIKMZfS
 solq0Adg0GZFzhxaJ7XTAAjvY1mELk2nzjxyS1v4enMltBNcPP93wmNAWq4lUwl2HVxLOvkT7
 uwsdHZKGZsr2E1TeFaYjSxUeS7ZxhCGtctZ2ETEH+In4r36+0pEe3heFa5t1S8cLC+vgfKYy+
 AzNxMNRmlek7L02OwpI167CFbLwJ9XlBYmu3tSePauDa6zHTQCiY25BClqTUXNcMm52RHQHmG
 RsU6KZBRzh0nF3Kzy9/YHGf/ZvBeR3TRzwLNoKdjotHaJrEwLPsXMcoz/geUnbJHtY+Mk698y
 HsYzdd2BWdum3wr9F3Abn/L7fbmlNv8cmTwuMvT/yp6hRMvYBuzFa1G9/QGsmySNcJZtcvxdI
 ojyP45lau5G90KawsFT49AMLw0dcgahYEB+4qxsPa/oLtSJOCd7jqwWSbGc1FH1XJKh0sYL4B
 qpf+wnSJO1S/Tt0X6Gj1wRe1Csn0KEGKljszCe10hmPzmz+e2NRkbPvf49ZgfzOZ6KsNdL39Z
 ZgqrJUt2rVSY3dU2Gh6sIgSRDEk3E9NZP7GBZD1SEzqvNqEIFYU4aYe3QuClNXNYOS/9Syr4V
 b8O7TI5D6AGm2OZFv5bsTopxCXKnSOZ4fd3vnlO7xbtrpTyPeIWt1Hq9jb95DT8XYVMGwk2Ty
 N0bcaA12JwoTAINaFlbPPVmKXGVb/vx5gcdWe8dt5WhkQQZU7rGfdMqBeAYX/X4mdy8tWSMiP
 0DOIlLBIFdnhmR0Wj0Qx8Y2QWvzUZ1QqxdKlV3ZBLNt7p89DiD5LXhdt3WRv/vCluIJ8UC0/D
 Nlo2zP1CPt7r+YfgofABiRWYIdcKUGvWw0+PtZ/evOcK3dHTJrSR6JVq4MkgBmoSnVSM3prkL
 f5Nh260NoISa+5LVZ2j9mmnlrqRT8DiHqP7Q1yTBK33vZzeqUrOVbGUkplDYeUhD4gz2Wod+2
 dG2gjgs7B//KliC1GuoIDhLx/DRXTm+QZr/dQrzZS5KJA2CmhlACsVTNS6B0yq0cNPG1v3a9l
 r69CGXvjxiFxQHRCs
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 10:24:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/DaMAwGF/S0Eh5XQLd8Kofq/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jun 2020 15:39:57 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, May 25, 2020 at 05:44:23PM +0200, Lukas Straub wrote:
> > The yank feature allows to recover from hanging qemu by "yanking"
> > at various parts. Other qemu systems can register themselves and
> > multiple yank functions. Then all yank functions for selected
> > instances can be called by the 'yank' out-of-band qmp command.
> > Available instances can be queried by a 'query-yank' oob command.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  qapi/misc.json |  45 +++++++++++++
> >  yank.c         | 174 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  yank.h         |  67 +++++++++++++++++++
> >  3 files changed, 286 insertions(+)
> >  create mode 100644 yank.c
> >  create mode 100644 yank.h =20
>=20
> > +void yank_register_function(char *instance_name, YankFn *func, void *o=
paque)
> > +{
> > +    struct YankInstance *instance;
> > +    struct YankFuncAndParam *entry;
> > +
> > +    qemu_mutex_lock(&lock);
> > +    instance =3D yank_find_instance(instance_name);
> > +    assert(instance);
> > +
> > +    entry =3D g_slice_new(struct YankFuncAndParam);
> > +    entry->func =3D func;
> > +    entry->opaque =3D opaque;
> > +
> > +    QLIST_INSERT_HEAD(&instance->yankfns, entry, next);
> > +    qemu_mutex_unlock(&lock);
> > +}
> > +
> > +void yank_unregister_function(char *instance_name, YankFn *func, void =
*opaque)
> > +{
> > +    struct YankInstance *instance;
> > +    struct YankFuncAndParam *entry;
> > +
> > +    qemu_mutex_lock(&lock);
> > +    instance =3D yank_find_instance(instance_name);
> > +    assert(instance);
> > +
> > +    QLIST_FOREACH(entry, &instance->yankfns, next) {
> > +        if (entry->func =3D=3D func && entry->opaque =3D=3D opaque) {
> > +            QLIST_REMOVE(entry, next);
> > +            g_slice_free(struct YankFuncAndParam, entry);
> > +            qemu_mutex_unlock(&lock);
> > +            return;
> > +        }
> > +    }
> > +
> > +    abort();
> > +} =20
>=20
> Since the NBD impl no longer needs to register multiple different functio=
ns
> on the same insance_nane, these methods could be be simplified, to only
> accept a single function, instead of keeping a whole list. This would avo=
id
> need to pass a function into the unregister() method at all.

Multiple yank functions are still needed for multifd migration.

> I don't consider this a blocker though, so you pick whether to do this
> or not.
>=20
>=20
> > diff --git a/yank.h b/yank.h
> > new file mode 100644
> > index 0000000000..f1c8743b72
> > --- /dev/null
> > +++ b/yank.h
> > @@ -0,0 +1,67 @@
> > + =20
>=20
> Missing license header

I will fix that in the next version.

Thanks,
Lukas Straub

>=20
> > +#ifndef YANK_H
> > +#define YANK_H
> > +
> > +typedef void (YankFn) (void *opaque);
> > +
> > +/**
> > + * yank_register_instance: Register a new instance.
> > + *
> > + * This registers a new instance for yanking. Must be called before an=
y yank
> > + * function is registered for this instance.
> > + *
> > + * This function is thread-safe.
> > + *
> > + * @instance_name: The globally unique name of the instance.
> > + */
> > +void yank_register_instance(char *instance_name);
> > +
> > +/**
> > + * yank_unregister_instance: Unregister a instance.
> > + *
> > + * This unregisters a instance. Must be called only after every yank f=
unction
> > + * of the instance has been unregistered.
> > + *
> > + * This function is thread-safe.
> > + *
> > + * @instance_name: The name of the instance.
> > + */
> > +void yank_unregister_instance(char *instance_name);
> > +
> > +/**
> > + * yank_register_function: Register a yank function
> > + *
> > + * This registers a yank function. All limitations of qmp oob commands=
 apply
> > + * to the yank function as well.
> > + *
> > + * This function is thread-safe.
> > + *
> > + * @instance_name: The name of the instance
> > + * @func: The yank function
> > + * @opaque: Will be passed to the yank function
> > + */
> > +void yank_register_function(char *instance_name, YankFn *func, void *o=
paque);
> > +
> > +/**
> > + * yank_unregister_function: Unregister a yank function
> > + *
> > + * This unregisters a yank function.
> > + *
> > + * This function is thread-safe.
> > + *
> > + * @instance_name: The name of the instance
> > + * @func: func that was passed to yank_register_function
> > + * @opaque: opaque that was passed to yank_register_function
> > + */
> > +void yank_unregister_function(char *instance_name, YankFn *func, void =
*opaque);
> > +
> > +/**
> > + * yank_unregister_function: Generic yank function for iochannel
> > + *
> > + * This is a generic yank function which will call qio_channel_shutdow=
n on the
> > + * provided QIOChannel.
> > + *
> > + * @opaque: QIOChannel to shutdown
> > + */
> > +void yank_generic_iochannel(void *opaque);
> > +#endif =20
>=20
>=20
>=20
> Regards,
> Daniel


--Sig_/DaMAwGF/S0Eh5XQLd8Kofq/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7synYACgkQNasLKJxd
slhZ7A/+Jy9eh5Sp9HEHYvwws8VM9gri/chd95l+0wbBArBjhxLkXsagsJdrO/oF
unr4RYtJoi6Ibgg/DUclnkacavwLaYjZQtLvwJ+8KCYpHDkzl+1zqbjhSJ6Nt6PW
dX0/DUkuxuyCWnQYikxewSSAAIbAGPhAywHbwjw7MY7EXXXyCPzKdLlw3uiibTI7
riqxHYcx3ryDkQRkzd6b543IQ1NYBhrmXuatRqUYbW1dpjURw1ZOOzssS0GNxnHg
7C54z2PaL23uv4b/g5dJCvbdLn1QaO1FC3/5PbWd6dasBj8bY/4f7xBm6jvrC3/8
Dcliin3WN/JfIW5o+fjW+RogYkraF3oyLk4mK8ZJs0TjJNcOohH2CjMeFuyvJrL7
dYviWgupO5XDXs8ycq3K3xoIJyrbEIDkZ4Xvstoab+9EUzWfXpHFAaAjDSDZ6Q1T
MUFmEeof4kPBDK8uIJZvqzXSnSV/V4ETS6eLDQ1v7Vympi3tWFtZNOak9JoLsv+S
lshuZvLTqr94BU2uONDky8YVLdJRCBW4M1wC6Bokuiz1gk3tjo454JjNmK4YMxsH
asaGabHELznG65HuWgqRKFhx9suREPTWG/q9Tj/3XoOYw26kXmDabCPjxy3b5Z04
mlFePcVguI3n36vN0/RaNysRL78DenXVfbiV5djCjg5TbbjyKj4=
=CnMu
-----END PGP SIGNATURE-----

--Sig_/DaMAwGF/S0Eh5XQLd8Kofq/--

