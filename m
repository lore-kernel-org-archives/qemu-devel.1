Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB7BC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F4D218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F4D218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hidTt-0000Jx-FP
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 07:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38298)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hidSW-0008Gk-Il
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hidSV-0001Mj-ND
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:29:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40095)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hidSV-0001L4-G4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:29:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so1967393wmj.5
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 04:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qy0oA8w3/FWmp1DcFDVFW9p44SopTtad/1vgoLVFAVg=;
 b=Z9+q0pkvLd0gDWNrxGPfO9GEoB5eg+69DViEgcVTxMj+eiLqgko2RhPyc8DcIKLk3h
 +8DkGYPDqxfeLbSWQ6c99YDX2u8IcLxGGwaQueNGcmxBaNWTIvIrhybqdK4cLiKkVqDY
 Q1AfvhVgSWAYutRLQTqf8NsSBHYuHSIKus1267eShLlzGd9Guxwr2XJiI9GWi9yMjrTt
 QWnzu5/ZP1c1Kx5c6Ycxbmt7K4VvV42Z4bfCRtUMgErXh0z4SHy2Ew2ojW3VhJaZ9szi
 tUnVL8VJSMy0VuS6sIbf+TPBVwjuJf5dsi6VU6F+kLIUb0f45YEKFuXnQ6c2mQldoZIx
 pPMQ==
X-Gm-Message-State: APjAAAWNtPbvlRMaxgrGYO3rLlHXsRvAx565wjycSaIfyW0UmhLuL6ty
 HKMDrJY9Q/bpgid2JrWmNxEEZQ==
X-Google-Smtp-Source: APXvYqwXnHQbY4GLRXnSKgeQzQC/15fngBr6HBu3xz0meStREJiQcnEmRvHcsoiSrf9dgeSJvBjFJw==
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr7807679wmj.155.1562153394113; 
 Wed, 03 Jul 2019 04:29:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6c1d:63cc:b81d:e1a9?
 ([2001:b07:6468:f312:6c1d:63cc:b81d:e1a9])
 by smtp.gmail.com with ESMTPSA id m9sm1946728wrn.92.2019.07.03.04.29.53
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 04:29:53 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20181206215026.7716-1-pbonzini@redhat.com>
 <20181206215026.7716-3-pbonzini@redhat.com>
 <34baad42-1ab8-ec81-467d-f62937656bc8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <633f51c0-b7c7-a512-e45b-1aaec6ca647c@redhat.com>
Date: Wed, 3 Jul 2019 13:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <34baad42-1ab8-ec81-467d-f62937656bc8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 2/2] test: replace gtester with a TAP driver
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
Cc: Auger Eric <eric.auger@redhat.com>, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/19 16:42, Philippe Mathieu-Daudé wrote:
> $ make check-qtest-x86_64 GTESTER_OPTIONS="-p /x86_64/acpi"
> 
> But this commit removed the use of $GTESTER_OPTIONS, however it is
> still documented:
> 
> $ make check-help
> [...]
> The variable SPEED can be set to control the gtester speed setting.
> Default options are -k and (for make V=1) --verbose; they can be
> changed with variable GTESTER_OPTIONS.
> 
> Is it possible to filter the tests to run with the TAP driver?

Yes, we can just add $GTESTER_OPTIONS to the invocation of the test
executables.

Paolo

