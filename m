Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB92C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD26206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBF74msI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD26206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVKBE-0008VN-Lj
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 13:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iVK9r-0007b4-D9
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iVK9p-0001qc-6O
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:47:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43373
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iVK9o-0001q3-Lh
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573757271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4Dgl0jipxuxAHbgsvojEcxg/zVNh3DhEiG5QSO/ras=;
 b=OBF74msIlkjRUXuuLblsKZ+cMQ/5qkDt3vhJ64C+xbuuMDJ58I8ezg0LMyaMJ9IuEcAHTp
 pfRa5XjDm3ltXqDyOmuXBXEyDdb6gmt4aCuqJ8a04wUOjMiVJ9/UL1RX6ybb63Ci3FD+Mq
 Szx1fsM8xfrhqyRyWjOhwtdgoYhtu+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-uKyuy4d4MM-sc3sp_-pALg-1; Thu, 14 Nov 2019 13:47:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C26A800C73;
 Thu, 14 Nov 2019 18:47:45 +0000 (UTC)
Received: from [10.3.116.242] (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E065600CA;
 Thu, 14 Nov 2019 18:47:41 +0000 (UTC)
Subject: Re: [PATCH v2 00/10] Further bitmaps improvements
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191022125839.12633-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4aec835a-a894-03a0-11e4-0407e0f18a84@redhat.com>
Date: Thu, 14 Nov 2019 12:47:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022125839.12633-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: uKyuy4d4MM-sc3sp_-pALg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 7:58 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi!
>=20
> The main feature here is improvement of _next_dirty_area API, which I'm
> going to use then for backup / block-copy.
>=20
> v2:
> 01: just use INT64_MAX instead of adding new constant
> 08: add separate function nbd_extent_array_convert_to_be and converted
>      state of NBDExtentArray, to make these things explicit, and avoid
>      extra memdup.
> 09: Save part of comment for bitmap_to_extents(), add Eric's r-b

Is any of this series a bug fix important to get into -rc2?  Or is it=20
safe to defer to the 5.0 timeframe?

>=20
> Vladimir Sementsov-Ogievskiy (10):
>    hbitmap: assert that we don't create bitmap larger than INT64_MAX
>    hbitmap: move hbitmap_iter_next_word to hbitmap.c
>    hbitmap: unpublish hbitmap_iter_skip_words
>    hbitmap: drop meta bitmaps as they are unused
>    block/dirty-bitmap: switch _next_dirty_area and _next_zero to int64_t
>    block/dirty-bitmap: add _next_dirty API
>    block/dirty-bitmap: improve _next_dirty_area API
>    nbd/server: introduce NBDExtentArray
>    nbd/server: use bdrv_dirty_bitmap_next_dirty_area
>    block/qcow2-bitmap: use bdrv_dirty_bitmap_next_dirty
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


