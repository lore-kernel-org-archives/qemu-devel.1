Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5874C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 17:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B0720657
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 17:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B0720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRKfO-000547-SQ
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 13:59:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hRKee-0004lA-Gl
	for qemu-devel@nongnu.org; Thu, 16 May 2019 13:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hRKed-0004o0-5B
	for qemu-devel@nongnu.org; Thu, 16 May 2019 13:58:56 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:33443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hRKec-0004Wr-VU
	for qemu-devel@nongnu.org; Thu, 16 May 2019 13:58:55 -0400
Received: by mail-pl1-f180.google.com with SMTP id y3so2014823plp.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 10:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vcEP3YYaimXYhcuON9isV+dxuxxa09vjqIJa1g5blY0=;
	b=g7dMVP8kyDO2HJBSa6O9jt7htMs9gDz0UwaNwEg5NeppPY9Ew8t2gbq4G+R8kyxjzf
	y1xFTNR7UVJ7PjkrN1K0aVskD04xvutT6xX4uUmbnLIriV1hyN/Ga1HpENBTC+4iERQA
	7+LUz9mHMeLiivr50NfcNE4WVwwga4nDLbWfQzMAe+mZPYcTc2ag7JTdZN3/gBXMomMu
	MsroKe9MFM9Yj4TVCCheQm4JfSNuD818wRiswMLGKHB8KjkSI3IW49b4UdW5vR/BJfnn
	dvzH0i9WIHYrcD/Fz+mORzDDiz1fvxBfha9H9Ypk1Ca2aP4+BRAQvuTA2yhhDlJGUqah
	lm1w==
X-Gm-Message-State: APjAAAVmOK69xKd909D5ue1nPiItoEiLuu2c0lLYG3XYOSB4mnwttJ3i
	4so0zF61tk7QbqJmeayn7Jq6GMWpvChQgw==
X-Google-Smtp-Source: APXvYqwPqqi8zUrN+LIcsWLrQgWO58BPCN+CxKjfM+sQNDdR24UhhSGbG86iT19+5CyioFmufaQK9A==
X-Received: by 2002:a17:902:8a81:: with SMTP id
	p1mr51870010plo.106.1558029508843; 
	Thu, 16 May 2019 10:58:28 -0700 (PDT)
Received: from [172.10.18.228] (24-113-124-115.wavecable.com. [24.113.124.115])
	by smtp.gmail.com with ESMTPSA id
	j184sm6400429pge.83.2019.05.16.10.58.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 10:58:27 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA95TtKvc0iy7UAKvBYSzj+=_WbRXug+E7MCStbOnst7_w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e16e40e3-8be4-698d-4fbf-0b3661e09531@redhat.com>
Date: Thu, 16 May 2019 19:58:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA95TtKvc0iy7UAKvBYSzj+=_WbRXug+E7MCStbOnst7_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.214.180
Subject: Re: [Qemu-devel] [PULL 00/21] Misc patches for 2019-05-15
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/05/19 14:14, Peter Maydell wrote:
>> Chen Zhang via Qemu-devel (1):
>>       hvf: Add missing break statement
> Hi -- looks like this commit needs its author
> email tidying up so it isn't attributed to the mailing list.

Oops, it's the first time I see this.  I'll fix and resend.

Paolo

