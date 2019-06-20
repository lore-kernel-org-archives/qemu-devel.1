Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FFFC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B12206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B12206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdvjl-00016z-0b
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 08:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdvYc-00082P-Tt
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hdvS1-0007jV-M3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:41:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hduqp-0000Ay-GV
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:03:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so2554360wrm.8
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 04:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R34I9t6ZFbqPjQwuP9tkKod/laiUyDKmB1hOhQ7Bdzg=;
 b=ss5GGmPM3CbNf6Lh52xJsvTZthubVQb7aRPwjk47kbE93SgnQKVaROHLMrtqN8T5vy
 NMQrri6kZ5LnkI/Ra2qC95iwkajabrcOiiKda3/gZLExGfshI9Dfg2uWzRQzBSWHICEA
 qwKtC7kuIAb11jsdNsMVEHKXLYD2BmLwDN387yMpHR8n4gO15TAMpsg6FXZy+ytfaOIM
 b+F0tAhwa6ZK9neVqsRPaVUtPwN64ieWxuVkU3oSdPl/Kim/SI6HBiSzPLBvs2zA987R
 zaWF99OXoGGokbwN7/HnzyDj8CMvt9OJWu2SjC/N0mmfkU11nfVokWRc1PUfEIgO6LUr
 04mA==
X-Gm-Message-State: APjAAAXij49XDNW1sa6ATAZEQtWggMZTfsWFuET8tMAPWMVS+QzfD0Pc
 nPHQF3T6yh121fUnWe4tVKZang==
X-Google-Smtp-Source: APXvYqx3tajlXTj9jPjT2x7gNiv1K7UoPngPNpQWJRLC5nuQLvbcDAPEcwYeKBzy8prsD4dyuKBTmQ==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr15537268wrw.232.1561028609530; 
 Thu, 20 Jun 2019 04:03:29 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id g17sm17964962wrm.7.2019.06.20.04.03.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 04:03:28 -0700 (PDT)
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190531064341.29730-1-philmd@redhat.com>
 <20190531073859.ojouyr3urzcarn4f@steredhat.homenet.telecomitalia.it>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5489328b-92d7-6595-a6da-3f27d0839882@redhat.com>
Date: Thu, 20 Jun 2019 13:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531073859.ojouyr3urzcarn4f@steredhat.homenet.telecomitalia.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] Makefile: Rename the 'vm-test' target as
 'vm-help'
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefano,

On 5/31/19 9:38 AM, Stefano Garzarella wrote:
> On Fri, May 31, 2019 at 08:43:41AM +0200, Philippe Mathieu-Daudé wrote:
>> We already have 'make check-help', use the 'make vm-help' form
>> to display helps about VM testing. Keep the old target to not
>> bother old customs.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> Based-on: <20190530101603.22254-1-alex.bennee@linaro.org>
>>           "testing/next queue"
>> ---
>>  Makefile                  | 4 ++--
>>  docs/devel/testing.rst    | 4 ++--
>>  tests/vm/Makefile.include | 5 +++--
>>  3 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index f0be624f47..f67739df7c 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -9,7 +9,7 @@ SRC_PATH=.
>>  UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
>>      html info pdf txt \
>>      help check-help print-% \
>> -    docker docker-% vm-test vm-build-%
>> +    docker docker-% vm-help vm-test vm-build-%
>>  
>>  print-%:
>>  	@echo '$*=$($*)'
>> @@ -1121,7 +1121,7 @@ endif
>>  	@echo  'Test targets:'
>>  	@echo  '  check           - Run all tests (check-help for details)'
>>  	@echo  '  docker          - Help about targets running tests inside Docker containers'
>> -	@echo  '  vm-test         - Help about targets running tests inside VM'
>> +	@echo  '  vm-help         - Help about targets running tests inside VM'
>>  	@echo  ''
>>  	@echo  'Documentation targets:'
>>  	@echo  '  html info pdf txt'
>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>> index da2d0fc964..68aba3926e 100644
>> --- a/docs/devel/testing.rst
>> +++ b/docs/devel/testing.rst
>> @@ -399,12 +399,12 @@ VM testing
>>  
>>  This test suite contains scripts that bootstrap various guest images that have
>>  necessary packages to build QEMU. The basic usage is documented in ``Makefile``
>> -help which is displayed with ``make vm-test``.
>> +help which is displayed with ``make vm-help``.
>>  
>>  Quickstart
>>  ----------
>>  
>> -Run ``make vm-test`` to list available make targets. Invoke a specific make
>> +Run ``make vm-help`` to list available make targets. Invoke a specific make
>>  command to run build test in an image. For example, ``make vm-build-freebsd``
>>  will build the source tree in the FreeBSD image. The command can be executed
>>  from either the source tree or the build dir; if the former, ``./configure`` is
>> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
>> index 5e37063d32..b7311d7bd9 100644
>> --- a/tests/vm/Makefile.include
>> +++ b/tests/vm/Makefile.include
>> @@ -8,8 +8,9 @@ IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
>>  
>>  .PRECIOUS: $(IMAGE_FILES)
>>  
>> -vm-test:
>> -	@echo "vm-test: Test QEMU in preconfigured virtual machines"
> 
> What about adding something like this?
> vm-test: vm-help
> 	@echo ""
> 	@echo "vm-test is deprecated, please use vm-help"

I wouldn't worry about deprecation warnings for dev tools, it would be
just noise :)

> 
>> +# 'vm-help' target was historically named 'vm-test'
>> +vm-help vm-test:
>> +	@echo "vm-help: Test QEMU in preconfigured virtual machines"
>>  	@echo
>>  	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
>>  	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
>> -- 
>> 2.20.1
>>
> 
> With or without the vm-test message:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks!

Phil.

