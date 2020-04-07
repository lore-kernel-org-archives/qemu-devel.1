Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2EBC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527AB20644
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527AB20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLlby-0005mA-GR
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 06:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jLlbJ-0005Fz-Hq
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jLlbI-0001vA-Gc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:37:01 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48879)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jLlbI-0001tU-7y
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:37:00 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M6m1g-1jNOxq3Qic-008LTb; Tue, 07 Apr 2020 12:36:56 +0200
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
References: <mvmftdg8wxw.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: Use getcwd syscall directly
Message-ID: <216610b1-0d0f-a50b-8997-bb6aa6e20abf@vivier.eu>
Date: Tue, 7 Apr 2020 12:36:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <mvmftdg8wxw.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kXrXWLbm9cctGu1FDt1cBzgUsbCRyGZ8R9VNbnOyzLwUWIbQkUT
 Kzv/bxcRR9pK6yDWgvHLJ3YF4uL/baBd+kaxoYB/H/RD+UGys8TJrzS6UV+dGIQO0OataZy
 4yxr4pJocaJ4y7kuGQ49N4KAjGAca0FjCUAxASbZ+lWm0r4hyLy/oFYa1Io+bqU/6aXyMjx
 gYNHoveYbH/M8bYTewEQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6WdX4YhasYE=:RuSMkxD+abjbyjmvvftLBz
 /6DXI7WtMuSaZluber+L1mxv6WWRvRlJXBpPQrrR5ZVoGZaMb7ng9WJSeDgZeQ7pbdLPyrEDx
 6RXHZJ/wDxEGHVfkNbAWJBkOWYRC2kVJjPCLuNqN/sZd3p4vhfcPnilgc3w0mc5l2RHOc7PpZ
 ER2RsU7OQ8HBbXnki9a7X47F1POyiQqy/w67OKTSQwwCufes0dDq+nALdpjC0DVl49HIy4Lm2
 HfbojF4TYD7V4soPnXMDc8IaVs1vw+ewsIsZ5B+xzqyg5Cb+9W6j75tu2AiLR0Uzb1mmbX6Vn
 5x705IX0Hnrd1WzxR803VNOsONvWP9GiKXv8njJUSOr7oqf4AYXR6WHXeTkiaeoAOB6qgv2X4
 eeqw1oKObTn26c/aJMGt27oorPD2HhAsyZ3R6pLq0BYIQQRCNxpFytJukJ8LSzcE8wVdgQS9a
 OCEFBAcw7by0gWyBgep2llStfB7vkTJ8u/2gU7n8v7gTcA4Sqgq9N9VuXWteiZ9plgpeDl+E6
 PGDbNCutY3X4pjayhV2NcGMSQzBpgro+ZOjKkOjYxpyQyuPi71RrgQWlpIasGZEeE/bAvR2pV
 nTPazCDtKZs/Nw/fpw7mkUTEcMseKecr6nNQ38UrJywvJf0ZZgDpw9tAljzm4McG1Fcyk/fqc
 axEFDLg0WBqDgvLu2YkkFsd2DOqK+/Vhw/sOdPDfIVMlT7TxwekVISRJ3aljzF6D5yyE4jo+p
 eyhQo0Y5eUxrP/hIC8FN9fP9ypygZH29Nrzwhyfbq3+cZewciiebMJGn7/Igs2ZcwQCEEPaT3
 4PNU6k5e07Q/ifuf0jssyhd82g+btmaNCUb4JP7bo09u7xm1xxWwuQMENgFMlluLG4HIOjX
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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

Le 06/04/2020 à 17:18, Andreas Schwab a écrit :
> The glibc getcwd function returns different errors than the getcwd
> syscall, which triggers an assertion failure in the glibc getcwd function
> when running under the emulation.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  linux-user/syscall.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 83c2891169..90c5433fec 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -375,14 +375,7 @@ static bitmask_transtbl fcntl_flags_tbl[] = {
>    { 0, 0, 0, 0 }
>  };
>  
> -static int sys_getcwd1(char *buf, size_t size)
> -{
> -  if (getcwd(buf, size) == NULL) {
> -      /* getcwd() sets errno */
> -      return (-1);
> -  }
> -  return strlen(buf)+1;
> -}
> +_syscall2(int, sys_getcwd1, char *, buf, size_t, size)
>  
>  #ifdef TARGET_NR_utimensat
>  #if defined(__NR_utimensat)
> 

According to the commit introducing the function, it could break fakeroot:

commit 3b3f24add09f8ab720860d4840f9755c102121b5
Author: Aurelien Jarno <aurelien@aurel32.net>
Date:   Wed Apr 15 16:12:13 2009 +0000

    linux-user: prefer glibc over direct syscalls

    The openat/*at syscalls are incredibly common with modern coreutils,
    calling them directly via syscalls breaks for example fakeroot. Use
    glibc stubs whenever directly available and provide old syscall
    calling for people still using older libc.

    Patch originally from Mika Westerberg, Adapted to
    apply to current trunk and cleaned up by Riku Voipio.

    Signed-off-by: Riku Voipio <riku.voipio@iki.fi>
    Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Thanks,
Laurent

