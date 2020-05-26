Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3AAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0C720787
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrbcyZLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0C720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUIX-0001bl-V1
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUHA-0008MQ-Js
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:45:28 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUH9-0000P3-WD
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:45:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id n5so2263203wmd.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 00:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pXXDynFGIl09r/hiWIK2esYQrjIPZTwOjj1QaED/tqk=;
 b=qrbcyZLB5prDsumDTD7JAAMwociXC6KlIp/MpHUK/ZOVJjKf5mkY7KyLNsg281na59
 Z9CWuwoqAj43XghkRJsiIEDnfix8TvNv5/e5yr3p7ocH0OrPvIU5tUbO+PJEOwDxUphh
 DnfVzinZAQvWIC565c12dgwCP+d4mRr0GuZQUmPMPe4GP8ILF9n7gVDUKu6h0EHnTOWJ
 rBTBRN/kebW8XA8+h6ixASGWQSOlFAouFVh2exFf0d7KRxtp7Gqn/P8lah1WynPFGgdt
 PHRZQ55q76nn/iIC50MLfW3GWNF1DquLmbvoHrsh+Qf+ekTT+41XrU9EUMAWPvlD8zh+
 DUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pXXDynFGIl09r/hiWIK2esYQrjIPZTwOjj1QaED/tqk=;
 b=kpC+drCpC8mYdtOSCP8uS1mvh7qdhU1+huJP17dPmbD0rJWz+ytDg2lnQCbVbOsJhL
 TCLl7ncSra4FuY1yoP/VgdhSco6swZ2nRkAs4kjBnk8KZL6eHu2UY/FPwTFK5b2KLJzs
 yR9sX7v4x6kMOgoo0pWAefW6LjLCql6aDQsN5Vy8s9Y7GJTDnTexzpcctPHb8Lp/rGFo
 7qAgWoDnuBrGLwTLcdAPhd9kfBeNFDomxsct7fguA5NLFUgjJ5YF8otlGcZJVFWSXGU6
 q3r38d4mdldT+yr/R50uMNpugWILAvQlhdRR6j9sWT1aaTK/3NCe/uel5pn5NvTBAIhx
 6a3g==
X-Gm-Message-State: AOAM533lN9jRhh/0F+CySojIlWqIFISpXHS9vEwRpCWyjbXO8sB7eHrJ
 /+UrnI114NgeT7cqz3uJTg0=
X-Google-Smtp-Source: ABdhPJybKJJSwRONLmx5cgxAUUYF18910ZCo05thWHXhXQYiKyqXMkHUYCKrgX1TsIwVyJpTP2jgcQ==
X-Received: by 2002:a05:600c:228d:: with SMTP id
 13mr139799wmf.182.1590479126337; 
 Tue, 26 May 2020 00:45:26 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n6sm20258957wrt.58.2020.05.26.00.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 00:45:25 -0700 (PDT)
Subject: Re: [PATCH] hw/mips/mips_fulong2e: Remove unused 'audio/audio.h'
 include
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200515084209.9419-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f007ddaa-d186-af34-b660-a687969a731b@amsat.org>
Date: Tue, 26 May 2020 09:45:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200515084209.9419-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 10:42 AM, Philippe Mathieu-Daudé wrote:
> The Fuloong machine never had to use "audio/audio.h", remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/mips/mips_fulong2e.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index ef02d54b33..05b9efa516 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -33,7 +33,6 @@
>  #include "hw/mips/mips.h"
>  #include "hw/mips/cpudevs.h"
>  #include "hw/pci/pci.h"
> -#include "audio/audio.h"
>  #include "qemu/log.h"
>  #include "hw/loader.h"
>  #include "hw/ide/pci.h"
> 

Thanks, queued to mips-next.

