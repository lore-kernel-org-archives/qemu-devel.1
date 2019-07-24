Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CABCC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AFC2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AFC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqIMo-0001fA-5u
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 10:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59911)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqIMN-0000eg-5i
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqIML-0007SO-Kk
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:35:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqIML-0007NB-9D
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:35:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so32276192wrr.9
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 07:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EAumKrsgFbp2Bo6+jG0njwbRWsxzBeLS7COCLpaOagE=;
 b=n5An+7XgACyfd7Oop9p4cN2c8KofDc29AsPjr/COJVkW0TNwlD/er3LBO7uT/SBTxy
 15iLf8luqD0dQ8+BDy1jOVEMk6P2jOmnCvpDL3jgeGEppjIlLsh68pY2APByhMSc1zqo
 zQCdYwzlfXPUxoRzeYCT13Qk5Ebg5qUTgclqThDp4wO2fa5eQdpYpxFYOAK3UYjKkaK5
 ZE0fuTT7LJYAQUjrGwocb6X0JYuooIVyo+1HMYxI8kZsivwN25zKgTCU1Ubu7WyNFdKH
 jkie+3iu49HqBV+ddSdU16wttIvG5SITWti0SA1USFd/ahSXZsDMrhk3cfc0Sl9AN+pS
 7/aw==
X-Gm-Message-State: APjAAAWa+/0QK+PLefn9W34bPMkf/MgexutZhW8J5i+hK8OATzVzoC8C
 4ybREHT0ttDoGab+vsWs0UcV7A==
X-Google-Smtp-Source: APXvYqxz51w6PzE9jZzFXGZFHZIJyYrSvQx03SDxpiOJnkvY52XRe0vzyfM6ohTBuSYPCX5jxIVzgA==
X-Received: by 2002:adf:f206:: with SMTP id p6mr15589335wro.216.1563978906098; 
 Wed, 24 Jul 2019 07:35:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id k17sm52824675wrq.83.2019.07.24.07.35.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 07:35:05 -0700 (PDT)
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <156395778867.510.17588721322993616668.stgit@pasha-Precision-3630-Tower>
 <156395787270.510.3319575187228105326.stgit@pasha-Precision-3630-Tower>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <968ae3fd-0482-24f2-b24d-459152ff226d@redhat.com>
Date: Wed, 24 Jul 2019 16:35:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156395787270.510.3319575187228105326.stgit@pasha-Precision-3630-Tower>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH for-4.2 14/14] icount: clean up cpu_can_io
 before jumping to the next block
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 crosthwaite.peter@gmail.com, armbru@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/07/19 10:44, Pavel Dovgalyuk wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> Most of IO instructions can be executed only at the end of the block in
> icount mode. Therefore translator can set cpu_can_io flag when translating
> the last instruction.
> But when the blocks are chained, then this flag is not reset and may
> remain set at the beginning of the next block.
> This patch resets the flag before "chaining" the translation blocks.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  accel/tcg/tcg-runtime.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> index 8a1e408e31..fe6b83d0fc 100644
> --- a/accel/tcg/tcg-runtime.c
> +++ b/accel/tcg/tcg-runtime.c
> @@ -151,6 +151,8 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>      target_ulong cs_base, pc;
>      uint32_t flags;
>  
> +    /* We are going to jump to the next block. can_do_io should be reset */
> +    cpu->can_do_io = !use_icount;
>      tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, curr_cflags());
>      if (tb == NULL) {
>          return tcg_ctx->code_gen_epilogue;
> 

This only fixes indirect jumps though.

I think you do not need this patch if you remove the assignment in
cpu_tb_exec, and compile a "move 0 to cpu->can_do_io" in gen_tb_start
instead.

Paolo

