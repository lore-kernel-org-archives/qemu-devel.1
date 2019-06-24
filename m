Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11230C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 21:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF8C20656
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 21:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF8C20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfW6s-0001EA-GF
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 17:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42171)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hfW5u-0000me-Lm
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 17:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hfW5t-0004Zz-9G
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 17:01:42 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55789)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hfW5s-0004NZ-VR
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 17:01:41 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1McYP5-1iHsEm0dWn-00cukr; Mon, 24 Jun 2019 23:00:57 +0200
To: qemu-devel@nongnu.org
References: <20190529084804.25950-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <8174b26f-e440-6d55-54f0-4ea1bba9dbb2@vivier.eu>
Date: Mon, 24 Jun 2019 23:00:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529084804.25950-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GNu6mbSFdqZC3ZRcJK0U9TBsCxHj+BBvKFzEx5LlRrZ/jnROzoV
 CCltkAi+lq73vUW17gfOAKAoR85hi6UTSf6vPqc7+bPboPe1sX0oh56oyUvQ4JVKPPBHuS0
 /A/OEXsS5dAwLDnWjYxXm8p1mP+j6SvIx37AxGLSzW8YRZ1qEcIxoQJMzL8oJ2Q5bXmZigb
 YD9zFKxVMkvKHFeLuArxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZDCsdHOSDhc=:wq4RXx7YRBpw5t4p4Qhfs3
 2AoZZUZNeDh394C+yHsDM/xxh34unoVrazSnf15k5i1lsMBVKAsTy0kuZE4hFPDvM8Ebm4dYR
 VnxMjev6mhWNoT1wO9wA+af7c4wk4SDyzOq25WS5AvT5FduEtQN453xXICB0Iyj31vqyLalPU
 RGjh/6e7ZpBubBiITdFnISdKRZRwN27TuvFcHjmM2yMI5vuUAx1M6buDufgOh7RWcgP/Ai+cH
 ZJkThFf4qyO2/287dZAqgq4U8eJRvhnh6O8akhc7hnAtLLdt8x3mz1l+YIh7GJtYjgYQpppCx
 jIbmI46J4JufqALTQBlfpGANcz4En5zUdW99GUl36wYg/PgzFDEC5Bt7NbTDyy9FFu6P29nl7
 +yvo1X609hCuqX2sRhzCx5ixPLKweXLfxBLjx2SBPAhwbCnk72gzzN1aJ4lpghdzLKOFB9EVP
 lt5pNQg1J3XE6gXZaLuqcA/zJllhM1sUkuKz2MALNnZmH0Q5LGBj5zqF5bUH5MIkFNaKtQ3Nd
 odXONUiC6Ubz0SLq75LVsOP4rEW0iUzeeGG++IQnJm/uAorBx8eK7MqSKs8DXdPAde0SYs+9Y
 uvGOmdmtRMyMUKLX15lclkelznWTVmS5dqwj8aT1ToxcVPKTWZkakwpmxze0YFGxZfEMMJS4y
 O9cPySKRDAYlJeuRpP5a5tgiUDneNn5k+aZ4Upn3z0Lj+pikxlvqvQ4iPHWqyOpqxCTThr6ar
 sdxMXg2LPYoUWyhzn3FvZAl9oradjG5IJ7ktbCrWaFyvjMgMofW3obQodo4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: emulate msgsnd(),
 msgrcv() and semtimedop()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 29/05/2019 à 10:48, Laurent Vivier a écrit :
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
> 
> Notes:
>     v2: replace ENOSYS by TARGET_ENOSYS
> 
>  linux-user/syscall.c      | 61 +++++++++++++++++++--------------------
>  linux-user/syscall_defs.h |  1 +
>  2 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5e29e675e9cf..9ecbac463385 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -763,50 +763,21 @@ safe_syscall2(int, nanosleep, const struct timespec *, req,
>  safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
>                const struct timespec *, req, struct timespec *, rem)
>  #endif
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
>  safe_syscall6(int, ipc, int, call, long, first, long, second, long, third,
>                void *, ptr, long, fifth)
>  #endif
>  #ifdef __NR_msgsnd
>  safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
>                int, flags)
> -#else
> -static int safe_msgsnd(int msgid, const void *msgp, size_t sz, int flags)
> -{
> -    return safe_ipc(Q_IPCCALL(0, Q_MSGSND), msgid, sz, flags, (void *)msgp, 0);
> -}
>  #endif
>  #ifdef __NR_msgrcv
>  safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
>                long, msgtype, int, flags)
> -#else
> -static int safe_msgrcv(int msgid, void *msgp, size_t sz, long type, int flags)
> -{
> -    return safe_ipc(Q_IPCCALL(1, Q_MSGRCV), msgid, sz, flags, msgp, type);
> -}
>  #endif
>  #ifdef __NR_semtimedop
>  safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
>                unsigned, nsops, const struct timespec *, timeout)
> -#else
> -static int safe_semtimedop(int semid, struct sembuf *tsops, unsigned nsops,
> -                           const struct timespec *timeout)
> -{
> -    return safe_ipc(Q_IPCCALL(0, Q_SEMTIMEDOP), semid, nsops, 0, tsops,
> -                    (long)timeout);
> -}
>  #endif
>  #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
>  safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
> @@ -3530,11 +3501,21 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
>  static inline abi_long do_semop(int semid, abi_long ptr, unsigned nsops)
>  {
>      struct sembuf sops[nsops];
> +    abi_long ret;
>  
>      if (target_to_host_sembuf(sops, ptr, nsops))
>          return -TARGET_EFAULT;
>  
> -    return get_errno(safe_semtimedop(semid, sops, nsops, NULL));
> +    ret = -TARGET_ENOSYS;
> +#ifdef __NR_semtimedop
> +    ret = get_errno(safe_semtimedop(semid, sops, nsops, NULL));
> +#endif
> +#ifdef __NR_ipc
> +    if (ret == -TARGET_ENOSYS) {
> +        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid, nsops, 0, sops, 0));
> +    }
> +#endif
> +    return ret;
>  }
>  
>  struct target_msqid_ds
> @@ -3689,7 +3670,16 @@ static inline abi_long do_msgsnd(int msqid, abi_long msgp,
>      }
>      host_mb->mtype = (abi_long) tswapal(target_mb->mtype);
>      memcpy(host_mb->mtext, target_mb->mtext, msgsz);
> +    ret = -TARGET_ENOSYS;
> +#ifdef __NR_msgsnd
>      ret = get_errno(safe_msgsnd(msqid, host_mb, msgsz, msgflg));
> +#endif
> +#ifdef __NR_ipc
> +    if (ret == -TARGET_ENOSYS) {
> +        ret = get_errno(safe_ipc(IPCOP_msgsnd, msqid, msgsz, msgflg,
> +                                 host_mb, 0));
> +    }
> +#endif
>      g_free(host_mb);
>      unlock_user_struct(target_mb, msgp, 0);
>  
> @@ -3717,7 +3707,16 @@ static inline abi_long do_msgrcv(int msqid, abi_long msgp,
>          ret = -TARGET_ENOMEM;
>          goto end;
>      }
> +    ret = -TARGET_ENOSYS;
> +#ifdef __NR_msgrcv
>      ret = get_errno(safe_msgrcv(msqid, host_mb, msgsz, msgtyp, msgflg));
> +#endif
> +#ifdef __NR_ipc
> +    if (ret == -TARGET_ENOSYS) {
> +        ret = get_errno(safe_ipc(IPCOP_CALL(1, IPCOP_msgrcv), msqid, msgsz,
> +                        msgflg, host_mb, msgtyp));
> +    }
> +#endif
>  
>      if (ret > 0) {
>          abi_ulong target_mtext_addr = msgp + sizeof(abi_ulong);
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 7f141f699c1a..3175440e9dd9 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -32,6 +32,7 @@
>  #define TARGET_SYS_RECVMMSG     19        /* recvmmsg()            */
>  #define TARGET_SYS_SENDMMSG     20        /* sendmmsg()            */
>  
> +#define IPCOP_CALL(VERSION, OP) ((VERSION) << 16 | (OP))
>  #define IPCOP_semop		1
>  #define IPCOP_semget		2
>  #define IPCOP_semctl		3
> 

Applied to my linux-user branch.

Thanks,
Laurent

