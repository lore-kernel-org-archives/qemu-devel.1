Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621EDC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F0E218EA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F0E218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqxdP-0004AL-Aj
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 06:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56166)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqxdC-0003lB-2Y
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqxd7-0004b9-2D
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:39:20 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqxd6-0004LK-Qq
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:39:16 -0400
Received: by mail-wm1-f52.google.com with SMTP id 207so47602504wma.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 03:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rOz9vd5bQ8csDJcR9DambSHLy1SbYwjYJbDKArh43Xg=;
 b=B6ZlK+ALu7g7NDgUBDxNwZ5FTFU0Ge2oGyWQMgtTVuX3hR0JNKrpmc4svuBVWBI3wm
 F/7MxxyEFfcvDF9bE9ht2i6sgxibdcBvTBsGf7vSN/bwJOcMqCU4Pr6jez2NSJ4vmsAg
 M9rs7ptOiTFg4k8/a0Kktdj5IlJrPIB0ayKmug4F6hRTCzq2dLUYcQqduNndFX/4KTqQ
 F1+aruz2Eo7m1KclXqeJHtJKDqubpVqFplG7PUAnL0ss7IwDVV8ttbUZEl83qkwQcc9y
 yvh3j5DPSImK5vek6CFJftCtIqdDr/wcc3+a5e+8UJ3LkzYFLeHfs1HIOGWlaYUxAowG
 6rEg==
X-Gm-Message-State: APjAAAVRStzovTSGn0QtVFo4GjYp9DORbPNDCu7/FM7/UG0wmySCoZfu
 j5T6rJ5O9gpRo4KzC8ktCTauow==
X-Google-Smtp-Source: APXvYqySqBsFwi1qD2SQ94MLlt8IU6yX/TidKoQLMGQ+X5dzMVFDwUIIAig3fOQXDF1s7f3o7d66MA==
X-Received: by 2002:a05:600c:20ca:: with SMTP id
 y10mr52433565wmm.72.1564137552685; 
 Fri, 26 Jul 2019 03:39:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id h8sm53629339wmf.12.2019.07.26.03.39.11
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 03:39:11 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-5-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5f030ef4-2cca-4f28-cdb2-20924cd2ad6e@redhat.com>
Date: Fri, 26 Jul 2019 12:39:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725032321.12721-5-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.52
Subject: Re: [Qemu-devel] [RFC 04/19] fuzz: Add qos support to fuzz targets
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 05:23, Oleinik, Alexander wrote:
> qos_helpers.c is largely a copy of tests/qos-test.c
> 
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  tests/fuzz/qos_fuzz.c    |  63 +++++++++
>  tests/fuzz/qos_fuzz.h    |  29 ++++
>  tests/fuzz/qos_helpers.c | 295 +++++++++++++++++++++++++++++++++++++++
>  tests/fuzz/qos_helpers.h |  17 +++
>  4 files changed, 404 insertions(+)
>  create mode 100644 tests/fuzz/qos_fuzz.c
>  create mode 100644 tests/fuzz/qos_fuzz.h
>  create mode 100644 tests/fuzz/qos_helpers.c
>  create mode 100644 tests/fuzz/qos_helpers.h

If there are functions that are exactly the same, please move them to a
new file that is shared by qos-test.c and the fuzzing driver.  Other
functions can stay in qos_fuzz.c.

Paolo

