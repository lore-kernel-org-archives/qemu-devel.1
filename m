Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96B8C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 12:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED3C214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 12:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED3C214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhCWq-0000W5-Bl
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 08:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36748)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhCRn-0006Jh-N9
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 08:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhCRm-00021w-I9
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 08:27:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38896)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhCRm-00021E-6G
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 08:27:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so8946994wrs.5
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 05:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VetzouY/53qzewTyzYuxYMEXWIlkpEazSo9uLH9EoSI=;
 b=r8lC49Vd4Wg8RCBrjq+ESbBB4Fs6fyAWOg27empY4kBrBmb7o8FKsOwxZ3y+DcGksk
 xeIhgb9SwIlNQPDkavwm4ZAlhTCOA9UKELdLRXScFbFqgHtQVt8DlG/aQ3lisENGHrdW
 MsR4a8NjOdWw0lt7J2MPGDp374BO9fZco7XTdJpAvF0SI6FhGpI+Tr+GCp/pyG/giYTP
 Dy9J+XwU+yqi2RJkSuyNwnmktMVgvIsRyVRibZndRh2vIixkd6F276hOq4YUAYkGygOF
 utRy13wccsAGOJI7TVfHvwoSQfy+IR+trNrN9jLs5no6teXxthlmOKCgCDFxZ9NNvJr6
 Igqg==
X-Gm-Message-State: APjAAAVwofkQgFkkAoD9Z0+2BWYL3MOUqgYIRTWAuFwM9h6sfVCuwPPC
 xTMXx2iRj+ehVzSMCFsBzseQ5w==
X-Google-Smtp-Source: APXvYqzxmdxJxz80GIdDMdUTKnfLvg3jSeLrXRC4MpHUkq1SDpjs329NOjznLEV4fNx72jj+G1/Zag==
X-Received: by 2002:adf:ea92:: with SMTP id s18mr11337600wrm.257.1561811233287; 
 Sat, 29 Jun 2019 05:27:13 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id h19sm4035924wrb.81.2019.06.29.05.27.12
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Jun 2019 05:27:12 -0700 (PDT)
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20190628181536.13729-1-huth@tuxfamily.org>
 <20190628181536.13729-5-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9317fd06-f129-b03b-e281-599792183fa8@redhat.com>
Date: Sat, 29 Jun 2019 14:27:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628181536.13729-5-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 4/4] m68k: Add an entry for the NeXTcube
 machine to the MAINTAINERS file
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/19 8:15 PM, Thomas Huth wrote:
> I don't have much clue about the NeXT hardware, but at least I know now
> the source files a little bit, so I volunteer to pick up patches and send
> PULL requests for them until someone else with more knowledge steps up
> to do this job instead.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cad58b9487..6b4fa7221f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -900,6 +900,13 @@ F: hw/char/mcf_uart.c
>  F: hw/net/mcf_fec.c
>  F: include/hw/m68k/mcf*.h
>  
> +NeXTcube
> +M: Thomas Huth <huth@tuxfamily.org>
> +S: Odd Fixes
> +F: hw/m68k/next-*.c
> +F: hw/display/next-fb.c
> +F: include/hw/m68k/next-cube.h
> +
>  MicroBlaze Machines
>  -------------------
>  petalogix_s3adsp1800
> 

