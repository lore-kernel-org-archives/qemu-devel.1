Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818A8C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 11:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E601206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 11:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E601206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNyed-00065w-GM
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 07:53:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNydl-0005jW-Dq
	for qemu-devel@nongnu.org; Tue, 07 May 2019 07:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNydk-0007Gq-A7
	for qemu-devel@nongnu.org; Tue, 07 May 2019 07:52:09 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNydk-0007GK-3L
	for qemu-devel@nongnu.org; Tue, 07 May 2019 07:52:08 -0400
Received: by mail-wm1-f50.google.com with SMTP id n25so19580383wmk.4
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 04:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/EBS7iRBKJaqM8lv7Uj3G99Ur4RgVkx+e/YAofFvGDM=;
	b=TiqFNdsIIMhFVu4VTSCeIwdCcq7T07WTvxeCh+hOgdY3E8lZ8XDB3yB9ICCOeXnE81
	0dtoaax0kigwsvfjJAm8MAV8BKOV6VDbYr1ZkvYp2T8vHhaZRggGemAM9KkdrJcHpO8d
	CzyxLzUXl0yVtInOPjMfrqKfrRoPwLNO2PA1l5JPgHc499OTDUkj486KLM90iHBVjWt1
	jHO0rl0FHs8FavLK1FL0f0Q1KlGIAKkrMh5oZC9JdQJEgrWmwXJcVAsW4PWyNfO5ClR5
	OPwZJgaNmwip5CeMwkAepnISkDty1DehDWWvaLzIfljoV40M2+RN5ffLNn0ib4A066TS
	JMLA==
X-Gm-Message-State: APjAAAWoecO+4BkS1HUaa5eWvKhSSgpt6oBnFLyZu9gok3FNHLuiymVw
	AdYYUMLiG50hklIt5G52DAPEtg==
X-Google-Smtp-Source: APXvYqzTbQpycsDGdR+j9oZVN618QomcpLDIoQNf830tBDjwh+WizruH5+G/7pWU9ob3yQuDE6pPlA==
X-Received: by 2002:a1c:eb03:: with SMTP id j3mr21013661wmh.15.1557229926781; 
	Tue, 07 May 2019 04:52:06 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	w14sm11619393wmi.2.2019.05.07.04.52.05
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 04:52:06 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20190505135714.11277-1-thuth@redhat.com>
	<CAFEAcA_utmcMFAmaGL5CJm4erBg2dZWZpdGvETRqVukOxrdpPg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c304a9df-1b8e-8f15-1daf-6e916dca3743@redhat.com>
Date: Tue, 7 May 2019 13:52:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_utmcMFAmaGL5CJm4erBg2dZWZpdGvETRqVukOxrdpPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.50
Subject: Re: [Qemu-devel] [PULL 00/28] Kconfig for Arm machines
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/19 1:01 PM, Peter Maydell wrote:
> On Sun, 5 May 2019 at 14:57, Thomas Huth <thuth@redhat.com> wrote:
>>
>>  Hi Peter,
>>
>> the following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04f7:
>>
>>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-05-03 15:26:09 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-05
>>
>> for you to fetch changes up to 55e5578fabf744e62038f7357369a68e460fe205:
>>
>>   hw/arm: Remove hard-enablement of the remaining PCI devices (2019-05-03 17:06:20 +0200)
>>
>> ----------------------------------------------------------------
>> Kconfig settings for the Arm machines
>> ----------------------------------------------------------------
> 
> Hi Thomas. My test setup that does 'make clean' before the build
> failed in 'make check':
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i38
> 6 QTEST_QEMU_IMG=qemu-img tests/ahci-test -m=quick -k --tap <
> /dev/null | ./scripts/tap-driver.pl --test-name="a
> hci-test"
> qemu-system-i386: Unknown device 'ich9-ahci' for bus 'PCIE'
> Broken pipe
> /home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:143:
> kill_qemu() detected QEMU death from signal 6 (Abort
> ed) (core dumped)
> Aborted (core dumped)
> ERROR - too few tests run (expected 74, got 0)
> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:903:
> recipe for target 'check-qtest-i386' failed
> 
> (all the builds that are just incremental without the 'make clean'
> worked ok). Any idea what's happened here?

You found a bug in hw/i386/Kconfig :)

I noticed this while working on refactoring ICH9 for the Boston board,
but didn't expect the Q35 machine would suffer the same issue.

The quick fix is:

-- >8 --
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
@@ -80,7 +80,7 @@ config Q35
     select PC_ACPI
     select PCI_EXPRESS_Q35
     select LPC_ICH9
-    select AHCI
+    select AHCI_ICH9
     select DIMM
     select SMBIOS
     select VMPORT
---

I'll send a patch.

Regards,

Phil.

