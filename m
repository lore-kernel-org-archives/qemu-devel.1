Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08DFC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F9E206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F9E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40211 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNsa2-0004VZ-0Z
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 01:23:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNsXu-0003C9-Dv
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNsXt-00056t-FK
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:21:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNsXt-00055X-8y
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:21:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so20266746wra.12
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 22:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fUDicPC99iA3eWQX85t2+xSWnTlEStej7kWs/MCMCVQ=;
	b=M8pxuyrO2vm1QkTRVlkz5dw31G4Qky2IeRzESZ25hutF1wQrLtsUvglMaasWCbFTfa
	wyKeYyvvk5kLIgCa2yNVbQ5puqXVAo2NRHrq8E2ycoSqE1/P74lK9q5DMRRR96P1/eho
	9uIte+Nx7xSPvqDaB26hdYyvIcQbLf0McO0bVK+MTml1F68n8t0cyd3+UsDw1gK/bYfT
	DTE/XC9ZF7IhxyxQHm19qPEwpPqfk3i/RBr8pzj7bfITVakRf/dtgjZmV+kghStW9fDp
	ApuwMxa2OF7wqowuXUFhitxWRRfK/qYHT/0IawkHb0v2ji7xj/B8ORbIsLt1NlRN6IFu
	qTtA==
X-Gm-Message-State: APjAAAXHPkS5PE9IMeC45Fw8SS9gXCfIZaMW076YH/TMtaKFj6nSu1yd
	/hZCyxz0meNqy27sSQcigvVO4A==
X-Google-Smtp-Source: APXvYqwhELT74SPRiuqXoNCBMFtX7GysiTJtJS7ZZ/YBSQ+HJ9Oqia2R2pFZOVyDobtbF37JfLl53Q==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr21811325wrw.187.1557206500360;
	Mon, 06 May 2019 22:21:40 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	b10sm24352954wme.25.2019.05.06.22.21.39
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 22:21:39 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190506213817.14344-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ea8a4248-24b3-4dce-f799-3b41fcb32920@redhat.com>
Date: Tue, 7 May 2019 07:21:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506213817.14344-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] tests: Force Python I/O encoding for
 check-qapi-schema
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/19 11:38 PM, Eduardo Habkost wrote:
> test-qapi.py doesn't force a specific encoding for stderr or
> stdout, but the reference files used by check-qapi-schema are in
> UTF-8.  This breaks check-qapi-schema under certain circumstances
> (e.g. if using the C locale and Python < 3.7).
> 
> We need to make sure test-qapi.py always generate UTF-8 output
> somehow.  On Python 3.7+ we can do it using
> `sys.stdout.reconfigure(...)`, but we need a solution that works
> with older Python versions.
> 
> Instead of trying a hack like reopening sys.stdout and
> sys.stderr, we can just tell Python to use UTF-8 for I/O encoding
> when running test-qapi.py.  Do it by setting PYTHONIOENCODING.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 7c8b9c84b2..af88ab6f8b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1103,7 +1103,7 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$(EXESUF)
>  .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
>  $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
>  	$(call quiet-command, PYTHONPATH=$(SRC_PATH)/scripts \
> -		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
> +		PYTHONIOENCODING=utf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
>  		$^ >$*.test.out 2>$*.test.err; \
>  		echo $$? >$*.test.exit, \
>  		"TEST","$*.out")
> 

