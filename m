Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CFAC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 18:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661C9205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 18:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661C9205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41759 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn5jM-0007hB-JA
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 14:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58852)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hn5jB-0007IL-Oj
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 14:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hn5jA-0002Va-NY
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 14:29:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hn5jA-0002Tq-EI
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 14:29:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so18226981wru.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 11:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0RhHwIUL8kDeVWFR5G96Jni2KX+TcbVRuIgdEI4bm2U=;
 b=tyrTTtuf1yZGBI6Hk1UmgXFeBnhXigHluSi4e/1JrIJ8nec3nL6TYe0DFIVohQ2Cav
 mKcW//z+6cP+1FGFWJD6vb+k48n3OvMV3epE97dwvW1Cfu22Lb1yykXMCX6ukcQyxsh+
 2skV8eAgdg9xZPGZNA15zzfvgGz5bi8czgmzN2kPJ5LNbwAtYbqlceZj9O7c635UeXzk
 xL2CzFHuKjrWvwJRRtWCk/EA1CNQPOcQOVfCujiVzm9OWg28HGEFtxy9Qcf8Uo5DxUQp
 gtVmQUi/Pys9d3LHgJq4om0ha/t3shejaw9O9YRsdu03GqoP+MjIeTN7ZlgWAuLtFYJu
 c9iw==
X-Gm-Message-State: APjAAAWCmxpEwFCufRqoP3KLKET0QjYKJ2EVjtLqu1yO5uF1ebBeYicg
 bgPD1GKeBTupyJ57WlpyJolb+A==
X-Google-Smtp-Source: APXvYqziKr72h67Qmkcc+9KKmUWKXz7qAhAyb/FgER87zGp+ELg65Q7M1Bmq7w0al9j1lWXI0bj4KA==
X-Received: by 2002:a5d:51c1:: with SMTP id n1mr26088710wrv.254.1563215370335; 
 Mon, 15 Jul 2019 11:29:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b159:8d52:3041:ae0d?
 ([2001:b07:6468:f312:b159:8d52:3041:ae0d])
 by smtp.gmail.com with ESMTPSA id o11sm17256283wmh.37.2019.07.15.11.29.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 11:29:29 -0700 (PDT)
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <156320087103.2556.10983987500488190423.stgit@gimli.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e5f5a2f9-23a6-1fcb-d16a-1907825c4169@redhat.com>
Date: Mon, 15 Jul 2019 20:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <156320087103.2556.10983987500488190423.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH for-4.1] target/i386: sev: Do not unpin ram
 device memory region
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
Cc: brijesh.singh@amd.com, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/19 16:28, Alex Williamson wrote:
> The commit referenced below skipped pinning ram device memory when
> ram blocks are added, we need to do the same when they're removed.
> 
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Fixes: cedc0ad539af ("target/i386: sev: Do not pin the ram device memory region")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  target/i386/sev.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 6dbdc3cdf10f..5ba1384ea1f6 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -161,6 +161,17 @@ sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size)
>  {
>      int r;
>      struct kvm_enc_region range;
> +    ram_addr_t offset;
> +    MemoryRegion *mr;
> +
> +    /*
> +     * The RAM device presents a memory region that should be treated
> +     * as IO region and should not have been pinned.
> +     */
> +    mr = memory_region_from_host(host, &offset);
> +    if (mr && memory_region_is_ram_device(mr)) {
> +        return;
> +    }
>  
>      range.addr = (__u64)(unsigned long)host;
>      range.size = size;
> 

Queued, thanks.

Paolo

