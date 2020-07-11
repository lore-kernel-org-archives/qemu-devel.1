Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B67C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 21:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90DD20725
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 21:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="A8a7rZeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90DD20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juMmW-0005ds-5o
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 17:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1juMls-000573-9i
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 17:10:56 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41]:37814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1juMlq-0008Rg-LB
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 17:10:55 -0400
Received: by mail-vk1-xa41.google.com with SMTP id q85so1982035vke.4
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=REb4y7GcfETX9SnJmZbCMXk+FEvmQCTen4+x3OMXdGc=;
 b=A8a7rZeAaIOnVOxgjAXC8acrxq8OX7EglrfEgkA6xQNWHwz+qXL8EEVpAzhcRj6CDG
 ziNCqj9MzK0vhbu76KzMiI87U2Cg0g0lq2TAJzuMVTtj4SSPaRVgdZUfyoZHrIf5XNwv
 QezVFqmqDpYhrKEbi7I+iCjGEQ77fkrV9h36Y8C16hBNzSQz9y9YPMuhY0U8vsNCVP3u
 Vm2D2dYHD5QytF8vxgEtwGDvFDiqIdk6VhK/V0dtBeNukQJ6btD64h2CnrEHVIJHvIu3
 RJlEg/n23KnnXlqPelgu7uQzVNM0Oc0FTuX6CC/0dmFhV8WrzAY26QyVgBWVhutTuzbu
 cJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=REb4y7GcfETX9SnJmZbCMXk+FEvmQCTen4+x3OMXdGc=;
 b=aMktuferr+nLZhH/yaDUmbM1q2S4cLyhtf20ErhYEPbHw3F+idBtC0hxRAQF/nmqpY
 xNfS2Hwg1J3z07f+JAbsqAQZEbiuaLqkqc6R4f4bTJeG2cdVVw/gfWyf3TbO4V8uRUJA
 iXDOFwkNz+lpd7B7cTuRZjupc4KtKV4XhwVwYHZcvH3GRNbN8urvL/IXT+I7pkncisMU
 sWegsDIkijumW4zHMZIVWscWF+WR0XXnMWwiau6CUJRD/tfYGfFZi9K5Dq4iDEkI+Run
 cyk9noXWCANhPe54iXKkR7Orz/GzHZhFkmPGdsF2k0uU2wo87ufi+y5Cdv1QLgUETLq0
 REWQ==
X-Gm-Message-State: AOAM533YOlPuAM3q1eicZq+OzbuYWNgM/cE61rttfr8nGjYz8+cnYuM7
 DprwIAnjrsYmnq8gPGVAj/0Cug==
X-Google-Smtp-Source: ABdhPJx0FruQkITZnm7yL9YvVJZdTnP+3VUHvhnByUalUUSakSYj5uae1fjhawYeRRI7NQVdbbB2ag==
X-Received: by 2002:a1f:acc2:: with SMTP id v185mr17399666vke.18.1594501853373; 
 Sat, 11 Jul 2020 14:10:53 -0700 (PDT)
Received: from localhost ([37.120.215.156])
 by smtp.gmail.com with ESMTPSA id t13sm834675vst.9.2020.07.11.14.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 14:10:52 -0700 (PDT)
Date: Sat, 11 Jul 2020 17:10:51 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 04/13] cputlb: ensure we save the IOTLB data in case
 of reset
Message-ID: <20200711211051.GC807960@sff>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200709141327.14631-5-alex.bennee@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::a41;
 envelope-from=cota@braap.org; helo=mail-vk1-xa41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 f4bug@amsat.org, aaron@os.amperecomputing.com,
 Paolo Bonzini <pbonzini@redhat.com>, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 15:13:18 +0100, Alex Bennée wrote:
> Any write to a device might cause a re-arrangement of memory
> triggering a TLB flush and potential re-size of the TLB invalidating
> previous entries. This would cause users of qemu_plugin_get_hwaddr()
> to see the warning:
> 
>   invalid use of qemu_plugin_get_hwaddr
> 
> because of the failed tlb_lookup which should always succeed. To
> prevent this we save the IOTLB data in case it is later needed by a
> plugin doing a lookup.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

Some minor comments below.


> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1073,6 +1073,42 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>      return val;
>  }
>  
> +#ifdef CONFIG_PLUGIN
> +
> +typedef struct SavedIOTLB {
> +    struct rcu_head rcu;
> +    hwaddr addr;
> +    MemoryRegionSection *section;
> +    hwaddr mr_offset;
> +} SavedIOTLB;
> +
> +/*
> + * Save a potentially trashed IOTLB entry for later lookup by plugin.
> + *
> + * We also need to track the thread storage address because the RCU
> + * cleanup that runs when we leave the critical region (the current
> + * execution) is actually in a different thread.

Mentioning the thread storage is now outdated -- I think this comment
(starting from 'We') can be removed.

> + */
> +static void save_iotlb_data(CPUState *cs, hwaddr addr, MemoryRegionSection *section, hwaddr mr_offset)
> +{
> +    SavedIOTLB *old, *new = g_new(SavedIOTLB, 1);
> +    new->addr = addr;
> +    new->section = section;
> +    new->mr_offset = mr_offset;
> +    old = atomic_rcu_read(&cs->saved_iotlb);
> +    atomic_rcu_set(&cs->saved_iotlb, new);
> +    if (old) {
> +        g_free_rcu(old, rcu);
> +    }

Using atomic_rcu_read here is not necessary (only this thread ever writes
to this field) and might confuse a reader when trying to find the
atomic_rcu_read that matches the atomic_rcu_set (that read is in
tlb_plugin_lookup).

Consider doing
	old = cs->saved_iotlb;
instead.

Thanks,
		Emilio

