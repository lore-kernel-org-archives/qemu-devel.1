Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D02C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9648F20665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRv6/kZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9648F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgnJI-0002zh-No
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 05:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47939)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgnIQ-0002Zh-EB
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgnIP-0004h4-CV
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:35:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgnIP-0004eE-47
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:35:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id d18so5546418wrs.5
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 02:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EYabABQgP8zIM6C4chUINaB01LzBD98XTQEtfc73hdk=;
 b=VRv6/kZvB/CnS2iVIQeqotU9dsX1sscrIaFrxx+Fl187qU5tsiua5Ni17K/jCEjbXI
 gIa0Fsb5uG+d0rCxySo74m9xZqRRCKPD0+ewD0Xs1JL1gQPG/y4Olq59Kauus7YrbzHx
 mei3dp+uqp3lPT6zdMr7rrei1lnlyJKSoKCewLFuPigZpk7tuZjhcY1MHDWV75LL9YB2
 vztmIVNwpP5JZXCq3p7324uj9Ldck3HhSswYf2roXsIfcQ2rfsDz69YM+AgDOrF51wjm
 4dXeyvbcqI2KNM38+uAhz+lfPLuW4ZvK0lSCJoOQ57jCZGQ0KQGlAeG5YaIO02rXNbt2
 XB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EYabABQgP8zIM6C4chUINaB01LzBD98XTQEtfc73hdk=;
 b=XaGtzg+W8FX8ukGRDkDb4Kc44A1diZUwpoXqVj8Q3v0ebwFX2FzgAdOQBGmz0iGnxq
 M+o4ypss8COdF9/Gk0p4VCvauqFC8zrpwDrMQ6kVQyccCaqb+lOWQYvQPx099uI6rcl9
 nKDQrL9tsB6Z/JQE9ax7DX0IF+8WCneIbyBkJfkXVQSPEFcXF7/yHUbE2lhvzYtR/img
 diMmktH62qQb1C+syKespLdDfGwVByP5V/9PDYFVfYjwYt7D5MMEx/xRPPcVOSdMzOiW
 yDxwn4JxCaWm8pxjIA52T0ta6UlQKmAoAVtzJwyHSoI3x2LacFDTZyrqCy16RUlvuczc
 Ab0g==
X-Gm-Message-State: APjAAAV9I13E7o+0dXW150y9EW3OWhbijnkierhYu+6pB1wRgrsrFtY0
 /d2PtpCGTSRCVaz+LxLnxlOWKw==
X-Google-Smtp-Source: APXvYqynPss+m/mLS06PraCkHqi5qMmgGxBUn5nDYH5/zGeX/f1hcxsUyGWUwmN+51aACFG9yDpTUg==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr6537659wrw.13.1561714550919;
 Fri, 28 Jun 2019 02:35:50 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id c65sm1407295wma.44.2019.06.28.02.35.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 02:35:50 -0700 (PDT)
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
Date: Fri, 28 Jun 2019 11:35:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628002713.GA19257@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/19 2:27 AM, Lucien Murray-Pitts wrote:
> The original way of handling it was causing single step to malfunction, I dont
> rightly know why but the effect was that step would step twice and end up
> inside the ISR function again OR just stepping past the RTE as if it didnt
> exist.
> 
> I have made a quick hack to implement it the way you suggest and confirm that
> works better.
> 
> HOWEVER, the "return" address is the instruction that causes the exception.
> So it immediately does return to the ISR.
> 
> This is a different issue, but I think interrelated to the original problem.

Is this a synchronous exception, like a SIGSEGV, that the instruction is
causing?  I have made attempts at fixing asynchronous interrupts, like the
clock, in the presence of single-stepping.  I haven't tested that in a while
and I hope it's still working...

> Further single stepping INTO the failing instruction results in ending up
> at the ISR +1 instruction

For a synchronous exception, that sounds like a real bug.

Probably within cpu_handle_exception,

  #else
          if (replay_exception()) {
              CPUClass *cc = CPU_GET_CLASS(cpu);
              qemu_mutex_lock_iothread();
              cc->do_interrupt(cpu);
              qemu_mutex_unlock_iothread();
+             /* Single-step into the exception handler.  */
+             if (cpu->singlestep_enabled) {
+                 cpu_handle_debug_exception(cpu);
+             }
              cpu->exception_index = -1;
          } else if (!replay_has_interrupt()) {


r~

