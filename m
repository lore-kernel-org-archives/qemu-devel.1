Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1508AC73C68
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 05:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF76720838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 05:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF76720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl50H-0006KA-5s
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 01:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46798)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hl4yh-0005gu-Ql
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 01:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hl4yd-0007qW-0j
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 01:17:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hl4yc-0007h1-D6
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 01:17:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so915130wmj.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 22:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jvXgVgHwU5VN3XdGoyLLLJeBT/9qkkJah9Go9SvGdt8=;
 b=OOOyK7JnfaPZkvc4kFzGmLd48LlYxfbp8NaZkazo4ForiDQUTZPgZ7gowcEqmZSw14
 yYR1L5TfFUZMLtBmpU0NsMxYPOSgfjaHlcUEoDyYa/lZ7HzBbme7mR0iOjVgQrnFTqsZ
 NTBxtXwDqIIv8wxAnaboeCT8Uzs4d9UxeBMkve52tQ/0g9JkaRJRZtevH2tyoZJK9Pin
 Z8FrOhxCxYShNwCJwtkRHgFmiun5zkPcD8uWdjYjSafxkXw0Kjta6sCKsWkHYFn9fpZn
 jbmPXTrKOwRyEhjGJ2FhqI7LhmLpath5Pkcs4bEUOgWpEYmRLepnpv+irwisU5kM4K1K
 Jklw==
X-Gm-Message-State: APjAAAWfp7llS81EKNdOqMJgUwAUZlf6k2wILaiqRa5Bz1lCTIF4WSTz
 0bccD/1O5OIpBMpJ4nsUaYaixA==
X-Google-Smtp-Source: APXvYqzoCw5az67kO4lEGRhPP2/G8vGfAeKP5/m7r0FkoOzzocfB6KGv7GetvHUstthCLuaKpWlQHw==
X-Received: by 2002:a1c:c005:: with SMTP id q5mr3097838wmf.59.1562735823791;
 Tue, 09 Jul 2019 22:17:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423?
 ([2001:b07:6468:f312:19db:ad53:90ea:9423])
 by smtp.gmail.com with ESMTPSA id s10sm1000053wmf.8.2019.07.09.22.17.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 22:17:03 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190709143912.28905-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc709a38-b858-8611-986e-52be36696609@redhat.com>
Date: Wed, 10 Jul 2019 07:17:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709143912.28905-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH for-4.1] pl031: Correctly migrate state
 when using -rtc clock=host
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Russell King <rmk@armlinux.org.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/19 16:39, Peter Maydell wrote:
> Reported-by: Russell King <rmk@armlinux.org.uk>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I think this is correct, and it makes the "rtc clock should
> not stay still across a save/reload" work, but I feel like
> there might be some subtlety I've missed here. Review
> definitely needed...

Yes, this looks good.

Paolo

