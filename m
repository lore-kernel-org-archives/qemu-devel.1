Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B94C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 13:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EF92053B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 13:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EF92053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37317 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQu4x-0006oG-2R
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 09:36:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hQu3q-0006Ge-Nd
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hQu3p-0004lX-Oy
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:35:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hQu3p-0004iq-I7
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:35:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id s17so2728974wru.3
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 06:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=YQERiB9ZlNDiOFoNbAjUjx/1yk4EKSRqB7Kae7YopT8=;
	b=nhaPfZRZINA7HTomwyeXXO5OwUr0gk6T7FeGPMwrxGP2e4UKxWzZGduX1I4OawRDyn
	EWF/VSdYwd5vf3v4UAmuVS8CYXIyRJZQ1twDmpJaF0dQFZDuMg2ExRJ+eVap4Oc4z855
	G4WrcrvuUndg+m5R6FimI7/nO+fOduexb2Ki/sBi3v4tGWctMZBRcYxL0m9xw5D5voM3
	4tlsxNGEeVlGQJ+U2RMxf9CTWDCnQr9Nh0lvgjHMXrr2TgLiUMXcNrbKxwWldd0fcwur
	CmbLASUZO6U5eIwDVZN6eA83eJZJN4PILnf7MIZ8tvEuzCYWiDVkKL8ieQrT2xJ+c2Bd
	aqeA==
X-Gm-Message-State: APjAAAXiL8Rz+S9NV+JxltJY2Q/Fph3DVrmC42t0xvyNz6k58JqY51sE
	cPMZFmH/bn8Pol7/REGY6m1dmATopnw=
X-Google-Smtp-Source: APXvYqx6UtFrtZHpfY7TQElQe5bWlh3Qb2uq1atgCwkJaSTZW0t4vErV6NSWT00OJCibrT28KZUF0A==
X-Received: by 2002:a5d:45d2:: with SMTP id b18mr16232217wrs.219.1557927307030;
	Wed, 15 May 2019 06:35:07 -0700 (PDT)
Received: from [172.10.18.228] (24-113-124-115.wavecable.com. [24.113.124.115])
	by smtp.gmail.com with ESMTPSA id a5sm1527301wrt.10.2019.05.15.06.35.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 06:35:06 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
	<CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
	<877eat6xgm.fsf@dusky.pond.sub.org>
	<e562c5f5-9d01-59b0-5a4c-d040fa8b8962@redhat.com>
	<87lfz88bva.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1089f272-838f-e3e0-3b50-5a33cce95030@redhat.com>
Date: Wed, 15 May 2019 15:35:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87lfz88bva.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/05/19 08:34, Markus Armbruster wrote:
>>> qemu-bridge-helper should have a manual page, and its handling of errors
>>> in ACL include files needs work.  There's probably more; I just glanced
>>> at it.  I'm not volunteering, though.  It lacks a maintainer.  Should we
>>> add it to Jason's "Network device backends"?
>>
>>
>> Yes.
>>
>>> -netdev's helper parameter is seriously underdocumented.  Document or
>>> deprecate?
>>
>>
>> I believe management should only use fd parameter of TAP. If we have
>> other, it should be a duplication. So I suggest to deprecate the
>> bridge helper and -netdev bridge.
> 
> Objections, anyone?

Yes, your honor. :)  The helper is the only way for unprivileged users
to set up TAP networking, which is basically the only really way to have
*working* network.  It's widely used in the wild, it's self-contained
and the only alternative for users is the S-word (hint, it's five
letters long and ends with LIRP).

However, I have no problem with deprecating the helper argument of
"-netdev tap", which is a useless duplication with "-netdev bridge".

Paolo

