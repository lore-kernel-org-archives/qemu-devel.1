Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738A0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A21520872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A21520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7biY-0000ri-Dl
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7bhL-000800-Ub
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7bhJ-0004l1-6Y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:40:27 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49895)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7bhI-0004kQ-36
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:40:25 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N8oKc-1iAPn01vny-015oL8; Tue, 10 Sep 2019 10:40:04 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1567601968-26946-5-git-send-email-aleksandar.markovic@rt-rk.com>
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
Message-ID: <cdbc48a4-7431-7c63-3a4d-6ca9a589b3d4@vivier.eu>
Date: Tue, 10 Sep 2019 10:39:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567601968-26946-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N8Wmyhk6K8IwBJGQUerbMqXAmWtAnXmC03Z/n3yalJar4N7xPWw
 o74r7nLbSjXt0PDewcReHNBVRXsuN6ESZ98iNy1T9lrQYqN/94V0DjARldF5ljPL6LBbBV/
 x40Hi2+0Owovq5zO+0c3i4Vjcnvgkcg5harAmixhbsf85PWPz3LlkCQ5w0Euf2oNEf5vury
 OYk8+E+EOv2zqiKxsO0XA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KPZjECOiXw0=:gYEzDGKgPlTyPOZeNWQFJl
 rBX8VgE/M14YXsudJxsO9KZGOVYJ9eDDWLnNlrqzcHk122X1U6D80cJDK8ZpV2ZA7vG2EdESw
 vmjtL7xb2b/iqQs6rwH7QiT5OECTzNevPPIweKcJkkE412RONW/C4bxp71tvGVOKGrM1ugCmO
 oGk+2VtgKkpf1b/paKuQBl75NxCxj0k2TlB9FNPf0XSxeTlXt5h6Q8bPTA7Ll3HG8AIxyJSdW
 3u6yuPwFSazR/jfSRwIt95xf3YbPK6SqN/34eRnZPdBSQwftRgvSzsBi5HT0xIinMEhGbT5kG
 Fsz2MtMB/dQEa8d+OiAiJHsp/aWJmXTFFtePRcdxBgPZrJBl3yC7kNaXnmyeuIYd5cEvfkuuw
 DckA/iojPrJQ6tsCZP5PYWnBBPPzSvXpmZt9dIscihA1GoUZx7Z9DG9U/5xBhwaYmQvowQGb+
 FMc13SvtoQdQpJws6mOBzZIdFu4CtFCHos1fRkkk0U0GMWEJmrWA3f4wj6nbYemVuJhURRUDr
 wuc1yD/KkKj2roWcMW1flOpl7UmjkGcuXAc6u1AMmseTZfbg/gvK+v/lI0lPYAnfQPzEH1YDb
 /VzTQhDnppl9ngr0ohGT1QQwuGSSBenP/LasCM4+ViKEKqKJcKs6hPEnjR0Ipe80BB+SfjRWJ
 fwRly2LEeUp8Xz6hzy50VHlaTYrtSgxCbrP1snLOE36AicKo3SOtdaAZUrTNnrnsDbbXqdy1V
 gwqkt6jF/MeuxFaCdc+YDvZ/kbs1P4WJSB/P+eMDvno7JC/pQEOQgGP532mBhps0fAXk0PVdY
 09wAbAmY/qlYGl43I2BUvPrdCYzBhrPS/Ijwsicy5K1na4jaaA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [PATCH v6 4/8] linux user: Add support for FDFLUSH
 ioctl
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
Cc: riku.voipio@iki.fi, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/09/2019 à 14:59, Aleksandar Markovic a écrit :
> From: Yunqiang Su <ysu@wavecomp.com>
> 
> FDFLUSH is used for flushing buffers of floppy drives. Support in
> QEMU is needed because some of Debian packages use this ioctl while
> running post-build tests. One such example is 'tar' package.
> 
> Signed-off-by: Yunqiang Su <ysu@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/ioctls.h       | 2 ++
>  linux-user/syscall.c      | 1 +
>  linux-user/syscall_defs.h | 4 ++++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 1830de9..bc19448 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -112,6 +112,8 @@
>       IOCTL(BLKZEROOUT, IOC_W, MK_PTR(MK_ARRAY(TYPE_ULONGLONG, 2)))
>  #endif
>  
> +     IOCTL(FDFLUSH, 0, TYPE_NULL)
> +
>  #ifdef FIBMAP
>       IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
>  #endif
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b5bc6e4..6825458 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -87,6 +87,7 @@
>  #include <linux/kd.h>
>  #include <linux/mtio.h>
>  #include <linux/fs.h>
> +#include <linux/fd.h>
>  #if defined(CONFIG_FIEMAP)
>  #include <linux/fiemap.h>
>  #endif
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 498223b..917202a 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -888,6 +888,10 @@ struct target_pollfd {
>  #define TARGET_BLKROTATIONAL TARGET_IO(0x12, 126)
>  #define TARGET_BLKZEROOUT TARGET_IO(0x12, 127)
>  
> +/* From <linux/fd.h> */
> +
> +#define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
> +
>  #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
>  #define TARGET_FIGETBSZ   TARGET_IO(0x00,2)  /* get the block size used for bmap */
>  
> 

Applied to my linux-user branch.

Thanks,
Laurent

