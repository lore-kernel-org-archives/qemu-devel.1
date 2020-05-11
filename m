Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770E1C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53807206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53807206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYDfa-0000ru-Bx
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 15:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jYDe2-00086x-U6
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:59:18 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:34229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jYDe1-0004B9-MR
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:59:18 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MUl4z-1jgmKZ01QH-00QmJG; Mon, 11 May 2020 20:59:06 +0200
To: Matus Kysel <mkysel@tachyum.com>
References: <20200511163928.70261-1-mkysel@tachyum.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: support of semtimedop syscall
Message-ID: <d1bdaf2c-1c8d-72c5-3024-4a4d458dbd8e@vivier.eu>
Date: Mon, 11 May 2020 20:59:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511163928.70261-1-mkysel@tachyum.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Eta++RlqOndq2tGkuUX98T1v6DBrdfih//r1gRtcVW+2u11cnEL
 IhZfWzLn63bftpEQYGdmDOS4eJTtF1YhPGchw8mEHFyUcny3VthrdY7yqO9RfuJFDQCOsCy
 MJHCMrw7QIXcuRX6oO7l7XS6YrQxZAYbrTfbpvpukoy86ses89ulrkv+6sWOiF0TZUwXXsW
 +JeS20lRslLq5SEsMyUAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vo8aQh4Vizg=:xaquVJ+BK5iICouWjqhQ2o
 7PGYOOhfsRpSIQOL6MqYzYTQ18tfwqUh0V4Ed4hLkCsO2Z7NOM0/RJg5YvvJioRRqspsWIhjr
 Q2LsoRMD9nmq8XsntL/NlAImSSrBO5JaTd06N8V+BPIgb31EECehI9XNY6KJ+zqtieNNRqUGv
 7pD/R6N+XvcnoiqSYunLPe/tqbPCzfcUfKQJxs3msJMVb+YJbj1g+Bbsh4/cpZoQRbH6UlRYC
 ojsBs9lB0rOm9FY7n1UNDxjCJLEd5v4rIqzzx0Ub8jlMzl2xcycVyjKHgPzmiShAe6NT9fOGD
 YX8t5WskXOWwnkKBkk7oCQ/ejauQiSWtAe7HSYW2/hIDcXPYNFk4LN0evrkja3ndenvafcbmf
 FO8pktoRhp7sSGo/KR8T+PQhJqPBxV3clapmuLZakC9QE+Lyl2TSFAkAs4L+wcMWHm6bQa9tL
 ttXXXk5DhFuzUE0Utwn2Ml6bq/nUbTAcwOewdFW/AtVZWbd7LTNIZvy8u/Fxns840yWByRH9C
 kFqjsYr+VRIWhjlMX9vqkzQSyMNe8Im4ACNZSLka/zrEM25tNQORy0DOSPdJ2fLaADw8lnS6u
 tPDdVjTMzokWpIK7qHkDihn+IHfVSJhmFO9QZsuVPW0iqGaec9u+eDgciw4asgxioKQ81mfkM
 eOD6dOlDULFP2YAWJz2TK0xkIEaFOOic+6YlYQUhBXsVr8hYCGrapdEa52Qut/yTWOZH4addE
 vxyUPCtCgs2xCsvgW6zAyyzA/L0j5zJYt3ROtZdchGQOW2A6B/zmmZtgJeObmUwrv7TOTsRRa
 jBerDcT4M6QdWwDshz3p8HOv4Szhqx1mV1sAoqf6JfDb1X2HOR43Gq2t4tnuYhUXgIESN4r
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 14:05:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 11/05/2020 à 18:39, Matus Kysel a écrit :
> We should add support of semtimedop syscall as new version of
> glibc 2.31 uses semop based on semtimedop (commit: https://gitlab.com/freedesktop-sdk/mirrors/sourceware/glibc/-/commit/765cdd0bffd77960ae852104fc4ea5edcdb8aed3 ).
> 
> Signed-off-by: Matus Kysel <mkysel@tachyum.com>
> ---
>  linux-user/syscall.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 3a924c0004..cb3978a2a5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3879,21 +3879,32 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
>      return 0;
>  }
>  
> -static inline abi_long do_semop(int semid, abi_long ptr, unsigned nsops)


You should add around this function:

#if defined(TARGET_NR_ipc) || defined(TARGET_NR_semop) ||
defined(TARGET_NR_semtimedop)

> +static inline abi_long do_semtimedop(int semid,
> +                                     abi_long ptr,
> +                                     unsigned nsops,
> +                                     abi_long timeout)
>  {
>      struct sembuf sops[nsops];
> +    struct timespec ts, *pts = NULL;
>      abi_long ret;
>  
> +    if (timeout) {
> +        pts = &ts;
> +        if (target_to_host_timespec(pts, timeout)) {

You should add the same #ifdef around target_to_host_timespec().

> +            return -TARGET_EFAULT;
> +        }
> +    }
> +
>      if (target_to_host_sembuf(sops, ptr, nsops))
>          return -TARGET_EFAULT;
>  
>      ret = -TARGET_ENOSYS;
>  #ifdef __NR_semtimedop
> -    ret = get_errno(safe_semtimedop(semid, sops, nsops, NULL));
> +    ret = get_errno(safe_semtimedop(semid, sops, nsops, pts));
>  #endif
>  #ifdef __NR_ipc
>      if (ret == -TARGET_ENOSYS) {
> -        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid, nsops, 0, sops, 0));
> +        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid, nsops, 0, sops, pts));
>      }
>  #endif
>      return ret;
> @@ -4373,7 +4384,8 @@ static abi_long do_ipc(CPUArchState *cpu_env,
>  
>      switch (call) {
>      case IPCOP_semop:
> -        ret = do_semop(first, ptr, second);
> +    case IPCOP_semtimedop:
> +        ret = do_semtimedop(first, ptr, second, third);

Are you sure "third" is NULL in case of IPCOP_semop?

You should explicitly keep

    ret = do_semtimedop(first, ptr, second, NULL);

for IPCOP_semop.

>          break;
>  
>      case IPCOP_semget:
> @@ -9608,7 +9620,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #endif
>  #ifdef TARGET_NR_semop
>      case TARGET_NR_semop:
> -        return do_semop(arg1, arg2, arg3);
> +        return do_semtimedop(arg1, arg2, arg3, 0);
> +#endif
> +#ifdef TARGET_NR_semtimedop
> +    case TARGET_NR_semtimedop:
> +        return do_semtimedop(arg1, arg2, arg3, arg4);
>  #endif
>  #ifdef TARGET_NR_semctl
>      case TARGET_NR_semctl:
> 

Thanks,
LAurent

