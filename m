Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D099EC5B576
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 22:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89601208E4
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 22:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4fZp8mJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89601208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhiJ3-0002sH-Ho
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 18:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhiIL-0002TO-4h
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 18:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhiIJ-0008BL-U6
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 18:27:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhiIJ-0008B4-LH
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 18:27:35 -0400
Received: by mail-wm1-x343.google.com with SMTP id u8so13837207wmm.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 15:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uAPDzJsnJ6JOiqOXfEa1oKdcaVV0oKX8GEkic1o5NtU=;
 b=e4fZp8mJUp0zkq3FB7Hk8BqtZBmSM6gNd6DhwVc6WdDb9o31L03bnOj8iLi1GcaJTq
 DDRykcMzHvLhM8DKnfAmNXV5+v6rqDhhMaoEw4p0LRexTLmkz9oALo3s0J3czjCryg0o
 px/wTO3SdkMMYiVwgPt8qsm4BnrzYOd87ZCR5q8f5yP0tJ4Z7e6Yyu1eSErOojyrQJ2N
 8aAs4lByqK48V4KtXxBnOdw9Yj50HdF2+jui2taQg1gw/XTaDIwHOHZmXtGy7Nm09Rsr
 fobCXRBGrnH9eSDPNPU5QywI2TLbisPezHuBfpQ6l/1TiGi7fIqKrQeHPN1hjJO0URaV
 h8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=uAPDzJsnJ6JOiqOXfEa1oKdcaVV0oKX8GEkic1o5NtU=;
 b=CMzPf2oF5MJ0ZD92HAFt4SEXou45u4Yh/3yPRGMr6AR8sAV/VDqF8y6aS2+tI4loge
 dEk74oXXZfdFSwk9dNW3hvmTcQzki5XG7ygcKfjR5ZMZ0DR/E6sbvUJ7frEFEb6IJc/J
 WHP1wrM7za43USYBaTOxsTGAc45bbhOcVjmeQojjBrBGD9hNAgnolFqMVcEcZGIPEyXH
 ZdgwI3kEE86o+GMZPMorg0ECgRPubCw7XcdchUhDNZwEKElV+OQ51ryYYbykZzW2LH6/
 m6JkTLXla2gKz+ZxBErnxSvf4VYsnv8Bn55DvZSpJN3CWAlDRBMGyEtdud+hnjbM+NK+
 XKFA==
X-Gm-Message-State: APjAAAWh45EIZYLn7lSVxhKzyQCUpGZIvPIEvRuo9Ncj08y89IQZf80y
 PTknqGFti7pLLWKukJ6aFmE=
X-Google-Smtp-Source: APXvYqyuPz83nB1ZJvd6nNg/wiNCrA5BNlKZ0vHempZMN9mbIaEu34ne9qQo5Ky4abj/PV9Gl0Euyg==
X-Received: by 2002:a1c:2d8b:: with SMTP id t133mr14475216wmt.57.1561933653784; 
 Sun, 30 Jun 2019 15:27:33 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id o20sm23034234wrh.8.2019.06.30.15.27.31
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Jun 2019 15:27:33 -0700 (PDT)
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20190629150056.9071-1-f4bug@amsat.org>
 <20190629150056.9071-2-f4bug@amsat.org>
 <96d86410-45de-d0ae-d4b9-747ed6e05358@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <2840afe8-3df5-28ab-8977-9bafab77baaa@amsat.org>
Date: Mon, 1 Jul 2019 00:27:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <96d86410-45de-d0ae-d4b9-747ed6e05358@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 1/2] tests/acceptance: Add test of NeXTcube
 framebuffer using OCR
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/19 9:08 PM, Thomas Huth wrote:
> On 29/06/2019 17.00, Philippe Mathieu-Daudé wrote:
>> Add a test of the NeXTcube framebuffer using the Tesseract OCR
>> engine on a screenshot of the framebuffer device.
> 
> Wow, that's a funny idea, I like it!
> 
>> The test is very quick:
>>
>>   $ avocado --show=app,ocr run tests/acceptance/machine_m68k_nextcube.py
>>   JOB ID     : f7d3c27976047036dc568183baf64c04863d9985
>>   JOB LOG    : ~/avocado/job-results/job-2019-06-29T16.18-f7d3c27/job.log
>>   (1/1) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_bootrom_framebuffer: |ocr:
>>   ue r pun Honl'ﬂx ; 5‘ 55‘
>>   avg ncaaaaa 25 MHZ, memary jag m
>>   Backplane slat «a
>>   Ethernet address a a r a r3 2
>>   Memgry sackets aea canflqured far 16MB Darlly page made stMs but have 16MB page made stMs )nstalled
>>   Memgry sackets a and 1 canflqured far 16MB Darlly page made stMs but have 16MB page made stMs )nstalled>   [...]
>>   Yestlnq the rpu, 5::
>>   system test raneg Errar egge 51
>>   Egg: cammand
>>   Default pggc devlce nut fauna
>>   NEXY>I
> 
> Hmm, the quality of the text is rather bad...
> 
>> Documentation on how to install tesseract:
>>   https://github.com/tesseract-ocr/tesseract/wiki#installation
> 
> ... according to that documentation, you're also supposed to install a
> language pack ... have you tried whether it gets better with
> tesseract-ocr-eng ?

Oops, I should had RTFM...

$ docker run -it -v /tmp:/tmp ubuntu:18.10
root@ed15d4d1ff4b:/# apt update && apt install -y tesseract-ocr-eng
[...]
root@ed15d4d1ff4b:/# tesseract /tmp/screenshot.pbm stdout
Warning. Invalid resolution 0 dpi. Using 70 instead.
Estimating resolution as 109
CPU HCesasa 25 Wz, memory 168 nS
Backplane slot #0

Ethernet address: 0:0:f:0:13:2

Nemory sockets 8-3 configured for 16MB parity page mode SIMMs but have
16MB page mode SIMMs installed
Nemory sockets @ and 1 configured for 16MB parity page mode SINMs but
have 16MB page mode SIMMs installed
Nemory sockets 4-7 configured for 16MB parity page mode SIMMs but have
16MB page mode SIMMs installed
Nemory sockets 2 and 3 configured for 16MB parity page mode SIMMs but
have 16MB page mode SIMMs installed
Nemory sockets 8-11 configured for 16MB parity page mode SIMMs but have
16"B page mode SIMMs installed
Nemory sockets 4 and 5 configured for 16MB parity page mode SIMMs but
have 16MB page mode SIMs installed
Nemory sockets 42-18 configured for 16MB parity page mode SIMMs but have
16MB page mode SIMNs installed
Nemory sockets 6 and 7 configured for 16MB parity page mode SIMMs but
have 16MB page mode SIMMs installed
Nemory size 64nB

Testing the FPU, SCC

System test failed. Error code 51

Boot command
Default boat device not found
Next>

Way better!

