Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8999EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5083B22C9F
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5083B22C9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40Js-0001yu-JK
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k40JI-0001ZQ-Vn
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:13:16 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k40JG-0006wc-RR
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:13:16 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MORVA-1kNJ3B079K-00Prps; Fri, 07 Aug 2020 13:13:11 +0200
Subject: Re: [PATCH v2 2/2] linux-user: Add support for a group of 2038 safe
 syscalls
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200722153421.295411-1-Filip.Bozuta@syrmia.com>
 <20200722153421.295411-3-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <920f9ff0-157b-af0c-8001-bc9357474318@vivier.eu>
Date: Fri, 7 Aug 2020 13:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722153421.295411-3-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iez3NOZ/vrzVAf9GDiJnIrOExNhfqr3kXbfT713QYF5qA2LxTfy
 /D8tDbm3CnklW8jvBG2pzppfapdU56BsGws93KQvW1+wIVnUjxNV7Hn3dvqA9P3TFDZHp5k
 lKLHJ7I1nVGZ5AF5PPgDMveNBxvtokZaSS2xteHgomqcwPtyb0F9PfkXmLqHIFr2EuWTLvO
 NaHMJkMWva61m51pvUUnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/JZSyLpMsJA=:1jzcyIvvBi0j/3srJ0bv+m
 z0EXrB0bsay5qZRN1sb32yyxu2sEqs8UCb5/2cKJcxLVoQzNLz3WOq4f8gdTQCi4eJ+fsXYV6
 FoRCB+FP/GWDqj8Bxj1WZ9wNTOpendto/2mBNxdkfVXq1R8/1havS+d+OGAUQcEpts9ZoWXtx
 WmDA9glq9QtL358H5nsdh142B9E6Nk0eobtN7ChA/QAIRrruOKjxOh/CoA0r7Nfl8V2zcR5Bq
 GwMd1GEGI+ZfWUa7VOvIpVMfITcpgXKIEV8ytyK+kQsKqzkVuR03VcYUJgy+7aaycCPxZjrr0
 7F/2eNbipXv27K2xWcLD5kuMOBnjksYm9ssQkK5tlPeFwADdfLrIgIVjL8IlL1nvRVbmDfboL
 /3KteomBtP+89jUbGptUoRXVNOCW927EFE/Lduprbz/WtubzX5WWCFkobV2HEBKOgFkc7AsTE
 wtvkAFnuF0Rt4a2L257QHWia5N6Vj11arTEUzbixTBg6pR/mTI3H7hT3uNwP/trLGln38MOTH
 k4DMVtNwsgFcbEHDNfuOF8KDEEAGCUoaa7qZF7O+8K2YxUyCtKnaonG79Bmlo9Lggs45q5nLt
 erzs0PP9Sl9j1DbDv1l/91nFWv9uZKVu1oLmWDAVg/aG2tQ2osFxmoiRtA/JKwhM8Ci/F3Rk+
 wE+4LT2R3JmZQ8wQBCjgKBG/iEH1+GdA7ttQK3uHAJLhF2jyY3Dk1X3c4lBmZjl3rJYabGeqk
 3Yw4Nt4COTfU1CegoGVAL+0yn9qUf3QDPTwex2MVfYnhGcNi9d8cO6THBBNvRraFPX+76YuYA
 y+0bshjCTu2KFJHXWBa1I380d8Yc0beG9TZy5CDeZYsde7HB9EljWYdI1rCttXXlk6YzUk5
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 05:56:31
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

Le 22/07/2020 à 17:34, Filip Bozuta a écrit :
> This patch implements functionality for following time64 syscalls:
> 
> *clock_getres_time64
> 
>      This a year 2038 safe variant of syscall:
> 
>      int clock_getres(clockid_t clockid, struct timespec *res)
>      --finding the resoultion of a specified clock--
>      man page: https://man7.org/linux/man-pages/man2/clock_getres.2.html
> 
> *timer_gettime64
> *timer_settime64
> 
>      These are year 2038 safe variants of syscalls:
> 
>      int timer_settime(timer_t timerid, int flags,
>                        const struct itimerspec *new_value,
>                        struct itimerspec *old_value)
>      int timer_gettime(timer_t timerid, struct itimerspec *curr_value)
>      --arming/dissarming and fetching state of POSIX per-process timer--
>      man page: https://man7.org/linux/man-pages/man2/timer_settime.2.html
> 
> *timerfd_gettime64
> *timerfd_settime64
> 
>      These are year 2038 safe variants of syscalls:
> 
>      int timerfd_settime(int fd, int flags,
>                          const struct itimerspec *new_value,
>                          struct itimerspec *old_value)
>      int timerfd_gettime(int fd, struct itimerspec *curr_value)
>      --timers that notify via file descriptor--
>      man page: https://man7.org/linux/man-pages/man2/timerfd_settime.2.html
> 
> Implementation notes:
> 
>      Syscall 'clock_getres_time64' was implemented similarly to 'clock_getres()'.
>      The only difference was that for the conversion of 'struct timespec' from
>      host to target, function 'host_to_target_timespec64()' was used instead of
>      'host_to_target_timespec()'.
> 
>      For other syscalls, new functions 'host_to_target_itimerspec64()' and
>      'target_to_host_itimerspec64()' were added to convert the value of the
>      'struct itimerspec' from host to target and vice versa. A new type
>      'struct target__kernel_itimerspec' was added in 'syscall_defs.h'. This
>      type was defined with fields which are of the already defined type
>      'struct target_timespec'. This new 'struct target__kernel_itimerspec'
>      type is used in these new converting functions. These new functions were
>      defined similarly to 'host_to_target_itimerspec()' and 'target_to_host_itimerspec()'
>      the only difference being that 'target_to_host_timespec64()' and
>      'host_to_target_timespec64()' were used.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/syscall.c      | 139 +++++++++++++++++++++++++++++++++++++-
>  linux-user/syscall_defs.h |   5 ++
>  2 files changed, 143 insertions(+), 1 deletion(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


