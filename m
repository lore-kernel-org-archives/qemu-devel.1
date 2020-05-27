Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3A5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CAC92084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAC92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdx5v-0000Ak-Fk
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jdx3P-0005g4-TB
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:29:12 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jdx3O-0005nU-6O
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:29:11 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MIKs0-1jq0Ge03sK-00ENRr; Wed, 27 May 2020 16:29:00 +0200
Subject: Re: [PATCH] linux-user, alpha: fix oldumount syscall
To: qemu-devel@nongnu.org
References: <20200502194642.32823-1-laurent@vivier.eu>
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
Message-ID: <5bd08ea4-bff9-d28f-8b7d-110717a7b505@vivier.eu>
Date: Wed, 27 May 2020 16:28:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200502194642.32823-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eyeW4cH4f+88Yn4xICeBMDTSnkl1tFbHoVqQK8jZYsx0uysSUHL
 Vcdloj1a96cmItFk2lwC1yNK5308hD425l0Qh5tNCvqwL87dQp1WSW9b2nufl4Whszc6AUq
 DZoJ3RrSJ3v5idwBbLqriZqtHJIgAhO1hL1yI0xM5CJ+WLZU2jlc2mOMOuiJGelIat5KL6f
 JlJtEjKRAueXOkohZW1vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kGscLtug8No=:7MO7/290NJmFXQVC2Ed8Qx
 YlJga954jrC4yePySBM4rIST183fYSRFXMMbqHGOA8yLI5y6/ekCcjcSKrI7MkCx+viG90A5b
 BNUEHQjbbg3HHwZ/olcQzO14VztrfRuHqFuTM/CR4yKGlSmdr68bSkNTP5QNy0EAb2p6ZbOjt
 v+zaLhVWmDG5H7Rk1ZkmvfswDMBnWqfFJ1cLLMeDLqiq65N4GwRws2UCAeVRT5mRzduCIfXQA
 Xoyb+PLLW+L4ImtVwzlwEFWa1IZ4tYkwbl+baqjYR3QJytUqPYO0hkKvuXohb8TOjNgEUJvGE
 LeUJlavT0V/n22lI1YEFg3j1KDIkhC2V3iMKXQjiPspWDgnwWpsBH2GXUQZsFDBgwP6Nb3+SO
 wOnIrxPOFhtDJxDC++eUVsFCXqYU/PX78a+bkS22VYP9B/iIJ9ou2++he5n7acngUvLlwdPrt
 tXqZg1QeoidgJn46/KYbKQY0lioIwifQA52URYldXZcZXkgtrlA8TqxAh88R9Z+CJ5Lfdhp0U
 NRFYNWn1UqwmoTfn2GaV/rxTfLanBBizmnKhOf6LKfvqE1IAUoTRl8zmxxvlu52cBvBR+bI82
 7PhLl0J4xiygivgMhO0NQDxdvpLu+MStMbiB0D1pp3Ft6tMgHLG1pyJLyifQA0EUs4Y2kJELj
 Pjv9iY8UwcFa3S3w54gzk/TrbrdshtwOaWNNJi7P1pOezfyYBhNHc4+QO+en42H6ht395e0k4
 6AQzVZq/E2sSPoMLPU9cxTYxfow3rCPwFiLxGdmioDHOsfFjpJXrDCcsW7JdTLmca+rR68DlP
 EevZvDgz+HnJz0fAtXhrEATgqb4xgi46yWLiVPO0RjPlb1FRncUoB60rUVLLZXX5yCVsaA5
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 10:29:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/05/2020 à 21:46, Laurent Vivier a écrit :
> When we try to bootstrap debian/lenny for alpha, it fails because
> it cannot umount /.root directory:
> 
>   ...
>   Setting up initscripts (2.86.ds1-61) ...
>   umount: /.root: Function not implemented
>   dpkg: error processing initscripts (--configure):
>    subprocess post-installation script returned error exit status 1
>   dpkg: sysvinit: dependency problems, but configuring anyway as you request:
>    sysvinit depends on initscripts; however:
>     Package initscripts is not configured yet.
> 
> This is because, when we switched from syscall_nr.h to syscall.tbl,
> the syscall #321 has been renamed from umount to oldumount and
> syscall.c has not been updated to manage the new name.
> 
> oldumount has been introduced in linux 2.1.116pre1 by:
>   7d32756b2 ("Import 2.1.116pre1")
> ...
>  * We now support a flag for forced unmount like the other 'big iron'
>  * unixes. Our API is identical to OSF/1 to avoid making a mess of AMD
> ...
> 
> Fixes: 6116aea994 ("linux-user, alpha: add syscall table generation support")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff07..e89b815ce983 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8028,8 +8028,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>          }
>          return ret;
> -#ifdef TARGET_NR_umount
> +#if defined(TARGET_NR_umount) || defined(TARGET_NR_oldumount)
> +#if defined(TARGET_NR_umount)
>      case TARGET_NR_umount:
> +#endif
> +#if defined(TARGET_NR_oldumount)
> +    case TARGET_NR_oldumount:
> +#endif
>          if (!(p = lock_user_string(arg1)))
>              return -TARGET_EFAULT;
>          ret = get_errno(umount(p));
> 

Applied to my linux-user branch.

Thanks,
Laurent

