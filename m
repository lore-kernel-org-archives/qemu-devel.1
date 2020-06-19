Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29255C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCDC20734
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Y32t8rWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCDC20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKQE-0005ao-1e
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmKMn-0004PV-K0; Fri, 19 Jun 2020 12:59:49 -0400
Received: from mout.web.de ([212.227.17.12]:51337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmKMl-0002uF-Pr; Fri, 19 Jun 2020 12:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592585980;
 bh=EK8bUs7cX7l7gntRfnub0oQ24EKFk1cmaQ+bgmkDc3E=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Y32t8rWQOW1SRp8xtXlSZPcoU+KIAkFpiYbfRUqTHeDjwjF9W7cHE6iBgYMyptdKy
 RAN2bTP2XIvemNUKdcLzQ6OkY6s3/VXyTonyZA/zuW+5pC02pK+fUusqITk+ZJjtfV
 vPWhyrsDDe+KMvIQkv+25GLiG8RMcwf+OsI+KOcw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.165]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLxs8-1jnQoq1Se4-007p3z; Fri, 19
 Jun 2020 18:59:40 +0200
Date: Fri, 19 Jun 2020 18:59:28 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH v4 1/4] Introduce yank feature
Message-ID: <20200619185928.348ee60c@luklap>
In-Reply-To: <20200619165240.GB700896@redhat.com>
References: <cover.1590421341.git.lukasstraub2@web.de>
 <dc2724aead900db8fb3bed0a066f7c7e2654edb0.1590421341.git.lukasstraub2@web.de>
 <20200617151240.GM1728005@stefanha-x1.localdomain>
 <20200619182924.7898035e@luklap>
 <20200619165240.GB700896@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FSsE7ai7lQpOEE22oj+qpNi";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:zHaU64oo/QjgIyD9AVgKP8ucpQbsQwc2H+FSS2prLeZq23KAgEP
 OglrHnbeCVSHvMmj0w6Z+L2krO2GQTQibJfPfSVCxoZYvl/uwXiXE0lPbqNx3bVMS02mfDX
 39Y4V3ApxPaUkxcCkTxiyLjAZ+VE1z67OYL/wpmFshOM+GILqN8WB5u9IC7yxhFc6EE1Bvx
 d8fevxLPq+7SDMO5WhDQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hOXptRNcQhg=:ILs+OrDU4Vk1+bSoKjRKS2
 JGLOoHvhVN3K7DK1DndlNMQvPgJDZlMJv0jvwLdydXu+frXmfjSy8TITbYZWy65ZK2lJ+1ixe
 ro0GoKFa5yNoobGdXN9ympkhOUTjF1MoQW8r9aXxXlMg7SFwLnpbPKpMffVBmucNmxkbJ5aTj
 FyfI+nnl0owGg29TPBceS+/+jIRoP6daO3jzH4WAHUknRz25AGcMuOrfI0tc2Ye8UxJAADlCE
 jMKyuiTnIbvB9+3arjxUo5zcMje3SwoikwG1XCGkGAmNaYl1RY++xnVqaGGbwdZ76ZmWf0T9X
 8wxchmyW56ykBb92yv5KfGnV/Tf2AZu5seKvFpnLh/ht6qo399mB/ZeSPxfXnLhgabHwCpxqy
 4iONu88p4S5xYlQcX9RdtSVgqD/Ha1nrIbX6ZnmLl1iMx+dvtcX3eeiVJbthQF05P1xFmN0nZ
 GNsCGMl6RBamRDPnoKrwlI/6GqQE0U/Rne3YkhWuF/bllDOsdLxwoqqfovaxP8lf/z47H+sJG
 J1GlGFmMlL/jEmGCkHROn8FfN9WQrhnP7DVIgpylFc7NHSGVxm4q4jBsISj5Xr49jTSMe6TL6
 yJwSq8Sf4YjG/JS34qLIj48hIrjmO8OcDjN7mit7snpyiDKldraMvo9slGC27yeYk5Cjfrch6
 1F+hKE8JqAiAjc4oFbjX3lmWAg6WV9Ah5kkwXdzD5ygbV+bzFXDtm7Rpgwdw3GuePcAG0kaR0
 C5tzEqsc01aGO0pgPSV+nQAlsqbageK5WWyJU1T5WFsif8+1v7p7OQ+m+0FVGWrLFRc/rzuUJ
 ewzrLekwhOsZPdvvTLSNFBcTJAdgGJbCs1sBDSOko96s8lcy9TKt/OvCIYzs4MMnMbxMhK2at
 IGoFEro59mFnKI7YwcdkJnsZZWM2t9SO644esqqq7z7694eWpMZxC5n8MC/94rDqGNRLn01bh
 +jAYLL6TD5001X79Ye9FV2gr/mi+0DLu+tikzbr88GbTDaHRucZuOMVI3DtnCxiSybDqMHMxL
 b3kSS+vElspcAy3jJ6XpIIRnJvLPPFSC7mjvEaZJcdtFNTwsmHn+P+wfAdti/uIkcrKJUQvy5
 l6rtZiaBx8qzlGFEWGJOa8XwlQTI69TKxbL9PoFIjJAKlOKKx2I0kM/smOjiLwHn2mtJ2uESA
 9BHofcA05o4PBR/vu7mbCelUC2q+PJYNp/wqGElLqojzzUt9HoZGLeJdGJw8fUKkr3pvXTbGk
 gNiWHsO0OWDQzbN1v
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 12:24:12
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
 Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/FSsE7ai7lQpOEE22oj+qpNi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2020 17:52:40 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Jun 19, 2020 at 06:29:24PM +0200, Lukas Straub wrote:
