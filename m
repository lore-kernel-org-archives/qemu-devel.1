Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998ADC11D30
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D34620880
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D34620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6IFq-0007Na-Jt
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 13:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j6IFA-0006cA-5K
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j6IF8-0006hr-5g
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:14:12 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j6IF7-0006c8-TK
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:14:10 -0500
Received: from [192.168.100.43] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.168]) with ESMTPSA (Nemesis) id
 1MMH2M-1ioDOP4BoU-00JNP3; Mon, 24 Feb 2020 19:14:04 +0100
Subject: Re: [PATCH] tracing: only allow -trace to override -D if set
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200211111054.27538-1-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d015f386-b7cc-361b-1708-0a08e1a1fa0f@vivier.eu>
Date: Mon, 24 Feb 2020 19:14:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200211111054.27538-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lQi2pKQF5RnbaPk+fxVKMq4WHjK/juGxcOsL6RrMvniAyvKVkb8
 Aq8NhcU+9jm+gCWhwea/+U5EJ4doYKmvDVrcqX31n52cOb/l8n9cV9To2YrgFdqH/hEwyY7
 TISQ6j0hcv1wCboQdd6CnyZ/9KMKhp/K1Lfw7WfMcD8l4bW6CBVwOtlW4tI+APvvUgvAvbl
 BDaCHdOEzQFGDwrXsfs2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nc+295jJi/Y=:QGW7TFN7vjWW8lHd53cyOV
 9KfL+NZJkaspFf7JEfYKFhFQQoVmOEEFpk01Dav5EVgj5rwqMJOwDpq3PwOmfGXza6+wuoqLu
 kW85SAWwSdrUJyHldPADotTRGlKxohM1T/4Y6AsuYJHcBlMCZ3ZC4Tr2+miay1HYU0CLHGtQL
 mYkrQ0T9y05PJNi7rEFvMESKOa7ZYse7bpq5/amCgAQ6H4gI8wTQ/DnDmqZVTwA0ASfp50NHW
 33AKgm2MxQK7swTtoROuCfxKpxYI2lfkltRjhn9PWxZGmwa/qo6UTUdnTijvJnQh2tNx0n4PP
 qy+rqKvKHZ9bax5ltutUd0X3DJ4Rrc5ehKnV7RBthUd2B95Vj+F3tQsHiMvd3Wop5u/0KKFot
 e0DRHI/xFuCoHm4Se8OsQ78BEYe21veepHEq9Cea1TOrEU9bWE7p0PrJ3zN66lTD+OFolXtiU
 DA08QfF5MOHS0EhX/5iND+mIS+qpU14PuxQliS7rTl3L4ymLz2V0YtUnBMk/jPbaSG7wPdW87
 Z9ABkVd5tsPY0+5igFlhOJXUBvSgi1r7wui1zJiUwByJCoQnMqD4gnZsaor6y7eDIo9E3T8hQ
 Y8DtTMTikc2n/3T0NCD04fgXjR00GqLbQWl0v59I9Tq4YezacbD/nc2zHxxmxCc6noTewA2rE
 GwEPevNOXWe03ruovasaar6sxkxwIVjdnI4byp0jyXKySpvp36jB41flYb4hPPGrxXHQfCOK/
 Xiv9UZ4j5gJr4TE5EN1dWG+qyoSgoaXotcUyF4eohBSKGBS2xEjr42/kMtWIgjqxlo0++ioWG
 J7xZlmTQ3TarF/SQSZ/LZjNoIxkYauLuBWCBdSdj9uepsCLWzl7xwfAcRcLbPsU5diTJBlZ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/02/2020 12:10, Alex Bennée wrote:
> Otherwise any -D settings the user may have made get ignored.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  trace/control.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/trace/control.c b/trace/control.c
> index 6c775e68eba..2ffe0008184 100644
> --- a/trace/control.c
> +++ b/trace/control.c
> @@ -226,10 +226,15 @@ void trace_init_file(const char *file)
>  #ifdef CONFIG_TRACE_SIMPLE
>      st_set_trace_file(file);
>  #elif defined CONFIG_TRACE_LOG
> -    /* If both the simple and the log backends are enabled, "--trace file"
> -     * only applies to the simple backend; use "-D" for the log backend.
> +    /*
> +     * If both the simple and the log backends are enabled, "--trace file"
> +     * only applies to the simple backend; use "-D" for the log
> +     * backend. However we should only override -D if we actually have
> +     * something to override it with.
>       */
> -    qemu_set_log_filename(file, &error_fatal);
> +    if (file) {
> +        qemu_set_log_filename(file, &error_fatal);
> +    }
>  #else
>      if (file) {
>          fprintf(stderr, "error: --trace file=...: "
> 

Tested-by: Laurent Vivier <laurent@vivier.eu>

