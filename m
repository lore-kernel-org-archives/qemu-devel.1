Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690ECC18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343E721479
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/l878j1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343E721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40097 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTOse-0003vO-IO
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 06:53:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTOrg-0003UP-8Z
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTOrf-0005Yp-4Z
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:52:56 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:46282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTOre-0005Y9-Sr
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:52:55 -0400
Received: by mail-yw1-xc41.google.com with SMTP id a130so646349ywe.13
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=canbqKu23RF5p9R0mQ+WIbtMxNZxpUGa6JSvUz2EQ5g=;
	b=Z/l878j1DjP05IxWbKvievwsEioMS66TpJN7i3VYacS1QSbAdfeM2eECqlVWIzALR+
	oY4qHFMrVmDUYqihn5dSoziNCtNCvO67n9zO+K6Txbpqk1hbmClvsw6s4oValZQLzaZa
	s979iOJbPI4Iq9pKQXeY9qZ6aSYE11zp9WgM6vv757l5JYzgrHG75WlPe98uvDAVctJP
	rWfcmDaU/3vpl7xpHy9g+NwM+NtxEANkqV9+mivILSTjGahKifTyWsr6TI9xJCK0NegN
	aXXP8XMMQsIr8jST7ouavliTtGKFnyJA7Mqm99JRQypIhhdER6OSmxifXcSYA8lckvA5
	mj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=canbqKu23RF5p9R0mQ+WIbtMxNZxpUGa6JSvUz2EQ5g=;
	b=caO273EMuW49ny660okA4IVOV8bzAWXUuIfjExOn/ZsA9BFA3moE7X/gcrZlKsboR9
	TRefVX4sBkUfux2tPEHQbA5S5MKa40C09TmmcO+KiPY7jFV7YWffucErQLqu4fUcoX9r
	GxElKxjo0n5ZWqR+WjL/HD6hibV5D6nmWHtrwLUSK6N8QJU0aGuGVqoHK5zVYQ/UTwoQ
	4FkXbTG8So8/7QRCFM+C3Dmi7tOuE0tIVi1e6Zk9Scn8rbwy26jAT7GVuC/f7O1NKb++
	HIcVcKktUt6Ubxr5a3EsVIrSS60WGtijeJEjexq8mqH8y9LoKoq2c45zaG+Z1FIfDJr/
	UQ6A==
X-Gm-Message-State: APjAAAXBtRtr6Wu1+C6M0BIGLloYlWCMR/DCzh7qoesgVOPrMkm4sN9/
	kjcfdB/d4NLjOUTqH4naAkcLFw==
X-Google-Smtp-Source: APXvYqzfZ7VuthelbykVUes9LerrTnKVjXXQAwTue0XqrkKoY60O84frZR1Ng9d60cf7VPCL1HR75A==
X-Received: by 2002:a81:a981:: with SMTP id
	g123mr29442586ywh.440.1558522373472; 
	Wed, 22 May 2019 03:52:53 -0700 (PDT)
Received: from [10.243.202.139] ([71.46.56.72])
	by smtp.gmail.com with ESMTPSA id
	e6sm6399455ywe.104.2019.05.22.03.52.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 03:52:52 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
	<20190517023924.1686-3-richard.henderson@linaro.org>
	<20190521150402.GQ25835@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a928e588-63dc-ed4c-fcdc-9001941559fd@linaro.org>
Date: Wed, 22 May 2019 06:52:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521150402.GQ25835@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: Re: [Qemu-devel] [PATCH v8 02/25] build: Link user-only with crypto
 random number objects
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/19 11:04 AM, Daniel P. Berrangé wrote:
> On Thu, May 16, 2019 at 07:39:01PM -0700, Richard Henderson wrote:
>> For user-only, we require only the random number bits of the
>> crypto subsystem.  Rename crypto-aes-obj-y to crypto-user-obj-y,
>> and add the random number objects, plus init.o to handle any
>> extra stuff the crypto library requires.
> 
> If you pull in my authz patch first:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04863.html
> 
> then we can just kill crypto-aes-obj-y entirely, and make
> linux-user reference crypto-obj-y as normal. My patch avoids
> pulling in PAM, and your previous patch takes care of the
> static linking problem.

You would think so, wouldn't you.  And yet, not.

  CC      authz/base.o
/home/rth/qemu/qemu/authz/base.c:23:10: fatal error: trace.h: No such file or
directory
 #include "trace.h"
          ^~~~~~~~~
compilation terminated.

We're missing some dependency somewhere, and I have no idea what's missing.

This for

../qemu/configure --static --disable-system --disable-tools

I have a working configuration here in v8.  Can we please leave the bikeshed
unpainted for the moment and you can adjust the makefiles as you see fit afterward?

Otherwise, I'll pass the entire series off to you and leave it at that.


r~

