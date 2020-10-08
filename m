Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF91C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB02217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB02217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTiB-0004y2-5h
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 07:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQTgz-0004SM-Io
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 07:02:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:44294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQTgw-0001Zh-VS
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 07:02:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3D423AFD5;
 Thu,  8 Oct 2020 11:02:33 +0000 (UTC)
Subject: Re: [PATCH 2/2] exec: split out non-softmmu-specific parts
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20201006091922.331832-1-pbonzini@redhat.com>
 <20201006091922.331832-3-pbonzini@redhat.com>
 <cb553da1-9cd1-1933-d678-8580a3c0d8f3@suse.de>
 <027d0f5c-d5c4-911b-b349-f63895fc164d@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <b6e4d4e0-6170-b3e6-f2f7-e337c71b0403@suse.de>
Date: Thu, 8 Oct 2020 13:02:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <027d0f5c-d5c4-911b-b349-f63895fc164d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 23:49:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/8/20 9:56 AM, Paolo Bonzini wrote:
> On 08/10/20 09:47, Claudio Fontana wrote:
>> On 10/6/20 11:19 AM, Paolo Bonzini wrote:
>>> Over the years, most parts of exec.c that were not specific to softmmu
>>> have been moved to accel/tcg; what's left is mostly the low-level part
>>> of the memory API, which includes RAMBlock and AddressSpaceDispatch.
>>> However exec.c also hosts 4-500 lines of code for the target specific
>>> parts of the CPU QOM object, plus a few functions for user-mode
>>> emulation that do not have a better place (they are not TCG-specific so
>>> accel/tcg/user-exec.c is not a good place either).
>>>
>>> Move these parts to a new file, so that exec.c can be moved to
>>> softmmu/physmem.c.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> Hi Paolo,
>>
>> the comment does not talk about cpu.c, which is now created in the top source directory.
>> What is the role of this new module?
> 
> It's actually in the commit message: "4-500 lines of code for the target
> specific parts of the CPU QOM object, plus a few functions for user-mode
> emulation that do not have a better place".
> 
> It's basically sitting between hw/core/cpu.c and target/*/cpu.c.  Hence
> the non-descriptive name. :)
> 
>> Also, could we find a more descriptive file name than cpu.c?
>> Do you plan further renaming of this new module functions?
>>
>> Or its this basically a "leftovers" file for which we did not find a proper role yet?
> 
> The user-mode parts are, but most of it is implementing the QOM CPU
> object.  We can move those functions to hw/core/cpu.c and make that file
> target-dependent, I wouldn't object to that.  But since there are some
> opportunities for simplification, I'd rather do that in a separate patch
> and keep the pure code-movement in this one.
> 
> Paolo
> 

Ciao Paolo,

this gives me an idea, we already basically have a target-specific part of a cpu QEMU object.

I basically was looking for a place to graft accelerator-specific code in order to refactor target/i386/cpu..., 
to split between tcg stuff and non-tcg stuff, and thus refactor even more code.

In the past I thought to put them here for example:

diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
index 3e96f8d668..3716c3e949 100644
--- a/target/i386/cpu-qom.h
+++ b/target/i386/cpu-qom.h
@@ -72,6 +72,12 @@ typedef struct X86CPUClass {
     DeviceRealize parent_realize;
     DeviceUnrealize parent_unrealize;
     DeviceReset parent_reset;
+
+    /* methods operating on CPUX86State */
+    uint32_t (*cpu_compute_eflags)(CPUX86State *env);
+    void (*cpu_set_mxcsr)(CPUX86State *env, uint32_t mxcsr);
+    void (*cpu_set_fpuc)(CPUX86State *env, uint16_t fpuc);
+    void (*cpu_report_tpr_access)(CPUX86State *env, TPRAccess access);
 } X86CPUClass;
 
 typedef struct X86CPU X86CPU;


But maybe that is the right component?

Just thinking out loud here.

Ciao,

Claudio

