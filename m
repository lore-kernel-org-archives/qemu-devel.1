Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40985C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135F423A32
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135F423A32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprgG-0002zG-As
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jprfd-0002XZ-DX
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:09:53 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jprfb-0007lP-H8
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:09:53 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MhDAi-1jCh5t3Q9K-00eOQL; Mon, 29 Jun 2020 13:09:48 +0200
Subject: Re: [PATCH v5 0/6] Add strace support for printing arguments of
 selected syscalls
To: Filip Bozuta <filip.bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200619123331.17387-1-filip.bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2e62ce84-3a9a-00c4-5e81-754df44b7f0b@vivier.eu>
Date: Mon, 29 Jun 2020 13:09:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619123331.17387-1-filip.bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EEUYMsQb0/fomsc2gQb40uYEuRRApmV5C5e7xIlL3DUDVYnfZRB
 v+3Kt7LiW2GyrAwSNBeRCwmArg2ZuzM/JxuXsxzkGTKYiZljkfau9yqLbY9mTZHTVrIH8Ai
 enBBBRpvhMfEnjreLohWgJ7svY/kjlZ/Kx0TxJltYq0RUeuaDzBmPFTf7R3oWYLmE41KngQ
 +0xpxyU58z6ULTizu0z5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yg/XRoBezyc=:8vMM8QhqKWkFuAhqprk7tS
 esSz83RRboK4EoDFUOAJrTqnJO+YDLbjnDSpTc/PB8TeHu0iyiUZuG0W0eW3GlIExGNhTJRhw
 urA+meMsqQnYYONXQPBR93PxavwZT36rcanTwpO4JHWt6Et1CfsBkisH6/QuBUMuDyJRSGar9
 5CPYQAmiGnSOYhkENFU/iYNvKGWqXxDrTsGu4u/KnsY/JpS8YkIY5zRp7hdoBPJhtvEXmwyVs
 29AcpMhJ0+jddJOG++lkimPeUlwQ7tyLiSI8tczCZGbERcbvoqgCBJO67gYl60LG0eBZMMYfX
 PjKXhthzrDo4DTAxHr7iUphaI/VEBs9mDY2rSy39bStDQmXeqpqmd3ZRoJo3UDvnrgEE/ehHY
 P2xv+/PfzulGD7+NYzUGJ3PNjZ/q8U/JeGc3Y9movmWj3Eoa2ofaVKkKQR9FPcDEQlC/CeU3M
 JNiH4qQVXTrp0gi6VGpSC7wa7ZW1udO9oiGDadvm/6tPtYxBWsd3AYt9nY4jubVaMbRoDkGM9
 B+MAgmmwbV9uWoK0ZaL5X22F+hwLWiUlx5s7ryUsM1fyc4XbdRo0O8S3uc1UR3B7fpXlKPaXE
 hIlgnn5qtN1M8EOInh/MA0AmXHV8SkyP037+ZOdj+14+k6wqkPe+m3wRcxmto4xRZ3M9yDJST
 TqArM6RQ7vmBcCnbIZCTXrhW5S51srcVAM4ZF/RYkCf+Vy+Y3UcFmZ1W4hrwaL8SZ0zTjer07
 PbA2XhmredllG7IxgEa1q9AtzGoTpfJn3cQRiDLsVIcW9/6JTyhadiLuQEehqkIvJbu6IL9Nh
 5Eb+SqgDktOv9X1tiIVf+c0v3xej00pST9TxaivPYSgH0U385s=
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 07:09:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/06/2020 à 14:33, Filip Bozuta a écrit :
> From: Filip Bozuta <Filip.Bozuta@syrmia.com>
> 
> This series covers strace support for printing arguments of following syscalls:
> 
>     *acct()           *lgetxattr()       *removexattr()       *lchown()
>     *fsync()          *fgetxattr()       *lremovexattr()      *fallocate()
>     *fdatasync()      *listxattr()       *fremovexattr()
>     *listen()         *llistxattr()      *lseek()
>     *getxattr()       *flistxattr()      *chown()
> 
> The implementation details for strace support is described in this series patch
> commit messages.
> 
> Testing method:
> 
>     Mini test programs were written that run these syscalls for different arguments.
>     Those programs were compiled (sometimes using cross-compilers) for the following
>     architectures:
> 
>         * Intel 64-bit (little endian) (gcc)
>         * Power pc 32-bit (big endian) (powerpc-linux-gnu-gcc)
>         * Power pc 64-bit (big endian) (powerpc64-linux-gnu-gcc)
>         * Mips 32-bit (little endian) (mipsel-linux-gnu-gcc)
>         * Mips 64-bit (little endian) (mips64el-linux-gnuabi64-gcc)
> 
>     The corresponding native programs were executed with strace, without using
>     QEMU, on Intel Core i7-4790K (x86_64) host.
> 
>     All applicable compiled programs were in turn executed with "-strace"
>     through QEMU and the strace printing results obtained were the same 
>     ones gotten for native execution.
> 
> v2:
> 
>     * Added patch that extends strace support by enabling argument printing
>       after syscall execution
>     * Added strace support for argument printing for syscalls:
>       removexattr(), lremovexattr(), fremovexattr()
>     * Added "print_syscall_ret_listxattr()" that prints list of extended
>       attributes after execution of syscalls: listxattr(), llistxattr(),
>       flistxattr()
>     * Corrected formats in some printing functions
>     * Moved target_offset64() function definition from "syscall.c" to
>       "qemu.h"
> 
> v3:
> 
>     * Added generic function SYSCALL_RET_ERR() that checks the return value
>       and prints the approppriate error message
>     * Added "print_syscall_ret_llistxattr" and "print_syscall_ret_flistxattr"
>       in strace.list for "llistxattr()" and "flistxattr()" that have same
>       definition as "print_syscall_ret_listxattr"
> 
> v4:
> 
>     * Changed error printing from macro SYSCALL_RET_ERR() to function
>       print_syscall_err()
>     * Changed while loop in "print_syscall_ret_listxattr()" to check printed
>       bytes against size of the return value
> 
> v5:
>     * Corrected "print_newselect()" and "print_syscall_ret_newselect()"
>       to use the new functionality to store syscall argument values
>     * Changed while loop in "print_syscall_ret_listxattr()" to check only the
>       size of the return value without the variable for printed bytes
> 
> Filip Bozuta (6):
>   linux-user: Extend strace support to enable argument printing after
>     syscall execution
>   linux-user: Add strace support for a group of syscalls
>   linux-user: Add strace support for printing argument of syscalls used
>     for extended attributes
>   linux-user: Add strace support for printing arguments of lseek()
>   linux-user: Add strace support for printing arguments of
>     chown()/lchown()
>   linux-user: Add strace support for printing arguments of fallocate()
> 
>  linux-user/qemu.h      |  20 ++-
>  linux-user/strace.c    | 328 ++++++++++++++++++++++++++++++++++-------
>  linux-user/strace.list |  37 ++---
>  linux-user/syscall.c   |  18 +--
>  4 files changed, 315 insertions(+), 88 deletions(-)
> 

Applied to my linux-user-for-5.1 branch.

Thanks,
Laurent

