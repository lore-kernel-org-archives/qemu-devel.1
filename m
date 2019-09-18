Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AC2C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D46820640
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D46820640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAVAW-0000aB-JB
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 04:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iAV5I-0003DY-J5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iAV5G-0002IT-1F
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:13:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iAV5F-0002HY-PG
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:13:05 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8028B882F2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:13:04 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id d10so653931wmb.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 01:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aPyQL4w1PZhScek4hl/XTV0HmaJer4In9eOOtffnv2Q=;
 b=CXxN/E2LwbdWN3noueMd+BHZoqbIJZk1bXVFqeO1bf7sN19pffi2ckAIIF3kDQY+aB
 LZGJlOG10ysYp2Tr6CHYWOfKlzeU+M7vkcLC7//Q+l/tw4s2usGnGD0Qj9uAzvWZLg82
 RO+lr85TMrr/xU0At00ItbmjqLKqeY7qv+kKb30tN2lR8NxHY46XhxshH/iIn2Sfgf1K
 UHblWA1aBNfZRAXY26rI2c78OAG11fKWP/rXlykYNCmJxpF7hHyV12fFUT802/yWXhgU
 6YrakFTX1U5CM2EffEF04MXGtFhCHQkNf/BIVysUvUL/KsvHIH1jcNYFxIRl5mKmMG9s
 PfmA==
X-Gm-Message-State: APjAAAUR9dSkBVhkzbOhfu/le4RmEMaExOpXDb1Du1qIcNWjEY7qQL6S
 AVdAflhnmTyuSJ2+QoRPml8rHBPO18S+NxC1hCHAOyOlroqyJDqRmT2kWTbY9F6NSb4yi0vP0jf
 IUldRJowyV+wysdE=
X-Received: by 2002:a1c:a8d8:: with SMTP id r207mr1648807wme.135.1568794383185; 
 Wed, 18 Sep 2019 01:13:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzuT6wETknPmTI6aJv2WcdveW/S0J3Z5wLzd7SScICZobM5ZCj2Hcmi4xtdxBI7spl/ODGWgA==
X-Received: by 2002:a1c:a8d8:: with SMTP id r207mr1648789wme.135.1568794382931; 
 Wed, 18 Sep 2019 01:13:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c111:7acd:8e1e:ee6f?
 ([2001:b07:6468:f312:c111:7acd:8e1e:ee6f])
 by smtp.gmail.com with ESMTPSA id b16sm7574848wrh.5.2019.09.18.01.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2019 01:13:02 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190918052641.21300-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <847b6bd0-5e52-52db-a0db-36a031d4f1f2@redhat.com>
Date: Wed, 18 Sep 2019 10:13:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918052641.21300-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 0/3] Move notdirty handling to cputlb
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
Cc: alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/19 07:26, Richard Henderson wrote:
> RFC because this doesn't work, and I don't quite understand why.
> The only failing test is {i386,x86_64} pxe-test -- the other
> migration tests that use notdirty all pass.
> 
> Note that if you try to reproduce this on x86, you'll likely
> have to --disable-kvm, as otherwise the pxe-test will skip tcg.
> 
> Anyone who knows how this works willing to have a look?

I think patch 2 is doing too much.  Why don't you keep
memory_notdirty_write_prepare and memory_notdirty_write_complete at
first (so that the atomic path is completely unchanged wrt MMU lookup),
and then simplify that separately?  Maybe that shows what's going on.

Paolo

