Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC617C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA75B21655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfjmWj2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA75B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Lz-0008UV-0y
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39267)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hs78r-0006xa-6Y
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hs78o-0006EF-Vp
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:48 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hs78o-0006Cn-7M; Mon, 29 Jul 2019 11:00:46 -0400
Received: by mail-wr1-x441.google.com with SMTP id n9so62323723wru.0;
 Mon, 29 Jul 2019 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EvGNx+Kn3j22mBnD961uLdesgAsnX9V9qF5f4y0JXAk=;
 b=EfjmWj2el3tkQhY49K2n7qYNNgdsfguH1ifg9deCMCWl99STnMa3uulGEV182xBF2B
 0iEqya+ZdE7eYyx+Rf5udJkDM3d1ryCXBDZqLk86vWwBKxh7DnQBeUAF37ZuuJLErNDJ
 6LKjBmMfZIbdYydbd/3PnwLPPar0U1IH4VpdTsSNmL9W8/+/qFSws9I0W9cQf0pxgIps
 SRYVAcyCxmIO8H+j/VEQUSW6qQWnAf19Dz5pVghoz9N81VfReSJcnhPsfUAVL+12gU/P
 SY9IADzKyMMqeO5eoGV2T9ib5byC7huFWVZ1TXuKkG9Orv/bWxzEldbPope4RCD33zQA
 K08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EvGNx+Kn3j22mBnD961uLdesgAsnX9V9qF5f4y0JXAk=;
 b=RvSx8oSjKW9DYpX5tz+a0y97ljYgYh4CETzUgO/rrLku71Yuz8W99x0yYHEKiN/qE1
 6bnNnzBATa3QkBJta9nAwNjKF3E02ctJH1K+KkyisvkGymUDbejAsX/ZCA0zKiCj37ZO
 zrkj0S+En2ONg0K2T4QJNs4yf8uM3gplUDrwAgHTXB4BpYnp8nOO1Y1t9HG7mzAmYTi0
 2GaMOfE/+C5GuRU0fppNyxvC41Sv2nMTJxNv86x9H3+sJ6LNO7lXtefhAL9iizSkJgV2
 X/TFF5ekFQot1zTCgl1ZIUr4PMgBp1GpZ2K1JmqaxCszSAOJsdimrFVjVVL5nzPB/Iwd
 AuGA==
X-Gm-Message-State: APjAAAWDYzsHyqR2Omr1nScypR+tev1MOzGcmVDagXU05AhpKsnOkJ/x
 wgspyDXhsVpTTjWK6clzSA8=
X-Google-Smtp-Source: APXvYqy2N2JqJM971redH8YBz1aVzaUt3bKb9FUYCmc08Im/9gX+ZXeX5j/jlAsZw1e+7WfTYKA/ww==
X-Received: by 2002:adf:e8c2:: with SMTP id k2mr30751971wrn.198.1564412444196; 
 Mon, 29 Jul 2019 08:00:44 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z1sm68458209wrv.90.2019.07.29.08.00.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:00:43 -0700 (PDT)
Date: Mon, 29 Jul 2019 16:00:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190729150041.GF6771@stefanha-x1.localdomain>
References: <20190725100550.33801-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <20190725100550.33801-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 for-4.2 0/3] block:
 BDRV_REQ_PREFETCH
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 01:05:47PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> Here is small new read flag: BDRV_REQ_PREFETCH, which in combination with
> BDRV_REQ_COPY_ON_READ does copy-on-read without
> extra buffer for read data. This means that only parts that needs COR
> will be actually read and only corresponding buffers allocated, no more.
>=20
> This allows to improve a bit block-stream and NBD_CMD_CACHE
>=20
> v3: rebase 02 on master, fix commit message of 03.
>=20
> v2: change interface to be just one flag BDRV_REQ_PREFETCH
>=20
> v1 was "[PATCH 0/3] block: blk_co_pcache"
>    https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01047.html
>=20
> Vladimir Sementsov-Ogievskiy (3):
>   block: implement BDRV_REQ_PREFETCH
>   block/stream: use BDRV_REQ_PREFETCH
>   nbd: improve CMD_CACHE: use BDRV_REQ_PREFETCH
>=20
>  include/block/block.h |  8 +++++++-
>  block/io.c            | 18 ++++++++++++------
>  block/stream.c        | 20 +++++++-------------
>  nbd/server.c          | 43 +++++++++++++++++++++++++++++++++++--------
>  4 files changed, 61 insertions(+), 28 deletions(-)
>=20
> --=20
> 2.18.0
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0/ChkACgkQnKSrs4Gr
c8huZAf8DYrt0xQ7OoO8i3iPV99FIod6laCocfMfgP6ifYYyi/48BywpkliHySzC
g0Vtg1DpJrTCeM4za5gDFZBEbB3oVmoidrgLNVENUI/pu0DWE7KsGtESh9I0nNoH
bYj771OapJB1SUl+h8JPjnRcBjPEjeOlSqSY6t+5t+I3KlkmUu1w5iZCoCt/qk5Q
iKaSrZS/VtuqhE5BOLZbWiToIEWyJxxbrdEBoa0Ki6DJBPOHoGxx4VJYk38VeX5j
0QxcVA/Wcb4JKiGnUc7Cs2+y7IrVnZoRbRyfh2YEgWr0UJY4eOF6Rde9rK7E4n5d
tqh81BDzr85lx3Z8YJoYEdcvy4RMdw==
=vXhs
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--

