Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D87C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C3620738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pBcCgBSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C3620738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrMI-0004N5-2h
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbrHV-0004nS-SW
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:55:06 -0400
Received: from mout.web.de ([212.227.15.14]:47509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbrHU-0007i6-4l
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590090894;
 bh=Mm/sZ80B4OX8v7UOmuNfiiAaxnnAiTE8vUt0qwl3O9I=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=pBcCgBSLw6TFgnqIcGyqy8XQ0O2NSVV6+z+3PWPGGVCZRNQBs70X1t6OmY0QwPVTe
 xiGTF4j8OCqELTQNEvmBIkED0jIv9SsUVkq+93wyEBttDQ9VZMW4NpFJAxJVT5ImMS
 ubnN4vI7dlpcNPH2jZK5+OiM1K/Fzh3pGn4VPmQ4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.99]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkyHN-1j1h7516MX-00an9u; Thu, 21
 May 2020 21:54:54 +0200
Date: Thu, 21 May 2020 21:54:36 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH 0/7] Latest COLO tree queued patches
Message-ID: <20200521215436.6e57e237@luklap>
In-Reply-To: <acdef015a5094522af56a40ddf2f5efa@intel.com>
References: <20200519200207.17773-1-chen.zhang@intel.com>
 <158994966578.22651.9229581933394242476@45ef0f9c86ae>
 <ec2f90c69cf54bafa6558fe40b9c2202@intel.com>
 <a23c4678-5e0d-38c6-176b-a400a2f46d06@redhat.com>
 <acdef015a5094522af56a40ddf2f5efa@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=5V_n7uqEeXb2s7LFqAPxED";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:+5ih69FZSc8RZgSfO5FXUIy3iR89EBxvRmKR+9Ig3bu4CV70Thy
 spN+TZojpzUP9n9QYxiI2d3zfzib5mWmRh6NM+DQI3qt2gZ/2XJEBNbJezDH/nSRK2wuynL
 /t4vw2rryPNpg6ToYlkm+68qCyPy/U1iQP8SbJo/5igjdBNR+SANMyiyCI53qKQODPkf+D+
 85SftAz53csnGU81IS+dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nzHTwfDNkNA=:lAG3ubtxVrwMgqhUzCcwqc
 0mD3le9VRJ8tuVnTEdbZnSleyTgTqOFhrSrka/Det49XO3rg8RWydLUchtX58vqC8eNpfdzb4
 EYiZefGFrhOvgs0IZGUPhncjMx6RSyJa2+aB4oRGmSEkpGdiSMSkiy64MFTGjE6ljxt1gTfOX
 J+SWzxDauC04v9amVcWEoj9UWTPltYBamqzXnmPiCei4PiQWiodolFFBqxD87i9ex9DrWi/u6
 qY24/akyW6hSYttREOYQXnhKE09brCMduDIjlMAyuiT6QglVM8DxFQRyxkAXhUd7bJbwGVsC+
 0g8vMaprtivDEDmOXnluChtUfdoHjH6Q8sG9wQqb7VoPHlYhPmFiTQp4y6IOSJRQI2MK8BLT0
 q6koZYO4B6BNO1FWQRM9ZYvCpYK7T/qnlhFf827yhynBZ+cexdzlrH3W+BiQ5YJlRwlbuOfae
 VwdqRmrT1fdTKLLT45bjJdjECr1wQXX7ia5jkuOaXEWe/u+0+98yizLEPGUK7EJ3NwvhCk9lm
 A+l4ZkmTH23y+eW76/r47Np9vgrOey/oS6h9x8J/VhzwOp3ExZe1dLsfN56Of0oMd0c4XedS3
 CZXRG2Ziva6VQY86TOT8WlRBiKyfd8wPDiKqgU5/spxRXrzUZZ/Vi5s7LkCeon22T5/bMG/ah
 hODOt5v/dkXg8PmKsU5dE+DKSfrBs+ncWTFfqF5ZjtK3qKSn4cnS3tohg7NhPBgXMizgeOAtq
 /18J8XL0UiSsAldogctTnv7DFZjMTv06tsCyV3w8oH6tXfMLniQ/TkGOs+T7zDfvUEoOWEJk5
 Ry1SrMf92BbIahWrPJcp62BAYvBf+wInZsIGV8qI2L1nt4y9s3nFXmyBJzO1lQ6MwCUewL8+j
 lVKEUniKltlg0bGxSrzCf+IDhR6kRn+zmbFkOl97bi3mEnhJeFP7AGgat1R7803VWOeqkhMCR
 gXXwHei8+utr/x7lvrfxn/LRd2qHNSQFZ23OdKpAtYDqBUWf5mLGMiGX8hcpc+bgpDr+SUT+k
 75pmvAPTDMOnuM0oKdG4jyb3JuGLed+wv2mdZR8bkTifFdnMUoaPhV4MAz30iGvJ5gsOkt261
 acG3SDwFtbdibk8Pk8wsFQFhcWk3veSgFhLfcCZUpiQTXyR1MeRCjLs4wFzHcixbS/ikJ+3Z/
 dFXc84OShaBIX+yH/JCopXPq5FCuK4OYW18XkaB2c+mE+Tg2T0xwfkDizF7jfKm9qrrwkLdSl
 BSs785K/R60hEAdsL
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 15:55:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "zhangckid@gmail.com" <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/=5V_n7uqEeXb2s7LFqAPxED
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 May 2020 01:30:48 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, May 20, 2020 8:23 PM
> > To: Zhang, Chen <chen.zhang@intel.com>; qemu-devel@nongnu.org; Lukas
> > Straub <lukasstraub2@web.de>
> > Cc: zhangckid@gmail.com
> > Subject: Re: [PATCH 0/7] Latest COLO tree queued patches
> >=20
> >=20
> > On 2020/5/20 =E4=B8=8B=E5=8D=885:07, Zhang, Chen wrote: =20
> > > It looks ASan doesn't fully support makecontext/swapcontext functions=
 =20
