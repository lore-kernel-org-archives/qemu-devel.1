Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E8C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C652072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkQvz95/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C652072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6C3U-0007vP-V7
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j6C2k-0007G6-TK
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j6C2j-0004bf-EX
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:36:58 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j6C2j-0004bO-82; Mon, 24 Feb 2020 06:36:57 -0500
Received: by mail-wm1-x341.google.com with SMTP id s10so8654939wmh.3;
 Mon, 24 Feb 2020 03:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UsbknRXKNgm7209vN9OeUp9toa97VHTSYqjafOpMK/A=;
 b=rkQvz95/J/AnpeM4AjP1hY6GXKzM4QVfLpbbkwmC5Ien/fUbng564tu4qwy5SsMx/K
 EARQl74664J/S6L7JHgI86RErOQFut2iob0q0/g0Ag8Mx0l9kWV1fQHvr1vMW/HH9qpo
 cg+m+PbfWhiWD1PbtkumhPzXZi6AtiS+H55Ky7aTtb/R52kze44uR9spcCT3PtZaUyPp
 d1a0fCtiTeJRes1w3+lu08Odstk4NmeaON6Z344JihpTu2Ln5KBq1Bw/Jwaguf6rHo/p
 1r/knmi6nP8hGznmMwBl8S9ZVAmFcezZA8GU8fofOANfInBBKFLJOR4nWSYvogrLZujm
 9Ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UsbknRXKNgm7209vN9OeUp9toa97VHTSYqjafOpMK/A=;
 b=ERj5XFjRHlXvv58E5rfss3JQNnP9xQesSEBtA9XPo5MMRuL5Etj0FlpVABnzTksCep
 uOcO88cPfNZ4PS9ZOw2koUZJYEu0fJIM6yA5/GHqeNIiU9smxBE/kD4V5X7G2Tf89ieK
 QRVNLkPAE5POHJGB+kdvwcxuTs3011A9wskQ51pcUF7Xd0Zn5UVsrMT8MC8G7viozniw
 +t9dl69ezZHcwnLXiXHNgEzVCiSnXCU7gmR7LESt02cZXv4waL3GsycvCgf1dqCMbV2+
 XYD1T2GXG4cCCsrXWnlPeOR4sxWAP6cZFcdn+mC/yAMCiR5zRX5QxRe2xGe1xZb6Em6v
 MeNw==
X-Gm-Message-State: APjAAAUul8+n1orqMFK8URM+P1iXxMumOevEwsM4GZoHTdtBCr/L70Me
 jiOefeOeaRICZLaW6IBfHBY=
X-Google-Smtp-Source: APXvYqzUsRlaNbwSjm990yt0jGb/SYD51BIZ5pJWb6ld0UqflceZ3P3QBsl1ou5QH9Vfq8wOAxp2TQ==
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr21177751wme.153.1582544216179; 
 Mon, 24 Feb 2020 03:36:56 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id e1sm17907023wrt.84.2020.02.24.03.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 03:36:55 -0800 (PST)
Date: Mon, 24 Feb 2020 11:36:54 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH v2 0/2] delete virtio queues in vhost-user-blk-unrealize
Message-ID: <20200224113654.GC1896567@stefanha-x1.localdomain>
References: <20200224041336.30790-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <20200224041336.30790-1-pannengyuan@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 mst@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 12:13:34PM +0800, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> This series patch fix memleaks when detaching vhost-user-blk device.
> 1. use old virtio_del_queue to fix memleaks, it's easier for stable branc=
hes to merge.
>    As the discussion in https://lists.nongnu.org/archive/html/qemu-devel/=
2020-01/msg02903.html
>=20
> 2. convert virtio_del_queue to the new one(virtio_delete_queue).
>=20
> v2->v1: rename vqs to vhost_vqs to avoid confusing with virtqs (suggented=
 by Stefan Hajnoczi)
>=20
> Pan Nengyuan (2):
>   vhost-user-blk: delete virtioqueues in unrealize to fix memleaks
>   vhost-use-blk: convert to new virtio_delete_queue
>=20
>  hw/block/vhost-user-blk.c          | 23 +++++++++++++++++------
>  include/hw/virtio/vhost-user-blk.h |  3 ++-
>  2 files changed, 19 insertions(+), 7 deletions(-)
>=20
> --=20
> 2.18.2
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5TtVYACgkQnKSrs4Gr
c8hR7wf/SR6rgzwBHlr3z9Dlm0f7mwO4EFM1Iu87FzoSjhsrN/+5w8pLxtmodkVR
vlTyUAimA363tjwueXCinYH3NOI7ISwLtha78p3KSBMaHGDRB45rPwrWVPZQBs6K
P7qVaOvbtGTIbw8GdsaRgBvl5kCdSGFlhvnj8qvLV/VuGx/x3YjkCZY8Z0R5hjYx
rcxIIiXf+m28riXfMEF9FuCgbKh1FqIKkUBMfdNeugx0DI/i3g8foc/SfZnJN6J7
+dhpWSnbQ2X2NOXHtFcgdQ/FlClZQL3Jx6Uat++3lJn+yuWXgmkOICf8gEkIKLyV
0p0QQJr0PCx98C0xQg4Q3U1OmnAUBg==
=kKU8
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--

