Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE9BC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3C9206BF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgkLnpxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3C9206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0lZ-00072g-8s
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT0kC-00060E-UP
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT0kB-0006KH-LC
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:12:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43192
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jT0kB-0006HX-8b
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587982326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEKjFrawBvjAEELDaO6epI3eLpu97RRKGa5s2m7cqDE=;
 b=DgkLnpxWEt99tmWI4a36OAh9BPiAYUTs3Tn5qPI0XARLAPASdUwlGrfqqW/7Kj9IYmAPW/
 CYYg/hJobS0E1hEnEVhYS6K19/TaA5cbhvXYE3RNO/osaNB2MMNlQ9tP232liOgOVEa9pj
 uOFvJTWLwSCXLW1hVAlSncAPVMQoNOU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-NVg1OAGyP2Seiogsv5cqPw-1; Mon, 27 Apr 2020 06:12:03 -0400
X-MC-Unique: NVg1OAGyP2Seiogsv5cqPw-1
Received: by mail-wm1-f69.google.com with SMTP id w2so5342008wmc.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 03:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vEKjFrawBvjAEELDaO6epI3eLpu97RRKGa5s2m7cqDE=;
 b=GIeGIAfYJcrTHSzqUuXoUl8e4T7nJFG9gMOrR6Z3fhr/7Rxnycm3dSe4l9wJ1Y9jMg
 JYrjmawfTG8r7+ufFItSuaiUuX9rTCDkwl+D4f5zRQxglegVaT0E/G1ffg9uDp3nr4TM
 bKi2+wd6amzoO56oFIBrPzrb8UUMgjy4tGMJTD+x/fmAjYG4MW0VI594EufQMQAkTWFz
 5UdUp1TG2uSDzbaKZpvArRPKHkMP2uWdC3heujz+suhyTcw50IlEvGTCVBQ9DYLmdwkY
 i2e9ZPKo9/jdj5v4+cghK1rdTSbEKHcN88b0fZkb/6ouMDf+VnwljaGs+xRBTajKe70W
 +PwA==
X-Gm-Message-State: AGi0PuZGygSUkqPxVPrR9x/qS+lTlIGyjp7M7VQKYnWxtvgTblFdECa6
 WOUDYlVFUpISeTm6lL2HGacLTHQ+Z2hxrlqRraPaQzGJSw45GRx3R5O3VI6N4PIlmV6mGHfii1v
 Cj2pLqFLQeO09EL0=
X-Received: by 2002:adf:edcc:: with SMTP id v12mr27210697wro.317.1587982321866; 
 Mon, 27 Apr 2020 03:12:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypLZMTwwPlew2cq0ASUjPKKZLKYiSfNHFtfeCt4Nz/RvM6uk+4v7KOFByp3NPBbE+s/e/LMNAA==
X-Received: by 2002:adf:edcc:: with SMTP id v12mr27210660wro.317.1587982321644; 
 Mon, 27 Apr 2020 03:12:01 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id 74sm21320449wrk.30.2020.04.27.03.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 03:12:01 -0700 (PDT)
Subject: Re: [PATCH v2 02/17] block: use int64_t as bytes type in tracked
 requests
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-3-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ab987de2-812b-7d31-ed3a-aafc7d44399b@redhat.com>
Date: Mon, 27 Apr 2020 12:11:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200427082325.10414-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 ronniesahlberg@gmail.com, sw@weilnetz.de, stefanha@redhat.com, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com,
 sheepdog@lists.wpkg.org, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 namei.unix@gmail.com, den@openvz.org, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 10:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> We are generally moving to int64_t for both offset and bytes parameters
> on all io paths. Convert tracked requests now.

This doesn't seem a strong justification... If I understand correctly 
this patch, it is safer to use positive signed type rather than unsigned 
type. OK it might make sense to better catch overflow, but it should be 
explained in the function prototypes, else commit message, else the 
series cover IMHO.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/block/block_int.h |  4 ++--
>   block/io.c                | 11 ++++++-----
>   2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 4c3587ea19..c8daba608b 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -70,12 +70,12 @@ enum BdrvTrackedRequestType {
>   typedef struct BdrvTrackedRequest {
>       BlockDriverState *bs;
>       int64_t offset;
> -    uint64_t bytes;
> +    int64_t bytes;
>       enum BdrvTrackedRequestType type;
>   
>       bool serialising;
>       int64_t overlap_offset;
> -    uint64_t overlap_bytes;
> +    int64_t overlap_bytes;
>   
>       QLIST_ENTRY(BdrvTrackedRequest) list;
>       Coroutine *co; /* owner, used for deadlock detection */
> diff --git a/block/io.c b/block/io.c
> index aba67f66b9..7cbb80bd24 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -692,10 +692,11 @@ static void tracked_request_end(BdrvTrackedRequest *req)
>   static void tracked_request_begin(BdrvTrackedRequest *req,
>                                     BlockDriverState *bs,
>                                     int64_t offset,
> -                                  uint64_t bytes,
> +                                  int64_t bytes,
>                                     enum BdrvTrackedRequestType type)
>   {
> -    assert(bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
> +    assert(offset >= 0 && bytes >= 0 &&
> +           bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
>   
>       *req = (BdrvTrackedRequest){
>           .bs = bs,
> @@ -716,7 +717,7 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
>   }
>   
>   static bool tracked_request_overlaps(BdrvTrackedRequest *req,
> -                                     int64_t offset, uint64_t bytes)
> +                                     int64_t offset, int64_t bytes)
>   {
>       /*        aaaa   bbbb */
>       if (offset >= req->overlap_offset + req->overlap_bytes) {
> @@ -773,8 +774,8 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
>   {
>       BlockDriverState *bs = req->bs;
>       int64_t overlap_offset = req->offset & ~(align - 1);
> -    uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
> -                               - overlap_offset;
> +    int64_t overlap_bytes =
> +            ROUND_UP(req->offset + req->bytes, align) - overlap_offset;
>       bool waited;
>   
>       qemu_co_mutex_lock(&bs->reqs_lock);
> 


