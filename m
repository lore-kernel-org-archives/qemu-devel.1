Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4FB208B8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsADg5Tu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4FB208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYEM-0001tD-4K
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlYCZ-0000ID-HN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:34:03 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:46998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlYCX-0004nN-RP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:34:03 -0400
Received: by mail-ej1-x642.google.com with SMTP id p20so2295791ejd.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I0U16efjBbAxbQ2aiQDUetYcF7HJ1N9/QcgXXhdpPfs=;
 b=KsADg5Tur9IsIedETm9JuXnWtEARAQSuo/76LPuYL3/aFTHo0vDO8tk1esM25bGI6M
 QprZ5UqmVNR0SuHCUbN7U21r5d2ZDD2A6zTFvJw8HkK2oGZscS94jqkFg1wDcZbt9DUJ
 WXAsrMV3968H+C7JJRJaq+1PXcPgvmfanaxS4muYlVhqVBZv1P9lbvijk5GwlQfcNXY3
 M6RyLmZHFzvJ6PSFexQkOuPmf/qIfjyS/YTbAhR12ZXtWg0yX9F2aPNVMOxOEslEHFl+
 cW93xWBuutDGGK5IAS5eE/6yBoBneFnDK0TgitMvUcNAMYC0asHJPQgq/OMA9S07oNWD
 1+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I0U16efjBbAxbQ2aiQDUetYcF7HJ1N9/QcgXXhdpPfs=;
 b=KEnFv9ImFWHy1sw6Z2xaOhbqH/HxhaUzFjA1N8vUO+0WwTHnOV9z5VBT990is6VK1m
 5e0uSRNQUuj9x5PDZqeMAqdvz6kWU0RxXfpBW0AWaKXIdPOI+ndML5CaxfBslNr9rTrJ
 ibKUM7W8CYRzYSLK0Ci4BQW6wwQlheDgghQJPMZaVzljCM3QWc2etb0pmKZ9XLmu5iUF
 J0emV5OxJ52cPM2eUT7ikKmH5IY9qsvkPPi6OjWWeHThHXRVfecJnSfCvKRMnX+aACkf
 UNTD+1+nAg7V1VSHl242lYavlgFY06DAEdXC0/goSyTHErv8AsrTOJDeSWPUDr9GRXxe
 7x8A==
X-Gm-Message-State: AOAM532QAZV0yja/qHMB8HiBUUBond31t9xtfNUHSpq+88PPG+Yyh4mE
 UVq/TKFDLVGgd6XWQ54Mxfc=
X-Google-Smtp-Source: ABdhPJxcrvYmyNh0bSWFjxa9uCElNlZ9PB88oOmewoJIfppqTyv7DBzUvWGFTuiN+//Cr7c3B/cyGg==
X-Received: by 2002:a17:906:f2c2:: with SMTP id
 gz2mr7388053ejb.260.1592400840040; 
 Wed, 17 Jun 2020 06:34:00 -0700 (PDT)
Received: from [192.168.1.38] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id n6sm12170674edv.24.2020.06.17.06.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 06:33:59 -0700 (PDT)
Subject: Re: [PATCH 0/8] ESCC2
To: Jasper Lowell <jasper.lowell@bt.com>, qemu-devel@nongnu.org
References: <20200617082402.242631-1-jasper.lowell@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b7449721-3499-0018-4c36-339937f4ba2d@amsat.org>
Date: Wed, 17 Jun 2020 15:33:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200617082402.242631-1-jasper.lowell@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, SUBJ_ALL_CAPS=0.5 autolearn=_AUTOLEARN
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
Cc: tony.nguyen@bt.com, mark.cave-ayland@ilande.co.uk,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing chardev maintainers and Laurent.

