Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E60C072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C33220856
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C33220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTMVT-0006s9-OS
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 04:21:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hTMUZ-0006Qu-Vh
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hTMUX-0007tj-3y
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:20:55 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hTMUW-0007rh-TY
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:20:53 -0400
Received: by mail-wm1-f42.google.com with SMTP id 7so1182674wmo.2
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 01:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=F91sqqIq9gYnXWJjfU3WtqxY/oByzJvaGiw3n0ouTgU=;
	b=CoN6gmsPxYSdrcei7/e1ubE3Dfh6nG2gS3o0I/09NRaC58Nw6CzpNLuq+lcYGQr1w5
	pCUNHTgngDUoMYnP0JnEq/5gdLTYWDXSlAvzLPzUIU4q6fUSKTQC4yqaP7SpP7be7AXH
	D1/yZc3vbQcadGl6UixEIgIlA0Bmgj9R88L9oqDbbVK+7HaI5xg2z2ljBSfNoS4dZYuv
	CqBpOn9xzPmema2WrFU5ZxeejXMNjEZbXVGmtUreabAfuaJlf1DppM9dBZ2X/bVRbnuh
	gaTA/dAquMd3QeGWDUJXWSQSG8LaNkF8PrcfXdrrvOydO6SgQQZLaEa/Ri86FIFMFL5I
	Qiwg==
X-Gm-Message-State: APjAAAVeIPxtiqegOHy5N/FQeKiZmgaCem1niuFbnL09yIH4fl3J//t6
	IXOfaVIapwcDHTIXgPpRkY4NKA==
X-Google-Smtp-Source: APXvYqzcjRlGQTaBf1cKjuEnzZEvjA1y5Q7kwBTBZfYYWJHRKq8/FX92tnVG7s8Zff6l52xTFmsh7A==
X-Received: by 2002:a1c:a755:: with SMTP id q82mr6323357wme.82.1558513250172; 
	Wed, 22 May 2019 01:20:50 -0700 (PDT)
Received: from [10.32.181.147] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
	by smtp.gmail.com with ESMTPSA id
	n63sm6018413wmn.38.2019.05.22.01.20.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 01:20:49 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>
References: <20190520184108.GA10764@habkost.net>
	<20190521085350.GF25835@redhat.com>
	<e2395213-efaf-6d6c-6cfd-d949d071b4f6@redhat.com>
	<87pnobrg37.fsf@dusky.pond.sub.org>
	<CAFEAcA8db=UsyU_kRBoatFT2ULQBqL318xRhg+CV4D_7hV76Og@mail.gmail.com>
	<7e468375-ca5f-0048-789e-c41d09065eeb@redhat.com>
	<20190521203712.GO10764@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dff30917-557a-cf41-e82e-03465d0209aa@redhat.com>
Date: Wed, 22 May 2019 10:20:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521203712.GO10764@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.42
Subject: Re: [Qemu-devel] Introducing GSoC project: API Documentation
 Generation
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
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/19 22:37, Eduardo Habkost wrote:
>> But this is the one we're going with? Do we have a plan for teaching it
>> not to panic for our use of named custom types?
>
> If I understood correctly, the patch from Paolo that I have
> forwarded to this thread is all we need.  Are there other issues
> with kernel-doc we would still need to address?

We can find out, but that patch is a good starting point to understand
that.  After all it's summer of code, not weekend of code. ;)

Paolo

