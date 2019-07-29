Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AAEC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC739206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1cej2NP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC739206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7VA-0002VE-5S
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40696)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hs7C5-0004Ky-PH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hs7C3-0000eY-Id
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:04:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hs7C0-0000bV-BQ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:04:05 -0400
Received: by mail-wm1-x344.google.com with SMTP id a15so54175434wmj.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wfhlxrJRaFp3hWxSE5Cb2xLcPJefE7XdQ7rh7BlSLXg=;
 b=c1cej2NPrRKMUmpkbSILdT8ocBDcIgpKMyb98xHNA6Snwvoybx0EES1BMi/gu8pp7n
 OwzqagVGX8m32G0s8CCpDaOdq/ZjFQaiYsYa6H5MSnVvKoj+PTx+RAFmOIfrkA1/+XQj
 nifnlxSDwNNME5emb2EbYiS7zlanP2t2+teHld5YUbP0f9FTCvEVj4S6/GY49Hynx0VV
 E7nDejPy5XZIURdqR61DfykHMWVuGV7189+0bG+R4tZo7/Bfy8SmWsnQgKYFtmmGlD0g
 YNKyH75M4SBJFCmP9M410eBSAcoHmZ5apw4l1MQAAljt/HiytatfT48awDDEedQbBlkN
 16dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wfhlxrJRaFp3hWxSE5Cb2xLcPJefE7XdQ7rh7BlSLXg=;
 b=o19xAypxm1Gg7yRx6sNL4WTPvi5jJLjifKWcezwqIDhhNldWI62rG0TTxNUyPkNcHG
 mmXMgbzXuW9pcQC4Hf/lvzdGBXIoH9CxDyP/LkIIrAPNWbJviFRl0eV8mLYElMSEyFbO
 WXt+GRoulC+sqZqziS2VPt9bQwm1IeiG/fgbmUZ1rH/WEZtrPWLcnR9BBk1dDPbQ7Of8
 z0XHqew2jA/CegJ4vptOl6jUlXOiGYxrUvn0YzmDvHtvrkW6L0TJWx0+HbGOp8Boi2Gx
 lR1yN70U3YZZhALJ2EeHdVqJh4r5e4dagRDI5OBq1Qkjui5OdcSl/f9/lL92jK8U53d2
 mieA==
X-Gm-Message-State: APjAAAVQlSuzt6LPbZvDUlBAxDTDdMbV4HtjUjty3h/mPzHAwVoPEdCm
 XS3voPjea8kRm+v/TDt03+Q=
X-Google-Smtp-Source: APXvYqw+LwzhCTKkgzt978UWbR+B92nOu/kLkowD+1DL6fFR2xwOg3ppU/mnGGEHi9JnLRpBWecZ2Q==
X-Received: by 2002:a1c:7d08:: with SMTP id y8mr82256119wmc.50.1564412643182; 
 Mon, 29 Jul 2019 08:04:03 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x6sm64158692wrt.63.2019.07.29.08.04.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:04:01 -0700 (PDT)
Date: Mon, 29 Jul 2019 16:04:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: P J P <ppandit@redhat.com>
Message-ID: <20190729150400.GG6771@stefanha-x1.localdomain>
References: <20190723104754.29324-1-ppandit@redhat.com>
 <20190723104754.29324-4-ppandit@redhat.com>
 <20190723130326.GC5445@stefanha-x1.localdomain>
 <CAKXe6S+pXN0d6K9Vw=kxsy51bVz1PxXBHYEmTesUnYo8u8vcYg@mail.gmail.com>
 <nycvar.YSQ.7.76.1907241116470.10049@xnncv>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1907241116470.10049@xnncv>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v4 3/3] net: tap: replace snprintf with
 g_strdup_printf calls
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2019 at 11:18:09AM +0530, P J P wrote:
> +-- On Tue, 23 Jul 2019, Li Qiang wrote --+
> | Stefan Hajnoczi <stefanha@gmail.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:03=E5=86=99=E9=81=93=EF=BC=
=9A
> | > On Tue, Jul 23, 2019 at 04:17:54PM +0530, P J P wrote:
> | > > -            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s",
> | > > -                     helper, "--use-vnet", fd_buf, br_buf);
> | > > +            helper_cmd =3D g_strdup_printf("%s %s %s %s", helper,
> | > > +                            "--use-vnet", fd_buf, br_buf ? br_buf =
: "");
> | >
> | > The change to the br_buf argument isn't covered in the commit
> | > description.  Why did you change this, was it a bug, etc?
> |=20
> | IIUC, if we pass the NULL argument in g_strdup_printf, the 'helper_cmd'=
 will=20
> | contain the '(null)' char.
>=20
> Yep, right.

This change isn't related to the topic of the patch.  It's a separate
bug fix.

Please either document it in the commit description so it's clear the
change is intentional, or send it as a separate patch.

Stefan

--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0/CuAACgkQnKSrs4Gr
c8hB3QgAqqsQ5pexGzGm08DdDmGJ2iS2MI5pgBRilsMt/VJelxoD5bKr7eCrvGRp
QmhN+62kIHxymaDCR63YHKAQwdTAPBpK1oDZUW/O6xRFwHTps4l0bAoBaltso3U6
VCe4P9v78q1Su0MX8fwS6IDnEw+FSWRpdRjMAnrfrHkIrO8O6bUrq7epLkLy4cJQ
6QCRyyMdEY6ZFuJ00S8/8YddS0+ePP9XV/r5AvlzhXhemzTqxN7bDO5fIZNLSth2
2rEG7b6QFHvOn1rwZCh7bTUZ6EZzRW9zEyfPdWjzHf6+I+k8BVkFUAQF2FO/WQR0
z/FJbsB7BUIzkDFT7gYidc+m/5ozzw==
=tzbn
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--

