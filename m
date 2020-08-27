Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D9C20737
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cijLuITE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D9C20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBLQU-0006Dt-Cn
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 13:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBLPN-0004tr-DL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:09:53 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:45626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBLPL-0006UB-Od
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:09:53 -0400
Received: by mail-lj1-x244.google.com with SMTP id w25so7243458ljo.12
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 10:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+OseA/6DuO9KByHFJCFjQDjO0mGfruXqXtCvguGanos=;
 b=cijLuITErQtBMPkLeaZaimRjKu6VaiBc1ovm4t2N6RPvRCBF6N9PvEh20GoAUQpL6r
 NY4f1uMrdhRbB+3TFt0EzdPIVNnzaqi9JQDM3Nj5+BBUL6Sr6M0nVaGu7lFEUVrxGSip
 fZVJqplFTuzZOb1ZV+3i4lCnYB9r3UPBIP7L7oyy592RV07u5uHynCk7/Er7wh90JpHN
 Xsn3gVPDHb2a5Av58apfeZhzk4jsLN7ZJhqYw43suFkSH7d5x+0K4LXI+muCGBQ0kgwH
 5AxXzUDX7StfJDv/+9MHrfsf2K7uLQbY3Xss0DMSJJ/f0RAWTDh+IFAFw8u6FZc4tGY2
 AgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+OseA/6DuO9KByHFJCFjQDjO0mGfruXqXtCvguGanos=;
 b=EA0DhADbPGa+amBj7GhnchDAn4u3T66jh2XJp1A39lu1DJK8PLRqfuJCLXJXkUjm3u
 8L2npO2Wjk/umnC6+2wsExrvwKixDTTNfPqs8GN3JxI8WVTmLpeRoNYL8j61e+QHd5Pp
 7Hi9BXCw3ubv2odhDKHGhaJIsUveVfJFZtoHAK2TeP45eCcXw2VSZ3IwrcLc6GJ6QNBS
 UF+qvqMrCHo8m7CCUBDtMWn8v7Qw5SFi1UZIyOBtxyuuOXf6RK9HwrVH7VE/xZSwEJJw
 7+cOaBEYGt538inwooKSmqT+DQj4yGeAn9AzFRBYWH19xFhxDCXt7xuHU7fnrImfD/OV
 eIVw==
X-Gm-Message-State: AOAM532gkZP+iOX8o6bOgZihPZOWhQhz8UewAWZLtQbDWl864BNVmVrY
 XabGxU7wxoL0OuhY54jP35k=
X-Google-Smtp-Source: ABdhPJzidhtUAZrpsqZlDadNxOva+0hBoW8xbSiF6byzrmnwbW98YZlWIy41GjTZhDRwkES+gYorqQ==
X-Received: by 2002:a2e:558:: with SMTP id 85mr2937272ljf.293.1598548189386;
 Thu, 27 Aug 2020 10:09:49 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id v27sm645111lfi.79.2020.08.27.10.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 10:09:48 -0700 (PDT)
Date: Thu, 27 Aug 2020 19:09:48 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/77] target/microblaze improvements
Message-ID: <20200827170948.GO2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200827091128.GK2954729@toto>
 <1628c0ac-db22-ef9d-22e2-6a167ceaaf55@linaro.org>
 <20200827102217.GN2954729@toto>
 <5a787d85-a75f-60cf-0c99-a40c84222b35@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a787d85-a75f-60cf-0c99-a40c84222b35@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.899, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 04:19:44AM -0700, Richard Henderson wrote:
> On 8/27/20 3:22 AM, Edgar E. Iglesias wrote:
> > Thanks. Here's another issue, it seems some branches are jumping
> > to the wrong address.
> > 
> > This is a disasm from a failing case:
> > 
> > 0x00000000ffd033a0:  brlid      r15, -636       // 0xffffffffffd03124
> > 0x00000000ffd033a4:  or r0, r0, r0
> > 
> > 0x00000000ffa73124:  Address 0xffa73124 is out of bounds.
> 
> That's a weird one.
> 
> My guess is that IMM_FLAG is set in iflags incorrectly.
> Can you verify this with -d in_asm,op,exec?
> 
> When IMM_FLAG is set, you'll see in in iflags: bit 0 will be set in the second
> word of the insn_data.  E.g.:
> 
>  ---- 00000000ffd033a0 0000000000000001
> 
> It would also show up in the tb_flags of the exec lines.  E.g.
> 
> Trace 0: 0x7f38a4000940 [0000000000000000/0000000090000058/0]
> 
> where the format is host_pc [cs_base/pc/tb_flags].
> 
> 
> If so, then we'll need to check where iflags got out of sync.
>

It seems to be getting out of sync when getting a slave-error and the core
is not setup to take exceptions for slave errors. Looks like a pre-existing
bug where we're restoring CPU state without taking the exception.
The following fixes that particular case in my runs.


I'm on a backported QEMU 5.1 so thing may look different in master.

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 831ff2cac1..0cae51c2df 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -432,22 +432,19 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
     cpu = MICROBLAZE_CPU(cs);
     env = &cpu->env;
 
-    cpu_restore_state(cs, retaddr, true);
-    if (!(env->msr & MSR_EE)) {
+    if (!cpu->cfg.iopb_bus_exception || !(env->msr & MSR_EE)) {
         return;
     }
 
+    cpu_restore_state(cs, retaddr, true);
+
     env->ear = addr;
     if (access_type == MMU_INST_FETCH) {
-        if ((env->pvr.regs[2] & PVR2_IOPB_BUS_EXC_MASK)) {
-            env->esr = ESR_EC_INSN_BUS;
-            helper_raise_exception(env, EXCP_HW_EXCP);
-        }
+        env->esr = ESR_EC_INSN_BUS;
+        helper_raise_exception(env, EXCP_HW_EXCP);
     } else {
-        if ((env->pvr.regs[2] & PVR2_DOPB_BUS_EXC_MASK)) {
-            env->esr = ESR_EC_DATA_BUS;
-            helper_raise_exception(env, EXCP_HW_EXCP);
-        }
+        env->esr = ESR_EC_DATA_BUS;
+        helper_raise_exception(env, EXCP_HW_EXCP);
     }
 }
 #endif

