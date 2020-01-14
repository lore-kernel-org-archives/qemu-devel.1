Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06881C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CD52467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CD52467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irO8h-0005fG-8z
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irNsf-0001Ls-HK
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:13:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irNsb-0002QV-RQ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:13:21 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:45641)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irNsb-0002PG-IH
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:13:17 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N4eOd-1jpzEY1wvv-011fsw; Tue, 14 Jan 2020 16:12:53 +0100
Subject: Re: [PATCH v5 02/20] linux-user: alpha: Update syscall numbers to
 kernel 5.5 rc3 level
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1578947683-21011-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
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
Message-ID: <36e5c46b-e38e-5440-5536-fc049cc880a4@vivier.eu>
Date: Tue, 14 Jan 2020 16:12:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578947683-21011-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r3z7Wg36sfG6G5D0xqDBPPPTHiy9M5qgSuUhYbZndVK/fWFBqDf
 wo1GsVni3Q3cMvTirusbyYXoGDq0AmU0LsiZKr0HY1eIBqOSZHKv5BgE2VYpbUgvw8lqqbt
 0KiRlYNE2rTVQ22ZPYBOpbjo2Qe/SHy4L6RITFFokrFh2tYJ8BWdg9ElpEGKo8kYwGG/SwG
 4LuvbcNMrBGAxAZH8C/Fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JclYUtLTjUM=:6Bw0vk3keDuTh8iPdxk/0Z
 6RQ5v2bRYqgErH7PXnXDidcIGzfUEUN7+Qhp3MvmJtdl31djBt5OezojD7av3soug9EZyiJU9
 L/wvN9vKocFXfoiKmuGD9rkDCEv00wZYLs7l0pneOH9BKQ7zDRvdzX9/I/WRKoe5OyC0e13Xu
 mdHV1FMzeRh4CMgTC2EZF7TcXcy9kQXY9FJBox9tM/jXgwOcoM0sfm8Za5Gi5vaa9F3hcYwIh
 VsAAKfS6W8DSGQU8YydqsKpUjwiVacL/MuRN1hmJOgMSSb8gJxNhA1ZBZy0hWqRS4s9bMfvH0
 P9y6dkmbWqKooeGTv9f2qTHf0JQbFbgeRPoj0NQQfJT0B3IrI3YTWXQQCoEEO/BIXE3ogdC4l
 sCeL+CczNwORM+2Y2vdGpO3aru70RnM7PFm+zdk7y1GqRDkiwXDy0GV1HO3P7omPSH0GkI+9K
 fO71wPs0LxJ0PTW3n31QduN9cB6jktfZ8AFuXL8MwmjIl8fu9wfZxiA0GzfO32uigohH2OGpd
 5hRrS/qplvsCi4RAmYkkeJ8/upfsAhaoSIUEthpPZ8B4M2hVkCM5ZpfMTa0heiayl3qmV70Wz
 FMJ348u57R3PNHNG7/wIJYWYIqKsK2ZMM5xNZ0x/uNa4NTjEaaEvpi5jMSJyCUB96DELmJvvd
 06VgSvnz7WSk9qNIrbf1pgS7WEzh38gzqhULf0lR0ggtT69+ZpVpMPePCu/fycPx/ksoBxoAA
 b9MaKkwX3R1o3U0wGhB96yt8tIu5aQHcMRc9If1pll9HShv1Zzz1eVzB4NlrVNJqff5B/cDwJ
 3ZokeTHn947qwPefK41WtFRCTzsbvpxu2nwbgup7aGRAf/H1p4VUPeCIzo+wtREIi8561Hkgr
 f4exGfQrd5QtNvsjl0mbvteRapqyNVys4/S6Raj4E=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: amarkovic@wavecomp.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/01/2020 à 21:34, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Update alpha syscall numbers based on Linux kernel tag v5.5-rc3
> (commit 46cf053e).
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> ---
> 
> cc: Richard Henderson <rth@twiddle.net>
> ---
>  linux-user/alpha/syscall_nr.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/linux-user/alpha/syscall_nr.h b/linux-user/alpha/syscall_nr.h
> index 2e5541b..c29fc17 100644
> --- a/linux-user/alpha/syscall_nr.h
> +++ b/linux-user/alpha/syscall_nr.h
> @@ -453,5 +453,40 @@
>  #define TARGET_NR_getrandom                     511
>  #define TARGET_NR_memfd_create                  512
>  #define TARGET_NR_execveat                      513
> +#define TARGET_NR_seccomp                       514
> +#define TARGET_NR_bpf                           515
> +#define TARGET_NR_userfaultfd                   516
> +#define TARGET_NR_membarrier                    517
> +#define TARGET_NR_mlock2                        518
> +#define TARGET_NR_copy_file_range               519
> +#define TARGET_NR_preadv2                       520
> +#define TARGET_NR_pwritev2                      521
> +#define TARGET_NR_statx                         522
> +#define TARGET_NR_io_pgetevents                 523
> +#define TARGET_NR_pkey_mprotect                 524
> +#define TARGET_NR_pkey_alloc                    525
> +#define TARGET_NR_pkey_free                     526
> +#define TARGET_NR_rseq                          527
> +#define TARGET_NR_statfs64                      528
> +#define TARGET_NR_fstatfs64                     529
> +#define TARGET_NR_getegid                       530
> +#define TARGET_NR_geteuid                       531
> +#define TARGET_NR_getppid                       532
> +/*
> + * all other architectures have common numbers for new syscall, alpha
> + * is the exception.
> + */
> +#define TARGET_NR_pidfd_send_signal             534
> +#define TARGET_NR_io_uring_setup                535
> +#define TARGET_NR_io_uring_enter                536
> +#define TARGET_NR_io_uring_register             537
> +#define TARGET_NR_open_tree                     538
> +#define TARGET_NR_move_mount                    539
> +#define TARGET_NR_fsopen                        540
> +#define TARGET_NR_fsconfig                      541
> +#define TARGET_NR_fsmount                       542
> +#define TARGET_NR_fspick                        543
> +#define TARGET_NR_pidfd_open                    544
> +/* 545 reserved for clone3 */
>  
>  #endif
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

