Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A95C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C694D208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C694D208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVI8Y-0004jz-1w
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 12:06:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVI7g-0004Pw-Q8
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVI7f-0007oj-TM
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:05:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVI7f-0007nC-N0
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:05:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id b18so17303186wrq.12
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 09:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=XJ3UGUdW1/zG6smsWMUd6Ta0pukHRlXN4ZIYUZpzSvQ=;
	b=lctiemp+eRvHv9IZfoEeSujbrFpNdtXOMnC1b5DXlpzKDhtfBT8MJ2TT6e/tySobQw
	o8xp4GugIJJEidfOcVsSJybKkd2hKsL7+ZQBhUxh3esHjbmDBf+wXb04bj0VC0ZXQNoI
	S5k+OC2TmLlsGMG4ggsAJW4tQDPhBY4dbmrsR1803LLTw3aWNvLUMFIpUySuCbvYtgFn
	Tv+poh6XXDLLfdkD+wLkcR3ppKpFComFrokgTrw022dsB/WDJPm+RnO3HwuAykL+wSn2
	+MCox+tpthrd/eF1b2diqUZIN31LJnb8qDqHvmTCpuJO9vQplYYqDtJvj+8PEsCpEibJ
	XXLw==
X-Gm-Message-State: APjAAAX/RwxSKsGeF5YKxq5JOQxtcgdT5zhC6BnLm9vzYRySGUXowwgJ
	MNhdmuVztVKSplcTGQWAOcbBWQ==
X-Google-Smtp-Source: APXvYqxaXP6wCHvVnWv+ucFItgzO50A3oP29mswJ2F1KrzAhveQAFrZ6A7MOQpSsGX/5lue0mvPlIw==
X-Received: by 2002:adf:c188:: with SMTP id x8mr11992474wre.256.1558973114724; 
	Mon, 27 May 2019 09:05:14 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	s127sm11365705wmf.48.2019.05.27.09.05.13
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 09:05:13 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
References: <20190316234456.18140-1-philmd@redhat.com>
	<97745dfa-ceaf-6572-59ba-a37e8f3c1e89@redhat.com>
	<097f4f90-b190-93d3-5c72-756fb29f7cc3@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8e8abf8a-ba65-c03f-54e3-865f2919c4bd@redhat.com>
Date: Mon, 27 May 2019 18:05:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <097f4f90-b190-93d3-5c72-756fb29f7cc3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] hw/alpha: Add the CY82C693UB
 southbridge in Kconfig
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 10:16 PM, Philippe Mathieu-Daudé wrote:
> Paolo, Thomas,
> 
> On 4/29/19 1:29 PM, Philippe Mathieu-Daudé wrote:
>> CC'ing Thomas who is a Kconfig expert.
>>
>> On 3/17/19 12:44 AM, Philippe Mathieu-Daudé wrote:
>>> Explicit the CY82C693UB southbridge used by the 264DP.
>>>
>>> Philippe Mathieu-Daudé (2):
>>>   hw/isa/southbridge: Add the Cypress 82C693UB chipset
>>>   hw/alpha/Kconfig: The 264DP machine use a CY82C693UB southbridge
> 
> This series does not fix anything, but makes the kconfig graph cleaner.

Ping?

