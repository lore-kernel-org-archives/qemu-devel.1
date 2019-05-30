Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE5BC28CC2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 14:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776A225A17
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 14:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776A225A17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54589 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWLjT-0008A4-FL
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 10:08:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hWLiI-0007aU-AH
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hWLiH-0008QJ-Bm
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:07:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hWLiH-0008PU-5E
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:07:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id w13so4287459wru.11
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 07:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ZpMjqyCqZkPrjQeVY3cuelwz++9CMifqrFZNCVg+YCY=;
	b=o8y3NGcrAyL2qBnHXUqGWO2wano6bEW36AivHIHC+2vJ4R2yXMheulgHWnhHm7kUXy
	w3UCRIpe6PSR3D/QyX5kxS8FPstIFuOEOqYtyYg4bYmiPJaBUMVp4JrP4tv79t6z0S0m
	0gzZ/CnmJOe1Gc7qfWbKAQD4Iqqg1+AyIJZyjU6ugCAz46240BiG72UlauLUap66E1xa
	HfxSfYP1wKA5JzECVOW8T0fZvou92ml8VEj4NOcXfgB1FauXeDbp192wbA6VFpHGgqCF
	V3pp0ZefhKGtJs4p2DRHUxoAv4jEB87e1+FvnPZ9fRJokbtx3uuT4tb7NLA1Xt3SncNi
	Hybg==
X-Gm-Message-State: APjAAAUVRunzUlnWyKtiInhf/zIua8AFdWYnatiMsNqNAAbqSl9fGkXL
	38RKWaCPKvnKWK5dE4QVmfad7A==
X-Google-Smtp-Source: APXvYqzIFu3RaJZALmkL2Je9ENDd3zTdhqTpv2516ZzbGqs92GqLfFW4khEGKM8pnZgOD/GZivImuA==
X-Received: by 2002:adf:ce11:: with SMTP id p17mr2758900wrn.58.1559225243958; 
	Thu, 30 May 2019 07:07:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f91e:ffe0:9205:3b26?
	([2001:b07:6468:f312:f91e:ffe0:9205:3b26])
	by smtp.gmail.com with ESMTPSA id n5sm3394558wrj.27.2019.05.30.07.07.22
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 07:07:23 -0700 (PDT)
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20190527092319.15844-1-stefanha@redhat.com>
	<20190530084214.GA4890@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2cbb60cd-beba-52bf-71d0-bc3cfe756a59@redhat.com>
Date: Thu, 30 May 2019 16:07:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530084214.GA4890@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] block/linux-aio: explictly clear laiocb->co
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
Cc: Max Reitz <mreitz@redhat.com>, Julia Suvorova <jusual@mail.ru>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/05/19 10:42, Kevin Wolf wrote:
> Am 27.05.2019 um 11:23 hat Stefan Hajnoczi geschrieben:
>> qemu_aio_get() does not zero allocated memory.  Explicitly initialize
>> laiocb->co to prevent an uninitialized memory access in
>> qemu_laio_process_completion().
>>
>> Note that this bug has never manifested itself.  I guess we're lucky!
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> That the bug never manifested itself might be because it's in an unused
> function. How about we finally just remove the unused callback-based
> laio_submit() from the code?
> 
> At the time when I converted linux-aio to coroutines, someone (maybe
> Paolo?) insisted that we keep the old interface because we might add a
> new user sometime with possible shortcuts that bypass the whole coroutine
> path, but it hasn't happened and I think we've moved even further in the
> opposite direction since then.

Yes, I suppose it's time.  Spending time fixing bugs in dead code is
always a sign that it's time. :)

Paolo

