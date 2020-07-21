Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E030C433F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D16A20702
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D16A20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxtAf-0003Yx-HU
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jxt9o-00034f-Mn
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:22:12 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jxt9m-0003TP-FC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:22:12 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MTznQ-1kNdFd2pVa-00R1p6; Tue, 21 Jul 2020 16:22:07 +0200
Subject: Re: [PATCH v2 1/4] linux-user: Make cpu_env accessible in strace.c
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200713095058.106624-1-Filip.Bozuta@syrmia.com>
 <20200713095058.106624-2-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <29c8bbb5-5234-8580-dcae-17fcfbfbb4fd@vivier.eu>
Date: Tue, 21 Jul 2020 16:22:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713095058.106624-2-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2TXie38P80ezxHh0JFGKKFf/gmPRegUyOfHN73NubEBgZgRxw/K
 +VodoQBoEiO44IO6W+ORu+T03Bad7FJKncgIZMEJMPH25ogeD1cjcWVQJ4fvfirLf6EFZ8I
 7mhr+/sbKZd4BB+QfXmrZBgKk+vzEfsWwYHI6brZLPpAt8eJ0qh3WaNUZ1zZzE2JzNCJ0do
 45VkrfyOJE9CP31hrAPdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6KNLIIhd+3c=:SEfV2VJ5IhUxa3kzGeqoJX
 mykffGFtJa6gpGpjSg6ZQAN/+R8CJqk/00G5tQqSHWbC9fXCFpGt8qVy2agK1doj5uZb58Zkn
 CCZUx/2jU9o/qQvVloTtmztGmKKgBrbP5k2gGNpc0fkbtiGkXA45zklg3vuSFHOvE4J/tOzF9
 EJriK3kogzQIBPYqwbS2hmGIAG0UQh7u8ryUxLfet6XUyCVIL8HLq4yeLMNkeHBt3M4FoOtDg
 L+91RXvMgswglzewCfs4CploTH+nShtjJ2OiUFo9aEvI0qZKVWVGi7p2bg2FEF9bc9TXs5PXh
 SXsZtI1Y464JwQEmfglrN4yAMlC43gkydE10otzRVGjqHjMDmR3PFEHYROr1qhELncS0xD233
 9q0upEz+E4M9WPkVddbqE1KNbRKU78R2W0KP88QHeF+ls/N1Er2LUO3/tBj79sxScEBjUn/8Y
 e9VZoIjLrkc5n8suCF/GeEpLMdBsUW65iJMnsmyEnWgne3UCXVQ+5WOgAJWaZ4qpauhiLS1NK
 Y5bqExlUHO3tkCoT0yccBc4v+cYHqoff/VrEt9q3UrxCgCU7V6h5cfKAIj4govrwqn5+ytrbD
 RM/1u2n3IFOvgB4pHoHw7z/xjj+AuiUdlpZgO9AFtldF1xBcNVoWiy4f/4hjil77Mtj/nb28r
 6H3zmBQpYjyLx5Oj2wd4GF02vNgqlRO8ZznPu+7ofBOLduihYkNiZIbGlOh5jfgfNLu3jaXQ8
 Ri9nu4DfoQhp6oEaXSrl14orD4B8pwz2C5grwIpnp516LcGAiHnLS0y/exZxEFGA5O4v5ECMy
 qEhWjN4feGgucwp5zS37Eeh4PnRgpPpTWOU/ZSf/RajsAdxbU7LKXU+VEg1krTEh/YQhNjo
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:22:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/07/2020 à 11:50, Filip Bozuta a écrit :
> Variable "cpu_env" is used in file "syscall.c" to store
> the information about the cpu environment. This variable
> is used because values of some syscalls can vary between
> cpu architectures. This patch makes the "cpu_env" accessible
> in "strace.c" so it can enable aproppriate "-strace" argument
> printing for these syscalls. This will be a useful addition
> for future "-strace" implementation in QEMU.
> 
> Implementation notes:
> 
>     Functions "print_syscall()" and "print_syscall_ret()" which
>     are stated and defined in "qemu.h" and "strace.c" respectively
>     are used to print syscall arguments before and after syscall
>     execution. These functions were changed with addition of a
>     new argument "void *cpu_env". Strucute "struct syscallname"
>     in "strace.c" is used to store the information about syscalls.
>     Fields "call" and "result" represent pointers to functions which
>     are used to print syscall arguments before and after execution.
>     These fields were also changed with addition of a new "void *"
>     argumetn.
>     Also, all defined "print_*" and "print_syscall_ret*" functions
>     in "strace.c" were changed to have the new "void *cpu_env".
>     This was done to not cause build errors (even though none of
>     these functions use this argument).
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/qemu.h    |   4 +-
>  linux-user/strace.c  | 479 ++++++++++++++++++++++---------------------
>  linux-user/syscall.c |   5 +-
>  3 files changed, 247 insertions(+), 241 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


