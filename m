Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 08:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57021206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 08:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxBO8w4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57021206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jffWO-0003Qv-HC
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 04:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jffVo-0002sc-NK; Mon, 01 Jun 2020 04:09:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jffVn-0006jM-5D; Mon, 01 Jun 2020 04:09:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so4578182wrc.7;
 Mon, 01 Jun 2020 01:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S/vy6ProRnX/IxMiIPIBm1J9HAqTrgB5aNqJueLyivE=;
 b=mxBO8w4f+toeBGDWhRSPGCgj1vK4Zsol8NpDKyoIWBSHqVdHUpr3C3MeKkZbGkSl4s
 oIExtEO/+Wtr/a7/eIY1kGvTOCyfNES/PYA2xt6wll2PLQDjsDaQ9sn3q4dWSH6FQmo4
 CyGo16iAHOeJgWDgHhdoOgQgGcs9MzMlKB1lIJMnFuqQp1faIT/CoA6Yh7OLgQOs4JLf
 O91fBSj4+PtuJgrscZ8/E+iGYbE7QQssoDKa7x+s7ls3mK/KXg2d6f1MNYzEvjhL5tLo
 yxsDiMdggeE4loo4gUfWXQwEGjk5myUBY4oyIcgO1KhPNdRmLDCzKY2IK00QDiWwH8/5
 2CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S/vy6ProRnX/IxMiIPIBm1J9HAqTrgB5aNqJueLyivE=;
 b=U9MLCS9aRT3q3U0CITETPKobtVO7Owp8kIW23gjHE0LvyAE6Ez0k8rfQ1x+9IVX+/E
 uTe/SMQGp16AhzGSccWBIWZS6AwlCvp9Te3+yMBzqOEazFbhBbv5f5BoTKGFWJGHk5Kb
 5yZ8ZxFNOFYWKhGwyAathKFlSp2s6XLInG8vz+kP+Aut/ChzVn1xeHhRgPjRi+rV6sxZ
 tXnmDyZG5MQJrq6xRr3BNnbZdwlVy/EHxzv6JQxKP81ymeI0Sh5yGZfKGnUWtusqivaG
 jDdvkfa/Xyt1SKuD2cpMsnrqiUBusFYZIF9TXUYM1e0NJEkYlfNEozRViLkATqjaez3U
 rz8Q==
X-Gm-Message-State: AOAM532lTCQ34LKJDzrAElnt+VSXjZOyBj82HGzmgxauRAePQ9fJaKrR
 nF4PpE++5XQov/JsyapIHCc=
X-Google-Smtp-Source: ABdhPJzbLgxCQhlcP5GC7EpBbtG39wzrAlolqyjw7PSlCUedCAbNRQvfgHXiGVGtcpwDMy1IQdQt+Q==
X-Received: by 2002:adf:e744:: with SMTP id c4mr22343626wrn.71.1590998972818; 
 Mon, 01 Jun 2020 01:09:32 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id f128sm10368830wme.1.2020.06.01.01.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 01:09:32 -0700 (PDT)
Subject: Re: [PATCH 5/6] exec: Restrict 32-bit CPUs to 32-bit address space
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200531175425.10329-1-f4bug@amsat.org>
 <20200531175425.10329-6-f4bug@amsat.org>
 <CAFEAcA9CkBy=e3EmJhKko9XGbL7A_E_vedm8jt_H3+Gr6yzbhA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2e78619d-543b-55b7-f241-7652274fcf4a@amsat.org>
Date: Mon, 1 Jun 2020 10:09:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9CkBy=e3EmJhKko9XGbL7A_E_vedm8jt_H3+Gr6yzbhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/20 9:09 PM, Peter Maydell wrote:
> On Sun, 31 May 2020 at 18:54, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> It is pointless to have 32-bit CPUs see a 64-bit address
>> space, when they can only address the 32 lower bits.
>>
>> Only create CPU address space with a size it can address.
>> This makes HMP 'info mtree' command easier to understand
>> (on 32-bit CPUs).
> 
>> diff --git a/exec.c b/exec.c
>> index 5162f0d12f..d6809a9447 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -2962,9 +2962,17 @@ static void tcg_commit(MemoryListener *listener)
>>
>>  static void memory_map_init(void)
>>  {
>> +    uint64_t system_memory_size;
>> +
>> +#if TARGET_LONG_BITS >= 64
>> +    system_memory_size = UINT64_MAX;
>> +#else
>> +    system_memory_size = 1ULL << TARGET_LONG_BITS;
>> +#endif
> 
> TARGET_LONG_BITS is a description of the CPU's virtual
> address size; but the size of the system_memory memory
> region is related to the CPU's physical address size[*].

OK I misunderstood it was the physical size, not virtual.

> In particular, for the Arm Cortex-A15 (and any other
> 32-bit CPU with LPAE) TARGET_LONG_BITS is 32 but the CPU
> can address more than 32 bits of physical memory.
> 
> [*] Strictly speaking, it would depend on the
> maximum physical address size used by any transaction
> master in the system -- in theory you could have a
> 32-bit-only CPU and a DMA controller that could be
> programmed with 64-bit addresses. In practice the
> CPU can generally address at least as much of the
> physical address space as any other transaction master.

Yes, I tried the Malta with 32-bit core, while the GT64120 northbridge
addresses 64-bit:

address-space: cpu-memory-0
  0000000000000000-00000000ffffffff (prio 0, i/o): system
    0000000000000000-0000000007ffffff (prio 0, ram): alias
mips_malta_low_preio.ram @mips_malta.ram 0000000000000000-0000000007ffffff
    0000000000000000-000000001fffffff (prio 0, i/o): empty-slot
    0000000010000000-0000000011ffffff (prio 0, i/o): alias pci0-io @io
0000000000000000-0000000001ffffff
    0000000012000000-0000000013ffffff (prio 0, i/o): alias pci0-mem0
@pci0-mem 0000000012000000-0000000013ffffff

address-space: gt64120_pci
  0000000000000000-ffffffffffffffff (prio 0, i/o): bus master container
    0000000000000000-00000000ffffffff (prio 0, i/o): alias bus master
@system 0000000000000000-00000000ffffffff [disabled]

So my testing is bad, because I want @system to be 64-bit wide for the
GT64120.

From "In practice the CPU can generally address at least as much of the
physical address space as any other transaction master." I understand
for QEMU @system address space must be as big as the largest transaction
a bus master can do".

I think what confuse me is what QEMU means by 'system-memory', I
understand it historically as the address space of the first CPU core.

This is more complex in the case of the raspi SoC where the DSP can
address the main bus (system memory) while the ARM cores access it via
an MMU, see this schema:
https://www.raspberrypi.org/forums/viewtopic.php?t=262747

Regards,

Phil.