> > On Wed, 17 Jun 2020 16:12:40 +0100
> > Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >  =20
> > > On Mon, May 25, 2020 at 05:44:23PM +0200, Lukas Straub wrote: =20
> > > > +static struct YankInstance *yank_find_instance(char *name)   =20
> > >=20
> > > There are const char * -> char * casts in later patches. Please use
> > > const char * where possible. Callers shouldn't need to cast away cons=
t. =20
> >=20
> > nbd and chardev generate the instance name dynamically so it
> > needs to be char *, but in migration it's hardcoded. =20
>=20
> I think you're looking at it from the wrong perspective.
>=20
> The yank_find_instance() method never modifies the 'name' paramater
> that it receives. Therefore it should be "const char *". Likewise
> for the other yank_*()  methods in fact.
>=20
> The caller can have a char *, or a const char * as suits its needs.
> Either can be passed into the yank_* methods and will gain const-ness
> from the POV of yank code.

Makes sense, I will change it in the next version.

Thanks,
Lukas Straub

>=20
> Regards,
> Daniel


--Sig_/FSsE7ai7lQpOEE22oj+qpNi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7s7vAACgkQNasLKJxd
sliSLA/+JtiXBpIl5iZUT0/3vxALtSyTvaT+dFMYPtIs93bHd6smEFx0o0qwWqfn
jWRQE/0qZB5BjrgAPfaksyZALP/R3Bv17YT5y53k80IKkRypQ/MzlgUJFD3+btP/
mV3p6hCFHoHrRWhLqdItBaTfw2GNx+WTuMKADb+tzFf+ro0e7oqc1wO84vBt5vBA
Mc3KRAh33RFI7AUuY3FKeX6EYU3TPy3BlvgccjOmxW7E84W3Fs1gxfvztMcqiluO
aw81ShaxQu8/aPPcYn/MfCkNmwPjmAKDYz4GmCtLvQNmPeyjOCi60w3L/9Kz56tz
TrFSuyf48RJV9n5NVzB0+n/OW4lHaOEmayFzpcvRmwVOrQAOLAkH4tX8UDLQUZxx
AjFDWlnMSvNAo4FO/ElMHvn3tV2b+8ZO1PUztBbKnapnW7xmwXhWam+Xrm/jqt9t
jy5rLiC7t84guPWqXFtXzMPK7Yl+okMrODN+J3bJvWy2jnCT36fehZSfhkplpr5f
1OO6cfBQYyjXUihJHn34VfcJXg4uSIDs9Qmz0Ipc2Sgxai8D6ojmFKvRPixxw2qA
/dmJi93sPs+kPJZPvBhvq1WaXrrVe6cl9QpOR08hIlSGZo92UB4328gju9p+6TU/
zyNbE8l5tdpLulabO7OtlA/2KcPxdOQYy062gbNhmIoXO+sDU50=
=4flk
-----END PGP SIGNATURE-----

--Sig_/FSsE7ai7lQpOEE22oj+qpNi--

