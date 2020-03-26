Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BFEC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B9C20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULpfs/LF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B9C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHW3g-0005w0-Vr
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 13:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHW2s-0004dA-Lm
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHW2r-0006bI-4x
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:11:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23969)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHW2r-0006aZ-23
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585242712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVXqHm+4ue0BofojqUKCOQqp9W7Ns++tEQLrEqek4RQ=;
 b=ULpfs/LFB4sRz7hYg4VIkB8eWid8BzcAU98bufBTwDvgb3sKViYiaFEMLWhtu9urdNB5X/
 V4hnJAv63PxlDQrFbv6XdR92bRaYP0YJPStTJavSK/JQQKv0bfJDwmTRNd1cDcL3Y81TmN
 O/bIPxsijI7nOR5B+SUOwDNU+05pmJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-rQYmf4m4MlGLVgA5HOvexw-1; Thu, 26 Mar 2020 13:11:47 -0400
X-MC-Unique: rQYmf4m4MlGLVgA5HOvexw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF5AA800D50;
 Thu, 26 Mar 2020 17:11:46 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9602C19C69;
 Thu, 26 Mar 2020 17:11:46 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Remove unused fields from BDRVQcow2State
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200326170757.12344-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <01b85e0d-8e02-3430-821f-e3294c735437@redhat.com>
Date: Thu, 26 Mar 2020 12:11:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326170757.12344-1-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 12:07 PM, Kevin Wolf wrote:
> These fields were already removed in commit c3c10f72, but then commit
> b58deb34 revived them probably due to bad merge conflict resolution.
> They are still unused, so remove them again.
> 
> Fixes: b58deb344ddff3b9d8b265bf73a65274767ee5f4
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qcow2.h | 3 ---
>   1 file changed, 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/qcow2.h b/block/qcow2.h
> index 0942126232..f4de0a27d5 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -301,9 +301,6 @@ typedef struct BDRVQcow2State {
>       QEMUTimer *cache_clean_timer;
>       unsigned cache_clean_interval;
>   
> -    uint8_t *cluster_cache;
> -    uint8_t *cluster_data;
> -    uint64_t cluster_cache_offset;
>       QLIST_HEAD(, QCowL2Meta) cluster_allocs;
>   
>       uint64_t *refcount_table;
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


