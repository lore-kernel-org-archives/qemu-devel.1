Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CD5C742D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13D9204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13D9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzgU-0003lf-TM
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43366)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlzgK-0003N4-T1
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlzgJ-0001lx-Sa
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:50:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlzgI-0001i7-4d
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:50:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so10786738wrf.11
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GBDBfQXP/g3GTy20Feie8XCS7I3O37ORoj+kbmDxNvs=;
 b=i3j00Qw2YGse81M0s+7sYdX0pvBnPvr2y+KouEJ+HLu5Km5ImgkHi9eBq8LZ1dXsyk
 fmFcKqSWzAVmGmPWmj6dFxtsDs+lHFI0nz2b1FTeekDY+EldLrJtoeliUNCTj6H7XUqC
 ZkFFQAu7saV0esKAt1EI+V4p3nf/aPD3znfXTltHngWGkol8v1lg16A/EjzwiUc7mx3C
 yl5lxzEQDgUkZKkHJLvTv2fqyfzGscom3RehUYB0XliP2+BsEu9o2tb4evyFDLdXxXIt
 wF9Yz6L1yk61YUjS8GjHxLt0VLujqm7dsa0ZPDxHiaGgJxvQGwqYI7tTo+1I/i9jt6+w
 fjkw==
X-Gm-Message-State: APjAAAW96/8iqcK/IbPZNDZuFMTpJTCJRlR6XTeEJQTEi/74V//tEBEo
 3NZyFN8S/FDJec9e/3uYtdh8Mg==
X-Google-Smtp-Source: APXvYqwpzRzW536i5shGPooEFuEN8vJG12DWYtJ0AMQQuujaD6gmr7WND8lO8DJcM6DsI4hZZKzoyw==
X-Received: by 2002:adf:db50:: with SMTP id f16mr13464806wrj.214.1562953801125; 
 Fri, 12 Jul 2019 10:50:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id i13sm9472484wrr.73.2019.07.12.10.50.00
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:50:00 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
References: <20190712132611.20411-1-sw@weilnetz.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <69209a2c-80d2-dd79-beb6-9e5b47ae58a0@redhat.com>
Date: Fri, 12 Jul 2019 19:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712132611.20411-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH for 4.1] Fix broken build with WHPX enabled
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/07/19 15:26, Stefan Weil wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  target/i386/whpx-all.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 31d47320e4..ed95105eae 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -1396,7 +1396,7 @@ static int whpx_accel_init(MachineState *ms)
>      }
>  
>      memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
> -    prop.ProcessorCount = smp_cpus;
> +    prop.ProcessorCount = ms->smp.cpus;
>      hr = whp_dispatch.WHvSetPartitionProperty(
>          whpx->partition,
>          WHvPartitionPropertyCodeProcessorCount,
> @@ -1405,7 +1405,7 @@ static int whpx_accel_init(MachineState *ms)
>  
>      if (FAILED(hr)) {
>          error_report("WHPX: Failed to set partition core count to %d,"
> -                     " hr=%08lx", smp_cores, hr);
> +                     " hr=%08lx", ms->smp.cores, hr);
>          ret = -EINVAL;
>          goto error;
>      }
> 

Queued, thanks.

Paolo