> > and may produce false positives in some cases. =20
> > > And Lukas's patch maybe touch it.
> > > What do we need to do? =20
> >=20
> >=20
> > We need first identify if those are false positives. (Which I believe
> > yes, since I don't think this series have effect on the those qtests).
> >=20
> > And maybe we can consider to avoid using coroutine .
> >  =20
>=20
> Hi Lukas, Can you double check your patches whether or not are false posi=
tives?
> If yes, maybe we can ignore this error.=20

Hi,
I ran the qtest's (without ASAN) on my laptop and they pass here, except fo=
r qos-test which runs into OOM. Also none of the qtest's touch colo-compare=
 code. Anyway, I will send another version of my patches to address Philipp=
e's comment and to avoid touching softmmu/vl.c.

Regards,
Lukas Straub

> Thanks
> Zhang Chen


--Sig_/=5V_n7uqEeXb2s7LFqAPxED
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7G3HwACgkQNasLKJxd
sli5rBAAmhYfONKyj6UmR/5Clj8hGbfrM+abagHfthvVGchibyvO19Bur5cdQ3XX
BzSv1F6skjbXEuBQLnD2dURKwhm5NZ9Ay6yv93axxuN6qpeezzUNhBYrk7VjJ1RC
PvJ0T5DmjSJsFHYpR6491whinVKq+uhXGzA9rn4jldZcKuToF0Gu4T6ZDf2MyTUa
RGn7d01AvPCkimglVxT+O6ifFwZEtiPa8nj6/j0JvMf5Wq6KCdVUHVmrjZ9vMiaL
FTvaT2d52xRpiz0cVUe6Ro7mIgqlpUEYfNnwh0L6gwz8Yv2KdjFpghUvqs/av5ay
/UgzsCnPITH4rtx0el8mrem+PbKrGGDzCAhkBP3P1mgUImKPLqYftMxmctPNJlI1
moMBdO1s6SBhWg4y+EXq37qfNdULMvniLZZzIs9C8ecx4TkKJbgzrAFcxh0Erxzk
9cPCib8IKr8kBY1W7QjeyJTDI7I4g4dINYyoicEPuxKK44Foidw/mzHRV9COkNWt
SzF3jd7RkH8X138CCZV4JK3lfK6WwV1RLVtqz5Syg24J2KNdQbcNRL2TPtxAEJnh
jZr9N3jSLbKpbyO7mAppVt35+sZ+3qIgYUosXnwUqVqxj//OBvW2zqCzhdl5K3y9
3uVlXdZWy2yls3IvZV8E3ACSySYY4nJtj6ctpsQCS4Ex9HywXcU=
=0aPA
-----END PGP SIGNATURE-----

--Sig_/=5V_n7uqEeXb2s7LFqAPxED--

