Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563A7C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9D320645
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9D320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54344 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIw3X-0007f2-Rk
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:05:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIw1u-0006kK-2v
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIw1L-0007Bi-Sj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:03:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIw1L-0007Av-N1
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:03:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id c6so14693146wrm.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 07:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=5+D//lL1wednLcZdk15D/+RoGgg9k8OsIv/QDYJpiRc=;
	b=mDuESC+Z7Q2rEBcGIoysA6LPzuFIk6lTmF9TdXvDMgGPbbo/9H0USyxeJNWGxF7pKc
	6aW1Cs/HQm02SCJRl0fQrVdGtKGRTCfGonNS+oPyC763mTs8vgucq/pag9Y+tBhRrPf1
	smyNfV4N5z0TFl5iUvnOvHg856vLhyZmLV70mw4t93eQHiLKWy120Oyy2AmvQA1iD+6d
	fN8TVz/kXPHSiBoGgb3KYkb9N7WFfx6gZhCF48kNzuUms2sWthG0jsIUTC1dXmuECaSs
	FhfYmbeAp86EBeSZTMhUEdcWq6iuhIao/vx1sOtQY7KJDsFNdxDgsrzXUShKUarfH9sL
	LbTA==
X-Gm-Message-State: APjAAAWKqB5PFkXe7dIOAFww9A4Y+xdvikr2vhZt7l99WbXAwUnH38Oo
	UoX2+Q4z/fkyXwy6iTjZjCz8Cg==
X-Google-Smtp-Source: APXvYqwv5tWjAfywdo+WdZREmf6/4VvNbJOzEXm1R01uiGb3bBV+QuJkED9P+NKTP7wsRXzmhF0+Kw==
X-Received: by 2002:adf:e591:: with SMTP id l17mr16799234wrm.238.1556028218524;
	Tue, 23 Apr 2019 07:03:38 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	p10sm4460086wrm.38.2019.04.23.07.03.37
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 07:03:37 -0700 (PDT)
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
References: <1555669092-10351-1-git-send-email-frederic.konrad@adacore.com>
	<1555669092-10351-4-git-send-email-frederic.konrad@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9971c427-45e2-4f3b-b871-19539da11a41@redhat.com>
Date: Tue, 23 Apr 2019 16:03:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555669092-10351-4-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH V1 3/3] MAINTAINERS: add myself for leon3
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
	chouteau@adacore.com, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423140335.RWxBTs-LNlNVggOc4CI7RzHnPDmBMI0uNTVMlohx6bE@z>

On 4/19/19 12:18 PM, KONRAD Frederic wrote:
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 56139ac..3543035 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1151,6 +1151,7 @@ F: include/hw/timer/sun4v-rtc.h
>  
>  Leon3
>  M: Fabien Chouteau <chouteau@adacore.com>
> +M: KONRAD Frederic <frederic.konrad@adacore.com>
>  S: Maintained
>  F: hw/sparc/leon3.c
>  F: hw/*/grlib*
> 

Thank you for stepping in!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

