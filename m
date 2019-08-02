Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0DEC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D362087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D362087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htV9y-0006T3-1X
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 06:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44915)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1htV9S-0005et-8c
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1htV9R-0002nx-8L
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:51:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1htV9R-0002mF-1U
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:51:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so76677389wrf.11
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 03:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UtmHekdr4G21p2dC7uRGPmXsg3+XlK8mss09aDaqnMA=;
 b=qkaFe2JK6xBQLqBcLxdM2eNNTphHg9HnVki6eHB48iADiTxx/KB/p73sFA1trde0Ba
 38Zd+ZGKnVAUSfTjnM3+I4WANzgkWbv8bhi5InsJNqQ2L/Wrx1wRhmciff9bYgxUoL1h
 t0tmM+eVcvi2ZiUWMQwgEFQDfyS1hU+2ID1dU1S1rKxEw7GHpWHVyKZYEz2QQ61VdJ5J
 F4WqRpDgeRbva9bn2Y1JUr3MAG5qh9E2F+vNmJCZ8FfktxhwlvnEF8O5/gsQ+P94ht23
 26wkQ/bwXBJfPhko2w2WtO0htE0BfWeWDXeGfQsyZeSHv3x8ZZvkkFqKbCZYgRaU6OXv
 VbGg==
X-Gm-Message-State: APjAAAUJdbe7aUNp7kC3t2EmDFIG1mq3mbQY/su4gaOAYmCmm7hOe/w9
 gLETytlthMeEVq/KXFKnrny70A==
X-Google-Smtp-Source: APXvYqx+/hMpPrbzH45yv0Z/QKeBL1TuvfVBdmWpu7QojxhL31pz/jtfXhUAH//WD0yY8Dv1PldJWw==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr50514421wrm.218.1564743067467; 
 Fri, 02 Aug 2019 03:51:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff?
 ([2001:b07:6468:f312:4013:e920:9388:c3ff])
 by smtp.gmail.com with ESMTPSA id w23sm81021737wmi.45.2019.08.02.03.51.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 03:51:06 -0700 (PDT)
To: Li Qiang <liq3ea@163.com>, mst@redhat.com
References: <20190801162820.11238-1-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <28780d5e-6089-27f4-44c0-60fa35081e86@redhat.com>
Date: Fri, 2 Aug 2019 12:51:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801162820.11238-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] hw: intel_iommu: initialize 'name' in
 vtd_find_add_as
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

On 01/08/19 18:28, Li Qiang wrote:
> The 'name' variable in vtd_find_add_as function is not initialized
> now, so when in gdb, we will got following output:
> 
> (gdb) p name
> $1 = "vtd-00.0\000\000\000\000\000\000\000\000\060\330\377\377\377\177\000\000\001\000\000\000\000\000\000\000p\330\377\377\377\177\000\000\353\362\372VUU\000\000p\330\377\377\377\177\000\000  \000\000\060b\000\000\220\021\000\000\360a\000\000\200\"\002\000\020a\000\000  \000\000\060b\000\000\200\332\377\377\377\177\000\000\240\330\377\377\377\177\000\000<\364\372VUU\000\000\000\000\000\000\000\000\000\000  \000\000\060b\000"
> 
> After this patch, it is more clear:
> 
> (gdb) p name
> $1 = "vtd-00.0", '\000' <repeats 119 times>
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>

There are hundreds of other occurrences of this same phenomenon.  It's
not a bug, it's just how the debugger chooses to print character arrays.

Paolo

> ---
>  hw/i386/intel_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index de86f53b4e..e379c2a512 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3286,7 +3286,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
>      uintptr_t key = (uintptr_t)bus;
>      VTDBus *vtd_bus = g_hash_table_lookup(s->vtd_as_by_busptr, &key);
>      VTDAddressSpace *vtd_dev_as;
> -    char name[128];
> +    char name[128] = {};
>  
>      if (!vtd_bus) {
>          uintptr_t *new_key = g_malloc(sizeof(*new_key));
> 


