Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67817C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38AE12075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AE12075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47519 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7DR-00054Q-FW
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:37:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM6ti-0003aC-SX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM6th-0008Nq-6X
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:54 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hM6te-0007ht-Ug
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:52 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1My3Ef-1gYHv312SN-00zV9E; Thu, 02 May 2019 10:16:26 +0200
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
References: <20190501144646.4851-1-berrange@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2875a50f-6720-1346-6c14-83c5165cf6a8@vivier.eu>
Date: Thu, 2 May 2019 10:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190501144646.4851-1-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+h/gX9bVIV/uUk64woZ6yYpkN0NFFO8pnvofMJ/7MbLTaXbEeiV
	kmT6fWoY1gphYySQmoK8V8IH1rgLuaHy6vdd1cFvkY1Vx9dPLmAnGhWP3XaNrNzI8Rj7OMh
	sWOZxQvJB7gZTu1lO9jGjAPtPTWkNF4chUiBqW5MD5f+2v6/4tqKS3QAy7wpJ7Nqx3J0D29
	2s0oB1kTK+DtMROfM4LWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X/NvaeN4gyM=:EZz4pCrA5OENsJTmRK/pcD
	PtWB4c6ptHVnuShZ8t3+PwnfgXFg5NWVD8tbSPNm3sciyhrbAeJcDo7P+GF1ZGN/hpIfE+LwZ
	kQGjQg5C7wT8YrgIurpDarorJgduhC5JVhKONGpMcEFp5kIQpnGKL3AANL30FyYWxL91wcRNt
	4GPHFATGyNQaaqs6UIS2/2GRqPmb9f1jw1ddaTnj0VVaYyj6qVcZVLsjDbSYz/4GcT4JHv9N0
	ydWY8YTT/qM9jkvBE6QHDH6MK31GXKPfguAh0zwTCnWOnlTeriBSSzfUQnYUUWImfL4FUa1eO
	QVJjCk6LNoi4/GbPAiDafky7tP8Vr8JOEYENpTq5cNqgvYMiDt5l0Ul39EfQmVGp84pL+yTsf
	2OABECAMjjw1jV9o9sMIJQ2i71f9CWNwSJ2kwDESkU6yHmmfOJGNTfgQsPBmr5hiQr5r2awJS
	iGGTC/BRR+Z6DleDGAqj0b/ZFM+1YwU3GhOGbdZ9f3rZZ8qn7BSCGKQkaByQZMAJakSXhrrpM
	psDLv21YlLeaa/nrNa30uBkH3zGO9i4F2uby1Y/MYcOR0mVMKxrGzfKLBQYtfG/sDLCgyYJPq
	BSi0uaiaI+hr6K168btPt50rtPhu8/8R9jzFPTDjKtPewfRlVsE0dvBmT7en0ocETXU5aFDS8
	sFDqt2EHf9isE3LNB+CWox8PHANOZAlFFmt4ws8/qPW0UzglweHAlvdFalIfQoqE/7kljc/9w
	6R2st5+6V4rlVYDt4XkVUdFaJwlqPJG24/oVmleENKDpZYGG0K5ULg3kUl4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: avoid string truncation
 warnings in uname field copying
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502081624.9xnB07_JGCfFj2-qgcI8E-CPIf6eoqZUYIKQ_q_vT1I@z>

On 01/05/2019 16:46, Daniel P. Berrangé wrote:
> In file included from /usr/include/string.h:494,
>                  from include/qemu/osdep.h:101,
>                  from linux-user/uname.c:20:
> In function ‘strncpy’,
>     inlined from ‘sys_uname’ at linux-user/uname.c:94:3:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ output may be truncated copying 64 bytes from a string of length 64 [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> We don't care where the NUL terminator in the original uname
> field was. It suffices to copy the entire original field and
> simply force a NUL terminator at the end of the new field.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> Changed in v2:
> 
>  - Always use sizeof() in preference to __NEW_UTS_LEN
> 
>  linux-user/uname.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/uname.c b/linux-user/uname.c
> index 313b79dbad..1c05f95387 100644
> --- a/linux-user/uname.c
> +++ b/linux-user/uname.c
> @@ -72,9 +72,8 @@ const char *cpu_to_uname_machine(void *cpu_env)
>  
>  #define COPY_UTSNAME_FIELD(dest, src) \
>    do { \
> -      /* __NEW_UTS_LEN doesn't include terminating null */ \
> -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
> -      (dest)[__NEW_UTS_LEN] = '\0'; \
> +      memcpy((dest), (src), MIN(sizeof(src), sizeof(dest))); \
> +      (dest)[sizeof(dest) - 1] = '\0'; \
>    } while (0)
>  
>  int sys_uname(struct new_utsname *buf)
> 

Applied to my linux-user branch.

Thanks,
Laurent

