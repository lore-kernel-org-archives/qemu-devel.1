Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CEAECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C095218DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C095218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHOK-0005S0-EO
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iIDzG-0001Ae-U2
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iIDzF-0005qh-Qb
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:34:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iIDzD-0005ma-De; Wed, 09 Oct 2019 11:34:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4888B806A7A;
 Wed,  9 Oct 2019 15:34:46 +0000 (UTC)
Received: from [10.3.116.162] (ovpn-116-162.phx2.redhat.com [10.3.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E63E35DA2C;
 Wed,  9 Oct 2019 15:34:41 +0000 (UTC)
Subject: Re: [PATCH 01/10] hbitmap: introduce HBITMAP_MAX_ORIG_SIZE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190930151502.7829-1-vsementsov@virtuozzo.com>
 <20190930151502.7829-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a128842b-d3c8-adb7-ec27-c07f59fd53fc@redhat.com>
Date: Wed, 9 Oct 2019 10:34:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930151502.7829-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 09 Oct 2019 15:34:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/19 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

A bit light on the commit message for explaining why.

> ---
>   include/qemu/hbitmap.h | 7 +++++++
>   util/hbitmap.c         | 2 ++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
> index 1bf944ca3d..82317c5364 100644
> --- a/include/qemu/hbitmap.h
> +++ b/include/qemu/hbitmap.h
> @@ -33,6 +33,13 @@ typedef struct HBitmapIter HBitmapIter;
>    */
>   #define HBITMAP_LEVELS         ((HBITMAP_LOG_MAX_SIZE / BITS_PER_LEVEL) + 1)
>   
> +/*
> + * We have APIs which returns signed int64_t, to be able to return error.
> + * Therefore we can't handle bitmaps with absolute size larger than
> + * (INT64_MAX+1). Still, keep it INT64_MAX to be a bit safer.
> + */
> +#define HBITMAP_MAX_ORIG_SIZE INT64_MAX

That, and bitmaps represent disk images, but disk images can't exceed 
INT64_MAX bytes (thanks to off_t being signed).  But does introducing a 
new constant really help?

> +
>   struct HBitmapIter {
>       const HBitmap *hb;
>   
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index 757d39e360..df192234e3 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -708,6 +708,7 @@ HBitmap *hbitmap_alloc(uint64_t size, int granularity)
>       HBitmap *hb = g_new0(struct HBitmap, 1);
>       unsigned i;
>   
> +    assert(size <= HBITMAP_MAX_ORIG_SIZE);

or can we just inline INT64_MAX here?

>       hb->orig_size = size;
>   
>       assert(granularity >= 0 && granularity < 64);
> @@ -738,6 +739,7 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
>       uint64_t num_elements = size;
>       uint64_t old;
>   
> +    assert(size <= HBITMAP_MAX_ORIG_SIZE);
>       hb->orig_size = size;
>   
>       /* Size comes in as logical elements, adjust for granularity. */
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

