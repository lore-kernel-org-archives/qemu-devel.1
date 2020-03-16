Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54325C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFFE20575
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezW0PZ/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFFE20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpm2-0001GG-Pf
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jDoD9-0007yQ-Jh
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jDoD8-0005A8-IE
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:47:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jDoCr-000307-Jg; Mon, 16 Mar 2020 07:46:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id a25so20807041wrd.0;
 Mon, 16 Mar 2020 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=RBlFJuJzHGohbhvVENfE6ErBp1OQg6/SjUIrT3L/RyQ=;
 b=ezW0PZ/yVLXrrJBRIuMKqlI9yg5hTYHhela5YPc6VXD3AWyHNaQm4rm+1V4EuTM2ow
 RkYJgelQDivtbmtMGXFMfn9rg9lJ9tCKMSHZW4qrr87YEXjOx8R49xc4xb2Powjh9583
 zkZ+Jfb4khqsCdNEcgL/JRoN/h6p29LKmLWdHlYLzPmncf5OooNzsKsPAhvEkUIQqKz0
 TRtRNV8vNN6LXtpJ4fpILjXYMnkyWQxH7iD4vsivjmOCGEf9BIQXH9L66tp+VZUhHUAn
 99fsAhdGQYs6f4Jh9nZzCm+9CBjgKSWsOLkucSKENx7daKl52CP68rKQTHKnxaXh4cNN
 Jmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RBlFJuJzHGohbhvVENfE6ErBp1OQg6/SjUIrT3L/RyQ=;
 b=UeXXcWgAQoL9WsizU72chWkBl1a8lPfp+vYYk5JHEs9K8otFZAEWWtso/wZKsRLFaU
 fTKeggAEEuk7Dx88FB/T7e2Dlp4qP2+dgYCXlQl9lcRrXv7WcK6WnM7YqIdyi/5eQXwT
 ERKYXJ/vNior7AEpPUeSOWvRmfAyHvVVWVc5FY/jgquOqL+NKLPgxOrIgvmA8FHT5Ig4
 ez5z8BiaVVkX44f4mfQbhk8wiKABc2YmvVzF2u96RoaQGzcY1EOPKJaRvpbnO7oeQ92f
 4PS18xOfD2WAj4HtGSHUUdWcn35nZcKtqWhIlCAYriafqjU2ER1PBP8ZUa90PS/b687X
 vmuQ==
X-Gm-Message-State: ANhLgQ2616garXUDsoL6ubK7R0aKhcZQSbV2mt90rvke0OoDNewfzk8h
 umF7DKWCNToM7ZMfCIAox0Q=
X-Google-Smtp-Source: ADFU+vsyxro1MudvyS1i7k9SvjiNe4AJF64gPJMQtPLK4uFYkei/b6t00eY5Uhy9xFtAQXeIzYbamQ==
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr3132157wrq.23.1584359209342; 
 Mon, 16 Mar 2020 04:46:49 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x16sm28719961wrg.44.2020.03.16.04.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 04:46:47 -0700 (PDT)
Date: Mon, 16 Mar 2020 11:46:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH] block/io: fix bdrv_co_do_copy_on_readv
Message-ID: <20200316114646.GC449975@stefanha-x1.localdomain>
References: <20200312081949.5350-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <20200312081949.5350-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 11:19:49AM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Prior to 1143ec5ebf4 it was OK to qemu_iovec_from_buf() from aligned-up
> buffer to original qiov, as qemu_iovec_from_buf() will stop at qiov end
> anyway.
>=20
> But after 1143ec5ebf4 we assume that bdrv_co_do_copy_on_readv works on
> part of original qiov, defined by qiov_offset and bytes. So we must not
> touch qiov behind qiov_offset+bytes bound. Fix it.
>=20
> Cc: qemu-stable@nongnu.org # v4.2
> Fixes: 1143ec5ebf4
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5vZyYACgkQnKSrs4Gr
c8gz5AgAmCXCya0W8KsLTGk09CxT/8gda/iNMrKdpFu8Ea5y+wlzqn5pJSx/qgz5
8RSM3Tu9SPd9S9g9WGz7MtqOt+dKgEOc7lJQ+rhhaAZ0YvOlm2DEmyv6buwALXJS
gQdtGeeTppd14r1eDH2W5A4oebaNEs199wXLcK94HYzlt5GhLPb8jTt0+SatQZ/T
MctwJV75nH6IX+EjajyX1zG/jjhrkx4TSvG4N6fOIe/TqK3lKdVnfP7U/bnAWXCe
l+PZ1h8KGi33c4+rauVopwZJOZfcMOysmXEW11iocxe1b4b+ysePdpiNhQlDO4Ij
FZQxrdcjMpl9c5MzpDHz+68t7V74Gg==
=S3k6
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--

