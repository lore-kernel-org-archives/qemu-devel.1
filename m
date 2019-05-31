Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE89C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F16E26C9B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F16E26C9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkpL-0003U4-Id
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:56:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWkjq-0006js-Tp
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWkaB-0005be-EH
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:40:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWkaB-0005Dl-7t
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:40:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so6938357wrm.8
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 09:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=arjCHb58x12BUOgTbM8YeO65qdXrGPkTtcxs9sdPUP8=;
	b=hTUT6LyDRt/rYjwqBNaqcbPM/Lo3vBGHLnVZE82GWE51yuKO3WxGCaT6360p9xf1rJ
	laUpXpuyoyg1W+7A0XattFQj27AcopohSguDIlKxSA6hkTw2dtJ99+wuRZiagNos1ITZ
	MehiC6yrYvQa7KjKHDdPAzOMDOVV2re4kKsJ4uvTRQIyx2eH7RR8d0gvIcXlWlBzdyrL
	e0l1j4sNd3LwKf1E8FEJ4/SSlIaMcj9n3Sx5jVI863dKzcArQv5hy270miz7Gv2+OAUq
	4/ectaL2h8fyQVev8nHvuPDmcuWs6yvs3hIDUtaYSS0D06Uf0A9kj7FfEfB8xEEbXZVB
	uNOg==
X-Gm-Message-State: APjAAAX6ObtJ1Nmeb2Uh/Z4j1haKhiOMMVeXIsj5lLkeGRb32qF2qHvN
	3ZujQDKPmVscjc8fgSQjzOr5rw==
X-Google-Smtp-Source: APXvYqwi1HcbCpieRvy0CirRtDBOMrahE6N+jE6vyLbnWCHdM9n9yBoOSZEoUNXb5Y6Bw+7yl0gIFA==
X-Received: by 2002:adf:e841:: with SMTP id d1mr7340562wrn.204.1559320832943; 
	Fri, 31 May 2019 09:40:32 -0700 (PDT)
Received: from [192.168.1.43] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	u9sm13705282wme.48.2019.05.31.09.40.31
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 09:40:32 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190531154735.20809-1-philmd@redhat.com>
	<CAFEAcA9TJGq-8fMv2amQEEGz9QKCNWYwJxCXrjqSh=Yc87yTww@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <947e851b-4b95-3126-2eaf-d5d16f8b831b@redhat.com>
Date: Fri, 31 May 2019 18:40:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9TJGq-8fMv2amQEEGz9QKCNWYwJxCXrjqSh=Yc87yTww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] target: Build with
 CONFIG_SEMIHOSTING disabled
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Rob Bradford <robert.bradford@intel.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Miroslav Rezanina <mrezanin@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 6:21 PM, Peter Maydell wrote:
> On Fri, 31 May 2019 at 16:47, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Amusingly Miroslav and myself hit this issue at the same time.
>>
>> Currently there is no way to pass a CONFIG_X to sources in target/,
>> except via a Makefile rule (and filling with stubs).
>>
>> Paolo says this is on purpose, CONFIG_X selectors are meant for
>> devices and we try to avoid having config-devices.mak in
>> config-target.h.
> 
> ...but some things in target/ are devices (like the Arm CPUs,
> which inherit from TYPE_DEVICE).
> 
> Is there a way we can have a Kconfig fragment that expresses
> "if you asked for an Arm CPU then this should 'select SEMIHOSTING'" ?

Yes, but inversely, we can also deselect a feature, and all features
that requires it get deselected. My guess is Miroslav is building a
KVM-only QEMU, but upstream does not allow to build ARM without TCG.

I'll see what happened to Samuel series "Support disabling TCG on ARM"
and see if it can be salvaged:
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02451.html

I suppose in this thread:
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05641.html
you refer to this series (not yet merged):
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03137.html

I'll try to figure what "KVM injection of interrupts" is.

