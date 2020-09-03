Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEECC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395552054F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOx+S9GV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395552054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpts-0006qf-7L
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 10:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDpql-0004xS-NH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:04:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29280
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDpqi-00049U-8W
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599141862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KdQFCDIP0td3Ke7dofGMgnpeuH8euYaUWYxZlPQaTSQ=;
 b=EOx+S9GVjMBhydCX8uu/tHjk+jjg7I9GOfQf7saVEzeUTNaaX2l/EaiwEwBWmm3t6/tYhF
 d+mUguuE4ekQ8+Mv+/lsLhitZQc3TZ4Gbq9BWExLxI9oHnio+wGpWVaks5xmn6j+iDxtT0
 E4M6skYrylR/nd2cL9rL++3mTE6FEjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-MZw3ByHdNduATz1d207kTg-1; Thu, 03 Sep 2020 10:04:19 -0400
X-MC-Unique: MZw3ByHdNduATz1d207kTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8CBE18BA285;
 Thu,  3 Sep 2020 14:04:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-10.ams2.redhat.com [10.36.114.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E2A95C1C2;
 Thu,  3 Sep 2020 14:04:06 +0000 (UTC)
Subject: Re: [PATCH 2/2] hw/timer/hpet: Fix DPRINTF format string
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200903134506.440082-1-philmd@redhat.com>
 <20200903134506.440082-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <12e0c867-4d8d-43ef-1ba1-6696619947d0@redhat.com>
Date: Thu, 3 Sep 2020 16:04:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200903134506.440082-3-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/2020 15.45, Philippe Mathieu-Daudé wrote:
> Fix building with HPET_DEBUG enabled:
> 
>   hw/timer/hpet.c:512:73: error: format specifies type 'unsigned int' but the argument has type 'uint64_t' (aka 'unsigned long') [-Werror,-Wformat]
>       DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n", addr, value);
>                                                             ~~~           ^~~~~
>                                                             %#lx
>   hw/timer/hpet.c:655:21: error: format specifies type 'unsigned int' but the argument has type 'uint64_t' (aka 'unsigned long') [-Werror,-Wformat]
>                       value, s->hpet_counter);
>                       ^~~~~
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Keep trace-events conversion as ByteSizeTask.
> ---
>  hw/timer/hpet.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index b683f64f1d3..8115e42cff3 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -495,7 +495,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>      HPETState *s = opaque;
>      uint64_t old_val, new_val, val, index;
>  
> -    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n", addr, value);
> +    DPRINTF("qemu: Enter hpet_ram_writel at 0x%" HWADDR_PRIx " = 0x%#"PRIx64"\n", addr, value);
>      index = addr;
>      old_val = hpet_ram_read(opaque, addr, 4);
>      new_val = value;
> @@ -637,7 +637,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>              }
>              s->hpet_counter =
>                  (s->hpet_counter & 0xffffffff00000000ULL) | value;
> -            DPRINTF("qemu: HPET counter written. ctr = %#x -> %" PRIx64 "\n",
> +            DPRINTF("qemu: HPET counter written. ctr = %#" PRIx64 " -> %" PRIx64 "\n",
>                      value, s->hpet_counter);
>              break;
>          case HPET_COUNTER + 4:
> @@ -646,7 +646,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>              }
>              s->hpet_counter =
>                  (s->hpet_counter & 0xffffffffULL) | (((uint64_t)value) << 32);
> -            DPRINTF("qemu: HPET counter + 4 written. ctr = %#x -> %" PRIx64 "\n",
> +            DPRINTF("qemu: HPET counter + 4 written. ctr = %#" PRIx64 " -> %" PRIx64 "\n",
>                      value, s->hpet_counter);
>              break;
>          default:
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


