Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07570C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92ED20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Ci4neGQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92ED20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZX0I-000620-Q7
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZWxH-0004da-6b; Fri, 15 May 2020 05:48:35 -0400
Received: from mout.web.de ([212.227.15.3]:56455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZWxG-0003kk-08; Fri, 15 May 2020 05:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589536108;
 bh=9tGhd5Qz3eEm8u/RyCyfa9bQh+J3qYYyN47kYewIWKw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Ci4neGQWWzp/s1h6NtclM2aWD4o1/oxAqLFIZPtZyWta9kmVJVQ0o/bFD0r9yejiq
 N9GZuMC3KaTiuK/2awMky/8gQBVgAEl6xv4urEXVCBdCFfsB5DCTRfUYktnYw5ez4f
 uy7GiuCw7m9w7ME4wQX59MGsTHYEkYAI/Yxh16ss=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.164]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXjex-1jcSwW399z-00Wr7B; Fri, 15
 May 2020 11:48:27 +0200
Date: Fri, 15 May 2020 11:48:18 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 3/5] block/nbd.c: Add yank feature
Message-ID: <20200515114818.25d9eb9c@luklap>
In-Reply-To: <20200512085458.GE1191162@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <1e712fa7f08e4772c2a68197a851161bee51610f.1589193717.git.lukasstraub2@web.de>
 <20200511161909.GJ2811@work-vm> <20200511190524.3681e58c@luklap>
 <20200512085458.GE1191162@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3FnwuqdQcG_Pb7FRcBWz6S=";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:hjKZMFJ5SB8AI26mTGD3uEx8FxubWFPFAZi8y1ivGLzGgJpX3nh
 6TZ9DqpQXaw0TkUMp54Yh1LoPl4VQD7QDDFrzHWzgPiKBCn7mqfiO1kSwykBM5fdc1Ct3OL
 WeEhbdNKjxv4fuDyx74IemQbu0rqHDckf/WWbCtaos9gDCevygI8DF3FzOxhPZ4HL5WfMqA
 FGYUMYifywA059BOsDe6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Aoazy19FTaQ=:xz2nB8SDNhhrdBZ1IwiT/D
 8A3q1O7zJXRDzaldkcHIJgpjh3FJtIL2uKbVaDsZzS2ohKwL+we3s3yN/S+wNFeFQVxl1iffJ
 aaSxfOjQXJhHwrQkCYKx8SUn+WovuhlIy27IHsSoZTkXX7H4t7WHEIqYAjRu360aiVTYkHLWX
 1tLeIoH+A0/j8oFovcvF8Ep0hAfIE3Sx2+OzGu6Xe79eU3pBUNXR51Ea7x85jL5yz/hiPA5bM
 /scrhC6s8mv5Lx+ou2h9txl1V4GCGO8MQ52g4eUESkv6JNyZ8//gI/on0yQeDiJV5LVkAJl+q
 xdfQw4GkEWRIHUns3Fbq9VREov6DEZvjRx7CqY9FZxIpmBsLasrwaw75awuyRs//8/edLs31p
 vNRH9IHFZtac8j5FXcq9CPb0c89H8HYOSA0zM3wxviMpDOenpBZytKj+VJm9ZoukYzzsWUmBG
 GSFnMrWfwHTD/J+vrElj2nYMKZTNQBcmN/bTFOW63T8djgJ3BM2vfIHZq0AlM1rrTHNdlNqjS
 aMFQLAtmcIDlGp7UoKRny8IzzEG43ZISRXeGInrpP/JbqV/J/JELV3dmncMhRBNYMAUSrmpEx
 ZfVYlIzXTzk2Kt7GqBLF0kqMYfOj359dFE/t5EXvGK9le8jySZn2g+l4Qc0eYv/tq2s72Uf19
 U7I83AskyMm1wDuUEsHHg2lkgFoMQGSBJcfPxhm+EzG+mD8fcn1cc0o8llThllLWaVpR6Osax
 0/jvSkB/dNha/Tr5bRTwp/TWknMLKMmXhUYGqTjJUp6C/6q/xaPH+YihM9UkZ9OK1PavmkLfL
 zlAxpP6yqTVhv2YF4TFt0H/hcWSpqgWx+dEGrClzYgTuXaHgoaxMmlmfMQgbo7OyeLV6w2TQQ
 i67wNDSn+X1Bp9kGWwQwkdImW0m1ToV2zqW3+IpLi+asnMw70/ebBYO0bjqhHtP37Sdl1tEIw
 YvLvjhz6aUCA7yTVm//pWKH8mIkL94jOvNlwk11qTXcy6biVW6fetFu1ce0ISDxDvtIxP3Vyw
 mPPvAn3LjbgpyTq4K0n7kjE+emQC+RCZRChrrSl46pectz2hno9Z2HqCJYlHS9j4Ky+mBeElB
 tEv10tzX+oUXyl2NersvdFBYLPiy7m06RroBOPJsI07IaNAwnoAvWL0XCdtjfalEMuIAtds4y
 OlGhixqsePzK9u+dhBx//vB/l3hm7o6pMGQGRcvLWtGCogH2XkQw290ZdsjobXnzC9vPxClZu
 bBl6eXPMssKtOnB47
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 05:48:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/3FnwuqdQcG_Pb7FRcBWz6S=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2020 09:54:58 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, May 11, 2020 at 07:05:24PM +0200, Lukas Straub wrote:
> > On Mon, 11 May 2020 17:19:09 +0100
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >  =20
> > > * Lukas Straub (lukasstraub2@web.de) wrote: =20
> > > > Add yank option, pass it to the socket-channel and register a yank
> > > > function which sets s->state =3D NBD_CLIENT_QUIT. This is the same
> > > > behaviour as if an error occured.
> > > >=20
> > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>   =20
> > >  =20
> > > > +static void nbd_yank(void *opaque)
> > > > +{
> > > > +    BlockDriverState *bs =3D opaque;
> > > > +    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
> > > > +
> > > > +    atomic_set(&s->state, NBD_CLIENT_QUIT);   =20
> > >=20
> > > I think I was expecting a shutdown on the socket here - why doesn't it
> > > have one? =20
> >=20
> > For nbd, we register two yank functions: This one and we enable
> > the yank feature on the qio channel (see function
> > nbd_establish_connection below). =20
>=20
> As mentioned on the earlier patch, I don't want to see any yank
> code in the QIOChannel object directly. This nbd_yank function
> can simply call the qio_channel_shutdown() function directly
> and avoid need for modifying the QIOChannel object with yank
> support.

Hi,
Looking at it again, the problem is not with registering the yank functions=
, but with tracking the lifetime of it. Suppose we add qio_channel_shutdown=
 to the yank_nbd function. Then we need to unregister it whenever the QIOCh=
annel object is freed.

In the code that would lead to the following constructs in a lot of places:
     if (local_err) {
         yank_unregister_function(s->yank_name, yank_nbd, bs);
         object_unref(OBJECT(sioc));
         error_propagate(errp, local_err);
         return NULL;
     }

If you don't want the code in QIOChannel I guess I can create a subclass (Y=
ankableChannelSocket?) of QIOChannelSocket. What do you think?

