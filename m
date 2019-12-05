Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CFBC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B60B2245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hz9SrioF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B60B2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icmfC-0006xx-FN
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 03:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1icmdk-0005hT-3T
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1icmdh-0007Qb-Dg
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:37:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32893
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1icmdh-0007Kc-2G
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575535051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjAx9qo7unBhZw8XOGVCMog1QrLyKDuC1ZKnNfrR6Ic=;
 b=hz9SrioF5+VBH3BtIGq4+dpYY39ZaPSxJ+07ffymMTDFAArVkukk3cFr1XtRX26NICNz3A
 aM8YUsBDBDCtVU5AsL1fZrLXFYnNGcGwojuZNX934ShvtfRmViLFcVyLbf/E3AyQZuLkMy
 vDe+g0fQ0K9i0iey+MHBvfSbBk2qGo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-KrgiRwe-O-WdUIogmUeZOw-1; Thu, 05 Dec 2019 03:37:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D46541005502;
 Thu,  5 Dec 2019 08:37:28 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C13B517AA3;
 Thu,  5 Dec 2019 08:37:27 +0000 (UTC)
Subject: Re: [PATCH 4/5] hw/arm/smmuv3: Use correct bit positions in
 EVT_SET_ADDR2 macro
To: Simon Veith <sveith@amazon.de>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <1575467748-28898-1-git-send-email-sveith@amazon.de>
 <1575467748-28898-5-git-send-email-sveith@amazon.de>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <56987d35-a6cc-e9dc-b216-efae755a9fe0@redhat.com>
Date: Thu, 5 Dec 2019 09:37:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1575467748-28898-5-git-send-email-sveith@amazon.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: KrgiRwe-O-WdUIogmUeZOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Simon,

On 12/4/19 2:55 PM, Simon Veith wrote:
> The bit offsets in the EVT_SET_ADDR2 macro do not match those specified
> in the ARM SMMUv3 Architecture Specification. In all events that use
> this macro, e.g. F_WALK_EABT, the faulting fetch address or IPA actually
> occupies the 32-bit words 6 and 7 in the event record contiguously, with
> the upper and lower unused bits clear due to alignment or maximum
> supported address bits. How many bits are clear depends on the
> individual event type.
> 
> Update the macro to write to the correct words in the event record so
> that guest drivers can obtain accurate address information on events.
> 
> ref. ARM IHI 0070C, sections 7.3.12 through 7.3.16.
> 
> Signed-off-by: Simon Veith <sveith@amazon.de>
Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> ---
>  hw/arm/smmuv3-internal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index d190181..eb275e2 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -461,8 +461,8 @@ typedef struct SMMUEventInfo {
>      } while (0)
>  #define EVT_SET_ADDR2(x, addr)                            \
>      do {                                                  \
> -            (x)->word[7] = deposit32((x)->word[7], 3, 29, addr >> 16);   \
> -            (x)->word[7] = deposit32((x)->word[7], 0, 16, addr & 0xffff);\
> +            (x)->word[7] = (uint32_t)(addr >> 32);        \
> +            (x)->word[6] = (uint32_t)(addr & 0xffffffff); \
>      } while (0)
>  
>  void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
> 


