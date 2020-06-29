Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A879C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05AE020675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AE020675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq06o-0005Cr-A5
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 16:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jq06C-0004lN-Os
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 16:09:52 -0400
Received: from relay68.bu.edu ([128.197.228.73]:38879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jq06A-0000eI-UC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 16:09:52 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 05TK8hnY030733
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 29 Jun 2020 16:08:49 -0400
Date: Mon, 29 Jun 2020 16:08:43 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [Bug 1878645] Re: null-ptr dereference in tcg_handle_interrupt
Message-ID: <20200629200843.7fyiuemiscmleg6g@mozz.bu.edu>
References: <158947246472.30762.752698283456022174.malonedeb@chaenomeles.canonical.com>
 <159344662125.1630.9077511492884316123.malone@chaenomeles.canonical.com>
 <871rlxsnmr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871rlxsnmr.fsf@linaro.org>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 16:09:48
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Bug 1878645 <1878645@bugs.launchpad.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200629 2000, Alex Bennée wrote:
> 
> Alexander Bulekov <1878645@bugs.launchpad.net> writes:
> 
> > I don't think this is a qtest-specific error: 
> > cat << EOF| qemu-system-i386 -M q35 -nographic -serial none -monitor stdio
> > o/4 0xcf8 0x8400f841
> > o/4 0xcfc 0xaa215d6d
> > o/4 0x6d30 0x2ef8ffbe
> > o/1 0xb2 0x20
> > EOF
> >
> > ...
> > Segmentation fault
> 
> Both this and the qtest have the same problem of depending on
> current_cpu which is a TLS variable which will never be correct from the
> qtest or monitor context. There are only a few other cases.

Ah that makes sense. It probably isn't a real issue, but I'll send
patches with the changes you suggested below.
Thank you

> sun4m:cpu_halt_signal does:
> 
>     if (level && current_cpu) {
>         cpu_interrupt(current_cpu, CPU_INTERRUPT_HALT);
>     }
> 
> pxa2xx:pxa2xx_pwrmode_write does a bare:
> 
>     /* Suspend */
>     cpu_interrupt(current_cpu, CPU_INTERRUPT_HALT);
> 
> but given the context has a CPUARMState *env it could arguably use that
> to derive current_cpu but as it's only triggered by a system register
> write you can't actually trigger from a monitor/qtest command.
> 
> I would suggest either:
> 
>         } else if (current_cpu) {
>             cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
>         }
> 
> or possibly:
> 
>         } else {
>             cpu_interrupt(current_cpu ? current_cpu : first_cpu, CPU_INTERRUPT_SMI);
>         }
> 
> if you really care about triggering a real IRQ from outside the CPU context.
> 
> -- 
> Alex Bennée
> 