Regards,
Lukas Straub

> This will make the NBD code clearer too, as we can see exactly
> what actions are performed at NBD layer when a yank happens,
> which is what David was not seeing clearly here.
>=20
> Regards,
> Daniel


--Sig_/3FnwuqdQcG_Pb7FRcBWz6S=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6+ZWIACgkQNasLKJxd
sljIJw/+JWGvHZIjyO2KkgZM4+P2KB3tD+Sn0aLM/yIi2gjGDbDaZ5J+02+kE8pk
qzTq8UaVeUXYHoB630jne2uZoM52qdbdalCpujqf5fUIMcJ6oV4GJNVHfVxZWX3i
W1jff9zqM2p0wNcLl76bQp7OvKFL9G+MbXUOFwimkhfbl01nlF6wE0Xy+v8q+UHa
bQ7COHp3U07kNkCEkHUAfUwm5i0DaoU2s4eEvli59UmNFgUGrbhIptq58fk7yxJm
ya2ernEJoJ3nfL0bjym6m2WwL19E9y4SCFKntOWjGHAo0Nl0337kcQV3ZvKfF2Jf
ng5OTcyuhLvX4yJPiSvDPIptSopgCvQcNEElRFrbO3Ro74Qe4cjmzG8F3weKuQUZ
tvyZtWLOpUzasBvjcyUeOfPWvMLjZXR8ziPBhTX5zNcRNpAMRb1PeZFPL3UcfSz8
dEpSb/RsLLz/mx2TlU6p48QifFfrKMWEsVvNLlWJYp/A3VCEnoPKbyqchP5ps3e7
vi/QYS2250nJAEjC1xRatNGUA6zDXmidbQEuOTOToM646yd7LW1jMCK35O07CMh9
FK/0jDEDW1+SN0h9n1xYdCik+NyApChMWXuFkIBe5aGP2GdoMUpNa7IBqeFICsEM
zhpUg5RaSbJmGyjVrUBQJl5VjbZmlEt4gQr0dQh4A3Nc1Ipq9jw=
=NG3w
-----END PGP SIGNATURE-----

--Sig_/3FnwuqdQcG_Pb7FRcBWz6S=--

