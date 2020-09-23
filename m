Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28647C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3EE21BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3EE21BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8Sv-0007di-En
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kL8Rp-00077j-8J; Wed, 23 Sep 2020 13:20:53 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kL8Rk-0000V8-AY; Wed, 23 Sep 2020 13:20:52 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MwPjf-1kdUbs43K1-00sMK0; Wed, 23 Sep 2020 19:20:42 +0200
Subject: Re: [PATCH] docs/system/deprecated: Move lm32 and unicore32 to the
 right section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200923080015.77373-1-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1a1b655d-b676-b492-e82d-5a31de438b12@vivier.eu>
Date: Wed, 23 Sep 2020 19:20:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923080015.77373-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Bi//LHaEIgxUQ89RSSdTVM4vnL0ACrKXH4Pz8k6IZ+o/WKbygWs
 le0kaTAxt5PEJcz/LZIbRKcoXFpGP+TX/hXn/dyPBSlqaqQu8tY+so/vbSC30MpcDpLg5D0
 EuQvXnnu2pap5pnmkiQtKdXwvM5irp+ZGwyWd6FY8tmwOKPcsAkozHUxl0Cv+B8VV25vkyY
 mFuCO4InUrWyWQwiBkBeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dWgDTJ3zHKg=:GrQaS5ksrvetuQ7LUZY9dd
 Ct93rUqACLLYw5XwGfJj1RY2W8xASX/dMgI9gQYLhy7QGoJnRhKv5EJQptZdlmqiOMj5A6Uuh
 3dJqNxFIHBZIzdtZe3zbjPW7ir/uC4ZiB6Al274HN1arSZCZT50/ASEqgtSh8i0I65Ngt7uJ8
 DtxTkYiW5rVxAUQ1A+04HkZBYL1OrGI/wuAouKYFFnwy3S34/Ts1uM1YBHmrm+u+a9XIlIyGK
 ns8BPCbwKoYKZHQ5+DszlfefHmS618sylL21w5IYixzH2pjFVT5D8ZOtWr7aGnMffjl5qSmU4
 yEujabouSGHLYQ4JtIuMvPKX3XP+7qQY4H9GiJw9Uj7AUiADN9bZj4hrDskFWPOH7vjBXNfqY
 VcSKEclZxQxmJXtNuxtgHRjWHShGRzQY/uFR8EqZ5KcTpa/9yFweQC+R4Sn22lHMzsQ0KIHL1
 47XGux27SN3IX3QIMKz+cVuLBL2ul+aC57+zku1yjbcy/CogsgJoYK+MR/LoFkPRdofFm3WwC
 BHj0Eeu31f1ziAQE7VA7ODseGmv6AqZdKEAcx51u8S78dStihUEOaVl8Xn66cqZEpF+G6r9aw
 1hBEuPjekGucbSNpacrr0PncF3beHM/GlUBY9JfJlsNImR/DSQKMPCu6PZdU/sxmwcSVCtEIX
 9p+96f8WyA9IKPu8ezzupD5bJ/n/ILtO+nAGM6UHAclsUc8iYUVRySSyACrFNk3I0bcZY9ffE
 irRMwgH+rgBSGI6fFls9vG8iXc4T51yzgzUp6jUzx+Zd2eMMO2KCxpmzQdafEi++3+wmBGXT/
 cirIEwT2jgbZFs1VRhTdwBv1Z7M8sPB5Jane7ROsLF2gxqmRXUX3L4vCa+925ZDQ4DrOrvU
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 13:06:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/09/2020 à 10:00, Thomas Huth a écrit :
> lm32 and unicore32 are softmmut targets, and not linux-user targets.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/system/deprecated.rst | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 0cb8b01424..e3dcf1f149 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -329,6 +329,22 @@ The ``compat`` property used to set backwards compatibility modes for
>  the processor has been deprecated. The ``max-cpu-compat`` property of
>  the ``pseries`` machine type should be used instead.
>  
> +``lm32`` CPUs (since 5.2.0)
> +'''''''''''''''''''''''''''
> +
> +The ``lm32`` guest CPU support is deprecated and will be removed in
> +a future version of QEMU. The only public user of this architecture
> +was the milkymist project, which has been dead for years; there was
> +never an upstream Linux port.
> +
> +``unicore32`` CPUs (since 5.2.0)
> +''''''''''''''''''''''''''''''''
> +
> +The ``unicore32`` guest CPU support is deprecated and will be removed in
> +a future version of QEMU. Support for this CPU was removed from the
> +upstream Linux kernel, and there is no available upstream toolchain
> +to build binaries for it.
> +
>  System emulator devices
>  -----------------------
>  
> @@ -408,22 +424,6 @@ The above, converted to the current supported format::
>  linux-user mode CPUs
>  --------------------
>  
> -``lm32`` CPUs (since 5.2.0)
> -'''''''''''''''''''''''''''
> -
> -The ``lm32`` guest CPU support is deprecated and will be removed in
> -a future version of QEMU. The only public user of this architecture
> -was the milkymist project, which has been dead for years; there was
> -never an upstream Linux port.
> -
> -``unicore32`` CPUs (since 5.2.0)
> -''''''''''''''''''''''''''''''''
> -
> -The ``unicore32`` guest CPU support is deprecated and will be removed in
> -a future version of QEMU. Support for this CPU was removed from the
> -upstream Linux kernel, and there is no available upstream toolchain
> -to build binaries for it.
> -
>  ``tilegx`` CPUs (since 5.1.0)
>  '''''''''''''''''''''''''''''
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


