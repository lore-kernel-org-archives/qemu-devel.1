Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC14C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0D2208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbS9qmve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0D2208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58o4-0007Su-77
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j58n5-00064j-4B
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j58n3-00038a-3A
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:56:27 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j58n2-00037S-Sj
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:56:25 -0500
Received: by mail-wr1-x442.google.com with SMTP id c9so2169463wrw.8
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=C6khDLhnNEWJAB13BrdphdApp4hcEUz0Bu5uQFOau+w=;
 b=RbS9qmveHGIx3m3aKxjHMIMsf9qO/yZbSW1rYBwnZO3eL6I5sQk0rmZY5f3HErDH29
 TicjuIJwh4Lxs41BLFZkNbEUHBmyqvnZrYm8jmM5KMcOXc8pVoxooIjhNsAFD2Wokkxf
 JrNa0OEyKspIA7QouA+a+qidZk18Vpzlh35+O/9NXfEMx4SPHpHJEoPIrrUBH4/q/gnX
 AQVOf2s7K/mp43dzGK2BIQMdLsbkyUagJb3ic3xw1Tt358XvBRwfcQICGLhUp0SoiwiC
 8/DJwx4PwVP3sNUX4ZRRI5LYW3QnPzhOvKOcjOsqdidTFMzx7qacZwzNSk4b0bynrFA7
 JJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C6khDLhnNEWJAB13BrdphdApp4hcEUz0Bu5uQFOau+w=;
 b=KaGQgp314gIXNfy0jZRRgqHt9JbE9Q+0cCjIePSQW8juDADmUlzFbiMT+/Nblq7Idi
 tkQmPWaWsze/TkLaTQSOFzbnOD51oVvsz7HNL2TS5oinopMgX12OzhO2POaSS9ysfAEm
 O6Rw/clL8KlfLsAUUSsqL9unySZlkBmFhrJ7+9GnMtUmplxviWt+qzqd4fRADh2Zg40U
 QZAr7fOLzDyU3Or+afBuNw86Lug3Ps4YokP1GNodaYQj0zayQtML/yp+7Bv/85mtK95L
 G4/1dLvUMKFvDEcYRQC5WGPnavLEO56c0KIK8q/L0IW+ga6+KUZoojT09UnKSqWc8cg3
 KHaQ==
X-Gm-Message-State: APjAAAVTOZU1hPoAd56pKs6I/Qy8qOEAO3IUwJekH7zNX5dOM7+vTz5P
 Vi698Bsap/4IqxDTQSUQB0s=
X-Google-Smtp-Source: APXvYqzLOg4/X7T2U1HmiM/TR+4kQLb8/aGfkuh8FrpC3bOQh66IDKsKURjflxdVTXol0hGDtFQwpQ==
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr21526946wrw.184.1582293383982; 
 Fri, 21 Feb 2020 05:56:23 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id s15sm4014983wrp.4.2020.02.21.05.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:56:23 -0800 (PST)
Date: Fri, 21 Feb 2020 13:56:22 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v10 01/22] softmmu: move vl.c to softmmu/
Message-ID: <20200221135622.GP1484511@stefanha-x1.localdomain>
References: <20200220041118.23264-1-alxndr@bu.edu>
 <20200220041118.23264-2-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="o41d8xLWOaLD8vYh"
Content-Disposition: inline
In-Reply-To: <20200220041118.23264-2-alxndr@bu.edu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: pbonzini@redhat.com, bsd@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--o41d8xLWOaLD8vYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 11:10:57PM -0500, Alexander Bulekov wrote:
> Move vl.c to a separate directory, similar to linux-user/
> Update the chechpatch and get_maintainer scripts, since they relied on
> /vl.c for top_of_tree checks.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  MAINTAINERS               | 2 +-
>  Makefile.objs             | 2 --
>  Makefile.target           | 1 +
>  scripts/checkpatch.pl     | 2 +-
>  scripts/get_maintainer.pl | 3 ++-
>  softmmu/Makefile.objs     | 2 ++
>  vl.c =3D> softmmu/vl.c      | 0
>  7 files changed, 7 insertions(+), 5 deletions(-)
>  create mode 100644 softmmu/Makefile.objs
>  rename vl.c =3D> softmmu/vl.c (100%)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--o41d8xLWOaLD8vYh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P4YUACgkQnKSrs4Gr
c8gXXgf+JQQP/urSgC5nhrxj32yRJVqq5KrAUxuevUIOxRKDYsJo+XVyIpLSIiRk
fYk3d5w2IhbKtGC1zkNBU/V+nRZdQPLz+mOswocQXKItMMxXKex71BG+QiEH+Q9d
EVsy6mHdONWjxF+REVx7DrMGEgL1BsxnuRHmlEE6SZ9KW+KFbGxOWSERaxkCJbjb
X68jWV66bH5Y9eQmNQ5K5YAxE7p61z1olHO6ZmOfKS0qfXPBi2bGHgTIxCI9mCJi
biLSaNLmWn4d0mcIPLgn2oz9H/VNH4zmtjDUBWCJRzOLgyki6x/sIvnDk9DVBh8N
HWdcgf0cbc9SApPoEoMZHw2mmKf7+A==
=tofH
-----END PGP SIGNATURE-----

--o41d8xLWOaLD8vYh--

