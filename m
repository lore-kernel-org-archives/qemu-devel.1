Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F09CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61CA20674
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61CA20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUeF-0002oZ-48
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgUdK-0001a1-66
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:44:46 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgUdI-0007Kr-Lh
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:44:45 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M2fHt-1jglkM3dtv-004A63; Wed, 03 Jun 2020 16:44:42 +0200
Subject: Re: [PATCH 4/5] linux-user: Add strace support for printing arguments
 of chown()/lchown()
To: Filip Bozuta <filip.bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200602115331.1659-1-filip.bozuta@syrmia.com>
 <20200602115331.1659-5-filip.bozuta@syrmia.com>
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
Message-ID: <3c0cc211-c354-89f2-45be-3142b5821efd@vivier.eu>
Date: Wed, 3 Jun 2020 16:44:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602115331.1659-5-filip.bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GcbKq5afD5nL4BpeqgLZYXI/xcCYwv0htlLfYsm2iVYjqBxBv/M
 lI7yeRrgnJhFaCqVZ/Fef/0cLg2b274h3aFUeqpD57IFfM+qSwD5tIXG3qqyfh6CbpmKddp
 yvULYjzIgXFwN4cE+LPSSVhKv6Y3rP/ucc6ixD6LbpiERbAsomw4GLPQxuZ49z7ETPVyYF9
 3OUrDG2ihFaVR8k/vVN/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jlw+eoEZaE4=:OHFQ+jFUWiasE7/Lx4Rt7u
 zP6Xb79papWGHjF/SjXPUkiYi6jwZ0TR0vcEJ7Fy1Hy0YsNwZtpr+fCTmZSx1SdBv11K+zNA5
 kOAUkReVcDVo+VF3eYgJJFSeiZDkMNrynp941kF+dDcpXYNkcpP4+Db7nkw5ZWtX3Ly7jzi+E
 tcgm4qO83iQzpTFDieqpYVWiLPvdo1yvP9jODA5tOX0uTsmBU3s75rYK5XMyuVdooxGkaZzsD
 XvOdsoNc9MUyw3autuFXkkCYH03lCSFUraz1ysnwaMZEuk37u8QvJMruxDQMTcvuEO4Oj0cVU
 RDHt+gmqt6tk+FDpOckQ5VBUZ7eMWJ2i5pazUD7CHqngvzReUd+fTax4MbVLABq7b8WNxycrf
 c7ZqOphextcA5ejch/+k4uwtD7ZLaj8+7Cw5S0764iEZ2+0mF+hkerW1zMoCM5ZWGF9zy2rlG
 xiepTZN7IVAIe6nlI7fdNN9Ronj28s/dkE5T9ZXY0WaXWmMDguPH+GfTNvwhL+6gSsu3OuwB8
 6GceS2Udzu+xx9EnMz3k3Ur4RpOdYFtq2pJXpEvGLNXs3n7ibQOFHIeS4rR8nrlmh9KPdUJF+
 XL053DLuJ60eRPtNvxQQI+YnT1P+1/Ww66ST1JqRQWd4oPnFpvEH+HGUsIjCkHAy/tMh+tY2q
 usMwIXJFFIUHbyKHdbKlcYg6Cxg2p5MDV+cfTkfkm3TEMBijCaxWdiGZmMMGLxgMiObv1Cnl8
 E4FfswiOzJQnp87HjQ+Z43IJeujgFAznaTECIjb0Fntizgz1ihDTZwBGXc3HHyVcjdTnryBqg
 AacPv335xOF1KXtOftI3/ieLMtWQVQDiPx5HUQYiJg7yWLoGhxscHyfrq1Cx5I3CPaZOTWw
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 10:44:43
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/06/2020 à 13:53, Filip Bozuta a écrit :
> From: Filip Bozuta <Filip.Bozuta@syrmia.com>
> 
> This patch implements strace argument printing functionality for syscalls:
> 
>     *chown, lchown - change ownership of a file
> 
>         int chown(const char *pathname, uid_t owner, gid_t group)
>         int lchown(const char *pathname, uid_t owner, gid_t group)
>         man page: https://www.man7.org/linux/man-pages/man2/lchown.2.html
> 
> Implementation notes:
> 
>     Both syscalls use strings as arguments and thus a separate
>     printing function was stated in "strace.list" for them.
>     Both syscalls share the same number and types of arguments
>     and thus share a same definition in file "syscall.c".
>     This defintion uses existing functions "print_string()" to
>     print the string argument and "print_raw_param()" to print
>     other two arguments that are of basic types.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/strace.c    | 15 +++++++++++++++
>  linux-user/strace.list |  4 ++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index b7f012f1b5..542bfdeb91 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1414,6 +1414,21 @@ print_chmod(const struct syscallname *name,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_chown) || defined(TARGET_NR_lchown)
> +static void
> +print_chown(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_string(arg0, 0);
> +    print_raw_param("%d", arg1, 0);
> +    print_raw_param("%d", arg2, 1);
> +    print_syscall_epilogue(name);
> +}
> +#define print_lchown     print_chown
> +#endif
> +
>  #ifdef TARGET_NR_clock_adjtime
>  static void
>  print_clock_adjtime(const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 5a56212532..b72f757d3f 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -71,7 +71,7 @@
>  { TARGET_NR_chmod, "chmod" , NULL, print_chmod, NULL },
>  #endif
>  #ifdef TARGET_NR_chown
> -{ TARGET_NR_chown, "chown" , NULL, NULL, NULL },
> +{ TARGET_NR_chown, "chown" , NULL, print_chown, NULL },
>  #endif
>  #ifdef TARGET_NR_chown32
>  { TARGET_NR_chown32, "chown32" , NULL, NULL, NULL },
> @@ -474,7 +474,7 @@
>  { TARGET_NR_kill, "kill", NULL, print_kill, NULL },
>  #endif
>  #ifdef TARGET_NR_lchown
> -{ TARGET_NR_lchown, "lchown" , NULL, NULL, NULL },
> +{ TARGET_NR_lchown, "lchown" , NULL, print_lchown, NULL },
>  #endif
>  #ifdef TARGET_NR_lchown32
>  { TARGET_NR_lchown32, "lchown32" , NULL, NULL, NULL },
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

