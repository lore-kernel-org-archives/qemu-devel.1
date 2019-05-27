Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77B7C28CBF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB62F217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB62F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42901 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVCQG-0006aA-Rl
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 06:00:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVCPJ-0006CW-Hg
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVCPI-0000cr-Lc
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:59:05 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:34350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hVCPI-0000Yb-GZ
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:59:04 -0400
Received: by mail-wr1-f46.google.com with SMTP id f8so16326966wrt.1
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 02:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=HB6Fz43UWv6m1fxhwq8+SEnXHX2T0VD7m1O2Bm11akU=;
	b=eZsf/lmEcLi2M6vmmJ/9l9lphrcOGkCmJtZtso6kDyMbALkJD+uTD7xNLfjxmPMZud
	7P4irmY4ueWAv3CjA7RyymxIojAEcbqsx+trn7oTCpG0mzltm/FIYPdx4BfpJH/ukh5s
	efpNhNkVCT9Zhi63QZKtqkKinvtYbln51a3kyBI3fo1fskEzRseLe0x7DLbJUpxRt0N8
	V5/Ny4HfV0fYa49NH5F1+4P1qIDeiDxECPvrg1Ccy3PnmHcv3Rt5awtwd4/aCqFyYn9q
	ld3x/sMQQB8Ity81q5v6smL2R5+W1jUNomtR/DB5Iy9H0slSirYL+tqPiVhPIaPA3Pyi
	S4fA==
X-Gm-Message-State: APjAAAUMAJOIT+MThO/jftorcjT6i5TsMUJDFLlvm9SmffeYd/bbA6QQ
	ELRIetnBYoqQ1l+nUS7WRcmj2TcTBY0=
X-Google-Smtp-Source: APXvYqwHeEmHkNjkQNbmN5uM6LVq4ULwUJE6Unjv7Yjq/+z34+ngyfqesFTyB5Ss7maclQWUq8oRRQ==
X-Received: by 2002:adf:e590:: with SMTP id l16mr4288609wrm.257.1558951142223; 
	Mon, 27 May 2019 02:59:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c43e:46a8:e962:cee8?
	([2001:b07:6468:f312:c43e:46a8:e962:cee8])
	by smtp.gmail.com with ESMTPSA id
	i185sm14556374wmg.32.2019.05.27.02.59.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 02:59:01 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-6-armbru@redhat.com>
	<db337f20-8b76-9214-533e-3e4b79c5c4d5@redhat.com>
	<87ef4peyg5.fsf@dusky.pond.sub.org>
	<14caabd5-34e3-260f-91e0-df93e8f1a02a@redhat.com>
	<8736l032k8.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <82f1da26-1007-5971-5c5d-19256de96ad9@redhat.com>
Date: Mon, 27 May 2019 11:58:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8736l032k8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.46
Subject: Re: [Qemu-devel] [RFC v4 5/7] tests: New make target check-source
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/19 07:10, Markus Armbruster wrote:
>> Another suggestion: are there headers that cannot even be included once
>> (due to dependencies)?  Is it worth including a test for those even in
>> the first iteration?
>>
> I'm not sure I get what you mean.
> 
> Most headers failing the test fail it in the first #include: they fail
> to conform to 2. Headers should normally include everything they need
> beyond osdep.h.

Ok, good to know.

> The only way to fail in the second #include is a missing header guard.
> If it's missing intentionally, it's "_meant_ to be included many times",
> and you propose renaming to .inc.h.  Else, easy fix.
> 
> I think I'll make a list of headers that fail in the second #include,
> and try to sort them into "intentional" and "bug" buckets.

The proposal is to make two tests, but it can come later.

Another idea could be to make it print the result as TAP.  But I could
work on that later.

Paolo

