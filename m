Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABA3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC02E2085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC02E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8Bu-0006Ww-Jf
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kX82l-0005Qt-Mp; Mon, 26 Oct 2020 15:20:37 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kX82i-00009f-IG; Mon, 26 Oct 2020 15:20:35 -0400
Received: from [192.168.100.1] ([82.252.139.38]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MryOx-1k15022Zsb-00nzjX; Mon, 26 Oct 2020 20:20:27 +0100
Subject: Re: [PATCH] cpus: Drop declaration of cpu_remove()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <160268285707.1107461.15035929822602623985.stgit@bahia.lan>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8da28f02-502c-dcf6-4487-da89b0b9a9d0@vivier.eu>
Date: Mon, 26 Oct 2020 20:20:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160268285707.1107461.15035929822602623985.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RUo/JBIWTUjxWFDJTClEbWyWM6QwOc226ZM8hQcq8RQdWVu2WbT
 bCROYu4R8rVZr3KHusEuIYZYjsmTXeawjN4LgwBV/oEEOns+Kd0SzsrKcVCC63wixCgfGJy
 1BzODaG2YwyjxVvAHTaV3t+H0CRJwxu3m7sEsphCsTahSrlGLV9o4B3lOLrwsTZr5LrPK4j
 1tDHbMtedN4aKtOnzcjjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iTAPS1sTVBs=:DwBJv/JmHhJcVevJMh/6M7
 h570Wgy6wR1UT++UJ+2KmgmIje+qfN07Bkui/ztTJtNelK9A0aLJh2coio2m2OyoqKV2rvEEk
 C1ILFj9PLm08gVSUYbhuhpaE6WzksIZvwUEuvCHyWQ67FsuDEMgSu7wAd1aj4tmThkL7aH2xd
 5s6x3jo4bc4lJWNE6zpZCzD7geVvIJ5cnWVfqT21Z71K3J5twYeDWM45+Hyn2dgqV5o2LRyG3
 68h0pkgglRhgFZgx3ZDXLK5eMQkkJ6zg9QSYPav1parYcUxVFpL6LU+179C5chvuI2iy8WPEt
 qfoWZhu1Or4p5Fip75DEZTRy23GByXLVultdm/C5d+lNPBwRN6LExK9+y0SWgYz6afPFfnMSB
 hqz21cVkjsTndN7lryxlzuJIkcbQSy8Iq2PeOcqmNxx3w7wAeOHxSH3vGWNs+yBU9ogFTCqSO
 1rgq+MIWJQ==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 15:11:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 14/10/2020 à 15:40, Greg Kurz a écrit :
> cpu_remove() got superseded by cpu_remove_sync() in commit dbadee4ff4a0,
> but its prototype wasn't removed. We could possibly keep the shorter
> cpu_remove() naming but it seems better to highligth that this blocks
> until the CPU thread is joined.
> 
> Fixes: dbadee4ff4a0 ("cpus: join thread when removing a vCPU")
> Cc: pbonzini@redhat.com
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  include/hw/core/cpu.h |    8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 4879f2502659..ace443e88297 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -924,14 +924,6 @@ void cpu_exit(CPUState *cpu);
>  void cpu_resume(CPUState *cpu);
>  
>  /**
> - * cpu_remove:
> - * @cpu: The CPU to remove.
> - *
> - * Requests the CPU to be removed.
> - */
> -void cpu_remove(CPUState *cpu);
> -
> - /**
>   * cpu_remove_sync:
>   * @cpu: The CPU to remove.
>   *
> 
> 
> 
Applied to my trivial-patches branch.

Thanks,
Laurent


