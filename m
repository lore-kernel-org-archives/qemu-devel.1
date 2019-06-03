Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7F8C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CAD26E3F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQoDAiUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CAD26E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37603 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXpfS-0004Yk-Hi
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 12:18:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXpe0-0003ta-Ib
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXpdz-0005A1-FP
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:17:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXpdy-00058a-UB
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:17:07 -0400
Received: by mail-ot1-x343.google.com with SMTP id z23so1639435ote.13
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 09:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=yeIhDOPsG99ONO9KZnGPuCdQaDb2UvVW9P/MfsAktWc=;
	b=LQoDAiUfrQOAym9U9Z8JLOeRhAHO3Sv2fnowOyffT238rVsKzK/KuU9blYbCDW29oq
	HUfpIpnuMtbe/I1yIAfUWlkKJIlr0JeV5KKUB6LijTiLHZgirTWlvo4BWAlU4+HlveyZ
	jjUT9QoTgw+RIJyVlA3hXJ3IdJ8tt5S4UIfCVDQWs0NSXipziEeIcb5wWI2WSEmDl2as
	0Y9AzXUxe6GMIjRJEnUwTI8ocgTLE+QT1UDezASZkPoJgDifr5Ug0j8FTlKNXs8wONJy
	F6X+fT+Kk9/ovk7eI9bMOWFs90OAjWq9waTWxTCQKEGYXRy95hg5ne2/VHm55Q8PuCUR
	PP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=yeIhDOPsG99ONO9KZnGPuCdQaDb2UvVW9P/MfsAktWc=;
	b=OSAuaoGY7R7XBEEMVvdYwW5TGtxxQU1L9Fb5dYIWzdv1cKzfbvg+CA9CcrvIRUf3lK
	8f8LTnhg7ECg4T4WqZYumhzDtcoV3WzMtSpPAv4Exj8rNvnercAVWZe2/H5EADonAL2q
	SHcSubXJQiTHIBI1eFKv2AHBtai93jqLSUEvXrWSOOX05jZ664SfMbHRXq8hW9yWA6WB
	vT3ni0J/YmvxdANEzd/1l75c3YVNYTV/Wm4yDd5rlyeVHtEAgZwGc0DoQk0KEPWmIvfx
	PFzvXVMq2ahzT0S0PJdy9O6roAnhhuKC518b1GRFlM1XOQlqbu9Qg9b8SoZKci5okopz
	nmuA==
X-Gm-Message-State: APjAAAWH4kUluG0hggCucmtjtg62bNdZsScC3quJOer1jWMGWSUSl5Sf
	2JA/fWVaeOJtBa93dzLfqdQtY3dghsZCZA==
X-Google-Smtp-Source: APXvYqyc3VtSiXEXJ2jKuUdGAKjW32oZHeNUXLC4Rpov6pbiG9AmUErolRQFZkRauDT3KCsRBop7pA==
X-Received: by 2002:a05:6830:1c5:: with SMTP id
	r5mr1644887ota.89.1559578626330; 
	Mon, 03 Jun 2019 09:17:06 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.gmail.com with ESMTPSA id
	x20sm5409878ote.18.2019.06.03.09.17.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 09:17:05 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190603090635.10631-1-david@redhat.com>
	<20190603090635.10631-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e1dc09eb-632d-e3ff-849d-da0b3b637164@linaro.org>
Date: Mon, 3 Jun 2019 11:17:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603090635.10631-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 03/22] s390x/tcg: Export
 float_comp_to_cc() and float(32|64|128)_dcmask()
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
Cc: Thomas Huth <thuth@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, Pino Toscano <ptoscano@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 4:06 AM, David Hildenbrand wrote:
> Vector floating-point instructions will require these functions, so
> allow to use them from other files.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/fpu_helper.c | 4 ++--
>  target/s390x/internal.h   | 4 ++++
>  2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


