Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE3C46470
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E17B21670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E17B21670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49663 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVth1-0006zB-BP
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 04:12:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVtfL-0005oi-GW
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVtfJ-0001XS-Kg
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:10:31 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hVtfH-0001Ol-OT
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:10:29 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MYeZB-1h9dlh2sJH-00Vfx6; Wed, 29 May 2019 10:04:18 +0200
To: qemu-devel@nongnu.org
References: <20190528195355.26793-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <82cede0f-6149-cda0-987d-8eb4c943c9ca@vivier.eu>
Date: Wed, 29 May 2019 10:04:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190528195355.26793-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BJ2VvPrhfN2wC0CXj9z4t1m8T54elMcHCbLfc9ULhMrp9Z/KDqN
	p3RZH1wx0tCNlAYVNNwjf2TyWcSh9h3wvsd9097vpJqLo/xf2lCcWRTdOh5huf8H0PKPbDw
	4z6tih2PJHNwjmbmru9Uy+2yTLY0T04j1CQ8vJCW5rsEw6jx3Ieyfs/M+RPiMmFcPS4GxTW
	GFWjW4qS7cVm1Sw1KyeTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e0xrdYgDCaY=:CY7y20J1OQOjR3WvTCYmsI
	3J9hO474OUSZxyOQRouujdAXKttztUsZtee0W5C9OHEhCi/vWhzfjd2l4yjinTVvuqft8k4Av
	1p0DZySGgJLsah1xyQFAyMuJzY8GclL3oSbQcx3I5r4lAV3OGGe7CX91G60YySQL4QPHyTOhx
	LbyOfEAPvx0EGkJ0P2HRvPVEyK2x8IOW+aRwv8yAnGMcFKizlQqOfacH0MNJJn1Yaeden2E0e
	oFNaBefX0tc4ddn6h7YyEzwe86+Zhv13tFnbJ+0SOmiE1HzkfQV7RPhUUPdFKn1HvbbxA5mmb
	TYh8Kfkfba7MzgZPnay09HE1CzE2pFst/mjFNu0edJHKU4Ig32nSomo2gtC8n8srfRiu/OPIB
	BO2sfWaz14Nu1qFrbSH1NopTRBO0sBEyKFlERIeBPNn259vaEYA4FiMIL/5RM0tDJZcM77PQQ
	YlsqZcjmK7IOI0gWtZGRcOiRBLEdomgmIuQKNSwjo46pXL0War03Q3PiOcMWIwgijltbDrn/u
	pCsefBaHu8UvgbJ4WdRRLNilb4ZQj5ERojKr7lFG+coKXSSDKesDqSOblVCbdEZVLemQgdmV1
	Ol0l2BYuruFkbuLWmsLgoUhwFjJj+TtMV12bbflAKLalKHX3lVwHztSB1YDNpRdUxv2heONhq
	O2qLyFsYGfaLT1glqEvoOm7RG33/pbz6rb2YMr7XvDZbxRCp7COKSWlgMvIlCB4UhgrQbcym3
	tBSLIRg7UIN0TDnMnfouS+0ipK4YZ9uxvu8tISgsmBX7lpaKiv8TfS9HLys=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [PATCH] linux-user: emulate msgsnd(),
 msgrcv() and semtimedop()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/05/2019 21:53, Laurent Vivier wrote:
> When we have updated kernel headers to 5.2-rc1 we have introduced
> new syscall numbers that can be not supported by older kernels
> and fail with ENOSYS while the guest emulation succeeded before
> because the syscalls were emulated with ipc().
> 
> This patch fixes the problem by using ipc() if the new syscall
> returns ENOSYS.
> 
> Fixes: 86e636951ddc ("linux-user: fix __NR_semtimedop undeclared error")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/syscall.c      | 61 +++++++++++++++++++--------------------
>   linux-user/syscall_defs.h |  1 +
>   2 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5e29e675e9cf..bbd185bbff74 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -763,50 +763,21 @@ safe_syscall2(int, nanosleep, const struct timespec *, req,
>   safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
>                 const struct timespec *, req, struct timespec *, rem)
>   #endif
> -#if !defined(__NR_msgsnd) || !defined(__NR_msgrcv) || !defined(__NR_semtimedop)
> -/* This host kernel architecture uses a single ipc syscall; fake up
> - * wrappers for the sub-operations to hide this implementation detail.
> - * Annoyingly we can't include linux/ipc.h to get the constant definitions
> - * for the call parameter because some structs in there conflict with the
> - * sys/ipc.h ones. So we just define them here, and rely on them being
> - * the same for all host architectures.
> - */
> -#define Q_SEMTIMEDOP 4
> -#define Q_MSGSND 11
> -#define Q_MSGRCV 12
> -#define Q_IPCCALL(VERSION, OP) ((VERSION) << 16 | (OP))
> -
> +#ifdef __NR_ipc
>   safe_syscall6(int, ipc, int, call, long, first, long, second, long, third,
>                 void *, ptr, long, fifth)
>   #endif
>   #ifdef __NR_msgsnd
>   safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
>                 int, flags)
> -#else
> -static int safe_msgsnd(int msgid, const void *msgp, size_t sz, int flags)
> -{
> -    return safe_ipc(Q_IPCCALL(0, Q_MSGSND), msgid, sz, flags, (void *)msgp, 0);
> -}
>   #endif
>   #ifdef __NR_msgrcv
>   safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
>                 long, msgtype, int, flags)
> -#else
> -static int safe_msgrcv(int msgid, void *msgp, size_t sz, long type, int flags)
> -{
> -    return safe_ipc(Q_IPCCALL(1, Q_MSGRCV), msgid, sz, flags, msgp, type);
> -}
>   #endif
>   #ifdef __NR_semtimedop
>   safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
>                 unsigned, nsops, const struct timespec *, timeout)
> -#else
> -static int safe_semtimedop(int semid, struct sembuf *tsops, unsigned nsops,
> -                           const struct timespec *timeout)
> -{
> -    return safe_ipc(Q_IPCCALL(0, Q_SEMTIMEDOP), semid, nsops, 0, tsops,
> -                    (long)timeout);
> -}
>   #endif
>   #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
>   safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
> @@ -3530,11 +3501,21 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
>   static inline abi_long do_semop(int semid, abi_long ptr, unsigned nsops)
>   {
>       struct sembuf sops[nsops];
> +    abi_long ret;
>   
>       if (target_to_host_sembuf(sops, ptr, nsops))
>           return -TARGET_EFAULT;
>   
> -    return get_errno(safe_semtimedop(semid, sops, nsops, NULL));
> +    ret = -ENOSYS;

this and following ones must be TARGET_ENOSYS.

I send a v2.

Thanks,
Laurent

