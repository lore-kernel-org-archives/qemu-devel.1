Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C36C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEF1206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEF1206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxtMC-0003kn-Oi
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jxtLK-0002qe-Lv
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:34:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jxtLI-0005Mu-E3
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:34:06 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHWzP-1k2W2y1wUD-00DTPJ; Tue, 21 Jul 2020 16:34:01 +0200
Subject: Re: [PATCH v2 3/4] linux-user: Add strace support for printing
 arguments of syscalls used to lock and unlock memory
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200713095058.106624-1-Filip.Bozuta@syrmia.com>
 <20200713095058.106624-4-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <dc960bea-2d04-494f-a94a-9ab522a56be3@vivier.eu>
Date: Tue, 21 Jul 2020 16:33:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713095058.106624-4-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GlQIWvnI9l5PF2woVaKYhblbssPmHn2oOU6CWXmyxSif2iRq5m9
 Gg3o0JKjWTlSgQnXSwhbkGrjJLYFmpKrcDwgdiOb2ASSYpOrLhrKY05EG9PobSk8Mqpcokw
 JlPwq5BHvFNh4KrRd/1uksTu1Q6CtpMSab4fd/nZvL+9Pr0LMtkzYbU7QdtshACt0hGxX0g
 JiPT5u+ZQLH37j2eEjO5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q9WsvxR0UaA=:b8wH6nFcmgPYwQtrxcRf8n
 tZ74xyYdSAr667PlnVYy+UuqKP4iIXxbB7VUFR1qxggswGRD52EBJmnZ80Nvs/SCs4Kj8GSeN
 CiEEDjyh9g96A0s6uCEBWAKNzAooDPgHPnzW6FR0kvpXOqHkQ3ipGdw0ShUbzCpwgyYjt9vgr
 uSugMkHFXHfPnf6O+vOQw5OinDpqO4iA/Fs4mPWsT7la07jIBFpi7w2n9KU+fVLVPppkGju6J
 mCn0gc8EyxJA6pKiRHT0E7spzqO7kVJT9sLR6h5vRsUA6jIOTOHUCbuROPg+5TTxB08kK03rH
 zbPz4QdCvlaNDwYe0rslAL2Y+4IJygEYbSTdQCPv2Kg5fF55H1ejxWNm+b0lXfkvAKqZTfzxs
 eYT5RfO0whZOWls8y4csA/w30HCyhrFzs3fAyD62LlC04KAPt896U+7VqFE6bptZYai2JolE7
 YcBXYSSUMIqFTwLR97AcvHAuql6LOrjxAquJi/mtpILRAsZRZSbCIlrJtJ2/2Ui1vRwBN5HZh
 7VQa4cGhA4Ufw1zysKldL+7vifD1DpJptWxz+ua4wAc9B4w2KV2IEVQHL7DaVQ4z74jToAD9M
 ky5KjuKjn4vZh7opM/AejEvRy1IfCKvlrsP57qBAkT8NAYpGy1CggXGelyUBoPSnPdDfasqJd
 PG7/Xe8pLUWqlfNbMajZj0UQ4XG5YO/Tdk9lzVyV+vfCk58OYAMR02sig9Q0B4cAhDd7z4xN+
 aQzq8p/kwJZixPvaf5KucV1yk9YZUT8StUAM4MgYGwSzi1JK9+ksbBBWuWvohEr6ryUJZjjRD
 VMxiILand/yKh05x+cewqkBL5JhrGLb8nxf1C3umZ5UEJ5MhTLBTc4Ww+RrlfU+4YH4yvK7
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:34:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
> This patch implements strace argument printing functionality for following syscalls:
> 
>     * mlock, munlock, mlockall, munlockall - lock and unlock memory
> 
>        int mlock(const void *addr, size_t len)
>        int munlock(const void *addr, size_t len)
>        int mlockall(int flags)
>        int munlockall(void)
>        man page: https://man7.org/linux/man-pages/man2/mlock.2.html
> 
> Implementation notes:
> 
>     Syscall mlockall() takes an argument that is composed of predefined values
>     which represent flags that determine the type of locking operation that is
>     to be performed. For that reason, a printing function "print_mlockall" was
>     stated in file "strace.list". This printing function uses an already existing
>     function "print_flags()" to print the "flags" argument.  These flags are stated
>     inside an array "mlockall_flags" that contains values of type "struct flags".
>     These values are instantiated using an existing macro "FLAG_TARGET()" that
>     crates aproppriate target flag values based on those defined in files
>     '/target_syscall.h'. These target flag values were changed from
>     "TARGET_MLOCKALL_MCL*" to "TARGET_MCL_*" so that they can be aproppriately set
>     and recognised in "strace.c" with "FLAG_TARGET()". Value for "MCL_ONFAULT"
>     was added in this patch. This value was also added in "syscall.c" in function
>     "target_to_host_mlockall_arg()". Because this flag value was added in kernel
>     version 4.4, it is enwrapped in an #ifdef directive (both in "syscall.c" and
>     in "strace.c") as to support older kernel versions.
>     The other syscalls have only primitive argument types, so the
>     rest of the implementation was handled by stating an appropriate
>     printing format in file "strace.list". Syscall mlock2() is not implemented in
>     "syscall.c" and thus it's argument printing is not implemented in this patch.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/aarch64/target_syscall.h    |  5 +++--
>  linux-user/alpha/target_syscall.h      |  5 +++--
>  linux-user/arm/target_syscall.h        |  6 ++++--
>  linux-user/cris/target_syscall.h       |  5 +++--
>  linux-user/hppa/target_syscall.h       |  5 +++--
>  linux-user/i386/target_syscall.h       |  5 +++--
>  linux-user/m68k/target_syscall.h       |  6 +++---
>  linux-user/microblaze/target_syscall.h |  5 +++--
>  linux-user/mips/target_syscall.h       |  5 +++--
>  linux-user/mips64/target_syscall.h     |  5 +++--
>  linux-user/nios2/target_syscall.h      |  5 +++--
>  linux-user/openrisc/target_syscall.h   |  5 +++--
>  linux-user/ppc/target_syscall.h        |  5 +++--
>  linux-user/riscv/target_syscall.h      |  5 +++--
>  linux-user/s390x/target_syscall.h      |  5 +++--
>  linux-user/sh4/target_syscall.h        |  5 +++--
>  linux-user/sparc/target_syscall.h      |  5 +++--
>  linux-user/sparc64/target_syscall.h    |  5 +++--
>  linux-user/strace.c                    | 21 +++++++++++++++++++++
>  linux-user/strace.list                 |  8 ++++----
>  linux-user/syscall.c                   | 10 ++++++++--
>  linux-user/tilegx/target_syscall.h     |  5 +++--
>  linux-user/x86_64/target_syscall.h     |  5 +++--
>  linux-user/xtensa/target_syscall.h     |  5 +++--
>  24 files changed, 97 insertions(+), 49 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


