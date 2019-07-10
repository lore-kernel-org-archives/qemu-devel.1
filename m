Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE04DC73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A364420838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A364420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9ZP-0004Kn-Ur
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 06:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36151)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hl9YZ-0003vw-6b
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hl9YX-00062g-GD
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:10:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hl9YW-0005zm-Vp
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:10:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so1807273wrr.4
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 03:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FOtvsW16M/zrFVoWKELCEH/MWGxeLdOzaHbNycJ+ktQ=;
 b=VGtMR0IbF8cHFyhBHZjlay/SLFT9rCU8KtSGpdeWdhnswi8GdTZ6zqrPJq8H0nQgHd
 1Ck2VBmEt/2nISbjuj7hADglwi5W3QSY++MzBXOYdAKh7ntxliV4xP2kGyd4QMP82vB8
 3MXMIdoiOkree6++FuztRQTwfckLENHonrtcTt++7U2URERheVWRS1c+Csm12TAYT3G8
 wPMUYnnCpR5N7wMAAKEmHAmP0CXXRdB74UV2YfePPgwrgla4mu2EISrblI0ghGzqNOvf
 HvnmSxjYpgQ/VeEMNbc9OeXGJW5eUt95JHfGi33XKT6Tal42Gc64kNYikp0bdwNNkFI+
 YFew==
X-Gm-Message-State: APjAAAVeB3ERc+PUTF1WyG46Y15QxEmYUX3WhV6DdqGNaWDRRhWk3J3m
 aJFNW3vKEHbBeYzsKLrrCdlm1w==
X-Google-Smtp-Source: APXvYqzaUPPtj48lLWWka3r7i9XFTG0aDknOOfClVJT+d+uYhAoEAY2PnI/IH1IzF710yVVD3ByaqA==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr29990178wrq.333.1562753432053; 
 Wed, 10 Jul 2019 03:10:32 -0700 (PDT)
Received: from [10.32.224.100] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
 [159.63.51.90])
 by smtp.gmail.com with ESMTPSA id b5sm1175629wru.69.2019.07.10.03.10.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 03:10:31 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20190709213651.77315-1-mrolnik@gmail.com>
 <20190709213651.77315-7-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bf1181ea-0ad3-c6fa-c580-1175daa373ce@redhat.com>
Date: Wed, 10 Jul 2019 12:10:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709213651.77315-7-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v25 6/7] target/avr: Add example board
 configuration
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
Cc: imammedo@redhat.com, Sarah Harris <S.E.Harris@kent.ac.uk>,
 richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/19 11:36 PM, Michael Rolnik wrote:
> From: Sarah Harris <S.E.Harris@kent.ac.uk>
> 
> A simple board setup that configures an AVR CPU to run a given firmware image.
> This is all that's useful to implement without peripheral emulation as AVR CPUs include a lot of on-board peripherals.

Why not model a tiny existing board?

You can mark various pieces of hardware as 'unimplemented'.

> 
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  hw/Kconfig           |   1 +
>  hw/avr/Kconfig       |   4 +
>  hw/avr/Makefile.objs |   1 +
>  hw/avr/sample.c      | 217 +++++++++++++++++++++++++++++++++++++++++++
[...]

