Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC56C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928C42070D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928C42070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs6LG-00081D-Q6
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 10:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51599)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hs6KR-0007Ie-7q
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hs6KQ-0000EE-6v
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:08:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hs6KQ-0000Dz-19
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:08:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so49503812wme.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 07:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h6cijlYmM7NgpZZ1MvRHVkMFlJOlQTvz336JAxXv2gs=;
 b=oY0SNsO5zWFtsSu0EjI6PM+RBmrJVd8iJfS4s9/Zy3siLZClHnYpD/tb3c+38jV3ln
 1ePv/G3m4L+LxM7Cnzl57jBibTbZJJbyZzsC1p6T6mvGMgtka+BROYwHNxlPcidfzVPD
 hLit7pRUhYsxL8mrvOPqlMNE6HMo47WsKfe/s12PqUaUw7LaC9V/aLe9KPCQrVKoeQwe
 wRNGfkNTbBJzaIQKnfSap+DsgMH1rZ1c3//y5uknZKsnpdxZHYgG2J2bxUc252yu8ZNn
 2J+VjtuuYVDBYfHvPplH42gDsLUcr5vai6bF2+H3S91TG8Rka4Qn2Lvd8k4iLB5KKc6A
 d2bg==
X-Gm-Message-State: APjAAAXbmXgsUGWilgBQg2V59e+8NXvbfPaRN7J/JL8ujeQJhaxljaVb
 Pwz9XlCVeKlqhqS7RLGg+Ha7/Q==
X-Google-Smtp-Source: APXvYqykt59aBAvvSNAMGbytnkePOkOOS9g8OcjwVnK+Qpd6KjKvWSdxg7uXDAisy14NfgvM9BV44A==
X-Received: by 2002:a7b:cb51:: with SMTP id v17mr98180963wmj.20.1564409320793; 
 Mon, 29 Jul 2019 07:08:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04?
 ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id h133sm66105648wme.28.2019.07.29.07.08.39
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 07:08:39 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
 <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
 <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
 <20190729082115.GB32718@redhat.com> <87lfwhhv1p.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2848afbd-2906-94ab-6057-8a3db20f99f2@redhat.com>
Date: Mon, 29 Jul 2019 16:08:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87lfwhhv1p.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/19 14:41, Alex Bennée wrote:
>> I'd suggest we don't actually /need/ per-file compiler flags in most
>> cases. eg when we add  $foo.o-libs += $(FOO_LIBS) that's not really
>> a per-file setting when it gets expanded onto the final linker line.
>> Its just a "-lfoo" that gets used for the library as a while.
> We do for tests, often to select a specific processor type or feature we
> need to build that particular instance of the test.

Tests are also adding cflags per-executable, not per-.o file:

tests/tcg/aarch64/Makefile.softmmu-target:memory: CFLAGS+=-DCHECK_UNALIGNED=1
tests/tcg/alpha/Makefile.softmmu-target:memory: CFLAGS+=-DCHECK_UNALIGNED=0
tests/tcg/alpha/Makefile.target:test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
tests/tcg/arm/Makefile.softmmu-target:test-armv6m-undef: EXTRA_CFLAGS+=-mcpu=cortex-m0
tests/tcg/arm/Makefile.target:hello-arm: CFLAGS+=-marm -ffreestanding
tests/tcg/arm/Makefile.target:test-arm-iwmmxt: CFLAGS+=-marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16
tests/tcg/arm/Makefile.target:# fcvt: CFLAGS+=-march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
tests/tcg/i386/Makefile.softmmu-target:memory: CFLAGS+=-DCHECK_UNALIGNED=1
tests/tcg/i386/Makefile.target:hello-i386: CFLAGS+=-ffreestanding
tests/tcg/mips/Makefile.target:hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -mabi=32

(They also do not use unnesting).

Paolo

