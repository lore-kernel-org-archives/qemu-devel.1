Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA60C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 15:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1CB20773
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 15:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQQFmlBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1CB20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUB58-0000UK-Ux
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 11:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUB3y-0007va-G9
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 11:57:39 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUB3w-00042D-4Q
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 11:57:38 -0400
Received: by mail-pj1-x1044.google.com with SMTP id p21so3969433pju.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=X3VXly+QjuzpjKO03cHYna4GhojBc3MPHDAW8RGRkh8=;
 b=XQQFmlBJIwyS+ldxlqEnMAU6rrM6kOVmvfxT7roYOw2eMHDGD9Qe0M2u1mybl/9Hmb
 yg+Gp63UEIoeZo7e+e4fvl5TVSiOh/zPGQpdzgnv226wfMmCW1cu7+vshnuI+5byurgM
 5NP4viauIjm1ITROifSlFAdgaaqpJL6TlyiVGsQlhgvvvxHhJS5vA1lUvei0PizOhtCs
 YL3Fb3IOd7Vr/F8y9vQg2Qnnc7HOvEbrQHfgUubi5OpDorsDMQyWzaIRpNKI/TKuZeH4
 6nm4wYWgRK8lH4C8crT1cELtryuRZEh5g8UVx8YlQFZijnmkMAVGDFB9EbdRMYa+A+GL
 qlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X3VXly+QjuzpjKO03cHYna4GhojBc3MPHDAW8RGRkh8=;
 b=hvDta33Jn28BytLGgcetwg7pMbGL2em2ffpsb1pqo9/H5yXSDHPMmY05P0OzXEfnA0
 jRdaFx4L5YPZSoJqIHqTSHS7PocMO2pPhAr5RH/didGPMm+8z7jC+KHpSF6W+fI3xWq5
 PA1lh4ExBH9LzJItwpcBaFvw+SD+qTbPJvkmsB89VyIyyFQLL1JGxOVyrkCiUMGPh5Tf
 KUiMzbAoEJ0ehaZA3e/UZaXrvO7UlwQCJYQZhylO2VSajkYN/SIawUu/SjR8dRCmmyi6
 H8i9LoxXDcqLXzkDegVWkaLSeEtQ8qGwtBtC0ig5mlpLX+W1KbsGsctm3K9OpiD1EHae
 gBEA==
X-Gm-Message-State: AOAM530gMPGcyntSB82u/qGku9D5Z+KvyUvy8SS2GURZAXCqvUuubyDa
 LvVoAhj4gHe27CPLRnpnNUqsFw==
X-Google-Smtp-Source: ABdhPJyKKIwigAwMuRTlO7cAm1WQbThWb39mi4HBJXuccYMPelKctcKqxJhSFXeDxS22u+TaHK2Fhg==
X-Received: by 2002:a17:90a:7089:: with SMTP id
 g9mr13650749pjk.4.1603036654067; 
 Sun, 18 Oct 2020 08:57:34 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f204sm9768461pfa.189.2020.10.18.08.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 08:57:33 -0700 (PDT)
Subject: Re: [PATCH] target/riscv: Adjust privilege level for HLV(X)/HSV
 instructions
To: Georg Kotheimer <georg.kotheimer@kernkonzept.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
References: <20201018120308.1712054-1-georg.kotheimer@kernkonzept.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bb17cae6-68eb-af14-0d08-1140e83cabcd@linaro.org>
Date: Sun, 18 Oct 2020 08:57:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201018120308.1712054-1-georg.kotheimer@kernkonzept.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/20 5:03 AM, Georg Kotheimer wrote:
> According to the specification the "field SPVP of hstatus controls the
> privilege level of the access" for the hypervisor virtual-machine load
> and store instructions HLV, HLVX and HSV.
> 
> We introduce the new virtualization register field HS_HYP_LD_ST,
> similar to HS_TWO_STAGE, which tracks whether we are currently
> executing a hypervisor virtual-macine load or store instruction.
> 
> Signed-off-by: Georg Kotheimer <georg.kotheimer@kernkonzept.com>

Well, let me start by mentioning the existing implementation of hyp_load et al
is broken.  I guess I wasn't paying attention when Alistair implemented them.

Here's the problem: When you change how riscv_cpu_tlb_fill works, as you are by
modifying get_physical_address, you have to remember that those results are
*saved* in the qemu tlb.

So by setting some flags, performing one memory operation, and resetting the
flags, we have in fact corrupted the tlb for the next operation without those
flags.

You need to either:

(1) perform the memory operation *without* using the qemu tlb machinery (i.e.
use get_physical_address directly, then use address_space_ld/st), or

(2) add a new mmu index for the HLV/HSV operation, with all of the differences
implied.

The second is imo preferable, as it means that helper_hyp_load et al can go
away and become normal qemu_ld/st opcodes with the new mmu indexes.

Annoyingly, for the moment you wouldn't be able to remove helper_hyp_x_load,
because there's no qemu_ld variant that uses execute permission.  But it can be
done with helpers.  I'll note that the current implementation is broken,
because it uses cpu_lduw_data_ra, and not cpu_lduw_code_ra, which is exactly
the difference that uses execute permissions.  After the conversion to the new
mmuidx, you would use cpu_lduw_mmuidx_ra.  I would also split the function into
two, so that one performs HLVX.HU and the other HLVX.WU, so that you don't have
to pass the size as a parameter.

Finally, this patch, changing behaviour when hstatus.SPVP changes... depends on
how often this bit is expected to be toggled.

If the bit toggles frequently, e.g. around some small section of kernel code,
then one might copy the SPVP bit into tlb_flags and use two different mmu
indexes to imply the state of the SPVP bit.

If the bit does not toggle frequently, e.g. whatever bit of kernel code runs
infrequently, or it only happens around priv level changes, then simply
flushing the qemu tlb when the SPVP bit changes is sufficient.  You then get to
look at SPVP directly within tlb_fill.


r~

