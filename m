Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94B1C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC6F2054F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC6F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36307 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOLiT-0001dx-Ur
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 08:30:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOLhe-0001Ho-QV
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOLhe-00084r-09
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:29:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOLhd-00084A-PI
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:29:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so3056861wmf.2
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 05:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=JfFuS75QZH+ohLsy6LXoom87KOz5yO8X4rzQoE26WdM=;
	b=Ba2di3f9A/xnUDehI2PN2T759qpJr+frppkuBuPOjK3z66rG81eTTQ1JOzKW3AKi59
	tZZODvvb2M+YhN7GkAW4gDsIsV2Sywj8QFOS4eGftRAIptg8MegE3dDT9zQ9wD/S4Nf6
	0WcgvwL5dhR0bAvyI46WY8zqqOdpDQITCmwh7Uf38bzFs00T6WM+eKhgmP5LcMpCg4FM
	Y9WX/tP4+e1YCqau1DZzifr1ovDG4lRvUnISD0wWWkIYbqi808Gn0nvshcyngFBVVIwm
	LspSQwTya1D4MYwuGhMvw6c4GC4WXsED9rnX1JdXDyNj4jB7YKqjufgdWG/Uo6bmJvxK
	xaLQ==
X-Gm-Message-State: APjAAAXb5t0f3AUf9Wk9GUshLGrwBCz7sYNnrZcRqMQg6kNLmK+k9/xD
	KnrNMXvHyZXYjjWwAXVMu1tdJw==
X-Google-Smtp-Source: APXvYqx50V4x8C3El4RUMLnjDq146cRyQOX+DhvwIYQe0aWNg8y78cf8Yg8MxltDs5vqi31bxAY5BA==
X-Received: by 2002:a1c:7005:: with SMTP id l5mr2906265wmc.149.1557318580720; 
	Wed, 08 May 2019 05:29:40 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id
	n2sm35418726wra.89.2019.05.08.05.29.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 05:29:38 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
References: <20190505180719.31913-1-philmd@redhat.com>
	<02ce0766-4464-2c71-6085-7e164d4405af@redhat.com>
	<ffaa93ed-f790-8aba-3683-d1e11e2ac59c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63fc48d2-2d33-c6b6-0e22-b8b2578b75ac@redhat.com>
Date: Wed, 8 May 2019 14:29:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ffaa93ed-f790-8aba-3683-d1e11e2ac59c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] hw/timer: Compile devices not
 target-dependent as common objects
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
	Stefan Hajnoczi <stefanha@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/19 03:06, Philippe Mathieu-Daudé wrote:
>> By the way, I was surprised to see TARGET_FMT_plx there, since I first
>> thought that this would be a target-specific define, too. But apparently
>> it is not. Very confusing. I'd suggest to rename that to HWADDR_FMT_plx
>> instead, what do you think?
> I'd rather use HWADDR_PRIx and slowly kill TARGET_FMT_plx...

Right, either that or rename it to HWADDR_PRI0x.

Paolo

