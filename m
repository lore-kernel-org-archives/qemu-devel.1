Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B264C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69959208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suQW84sn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69959208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55661 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56Y0-0004gt-Il
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j56Wi-0003kM-Bi
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j56Wg-0004BZ-5F
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:31:24 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j56Wf-0004BL-CJ; Fri, 21 Feb 2020 06:31:21 -0500
Received: by mail-wm1-x343.google.com with SMTP id a5so1395995wmb.0;
 Fri, 21 Feb 2020 03:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3BRTlfjk7ABo+7g+IMgTIkFXBQpl93g0f1jPvvJB/xA=;
 b=suQW84snScwQhgKyPnkr1owZGEPwMRZ8yxlbMCksJmYFMloTtXEWHLPZC2N9xkAiXB
 EUsDY2ziEvw5exZywp1Wg5R374BtmMLaBDKwuct+4p23vpOci2P7/3Nh6ch1aH7W6nhf
 1hzc40EO8sJ+klcy3aOFQA9p0Z4RU6iKWcg17btNBGdlzFtc0vLgbMgiuDAEaU+pK0y6
 JzGNI5SxqCHfVPrh+N6Z5mMCFebv+Dg0WWpstsGwI24s1M6OJCAmN/6zHW2FV/OeC78+
 l9VwvlgVm2AGwsGMlVj01aOuVNIhUgHA+6JUdjclV/5P4b/iFt3cR6GwFPxX1X26Vu5I
 PrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3BRTlfjk7ABo+7g+IMgTIkFXBQpl93g0f1jPvvJB/xA=;
 b=iqseq1Ey1rDRJR1RqLrFWbnajGGio+wz2ASBVlwIXhiruyn6pc6A+8SfH4Kal0MyKQ
 m1v6pexi2LGuBHMdZ50S5w1fq6UUlNqvTPbgxYj/VTMbB/Y1tz/ycIx3QUcu3mTyAa7X
 YfQF/YSy5X5g5ID5JWQqJ/XoYosmL3jtTbLUvb9V2INhMnV7vzNkUP537TqD+fS4zMUK
 /mPCr0q3E8UdLIUTOxw2/pESBBUs3RX8WKDq0cmihIC61SdECVDo+KJjrxXhMlxm9pXt
 JYOqTZ5UmFZqkpu3X2ZX/dzXBJaIgVwEn441lXdPJOU0mtOm8MvZUnjaskIpYdOKv92S
 t32A==
X-Gm-Message-State: APjAAAWSZB1/aB/7lVIEPziHLFgjfmdUHE6J7WmRh09QS1WgNXVlX2MF
 Wr6fZxWWOe2uM8I8AJQfImw=
X-Google-Smtp-Source: APXvYqx3Bb5ZCwqedPzTb0WA7zdpHZZXrv43Ww1oTbo2mJn6kw5n37+/eVenI0DIz+hy8aB7ySnYzw==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr3213897wmc.109.1582284680053; 
 Fri, 21 Feb 2020 03:31:20 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c74sm3609659wmd.26.2020.02.21.03.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 03:31:19 -0800 (PST)
Date: Fri, 21 Feb 2020 11:31:18 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH 2/2] vhost-use-blk: convert to new virtio_delete_queue
Message-ID: <20200221113118.GG1484511@stefanha-x1.localdomain>
References: <20200213012807.45552-1-pannengyuan@huawei.com>
 <20200213012807.45552-3-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline
In-Reply-To: <20200213012807.45552-3-pannengyuan@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 09:28:07AM +0800, pannengyuan@huawei.com wrote:
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 2eba8b9db0..ed6a5cc03b 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -420,9 +420,10 @@ static void vhost_user_blk_device_realize(DeviceStat=
e *dev, Error **errp)
>      virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
>                  sizeof(struct virtio_blk_config));
> =20
> +    s->virtqs =3D g_new0(VirtQueue *, s->num_queues);

Minor point, up to you if you want to change it: the array is fully
initialized by the for loop in the next line.  There is no need to clear
the memory first:

s/g_new0/g_new/

> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
> index 108bfadeeb..f68911f6f0 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -37,6 +37,7 @@ typedef struct VHostUserBlk {
>      struct vhost_inflight *inflight;
>      VhostUserState vhost_user;
>      struct vhost_virtqueue *vqs;
> +    VirtQueue **virtqs;

Both vqs and virtqs exist and are easily confused.  Please rename vqs to
vhost_vqs.

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5Pv4YACgkQnKSrs4Gr
c8idCggAkGPUItnU5FWiSVyGmfdiQSpcqkSUSdXmJ/8ybqj02EqYqc/b2Eeg4WDN
+h0PZPB9BeF0JzfhEPCxIUuSf9tUAJmOsP31FEzBYr/VjmHc2NldPe5BaavzjJpq
FCvwdQOP2LsXK/y8nm3qV5MHyiy0gK5KFpR0eoTx4fy1eGmpRYsqYbINqzjwKfO4
jJkDl4A3oMMAEkPXKFjDH4ogdyMRB0L4vdd51J3JUPyBvi26UwDnXG65H30Dyhi+
XegdIgQlaZIjhe5A7u3pRFYLE1XgZzwgvkyviGVVxl6DCP6Mj/jXth0/viZxIZF/
Akj49CGuzzXSprPbz5CXcc6O8Vj5vA==
=Pg4q
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--

