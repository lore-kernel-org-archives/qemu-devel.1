Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBFEC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148A620833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148A620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctSb-0006qB-99
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49987)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcstF-0006zT-J3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcstE-0007zE-D3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:45:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42551)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hcstA-0007wE-Ij
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:45:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so10258531wrl.9
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h1yf6Vt1CyQuz/mXleAz0fDL+KIk9GhCVzaElcULaF4=;
 b=LlebQDMr+hjcwMq/iI7wz2Ib9HgtWYrZwTJ8uz+5lvWuE4EOFXXtNKkII2eToWdPeF
 NUYCXGi0qsGleq+wshOaX3GbY6UeaRGLYzq5SQcvtrSC+Cj8cjR8OE6n0oEyGKWm1O6M
 1Brc8QcxOhQ+98DrfrVTwWGGrR9qeAAc1pOzmPZwdDcDI5ZxNpzNBNfGhgyZON3sGfTZ
 q8IQvfx49tAHPLQSlqiOwLesol0KRLIOhk8IoFu4ONdhpj3V3fYLZVPyQinMoTF2laUk
 9s69WLsQ42ETwB1cVzoiy1/2yhWw9Ns4CWFbV+/CSXTw1mqzJGae7BMixNjHq1QmS4hs
 9+TQ==
X-Gm-Message-State: APjAAAVFJA/4Eqv3fs7ZaQhYlna6ikQksxFVOKnkViZSL2mkFAvo0hzD
 tOW+YZNacwXEdcOSosvYUHkYDw==
X-Google-Smtp-Source: APXvYqxSEMbpE5GZa+k4KKbZU0/h2LYrjpSFBQwii3aVZgi9pvlBNOr9Y1axBIdn0ljpMIS0KsalUg==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr53694424wrl.134.1560782738885; 
 Mon, 17 Jun 2019 07:45:38 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id a7sm10253325wrs.94.2019.06.17.07.45.38
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:45:38 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-19-philmd@redhat.com>
 <87h88o9svq.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <78478ee8-6707-a94d-5752-bc095378f502@redhat.com>
Date: Mon, 17 Jun 2019 16:45:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87h88o9svq.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 18/23] target/arm: Move CPU
 state dumping routines to helper.c
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Robert Bradford <robert.bradford@intel.com>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/19 4:41 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> From: Samuel Ortiz <sameo@linux.intel.com>
>>
>> They're not TCG specific and should be living the generic helper file
>> instead.
>>
>> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
>> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
>> [PMD: Rebased]
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  target/arm/helper.c        | 214
>> +++++++++++++++++++++++++++++++++++++
> 
> Hmm so helper is a mix of non-TCG and TCG bits whereas helper-a64.c is
> basically just TCG helpers. It makes me wonder if we are breaking a
> convention here as helper.c is traditionally only TCG helpers.
> 
> It feels like there should be different file that is unambiguously used
> for both TCG and KVM based workloads where things like the cpu dump code
> can live.

Good idea. What about target/arm/arch_dump.c?

>>  target/arm/internals.h     |   8 ++
>>  target/arm/translate-a64.c | 127 ----------------------
>>  target/arm/translate.c     |  87 ---------------
>>  target/arm/translate.h     |   5 -
>>  5 files changed, 222 insertions(+), 219 deletions(-)

