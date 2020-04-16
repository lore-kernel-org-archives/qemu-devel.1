Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33B4C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 07:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D03206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 07:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D03206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOysY-0006GI-Ch
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 03:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jOyrl-0005r6-UQ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 03:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jOyrk-0007Xv-TX
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 03:23:17 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36753)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jOyrk-0007XZ-LL
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 03:23:16 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M7KG2-1jJVDH3ihQ-007npZ; Thu, 16 Apr 2020 09:23:04 +0200
Subject: Re: [PATCH] linux-user/syscall.c: add target-to-host mapping for
 epoll_create1()
To: Sergei Trofimovich <slyfox@gentoo.org>, qemu-devel@nongnu.org
References: <20200415220508.5044-1-slyfox@gentoo.org>
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
Message-ID: <db152931-fbbb-6100-0778-3433dcac49f4@vivier.eu>
Date: Thu, 16 Apr 2020 09:23:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415220508.5044-1-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T1GneZfrNtrYz4Sxh2crxNjO1WzA3iIGq9Y7DjkoNV6Dr1D0KB+
 2j92rzqc6U1tyhKh8+WnXTYACcZHV5PIBX93qEodvyfu1cSBgB76mXbdWWAwHvqFa+Ko3Zy
 z7iQmGaUT7ivqNgQRVLwMUbfMPoCfcm+dFPkZgY4bMy9B2eik6XMxdkUKhca7XIo84C+j4G
 6vHCTMKOVVSTMHFGrAHvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zCQTceuJ9Ww=:07USXe4HlaLZNVlSlYF+AO
 cKc5p97PJMfVODmaFdXce88eyU+sSzh41jFLSZht2OhN2d1cY1DGhdLBksonnGr88Mxs8GAxJ
 Nbd3zvxoWeNcwlI3ENbpZJP5P0IqsmkORMk4RazUb26hDAMNQ874Rvvy7VgYH3piUI3IIl11e
 3jrPOosmhNuvxF//cL5ROG4a+4wF9WgIV3KKcIGbEmzt2bHm4aseKDH4odG3o89itOnw9Xxb3
 GReoOfhMnN4kRyFnmK8B7+xmuyhuOlzNd30oEslLpDK/FCpu//Cq+oo0rRi+gwcz3GDIUIAyo
 QqiFSO9smsigdfLI2VdLoxzo6FTrjR+8liSmAKMO52comxVNZBvD7leSQNrmDOZI3T4fn3ozS
 LeGxmcPOxQ8EHO38k17o/NI5bP0t3032KFvG2DswQDiJfj7c7hiGffGEXWcdbPnTDZ2lxQkC0
 /JcEQ6d2Xvig28+TzY9uAkKBlI9WwY8//i9SDIcbW4JKmZv0ehnHgKIM1GXOldVnKM3roLio8
 BDC41LWJk5XsqnY8nmUjdwJfPV7Kg/+q25u8qdbEqh5JtPjblWsKeoMMRknpGmXnohMaiaPfT
 WfKi5pXzSCMU/P0HGZ4x/6LcMMd+MU5SSAe5CTZKnUbUFVItka8vH3zyfKTCqkFVm5aajfrIE
 rJa8wawLeZ1eMUgfVgwJvWABrAI2Iff4GIuBroH6DyhcAoGg5np9yLc9nsgFXV37BFQWVXJSB
 JL/2CcUmPnVL9uYLNcgdbJB80KXJaMHR5iesMAe0e9iSWh9VcFajqADHp9GJ+lQmiO/WS4xFy
 wLhpdS2KtbQ+NuCMEcVlyBb8kPoIOvIwsFGrKIH9Rz7VLNUeQ746JOMUgdTr/JMpR0cyvO6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/04/2020 à 00:05, Sergei Trofimovich a écrit :
> Noticed by Barnabás Virágh as a python-3.7 failue on qemu-alpha.
> 
> The bug shows up on alpha as it's one of the targets where
> EPOLL_CLOEXEC differs from other targets:
>     sysdeps/unix/sysv/linux/alpha/bits/epoll.h: EPOLL_CLOEXEC  = 01000000
>     sysdeps/unix/sysv/linux/bits/epoll.h:        EPOLL_CLOEXEC = 02000000
> 
> Bug: https://bugs.gentoo.org/717548
> Reported-by: Barnabás Virágh
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> CC: Riku Voipio <riku.voipio@iki.fi>
> CC: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 674f70e70a..05f03919ff 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12012,7 +12012,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #endif
>  #if defined(TARGET_NR_epoll_create1) && defined(CONFIG_EPOLL_CREATE1)
>      case TARGET_NR_epoll_create1:
> -        return get_errno(epoll_create1(arg1));
> +        return get_errno(epoll_create1(target_to_host_bitmask(arg1, fcntl_flags_tbl)));
>  #endif
>  #if defined(TARGET_NR_epoll_ctl)
>      case TARGET_NR_epoll_ctl:
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