On 6/17/20 10:23 AM, Jasper Lowell wrote:
> I've been working on improving Solaris 10 emulation for the SPARC64
> Sun4u architecture with the goal of a working shell. Currently, Solaris
> 10 boots with a number of errors before displaying the prompt of an
> otherwise unresponsive installer shell. It's been mentioned that this
> problem may not be isolated to Solaris 10 but may affect derivatives of
> OpenSolaris including illumos.
> 
> From what I can tell, Solaris 10 never attempts to use the 16550A UART
> for the serial console. The kernel will probe registers to identify the
> device but will not use it for receiving or transmitting. The kernel
> only prints to the console using the prom interface that OpenBIOS
> provides. It's difficult to ascertain what the problem is because there
> is no visibility into the kernel. The 16550A UART on the Ultra 5
> (Darwin), the machine that QEMU Sun4u is modelled against, is used for
> the keyboard/mouse (SuperIO) and is not traditionally used for the
> serial tty. Instead, the SAB 82532 ESCC2 is used to provide ttya and
> ttyb on this system. This patch exists to increment QEMU Sun4u towards
> being hardware faithful.
> 
> The SAB 82532 ESCC2 is complex because of the jungle of features that it
> provides. Linux and OpenBSD only use a small subset of features
> restricted to the ASYNC serial mode. The ASYNC serial mode is
> relatively simple to implement in isolation. I have made progress on a
> patch series that supports all serial modes, along with transitioning
> between them, but I have decided against submitting it. The serial
> controller appears to multiplex bit positions in registers across serial
> modes while preserving the bits themselves. This means that some 8-bit
> registers need to keep track of more than 8-bits of data and that the
> interpretation of the value the register holds depends on the selected
> serial mode. It's not ideal having a copy of each register for each
> serial mode because some bits are shared across some of the register
> modes. An added difficulty is that the manual doesn't document this
> behaviour well and its unclear what exactly happens when there is a
> transition in the selected serial mode. I've avoided depending on
> registers being uint8_t and have made use of macros so that the backend
> implementation of each register can be changed at a later date when
> supporting other serial modes. If I have the opportunity to test real
> hardware, or it becomes clear that HDLC/SDLC/BISYNC support is needed,
> I'll look at upstreaming the other changes that I have.
> 
> I have written a bare-bones patch for OpenBIOS that adds this device to
> the device tree. With that applied, Solaris identifies and attaches the
> device successfully but does not interact with it further - similar to
> the 16550A UART. I did notice, however, that Solaris 10 entered an
> interrupt routine for this device when the network card was being
> configured. I couldn't manage to provoke this behaviour for the 16550A
> so this might be some small success. I strongly suspect that the
> interrupt is a spurious interrupt caused by misconfiguration of the
> devices in the firmware but I have not investigated this further.
> 
> Solaris 10, judging from the OpenSolaris source code, determines
> stdin/stdout for the console by examining the stdin/stdout properties
> under /chosen in the device tree. Naturally, this is done with the prom
> interface. From what I can tell, to set these properties to the ESCC2
> node it's necessary to change stdin/stdout for OpenBIOS completely. This
> requires a device driver. I have made some progress on an OpenBIOS
> device driver for the ESCC2 but it's taking longer than expected to
> completely replace the 16550A and it's unlikely that I will have this
> finished soon. It's possible that Solaris 10 emulation for this platform
> will improve once that work is finished but it's unclear.
> 
> This is my first patch series for QEMU so it's possible that I've made
> mistakes in the contribution process - sorry in advance.
> 
> Jasper Lowell (8):
>   hw/char/escc2: Add device
>   hw/char/escc2: Handle interrupt generation
>   hw/char/escc2: Add character device backend
>   hw/char/escc2: Add clock generation
>   hw/char/escc2: Add Receiver Reset (RRES) command
>   hw/char/escc2: Add RFRD command
>   hw/char/escc2: Add Transmit Frame (XF) command
>   hw/char/escc2: Add XRES command
> 
>  hw/char/Kconfig         |    8 +
>  hw/char/Makefile.objs   |    1 +
>  hw/char/escc2.c         | 1135 +++++++++++++++++++++++++++++++++++++++
>  hw/char/trace-events    |    6 +
>  include/hw/char/escc2.h |   17 +
>  5 files changed, 1167 insertions(+)
>  create mode 100644 hw/char/escc2.c
>  create mode 100644 include/hw/char/escc2.h
> 


