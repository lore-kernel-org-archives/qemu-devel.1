Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C552C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0363D2063F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0363D2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57344 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfgPh-0007D7-OT
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 04:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45285)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hfgOr-0006lD-Ee
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hfgOm-0005QW-UR
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:01:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hfgOf-0004wT-H2
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:01:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so1855001wmj.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 01:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uxc3F61hidTqb8sPNldKP+dtqraZZxlm2dUHrEm81VY=;
 b=D4cwE6IXMVPFB3QiiPnwgb/kWAwQYHaQNiv2BZCMCTrvqiW89q7/I/+1JZyf+dkKjh
 NrOh5lOxr55pOvDHAnyTh96uJ7vjcJ+H0d2wJs4XlhhiLgizHdjxcakXoc0+TnXWjONw
 KmzUsBFrKnJLzy3+wwl0WdXNQ1yxIOHtImGEwfLOI68tdrkLAj7RIjOT9QJRcjYIaKLJ
 Q8DQy8oQvoGm6Elp7nPv9ZcaYKgZ5VSwR9FqSqtG1qESULpxNyqlKCOnHB8nUYW2eOog
 gSC1fTFZSmdub98sKw1K4LjBOBaspHZK/gMajJdgVBAAPdWnKGJk58KB7SnuGNZj8CHw
 CcXg==
X-Gm-Message-State: APjAAAW0Xtidz2/Q0VaBnlFMfcOKNVbvyCXP+4feJce2yYJB+BNTn9th
 KyLoFYAtEMBZUqRDhfE7RndlEA==
X-Google-Smtp-Source: APXvYqxjaM/UILGu15gLDo4PD3snKZpxN5Hu/g5GvxDv+X0iDl15C5xF226f73CGtrhABoFV6m9lYg==
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr18405294wmb.103.1561449681580; 
 Tue, 25 Jun 2019 01:01:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e88d:856c:e081:f67d?
 ([2001:b07:6468:f312:e88d:856c:e081:f67d])
 by smtp.gmail.com with ESMTPSA id i11sm1701552wmi.33.2019.06.25.01.01.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 01:01:21 -0700 (PDT)
To: Li Qiang <liq3ea@163.com>, peterx@redhat.com, mst@redhat.com
References: <20190624151635.22494-1-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be98a9c4-3a49-00e9-b67c-e362f234208e@redhat.com>
Date: Tue, 25 Jun 2019 10:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624151635.22494-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] ioapic: clear irq_eoi when updating the
 ioapic redirect table entry
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/19 17:16, Li Qiang wrote:
> irq_eoi is used to count the number of irq injected during eoi
> broadcast. It should be set to 0 when updating the ioapic's redirect
> table entry.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/intc/ioapic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 7074489fdf..db9e518602 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -380,6 +380,7 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t val,
>                  /* restore RO bits */
>                  s->ioredtbl[index] &= IOAPIC_RW_BITS;
>                  s->ioredtbl[index] |= ro_bits;
> +                s->irq_eoi[index] = 0;
>                  ioapic_fix_edge_remote_irr(&s->ioredtbl[index]);
>                  ioapic_service(s);
>              }
> 

Queued, thanks.

Paolo

