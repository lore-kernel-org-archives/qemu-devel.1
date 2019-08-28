Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6457C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A117320828
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am7JhMuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A117320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2uQh-0005ty-Sk
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i2uPb-00052S-BQ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i2uPW-00028u-3B
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:38:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1i2uPV-00028c-SW; Wed, 28 Aug 2019 05:38:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id b16so1761708wrq.9;
 Wed, 28 Aug 2019 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mSw7V2zPOX2IaBpk217EYy6eWnf/bYWrO+wN/aYXCkw=;
 b=am7JhMuSUIBtyVFJah1UvLljFNNWRzlkHzoJk/PKp6IeDMzgMbxRH0jb3+4KjfOXmJ
 P9mr5p8ZBYemExW66BHAuaag8WZPbbrBlrHbsRw94cAGb9oniLFIHgHOblFdq9vsYLVu
 xP7H85qHfYdSPPCx14jFfVhePRUsrI9Rv6egACJiuo0iPKbcNntMHoadv4dfxgtNJJC5
 J+ipdsaCCDzii5ZqsmMJBEun6czGNvq+nqmVEG4hP06jXgAMNGIZ4tz2+KntTnhbw9C/
 YudP9NcyjXglDVYWEvjcjD2i8p8+LUpw1Eqush6m0EAa9Ex0lw78X5QkNquV8a6dIuCf
 hJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mSw7V2zPOX2IaBpk217EYy6eWnf/bYWrO+wN/aYXCkw=;
 b=Is/xonykDvLpPHBt5u+iKukaHKD/NppOIVRsP6kHAnabMQ2e6waB79gnsEvHrtpEGA
 EobwHiebhaphWJ0HidZEQSQjHE8UaDgzABs35zaZIS37CSk6KfYFwE5skgEDPHLOxrkz
 nOvMYQWydmxiJZD+kHhjgDiCVCnq/S7UY608jULxpaZWoUf4NMijWqjFAHhOal0p2wSG
 8qM1AXeuwP0uieyqPmUBby+T/L9B3KQ9BixAnigEA1w4nVyiUvhtHw7P3lLbWds0f6f+
 fbKsD5j/5ekbqLFfWQfU490ETDTQ2ioEpdkO2zo4S79dWi7i0IFEWRVck7Es7yZKT12c
 Vx5Q==
X-Gm-Message-State: APjAAAV4DJzoOQkXY6rNd9pkoflnsADBz43ccAsdrSXfrZh9530OcK/u
 l6EIMWxncmpr+iig3kLtHi4=
X-Google-Smtp-Source: APXvYqyKDK97zVQg3QSGJ5FHRSTwO+eCY0hwlO8g6/yDEbEOeFCbE1sTYO1w1kxLY0WhRxWz/F5yNA==
X-Received: by 2002:adf:ed8d:: with SMTP id c13mr3436902wro.106.1566985116718; 
 Wed, 28 Aug 2019 02:38:36 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id i93sm2911943wri.57.2019.08.28.02.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 02:38:36 -0700 (PDT)
Date: Wed, 28 Aug 2019 10:38:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Message-ID: <20190828093834.GF5573@stefanha-x1.localdomain>
References: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
 <20190823194927.23278-5-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <20190823194927.23278-5-dmitry.fomichev@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v5 4/4] raw: Don't open ZBDs if backend
 can't handle them
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2019 at 03:49:27PM -0400, Dmitry Fomichev wrote:
> diff --git a/block/file-posix.c b/block/file-posix.c
> index d9f2fc5e46..090e7c4d2f 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2884,6 +2884,20 @@ static int raw_check_perm(BlockDriverState *bs, ui=
nt64_t perm, uint64_t shared,
>              goto fail;
>          }
>      }
> +
> +    /*
> +     * If we are opening a zoned block device, check if the backend
> +     * driver can properly handle such devices, abort if not.
> +     */
> +    if (bdrv_is_zoned(bs) &&
> +        (shared & BLK_PERM_SUPPORT_ZONED) &&
> +        !(perm & BLK_PERM_SUPPORT_ZONED)) {
> +        error_setg(errp,
> +                   "block backend driver doesn't support HM zoned device=
s");

Spelling out "host-managed" would be helpful in the error message.  Web
search results for "hm zoned" and "hm zoned devices" aren't great,
whereas "host-managed zoned" brings up the T10 page.

> +        ret =3D -ENOTSUP;
> +        goto fail;
> +    }
> +
>      return 0;
> =20
>  fail:
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index c5f41b3eb6..673a8b39bc 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -570,7 +570,7 @@ static void floppy_drive_realize(DeviceState *qdev, E=
rror **errp)
>      dev->conf.werror =3D BLOCKDEV_ON_ERROR_AUTO;
> =20
>      if (!blkconf_apply_backend_options(&dev->conf, read_only, false, fal=
se,
> -    				       errp)) {
> +                                       errp)) {

Please squash this whitespace change into the previous patch where the
false argument was first introduced.

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1mS5oACgkQnKSrs4Gr
c8hWMQf/UOvR0xvMv0czYuxsV6Z7HQGKcZKy41R2UFqAxv2aJ5W2Kyuyqzc7FJ8i
jR+0DsI7kNLCPOvBryH8bdvviAWe3wnq+7PLZSXb1T/JNu+hRVtrAQ1Yo5Ggoiiv
xfjjLfLJaJwJ4OXUK229qhPAme0wDql7Kdrwa1sKEFDoFKXBNd21KGt09sxVVDrv
FMZt7I2OMAejUqUDbSOzKCxhyRuORjSM/5u/OfpuMILZSsvPBRRQbSdZnLamEWF/
lAgRBV34fksEvAN4FhGUL9+6Hx0W2L/eY6WAwQW0mq+/ojcSM/oqNWGs/CvewNsv
QQJEJ588kFAD0y12QvNPzmMI9RuLxQ==
=XZ9x
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--

