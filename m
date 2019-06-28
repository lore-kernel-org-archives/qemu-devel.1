Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED56EC5B57A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 08:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB8B2133F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 08:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdTXwTcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB8B2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgmUz-0004xu-UO
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 04:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36157)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hgmTj-0004Hx-Qx
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 04:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hgmTi-0000wf-NV
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 04:43:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hgmTh-0000uO-2w; Fri, 28 Jun 2019 04:43:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id f9so5334705wre.12;
 Fri, 28 Jun 2019 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mbYQh3g3r2MJy0RzYl9u2/pBPQYGqDuFYIQRwvNWy6Y=;
 b=SdTXwTcAOR9Aa+l326sMP++9YG//bLaUuYLyMqeQVwlT5kOhRBsWL3i1vPYqKllIeH
 SMNuhnHFJavFtJf+tFJwdovIdPSuxEFZbLWad7XWYvoo7gSNbwKQgm2w5Lcb/NuGBHZ6
 II0+L7bNb3Nu+TGnprpHcPJ9G7RdmJr35Ozj6rIU5CSoj5wi4AvwEvNWgVHqHRrZtF3Q
 sq40h1maQhBaLS0OkqY7M5c+lW1s2XCnvx3J7OwGgprd+P3CG/pehZxAEne7WSJBsD2q
 vkxdwMnP56rhaf1bGMnr/wRmFFHVGXqy9YRuW04ErfHqgyo+4byPlw3WacUHWi4glbEU
 YibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mbYQh3g3r2MJy0RzYl9u2/pBPQYGqDuFYIQRwvNWy6Y=;
 b=QpZc6CX7YrS/gfphVjBuaCYBz3u9dZ1rZJIKF8Ui2ba9P0PhFIPB5TAf19O1ge3Dp+
 L4yWg/NpQpcEBDZq1WzY5dhfl81smb+uXkRnF6c+bopk9yiAsyK8ZJz1RoFxXxZS/xz4
 oqwM6CRrEkz9dkkAw8X2aAl72iW/7ZXKwqQrVjkHzovhVEtWWgXm0HE6EXUIi9SByyrT
 nMgbKPWqKd7tPese2gmZkb/Qas2lE7yZLsATBhFMAIYXu1r6f94pEnola1kh0HEyaZwN
 pg5Xf9/aVNvy3WR1cPRhsp1T+Krt6v/pUuSRQbU/T/sojeWwpN7rR7aAS9Ygzhsy7e3m
 j6og==
X-Gm-Message-State: APjAAAUmB6fWpP3wW33m6szbYT/4+tmTDgQL8zfVc5VAIhJ9VBqc+Gzq
 tKE6eBvLPiZpKvlkk/QHoEA3oJqhtZk=
X-Google-Smtp-Source: APXvYqy1z3u123osCSRtvjOJ9WUxmyoNpE1nFz4gsQ7cFL4P8cnGtafUqnayQ5GF8Hy9mKBNased+Q==
X-Received: by 2002:a5d:4a02:: with SMTP id m2mr1792388wrq.193.1561711406201; 
 Fri, 28 Jun 2019 01:43:26 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q193sm1347544wme.8.2019.06.28.01.43.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 01:43:25 -0700 (PDT)
Date: Fri, 28 Jun 2019 09:43:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190628084324.GA3316@stefanha-x1.localdomain>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20190604161514.262241-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for
 io
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 07:15:02PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> Here is new parameter qiov_offset for io path, to avoid
> a lot of places with same pattern of creating local_qiov or hd_qiov
> variables.
>=20
> These series also includes my
> "[Qemu-devel] [PATCH 0/2] block/io: refactor padding"
> with some changes [described in 01 and 03 emails]
>=20
> Vladimir Sementsov-Ogievskiy (12):
>   util/iov: introduce qemu_iovec_init_extended
>   util/iov: improve qemu_iovec_is_zero
>   block/io: refactor padding
>   block: define .*_part io handlers in BlockDriver
>   block/io: bdrv_co_do_copy_on_readv: use and support qiov_offset
>   block/io: bdrv_co_do_copy_on_readv: lazy allocation
>   block/io: bdrv_aligned_preadv: use and support qiov_offset
>   block/io: bdrv_aligned_pwritev: use and support qiov_offset
>   block/io: introduce bdrv_co_p{read,write}v_part
>   block/qcow2: refactor qcow2_co_preadv to use buffer-based io
>   block/qcow2: implement .bdrv_co_preadv_part
>   block/qcow2: implement .bdrv_co_pwritev(_compressed)_part
>=20
>  block/qcow2.h             |   1 +
>  include/block/block_int.h |  21 ++
>  include/qemu/iov.h        |  10 +-
>  block/backup.c            |   2 +-
>  block/io.c                | 532 ++++++++++++++++++++++----------------
>  block/qcow2-cluster.c     |  14 +-
>  block/qcow2.c             | 131 +++++-----
>  qemu-img.c                |   4 +-
>  util/iov.c                | 153 +++++++++--
>  9 files changed, 559 insertions(+), 309 deletions(-)
>=20
> --=20
> 2.18.0
>=20
>=20

I don't see a significant advantage after taking into account more
complex code (e.g. additional block driver interfaces) and the risk of
introducing new bugs.  A measurable performance improvement would make
this refactoring more attractive.  Still:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0V0ywACgkQnKSrs4Gr
c8izNggAoDaQ71dzb2QNiY+zbI+Sa4j/AAazk6yQW8/unZOaMDGqOjts8lFtIRSp
hHwExVY/P+4ENRhOchzFdTZunW33Lw5HfnLT1WihuTQadQqqkQZz465kr2s41KA5
aW3UwBhfwKsD7H49kt/oN4ZQ0HeBxoJ3kw86/g/2P47+bTQTnLVhkasoIUMexyuf
3W4RAH+1cgJifaWUuJl/6tEg39Yz0v7wYPyKSwOjvPlUix5gzJwrVR2MElks11dF
S+JrTrm46GBlm9O/HQUYQjIEntMh5qqW7RuNkYYkiUH4enwm6CpC5WIuOvB7tnM7
PAUljOne7egAAjvO43meU3hzZgHZ5w==
=7RkY
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

