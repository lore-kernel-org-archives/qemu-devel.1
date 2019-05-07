Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39364C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CCC8205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCC8205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45920 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNz3B-0004yZ-CU
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:18:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hNyvG-0006oz-Bc
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hNyvE-0001ep-Mo
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:10:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hNyvE-0001eJ-0a
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:10:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id e11so8948612wrs.0
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=MfpSg9Q3f8tq5p+FYBjTg6g9hpkhoHZte1EMwPUTVxI=;
	b=ocCCHi4APPqEJL2j6q0wpDHWXyJBwv1vnjyzWOmPjRH50um2bKDW5sZIwmOIeagbfF
	3Iko58kcha634rw30zyCXGLs8jBa1Aojaip233O6zIKKllzwKJuwcPDu3DqoaCx9cdrU
	FVsf/4m2YrY8iqXgXzIxM2omGvhqT1ZsrOkoStvDQ4EV04l34+jgw6h3PIOdbmx6U7jI
	chImgy43ndb7rNKcNJRwcuP0ef9A4S8cJBviJ9Xk43DyzIgsL7gUTUtHsHiXZtdwiz5d
	2gqwnPuXYNDSiJ2U19B8+Q9p2gTMJTGtnPo+FXE2jhZPNUntH3+ynpBEgvb5rzZKwlv2
	uGzw==
X-Gm-Message-State: APjAAAVBfJb5VtzYMujUjoUnC5X3HI1fdKZm/AzGLhazwDtsvhN3Rea0
	JD3BjnBVw7P6P5LpFdL9fNjTDw==
X-Google-Smtp-Source: APXvYqxCA4nIW3QqYvO5acqx3YKTazfjN3MPB0fBgWs6UAwT/3SK8ZVkMzjelUqB4r2LuciWdeUnWQ==
X-Received: by 2002:adf:db0b:: with SMTP id s11mr15384061wri.180.1557231010789;
	Tue, 07 May 2019 05:10:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f572:d55d:64bb:59f8?
	([2001:b07:6468:f312:f572:d55d:64bb:59f8])
	by smtp.gmail.com with ESMTPSA id
	b184sm19309123wmh.17.2019.05.07.05.10.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:10:10 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190506051810.16493-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a10c71d8-3a97-797a-baac-61cedc993be6@redhat.com>
Date: Tue, 7 May 2019 14:10:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506051810.16493-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] tests/Makefile: Remove unused test-obj-y
 variable
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
Cc: qemu-trivial@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/19 00:18, Thomas Huth wrote:
> I recently noticed that test-obj-y contains a file called
> tests/check-block-qtest.o which simply does not belong to any .c
> file and thus wondered why this is not causing any trouble.
> Well, if I get the Makefile magic right, test-obj-y is not really
> used for anything - and "make check" still works fine if we simply
> remove it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

It is used to add -Itests to the command line (which refers to the build
directory).  However, it is not needed because "-iquote $(@D)" already
sets this up in rules.mak.

Paolo

> ---
>  tests/Makefile.include | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 7c8b9c84b2..dfc4b7746f 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -482,25 +482,6 @@ GENERATED_FILES += tests/test-qapi-types.h \
>  	tests/test-qapi-events-sub-sub-module.h \
>  	tests/test-qapi-introspect.h
>  
> -test-obj-y = tests/check-qnum.o tests/check-qstring.o tests/check-qdict.o \
> -	tests/check-qlist.o tests/check-qnull.o tests/check-qobject.o \
> -	tests/check-qjson.o tests/check-qlit.o \
> -	tests/check-block-qtest.o \
> -	tests/test-coroutine.o tests/test-string-output-visitor.o \
> -	tests/test-string-input-visitor.o tests/test-qobject-output-visitor.o \
> -	tests/test-clone-visitor.o \
> -	tests/test-qobject-input-visitor.o \
> -	tests/test-qmp-cmds.o tests/test-visitor-serialization.o \
> -	tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
> -	tests/test-opts-visitor.o tests/test-qmp-event.o \
> -	tests/rcutorture.o tests/test-rcu-list.o \
> -	tests/test-rcu-simpleq.o \
> -	tests/test-rcu-tailq.o \
> -	tests/test-qdist.o tests/test-shift128.o \
> -	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
> -	tests/atomic_add-bench.o tests/atomic64-bench.o
> -
> -$(test-obj-y): QEMU_INCLUDES += -Itests
>  QEMU_CFLAGS += -I$(SRC_PATH)/tests
>  
>  
> 


