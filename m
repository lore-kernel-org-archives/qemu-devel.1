Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AA8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39AA623128
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AA623128
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3gG9-0005Jh-BF
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k3gFM-0004Vk-Sr
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:47:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:47962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k3gFL-000484-61
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:47:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4F2A6AC55;
 Thu,  6 Aug 2020 13:48:05 +0000 (UTC)
Subject: Re: [RFC PATCH] CODING_STYLE.rst: flesh out our naming conventions.
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200806114036.10646-1-alex.bennee@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <f29af0bb-7a3c-9d32-5799-42a4efa5d097@suse.de>
Date: Thu, 6 Aug 2020 15:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200806114036.10646-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 23:10:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 1:40 PM, Alex Bennée wrote:
> Mention a few of the more common naming conventions we follow in the
> code base including common variable names and function prefix and
> suffix examples.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  CODING_STYLE.rst | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> index 427699e0e42..17cb42ba761 100644
> --- a/CODING_STYLE.rst
> +++ b/CODING_STYLE.rst
> @@ -109,9 +109,32 @@ names are lower_case_with_underscores_ending_with_a_t, like the POSIX
>  uint64_t and family.  Note that this last convention contradicts POSIX
>  and is therefore likely to be changed.
>  
> +Variable Naming Conventions
> +---------------------------
> +
> +A number of common short naming conventions exist for variables that use
> +common QEMU types. For example when dealing with the architecture
> +independent CPUState this is often in a ``cs`` pointer variable
> +whereas the concrete CPUArchState us usually held in a pointer called
> +``env``.
> +
> +Likewise in device emulation code the common DeviceState is usually
> +called ``dev`` with the actual state structure often the very terse
> +``s`` or maybe ``foodev``.
> +
> +Function Naming Conventions
> +---------------------------
> +
>  When wrapping standard library functions, use the prefix ``qemu_`` to alert
>  readers that they are seeing a wrapped version; otherwise avoid this prefix.
>  
> +Functions that are expected to be called with some sort of lock held
> +usually have the suffix ``_locked``.
> +
> +Public functions (i.e. declared in public headers) tend to be prefixes
> +with the subsystem or file they came from. For example ``tlb_`` for
> +functions from ``cputlb.c`` or ``cpu_`` for functions from cpus.c.

Hi Alex,

agree with the sentiment, for cpus.c I would suggest cpus_ though.

There are otherwise so many cpu_ functions and cpu.c modules.. using cpus_ would help a lot to understand that it is part of softmmu/cpus.c

Wdyt?

Also cpus.c contains a lot of qemu_ that is not used to wrap standard library functions.

After the current cpus refactoring, I could take care of improving the naming conventions in cpus.c

Thanks,

Claudio


> +
>  Block structure
>  ===============
>  
> 


