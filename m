Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF375C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD97921707
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DVMUO3q5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD97921707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJrP-0007BL-Qi
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmJoO-00056u-N5; Fri, 19 Jun 2020 12:24:16 -0400
Received: from mout.web.de ([212.227.17.12]:52315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmJoM-0004rN-Qf; Fri, 19 Jun 2020 12:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592583848;
 bh=zslMZHe7YmxpzuGgsn/syZOsgLS+tkkDW8kZZz1WDsY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=DVMUO3q5uMjXj2sfgtFyRCus8hIp1zsQYXJGWMNL709MAu7F/sfCjaQnVMXRMPZuT
 fsDg7wh7cUog50Ev46+Y5n4+Z1EQZ0Gtt9VG2sRCj0ATiFkJPaweIDzxIZf0NyzLQg
 w9pzyeDAzxL26zBTt3doW0FmU/cG5VetFBRAkcxU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.165]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNwjS-1jWsQS15U8-00OTLG; Fri, 19
 Jun 2020 18:24:08 +0200
Date: Fri, 19 Jun 2020 18:23:51 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH v4 2/4] block/nbd.c: Add yank feature
Message-ID: <20200619182351.549ea836@luklap>
In-Reply-To: <20200616144406.GJ550360@redhat.com>
References: <cover.1590421341.git.lukasstraub2@web.de>
 <8e6a8e61b25813cdcdf385729709ef57f6255a3e.1590421341.git.lukasstraub2@web.de>
 <20200616144406.GJ550360@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SyEbWl07Zt+A07gIcpSDj_d";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:JFfobidk3+7VtB44PHao8cQpDULCz2ABqkWntVcZSxdJWuj8dRj
 cLozX/ZDAIwu/vjoarFhBGFaIsjQ26WFsVXF3I8MpuEYBztd1kyzx/T5yDTWaYMSDR7bOUl
 8vJBc1eQJOxMtoPj6OsC/6HHN6IDTq49v0/hMlm0gN1ibN6D0W/ObUog9hg7N5stj9oTb2Z
 U6KIj6vanncMfYhWzkDCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q91GwYWR7VU=:aLyppLjRXcWcAGxStMMu0Q
 6rj550cRsYvX9AZgUiTyQsvAMeK3L3kJHl+2G/JZ9iEUcrGHuZ7PTaSdnN93tZhCkYWueh+M9
 MqIc6PfXfln9Yo6lWmRzlxsnSii6xcfaTqYGgZjwo9GJ3vZ1sev8ZD0RxQTgS4zTxyMDZdBnJ
 3eIScCMKg5ye2jGsEvSA5rldjoqBvLSKgoIpmfPj9VPMB4mCFGvvobhOLv7RsBMOQx0LcHxDD
 N9uGQeA00E+tZQujKEYynaczmU0nsrWK0oVilvkj1q1EwAiCChdQcuTBc4FjzTzU8yeDEw+Uw
 hX6GDB8m+GquAMagkw6UOZaGU38RlsOCnJH6RnIklcvmEEhEbxLGWbDpRZVhHl3+ZbbWe8ITK
 bTeOm5dYjKO2f+8ao5rsJQlJXXUw4DAQtEmNqX+D4keA8ZApjbmvvtXtlt+fD7XQmHmihIk8m
 BoSFSR0PqmNwydMkDkmhqMXYW+6p9tFZBTlCiqQa1GzOf2QHVYAbj86mTFH+xraLQjupX2B5h
 ESu4r9inIEc8g0Y3E1sEO3x+EVm1r/HAXu15+zy64WwiNDFfeXCSKfW8b7ixqUvcFH8VQzBPI
 8vMAPdjdBclGZrYndrOGmQBYZdwlScIXfQ35DPQ7QCKCE+qFnQoaImyNRiEIdjCJ6HWPKGQz4
 qX+eFHXbE2yD4Am40oaoe6/gwfPB1Yk2jTxb64EATje9w2FwJSwwECTj+pMxVpsGPy8i7fTR8
 ijccicXXze2itREctYdIslM5xECKVJ8CXrzRKq08z3bGDQ3oBgDALxgtUd9t2W8p6nv1VfbtD
 Ya30NGqtUX2KJhgGwrwzp8ZIj7Uq5W/wyFZ5kLtgHHXuakqdAi9fW6GDP4cV5eNNYhGHcMYX3
 K/YncNT51jx04nPZTGJ2LvGxQo0NDPa+a0b8ChVR8+4XeNwFken4cu0qPo+ioyylivX6hZo5H
 MyNia7+3eDZ3OOaxm9jFEQwdEqNSG8vUL/k74Gb1ZBL1NmF7220+RDU3AtGlimc1ie0G71uWU
 39GrgsLkB7bxaXYNxAq6KwFy3npwMemamswj2t6vRGaZXG4B/VqcYj8jxkl8y5Mf3avi26jgw
 5O2adrGrzcmQVvoHTV5iNP3ekkborYUJsn57awUVkvsExd2nI58//rrr/gOJePxM14Sm+ugpY
 ed96rbKqH26lgSDc2TOb7B+D7DZmmHecOBGFQBS8q7daD6FwzsvC1ge6CN+hMuq66JNFn9zZ5
 C7pm4+bHmuvawNnjb
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
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/SyEbWl07Zt+A07gIcpSDj_d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jun 2020 15:44:06 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, May 25, 2020 at 05:44:26PM +0200, Lukas Straub wrote:
> > Register a yank function which shuts down the socket and sets
> > s->state =3D NBD_CLIENT_QUIT. This is the same behaviour as if an
> > error occured.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  Makefile.objs |   1 +
> >  block/nbd.c   | 101 ++++++++++++++++++++++++++++++++------------------
> >  2 files changed, 65 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/Makefile.objs b/Makefile.objs
> > index a7c967633a..8e403b81f3 100644
> > --- a/Makefile.objs
> > +++ b/Makefile.objs
> > @@ -18,6 +18,7 @@ block-obj-y +=3D block.o blockjob.o job.o
> >  block-obj-y +=3D block/ scsi/
> >  block-obj-y +=3D qemu-io-cmds.o
> >  block-obj-$(CONFIG_REPLICATION) +=3D replication.o
> > +block-obj-y +=3D yank.o =20
>=20
> Oh, I see this is repeated for migration and chardev code too.
>=20
> Instead of doing this and relying on linker to merge duplicates,
> I think we should put yank.c into util/ and built it into util-obj-y,
> so it gets added to everything.

