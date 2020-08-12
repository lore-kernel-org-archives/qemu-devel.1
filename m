Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41F0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F98E20855
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F98E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5sxP-0002aj-SE
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 11:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k5swq-0002AS-Dg
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:45:52 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:39571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k5swo-0005Cr-HG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:45:52 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M1YtP-1k8tso3AWx-003A0g; Wed, 12 Aug 2020 17:45:45 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200812140704.46242-1-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: Fix 'semop()' and 'semtimedop()'
 implementation
Message-ID: <d2c73d12-25a9-e882-3ae3-aba5376fab0f@vivier.eu>
Date: Wed, 12 Aug 2020 17:45:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812140704.46242-1-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uogVL0N2W6EpW5pniFr43MG11NGYC/0dJ5Sz+ctlR6qpQrmUwIT
 qjE27WwewEOAo16bC1lUFkX/lZt3ncMrtfwiMaHVNSxfWx1hwaMssGkhSXbsxDobfHDq0Rh
 GOb3HMSRUFH58iZCE5UkmXBQoi36I9MDmFuYU820az2h9etgtbmITxWiSBfoXRPyC8MUDhZ
 Q5Cvi0qvvdqYHTTKFH9XQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8M2w/qwnhC8=:541WVDwJBps8j5tfgNgUsN
 YGUXDBJ/83DTa76oLN/qTHyhajj89r95nrqx2hClH/KlyC7C90zD4+Tm0YcfLz8Y/N2pv9neS
 yW+4+ZMak7c2DSiEAfhWS/8ksQNaZECPxJuqM80llZjksFr7M+CnQoECkbu/rcoU1ulnumeGV
 veW1UN/3GFl8S+CRfXLncsSbZ+OlQnwSoeZHtX8c0+FU8oG8KMSGsM/tYVFpusbrFMrvVSgUl
 Bd5q5rdEs2uMZT4fWIGx13MCVvX4+hB9GeYVzdnGRtK9gy7ABnFhAWrcpdDe4hhKAp/BPCgHR
 9kCxpdVTdN2ikjvTjKDt4ONXC33a0dBDNUObJIp5hP8qcOz5wil6n3exE67eQxoSo34zyttro
 qDbb6jCJyYr60VfqDuNZIvO/LDX6P3BgsgQrBQvd78p6VQG/GJm3CPTgYcGhraFusGy2SU/wK
 guS3cV5fEDMBBZ1M0xe6JvuxvtFGgvGY97vAKkQLf45aChaNFJ0erk4g9RM5kMYDSVdxvQNTs
 prz4NJ5FMBE5XZq7lih6JY8DMc5pkE0LUZZcqPtjBaMqHlfA5+ww797+sq2evHxBQ16WF6J7z
 vz1jdlGgqlkkTOB9Rd36t4ZgTi+pOE1/JiJSmm1aOFLCZcDEFPL4lThPLrKPZhaskus9CSxSE
 HByq/OlOAK/d19oDHgQSDFWTLlBofIX8bzo7ozleyfuDLfvCuQdwf6zc1icqd3UHwfO74VLu8
 R+UX4cX1rTfHSREZ1q6u5H3KLJjWDJ+sJIwSvfSfX1ThbPAURtFEL/SOqND8lD6NSX+O2ng4L
 LE3EVWT/Q2SJhTD6mHgOVhXgqA20eNSce3xwhy0EQSi+3w6xHuTJUrtCsLhQ7+9SOAHcCH7
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 11:45:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 12/08/2020 à 16:07, Filip Bozuta a écrit :
> The implementations of syscalls 'semop()' and 'semtimedop()' in
> file 'syscall.c' use function 'target_to_host_sembuf()' to convert
> values of 'struct sembuf' from host to target. However, before this
> conversion it should be check whether the number of semaphore operations
> 'nsops' is not bigger than maximum allowed semaphor operations per
> syscall: 'SEMOPM'. In these cases, errno 'E2BIG' ("Arg list too long")
> should be set. But the implementation will set errno 'EFAULT' ("Bad address")
> in this case since the conversion from target to host fails.
> 
> This was confirmed with the LTP test for 'semop()' ('ipc/semop/semop02') in
> test case where 'nsops' is greater than SEMOPM with unaproppriate errno EFAULT:
> 
> semop02.c:130: FAIL: semop failed unexpectedly; expected: E2BIG: EFAULT (14)
> 
> This patch changes this by adding a check whether 'nsops' is bigger than
> 'SEMOPM' before the conversion function 'target_to_host_sembuf()' is called.
> After the changes from this patch, the test works fine along with the other
> LTP testcases for 'semop()'):
> 
> semop02.c:126: PASS: semop failed as expected: E2BIG (7)
> 
> Implementation notes:
> 
>     A target value ('TARGET_SEMOPM') was added for 'SEMOPM' as to be sure
>     in case the value is not available for some targets.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/syscall.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1211e759c2..4743a5bef2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3899,6 +3899,8 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
>    (__nsops), 0, (__sops), (__timeout)
>  #endif
>  
> +#define TARGET_SEMOPM 500
> +

I think you could use directly SEMOPM as it is the same everywhere.

>  static inline abi_long do_semtimedop(int semid,
>                                       abi_long ptr,
>                                       unsigned nsops,
> @@ -3915,8 +3917,13 @@ static inline abi_long do_semtimedop(int semid,
>          }
>      }
>  
> -    if (target_to_host_sembuf(sops, ptr, nsops))
> +    if (nsops > TARGET_SEMOPM) {

You might move the check before allocation of the memory for sops.

> +        return -TARGET_E2BIG;
> +    }
> +
> +    if (target_to_host_sembuf(sops, ptr, nsops)) {
>          return -TARGET_EFAULT;
> +    }
>  
>      ret = -TARGET_ENOSYS;
>  #ifdef __NR_semtimedop
> 

Thanks,
Laurent

