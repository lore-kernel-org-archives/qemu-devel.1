Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8EFC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 21:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FC820737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 21:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDEJw+qX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FC820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK7fE-0001cP-OS
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 17:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jK7e3-000109-0W
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 17:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jK7e1-0005B0-Rt
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 17:45:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34569
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jK7e1-00059N-Oa
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 17:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585863901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPvMwUw0ah03gET9cru3CNufjC9IXWQYXjr1GCg6rek=;
 b=bDEJw+qXgJ60SVRh/i01Zm76K1pYkS0CpbnypphO/uuGNdMANjCvT+CTqpH32wg2vgAnDw
 HS47PFPXS/gSiB7XvpWOXCwdyFNF01AqiFFmwN3VJGWYZYpD9y09sQcV5FC6sVqOSn/1nv
 ykugkJXZ0LM1iQwP8QFe5XeR/Ex6/r4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-smppz1WRP9uv0vNyvtT_JA-1; Thu, 02 Apr 2020 17:44:59 -0400
X-MC-Unique: smppz1WRP9uv0vNyvtT_JA-1
Received: by mail-wr1-f71.google.com with SMTP id e10so2065380wrm.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 14:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SucngxGIsg1jO4fhhkoD14vVoqO9rTRmFbi7i+9UKhI=;
 b=JSC5u0/CuuhEVgclAynTBu9N3bu8zYvQgr1j7sfYl8JWpjYcfo5IOhCwou2QCm/5+S
 jOl7c+rdjctgHbKBWggVl5wWs0YJC9T7rhWy700xkcyFklv+ROYiCL088upHcq3297Yz
 HsivjLiKfYwHRpVh7xetoDI5bX10Xcn98Z1MvQpKND97AwMB2cNuOb199Bn7rR6dFrno
 L2dnHErGB04fcfVIlHFaPcTufVCtD9yJd55cGh9AvcuggeC/7pvNKhdaC/2zCBL/8fL1
 eeEv1IWzw2Q0nzgI8om/Nz4maPzwRNjoaLDti9/VQ6NUwypuOghzR93lWg/fl/9L1ccS
 Z7Ew==
X-Gm-Message-State: AGi0PuamaiXIo4nGAb9XI9eZMBYA+NC6+fDcQqIXnMs+hJyKw1/CPNWE
 UkHLPmCRwjLBxXl3t9KwK/Z33zLXWkCwISqq77SdFUvttNTNHfvqEXBw0aOBTAxpMXnd0IuBegN
 R/0crqmhdP75nfeY=
X-Received: by 2002:a1c:e242:: with SMTP id z63mr5517757wmg.72.1585863896869; 
 Thu, 02 Apr 2020 14:44:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypKDSqTdPhCZbTIjlLLqgYQ1e42ZHb0OgA0g3axM1LmqH1cca4U3p1acOReWIh3i0MIVZWqX0g==
X-Received: by 2002:a1c:e242:: with SMTP id z63mr5517730wmg.72.1585863896521; 
 Thu, 02 Apr 2020 14:44:56 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z3sm8355491wma.22.2020.04.02.14.44.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 14:44:55 -0700 (PDT)
Subject: Re: [PATCH for-5.0? v3] qemu-img: Report convert errors by bytes, not
 sectors
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200402135717.476398-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a0cc9691-22d1-d533-a66e-701524bb3628@redhat.com>
Date: Thu, 2 Apr 2020 23:44:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402135717.476398-1-eblake@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 3:57 PM, Eric Blake wrote:
> Various qemu-img commands are inconsistent on whether they report
> status/errors in terms of bytes or sector offsets.  The latter is
> confusing (especially as more places move to 4k block sizes), so let's
> switch everything to just use bytes everywhere.  One iotest is
> impacted.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> v3: Fix affected iotest [patchew]
>=20
>   qemu-img.c                 | 8 ++++----
>   tests/qemu-iotests/244.out | 2 +-
>   2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index b167376bd72e..821cbf610e5f 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1924,8 +1924,8 @@ retry:
>           if (status =3D=3D BLK_DATA && !copy_range) {
>               ret =3D convert_co_read(s, sector_num, n, buf);
>               if (ret < 0) {
> -                error_report("error while reading sector %" PRId64
> -                             ": %s", sector_num, strerror(-ret));
> +                error_report("error while reading at byte %lld: %s",
> +                             sector_num * BDRV_SECTOR_SIZE, strerror(-re=
t));
>                   s->ret =3D ret;
>               }
>           } else if (!s->min_sparse && status =3D=3D BLK_ZERO) {
> @@ -1953,8 +1953,8 @@ retry:
>                   ret =3D convert_co_write(s, sector_num, n, buf, status)=
;
>               }
>               if (ret < 0) {
> -                error_report("error while writing sector %" PRId64
> -                             ": %s", sector_num, strerror(-ret));
> +                error_report("error while writing at byte %lld: %s",
> +                             sector_num * BDRV_SECTOR_SIZE, strerror(-re=
t));
>                   s->ret =3D ret;
>               }
>           }
> diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
> index e6f4dc79934b..56329deb4b9f 100644
> --- a/tests/qemu-iotests/244.out
> +++ b/tests/qemu-iotests/244.out
> @@ -33,7 +33,7 @@ Convert to compressed target with data file:
>   Formatting 'TEST_DIR/t.IMGFMT.src', fmt=3DIMGFMT size=3D67108864
>   wrote 1048576/1048576 bytes at offset 0
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -qemu-img: error while writing sector 0: Operation not supported
> +qemu-img: error while writing at byte 0: Operation not supported
>=20
>   Convert uncompressed, then write compressed data manually:
>   Images are identical.
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


