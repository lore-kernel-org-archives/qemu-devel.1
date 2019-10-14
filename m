Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBEAC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABD9217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbQ6MckY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABD9217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2Yj-0004vr-7o
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK2XV-0004BG-L7
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK2XT-0007WF-HX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:45:41 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK2XT-0007Ul-BY
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:45:39 -0400
Received: by mail-pl1-x644.google.com with SMTP id w8so8177522plq.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IrS3xE40X23O9deChjT+7WzHLLNBRoS5UfnL3rbcn5o=;
 b=VbQ6MckY0sCSl775PO/fJqQK24WneI9Ul1s1wKbKzjKs43Y5cEIVQmVUZTgFLWZOJM
 AzufDBLrlTMQuC8H9xvtwewsEPIblNZqGfn4/QJPMF7UjpJE0JUdtROLzWpzM0lAiOKQ
 rJRITg+YR5oX0NATYVRp4YeNA0RIb6uLCbi8ybA7Nljc8hWbbZ/yYwt0/YyNOKoGWXtJ
 BYVrE3fovuapWvCDpKqAAcWPhG8yc2rwG7RcVxEkAdDJeWPjg6vYXmmrAh8yYdUvfGWC
 zNmATINkfNg0C30w0CjmjHVOz4rTeqlfVb2Aq1kIUK039ZORUS/3C2IJ3oskxKKS8Fgv
 Xh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IrS3xE40X23O9deChjT+7WzHLLNBRoS5UfnL3rbcn5o=;
 b=WU2yZ1uVffIT+vj9ooend6wqPzw/hn+coAVXCAXOUM6Nu3zrg/e1I+NRXl6JWFHURj
 op+aEFYT2Nz397VjzTLB3tH1/qtYvYDP2pu84YplAy8SzQZboqgzUGDHu8YqLCVZYe0+
 XiaauNENVOuYiDGEXMwHXxMomQqrZ17r6airuJXB7lfJgCRuRTcoQKNSrPgPjp6z7RSV
 j79ynPOxx9FYfVAl+0r6+M9GPvpJCHD+hyFsKk6Po+nVP+ncdHUdtNJiWovwSE7gISed
 7p9peuJxAlyq00pkIXYbGmCiCa49aA/4MomcsPtZXmwVL5S+yE+hdI/VVcYT734GqBIN
 KufQ==
X-Gm-Message-State: APjAAAXWr09hAYVbQEI/7V4aOJ4a2AqFrxOhEf8xDIjk/oMKYZG2ol2u
 wOMwBODK2lsNyaAC9ilJw3r/kQ==
X-Google-Smtp-Source: APXvYqz/fIakr9druKHafpW2juOYKTLItnWIgaal/NgUbHoFVttDM198bHN03W60/NsW0OWR+BPGFg==
X-Received: by 2002:a17:902:6905:: with SMTP id
 j5mr31752275plk.323.1571067937847; 
 Mon, 14 Oct 2019 08:45:37 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id y8sm15029589pgs.34.2019.10.14.08.45.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 08:45:36 -0700 (PDT)
Subject: Re: [PATCH v5 17/55] plugins: implement helpers for resolving hwaddr
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1dbbc6b6-0898-ea5c-ea2a-cd29614cd615@linaro.org>
Date: Mon, 14 Oct 2019 08:45:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: robert.foley@futurewei.com, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:49 AM, Alex Bennée wrote:
> +bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
> +                       bool is_store, struct qemu_plugin_hwaddr *data)
> +{
> +    CPUArchState *env = cpu->env_ptr;
> +    CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
> +    target_ulong tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
> +
> +    if (likely(tlb_hit(tlb_addr, addr))) {
> +        if (tlb_addr & TLB_MMIO) {
> +            data->hostaddr = 0;
> +            data->is_io = true;
> +            /* XXX: lookup device */
> +        } else {
> +            data->hostaddr = addr + tlbe->addend;
> +            data->is_io = false;

...

>  uint64_t qemu_plugin_hwaddr_to_raddr(const struct qemu_plugin_hwaddr *haddr)
>  {
> +#ifdef CONFIG_SOFTMMU
> +    ram_addr_t ram_addr = 0;
> +
> +    if (haddr && !haddr->is_io) {
> +        ram_addr = qemu_ram_addr_from_host((void *) haddr->hostaddr);
> +        if (ram_addr == RAM_ADDR_INVALID) {

So, did you want the host address or the ram_addr?

If you really only want the ram_addr then you can get
that directly from the (io)tlb:

    uintptr_t index = tlb_index(env, mmu_idx, addr);
    CPUTLB *tlb = &cpu_neg(cpu)->tlb;
    CPUIOTLBEntry *iotlbentry = &tlb->d[mmu_idx].iotlb[index];

    data->raddr = addr + iotlbentry->addr;

That said, what you have works.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

