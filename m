Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF29C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9894C206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqYvA9wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9894C206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihyYk-0007GV-Nj
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 11:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ihyXx-0006bn-6o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ihyXv-0008VP-V2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:21:04 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1ihyXv-0008NW-Lw; Thu, 19 Dec 2019 11:21:03 -0500
Received: by mail-wm1-x344.google.com with SMTP id b19so6036816wmj.4;
 Thu, 19 Dec 2019 08:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BWTYTE/FHmSsDmvCb+75KXF1TostnKahssYlPsZLtYA=;
 b=EqYvA9wzbwfoR6/Q9y9Rvgfzp1xy+HovavkNLZvSnHgS0gz4ZxPfEW0Ix2CI0SR1at
 E60CQnPeOHu8au0gSyOeAIdAO0S6u4diwC5ecaE2e1GwLYdC3ZU6HG+JlZ0C6BCiDo7t
 oSzA8gfMHR0o0qikcNRmuZfiASaXcgjMXFbieMTprHG9WBd0lxTsq2RispAOs31eBlwt
 4dYNGYgqUXIP+TgcA6hgwYpGb0iBL1uEGVWZSxK8gEPoltabkjto47c9RARGA0lHFCq9
 hAhr+wcZFgjLHECVj7HKZ+i+BUZstA1YNDEsozAxyQmld3DP30iVLNy8TXuSvhpMP1t+
 zSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BWTYTE/FHmSsDmvCb+75KXF1TostnKahssYlPsZLtYA=;
 b=F9Zs1zQ1lhO0bilHRak5WnrWq5qs7n1Oo4WL8cG9rBPq7zyqmWyzRaoao8ckJUIJad
 sA0RC2Vq3Y0pZd9SGxFl1PEkulHbvkW/Zf7epSb3gf8Np8VQC4N9Et+8ShXMoZUVdxyi
 hx0ZusHpkO1lP1h20WTpHH8IHd0Y0QWGe33PtjXcjL1Z5+9p7L9Ym5HQbLZutK8wj8hV
 OTZpZGiKkGwkE8wm8tDKpgJSZZ/G1yiKv3ooHcmgMx6rLwQXuIdS4lQIAWisMvXvcqA5
 prKoW32nhc7uH+OZuQcTbZsSD1xFtwMUdjwZZNIG8wg0rdIgNyuUzMzNalsY77okvvUT
 QnKg==
X-Gm-Message-State: APjAAAWjGtQkqIr8syT4jS+RySgsHMcixmU141Q/nv1XqYadkcMGD2vo
 cHNvHftdp1xf8MsJenZ2XwQ=
X-Google-Smtp-Source: APXvYqyZGRn4kJ7fkPq2XxytOJa2lAQ/a8YVMkQ1Q66RXPbqFs+Mr6L9HskdbIcxznztWQx4uS0a+A==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr10860808wmo.12.1576772462141; 
 Thu, 19 Dec 2019 08:21:02 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id m126sm6683321wmf.7.2019.12.19.08.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 08:21:01 -0800 (PST)
Date: Thu, 19 Dec 2019 16:21:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Li hangjing <lihangjing@baidu.com>
Subject: Re: [PATCH] virtio-blk: fix out-of-bounds access to bitmap in
 notify_guest_bh
Message-ID: <20191219162100.GI1624084@stefanha-x1.localdomain>
References: <20191216023050.48620-1-lihangjing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gTY1JhLGodeuSBqf"
Content-Disposition: inline
In-Reply-To: <20191216023050.48620-1-lihangjing@baidu.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: chaiwen@baidu.com, xieyongji@baidu.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gTY1JhLGodeuSBqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 10:30:50AM +0800, Li hangjing wrote:
> From: Li Hangjing <lihangjing@baidu.com>
>=20
> When the number of a virtio-blk device's virtqueues is larger than
> BITS_PER_LONG, the out-of-bounds access to bitmap[ ] will occur.
>=20
> Fixes: e21737ab15 ("virtio-blk: multiqueue batch notify")
> Cc: qemu-stable@nongnu.org
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Li Hangjing <lihangjing@baidu.com>
> Reviewed-by: Xie Yongji <xieyongji@baidu.com>
> Reviewed-by: Chai Wen <chaiwen@baidu.com>
> ---
>  hw/block/dataplane/virtio-blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ouch, thank you for the fix!  Applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--gTY1JhLGodeuSBqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl37o2wACgkQnKSrs4Gr
c8jTRgf/U9DTwY+zz9j9q8orOZ9AxigWRDacgvXnZdibYoiTM7KGCS3EpedouSz3
jnqBtZsCoLjicZzEGkAVvOa3veO7VIa7b/AQcTRP8QL4P31M+0GPn9KwhcOrydNb
1Z4zQj/lQVgsUa9mEfBaX6tBI9i5jMUD6vKIZ16BF4ZCxZVTBC6+WJN+Pt5aBRlU
Pl9J3R6e6mG62GNXasAEyF5bNB+Lps9KToTBswBmh63WDMMUlLvUdc01TA52OjB4
joifD5qxfguquNnhDlcQcSq3l0/lPafM1ZK4lvXhE2uux8+sW2GlgI4inr5SJ8Ar
DZMuCAV1o1ignr3+PUl37DwcJddZ0w==
=ICp6
-----END PGP SIGNATURE-----

--gTY1JhLGodeuSBqf--

