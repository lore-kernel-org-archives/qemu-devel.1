Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7692C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DBD217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DBD217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnJmx-0003aV-OI
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 05:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57273)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnJmj-00030v-JY
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnJmi-0007pP-6x
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:30:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnJmi-0007oZ-06
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:30:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so20130504wrr.5
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 02:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ijlboercCQvvQ5Ml3GWYUTK8hI+90I319LkMxxaJwXA=;
 b=GFk6K/F4xA0XSSPvUITmZY1kWSccIJmPjvX4G8a1/9h0ENX56eWRFTI2KB+9rKEvrm
 KyQ7Q7ftblVYFAUXSuLxMwP9IH/qiMD2N3RgSjQCEZ6QCfy+WmS+6sG87i3KqknRv+/n
 mASMwnXJKfbIGWPtW/NqUw1i+7iZDYiaycGyg7Q5iJvLfghNatYDQtkCpA2O4b2/veaz
 jgqRKX5lioAxjtu2MfUBgKa8QlflzPL6oo2QktpQiU9jiTHopv7U7N67e4jKKx8BsSj3
 I2W/+Ncj0GCBhoPqA4gaVR8URCRQh5i25xqtnPohyIjRPmgAA1ocWkjb0j7Efw2GZivp
 uIow==
X-Gm-Message-State: APjAAAVhcLY4+s7JR3DSpB/Yf21d8ytEaE/06cWq04OOHnZB16Vu3skQ
 xPUwugUX/JHwnFs6BWv2yuJx9A==
X-Google-Smtp-Source: APXvYqy/ws5kGdnydZRfgqcGyTUlmMX7l70ayF/DZkvsP7wh8Uo+bIOa11Enh/xKIgTZ3uXhWrQOUg==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr36109437wrp.188.1563269406680; 
 Tue, 16 Jul 2019 02:30:06 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id y18sm19538209wmi.23.2019.07.16.02.30.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 02:30:05 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190715152225.26135-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1cb9ca73-c988-8f7a-7b37-d28fbaf72c7c@redhat.com>
Date: Tue, 16 Jul 2019 11:30:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190715152225.26135-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.1? v2 0/5] semihosting: Build
 with CONFIG_SEMIHOSTING disabled
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, James Hogan <james.hogan@mips.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/19 5:22 PM, Philippe Mathieu-Daudé wrote:
> Amusingly Miroslav and myself hit this issue at the same time.
> 
> Note now that "config-devices.h" exists (commit 6c22ea9d83) I could use
> #include "config-devices.h" to implement Alex's suggestion to avoid a stub:
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg03607.html
> 
> Some know (arch-specific) limitations are:
> 
> - MIPS ITU is accessed by coprocessor instr (ISA feature)
> - MIPS timer is accessed by coprocessor instr (ISA feature)
> - MIPS semihosting (ISA feature?)
> - ARM semihosting (ISA feature?)
> - ARMv7 NVIC (device)
> 
> This series attempt to fix this the most trivial way, adding
> stubs for unreachable code.

Please disregard this series for 4.1 release.

As explained Peter on IRC, "feature changes need to be ready before
softfreeze".

