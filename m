Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB90C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D64214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D64214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38458 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlP1-0007xD-W1
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:44:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSlDR-0006bq-5L
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSlDQ-0003Qu-Bn
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:32:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSlDQ-0003Qe-62
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:32:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so1939wml.4
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 09:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pcrhVnfZkqq9nUYBJVJooopGSz92F5BjMRVaz91OSog=;
	b=iVptKq5wnL1pKlVX+DvwmjB20H16xiThzJs3M6Bx1R1dzGO/W2JWRdzgPM/7H7diep
	86yFYv+rXry2vgtKV3z2PUaXGFzM/qEBgEmt45+Z97p+GKVCXgnQESAnX0lXp9P53lXq
	90zT3qVpl1K3LhUz9+KxkxY6T4noMO5EwGsLXx7uKY7hSHKCQN0YR4xFoc/UiOpmv9ko
	Hbj98YDBNkOjAXGyUxO6IHztfj4B45zGUletmH8LTPGp3G/YNeB7bvIuaND9NE0RyUs9
	Wly2G17XhImAcIWuqSiUa9B88vqAuyWY4apY5xrUfXUHH4tM6+Hs1JD0v946fz9Vl0ip
	4ngw==
X-Gm-Message-State: APjAAAWMutirX/hyZLopD+Ptpq+L6OmF4cRYqt8IdMezmjgqQJf6pT6w
	okvRvBzTifKp1N7TAjkyB77NQQ==
X-Google-Smtp-Source: APXvYqxuN7HolzJAqzy4YyyM8VujZL8CKCtJzGQGmMzbU3+yRBuNQEH0x9PCh3ArplCC0g8eMwM+Qg==
X-Received: by 2002:a1c:d182:: with SMTP id i124mr20676wmg.102.1558369963167; 
	Mon, 20 May 2019 09:32:43 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id t15sm28072wmt.2.2019.05.20.09.32.42
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 09:32:42 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	Peter Maydell <peter.maydell@linaro.org>
References: <20190506142042.28096-1-clg@kaod.org>
	<b12201c8-7d5f-2108-6666-75543c38f243@kaod.org>
	<f1ca56fd-c83d-8ad6-29c9-a8fc6af4531c@redhat.com>
	<270e510b-687a-6b43-8cd6-c1eb1aea41e6@kaod.org>
	<6161d982-0d21-99d6-680a-37ae300fd7cd@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <98d1e57f-c033-fdb4-51bd-4a6fc2223d58@redhat.com>
Date: Mon, 20 May 2019 18:32:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6161d982-0d21-99d6-680a-37ae300fd7cd@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 0/3] aspeed: cleanups and extensions
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
	Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/19 3:32 PM, Cédric Le Goater wrote:
>> Peter, 
>>
>> do you want me to resend with only the two first patches and include 
>> Joel's in the same series ? I would leave out the part Philippe is 
>> covering in his object_initialize_child() patchset.
> 
> Nope, we can not do that, conflicts arise. I suppose the easier is wait
> for Philippe's patchset to be merged and then rebase.

Eduardo said he'll send a pull request during the week.

