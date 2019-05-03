Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD716C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B298C206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B298C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44741 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbcR-0008OX-Vb
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:05:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMbbX-00084o-KH
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMbbW-0006RX-BM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:04:11 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:34003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMbbW-0006QK-5T
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:04:10 -0400
Received: by mail-wm1-f51.google.com with SMTP id m20so347537wmg.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pHqpHDBluSnJ+bv7SK9GfHe57lbayMO6jW0qLFbpkLM=;
	b=f0JFiAkOJtbDo1GMtaVEsxWPGISJ4/TWoRgq/zfoiXidnv4300flN0RJcc04RTWbd6
	51+5ldHFBK7X8QfvmOdcDT72x/+HMi1qflQUs4ZxjRxTi6hpXgyzGcDfb0iEDCOshnsQ
	/aPLXkBSZ0qcceFgjqHB/dbJTiBlSDadBBn9zBCNaFvXYPe8vd809D1Qas8yWsPuXWHf
	TFXabSAuoiTPbSgOnfBvociDb8HEUeYkZRT1OeSU/sslLvYxAVzrbsMAK4Pe6pvmY1Gj
	gJSAr487o/2VCBv6yajLh3d73IcSNuIgMEOu7Ro9+ZZPeQFXjHBV2YgyOAus9Qza15NO
	UFeQ==
X-Gm-Message-State: APjAAAV+hL34i2SStydoXNeIkBeWeptdwUkHGQcreIejFCcnetHUznJX
	GuqhwWBOpp0Lz4A7TkorJfQuIA==
X-Google-Smtp-Source: APXvYqw+iQ+LsDhtBxeQty8yudBdI2Rqo3n7VIto3halmE3uHrauc1vwiR6aLbu9+fiyA6s61qJDgg==
X-Received: by 2002:a1c:ed18:: with SMTP id l24mr7052095wmh.8.1556903049023;
	Fri, 03 May 2019 10:04:09 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id i8sm4107325wrb.5.2019.05.03.10.04.07
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 10:04:08 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190503004130.8285-1-ehabkost@redhat.com>
	<20190503004130.8285-20-ehabkost@redhat.com>
	<40c4d236-ed76-e433-51d5-c9feabb4374a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b6e70863-4ec9-0209-46b0-b74eb1453fcf@redhat.com>
Date: Fri, 3 May 2019 19:04:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <40c4d236-ed76-e433-51d5-c9feabb4374a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.51
Subject: Re: [Qemu-devel] [PULL 19/19] configure: automatically pick python3
 is available
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503170407.CXLfnrhb3D__8Y8V3xb0lOnP3B7HzYPbrGXolgtt4dk@z>

On 5/3/19 6:41 PM, Thomas Huth wrote:
> On 03/05/2019 02.41, Eduardo Habkost wrote:
>> From: Daniel P. Berrangé <berrange@redhat.com>
>>
>> Unless overridden via an env var or configure arg, QEMU will only look
>> for the 'python' binary in $PATH. This is unhelpful on distros which
>> are only shipping Python 3.x (eg Fedora) in their default install as,
>> if they comply with PEP 394, the bare 'python' binary won't exist.
>>
>> This changes configure so that by default it will search for all three
>> common python binaries, preferring to find Python 3.x versions.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> Message-Id: <20190327170701.23798-1-berrange@redhat.com>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  configure | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> I haven't bisected it, but I think this patch here broke the gitlab-ci tests:
> 
>  https://gitlab.com/huth/qemu/-/jobs/206806257

What's the easier way to notice that automatically?

The quicker fix I have is Peter setup'ing a GitLab account mirroring his
repo:staging branch, and warn him, but that won't scale much.

> Seems like the test is now failing when you don't have an UTF-8 locale:
> 
>  LANG=C make check-qapi-schema
>  [...]
>  TEST    tests/qapi-schema/union-base-empty.out
>  --- /builds/huth/qemu/tests/qapi-schema/unicode-str.err	2019-05-03 15:21:39.000000000 +0000
>  +++ -	2019-05-03 15:42:01.561762978 +0000
>  @@ -1 +1 @@
>  -tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name 'é'
>  +tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '\xe9'
>  /builds/huth/qemu/tests/Makefile.include:1105: recipe for target 'check-tests/qapi-schema/unicode-str.json' failed
>  make: *** [check-tests/qapi-schema/unicode-str.json] Error 1
> 
> Any ideas how to fix this?
> 
>  Thomas
> 