Ok, I will do this in the next version.

Thanks,
Lukas Straub

> Regards,
> Daniel


--Sig_/SyEbWl07Zt+A07gIcpSDj_d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7s5pcACgkQNasLKJxd
slgNgxAAqVlaZY6nSZkK4EvCZvRD1BdbtXRZhdvb646cOd+M0UMQXk2LgqRMZgYm
LgRya0IEVJwZcdvnSDac6Q5Trxv0lJNj0U78MBOdVPOEh2f5mTB50shklKArllQu
r9YpzgqaNu0SONaQnb9ljs9JRn2weqB/frdZJSK773Ahj/T2350omVsd9Nyjo+xC
sCRmS+JxPk5o/xgh1ZNrpGlURVTFwAp6wJE/A5zfbW+Vk2Rmqt1llH/dytGxE175
lHAPHBOJJOl+IltQRAZ8pRkIpykb2nX69Il+dGReumD3dx7JN1EipQqLQx0JcojK
95TWOCwkJCS2g7tTRac5sUUUD2+sxzTFNDoDtPZXxEXtaX2s1sZ/30Vf99q2vqSH
HQgNUuHPMFAad6TNQFJhwIE8+XWenhNrtZ8+HdTRyC0MG5Hopw1dj7LyHc7eps89
57z238pzSBsTUUpsaj/6l8wkC4/H3UQXX5KtLUzDi/WEPFmo3xzp8+xm6QmzA/Nq
2aRCZbFFWmWKcGDGmURUJo9aaKe/HBp+zrQS459E9btjvcqPeL9JtPPFVIWujFOu
NOnuPDJCYqz3aS7ncgvRYZRa6baObYQGkmxZQyFNm39hpyM9Vl0M9NYdPN9TyinA
47+IObWd0AS9XMuQmEdrDIzZ2K9faOkzvQT2Nb8tGSZImEFqHaU=
=ODnC
-----END PGP SIGNATURE-----

--Sig_/SyEbWl07Zt+A07gIcpSDj_d--

