Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6E4C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A275620882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A275620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRch-0003I0-24
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCRXF-0005U4-DR
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCRXD-0000Pf-E8
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:50:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCRXD-0000PR-84
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:49:59 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F2A958569
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:49:58 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id k67so5206260wmf.3
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hB3rJIYODev7wCmm5+mv5nMEUnLapHNMdIIbXxk3axo=;
 b=eEACXgnlekgRtrpBeJZfAlDjw5gxd4Z5snOtWsbY0wdcyLzRzWTrq7xY2qgHScg/8H
 6xD7CKaBSrPeqkMyi5sNyBv7dnMKL29L2QYs0GSJwhW5QBUT0pjT2hWS4aKlPvml1d0x
 nd2TkBCeObf0LQ0Jh0x2i0JYNTqTOYF96pcFozmaHq2Ff60fAznVZ59o21iRnk+WrqBT
 BQAVvYhA0x2sWqZT0cDyT4NH4CXTPEoqm9u1Zjer9yyWveQgoPPNcDpSMkramd+CpkK2
 YZXWmSHaakhxncc5uLefmoZ5eHSItLeS7Otvas/B/le4XfXWgmcD4wtqnrM0cgggd6g5
 MdVA==
X-Gm-Message-State: APjAAAXkBDWW/jKjqRFf7+1w1fTvfPm7UAS5Q8IG+hLR+kHDe+jJjstP
 oIrvNAxX4bHlMRx/WFIiZBWugR17P9o8ft2d6D2tWRXvE0yzg30GxlYhMefwZobfW3bPdf+F+v1
 Wo/gDy0oMKeodQn4=
X-Received: by 2002:a05:600c:1103:: with SMTP id b3mr458839wma.3.1569257397050; 
 Mon, 23 Sep 2019 09:49:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxyuzmXxu6Cr679WTck7epQ8hAG5q/n9ON5y41e0scpe2OGDPmUWHAxlAZ6tjDJytIlLwLgFA==
X-Received: by 2002:a05:600c:1103:: with SMTP id b3mr458824wma.3.1569257396825; 
 Mon, 23 Sep 2019 09:49:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id 207sm21575866wme.17.2019.09.23.09.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 09:49:56 -0700 (PDT)
Subject: Re: [PATCH v3 08/20] cputlb: Disable __always_inline__ without
 optimization
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-9-richard.henderson@linaro.org>
 <4c505d4b-751e-911d-4b2e-fe90a9d5ab02@redhat.com>
 <ce2f8cc3-a97a-b15f-2816-b85d66bc7c17@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <73c01ed0-607e-9412-b287-1aa30d8f081d@redhat.com>
Date: Mon, 23 Sep 2019 18:49:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ce2f8cc3-a97a-b15f-2816-b85d66bc7c17@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: alex.bennee@linaro.org, stefanha@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/19 18:00, Richard Henderson wrote:
> On 9/23/19 2:45 AM, Paolo Bonzini wrote:
>> On 22/09/19 05:54, Richard Henderson wrote:
>>> +/*
>>> + * Forced inlining may be desired to encourage constant propagation
>>> + * of function parameters.  However, it can also make debugging harder,
>>> + * so disable it for a non-optimizing build.
>>> + */
>>> +#if defined(__OPTIMIZE__) && __has_attribute(always_inline)
>>> +#define QEMU_ALWAYS_INLINE  __attribute__((always_inline))
>>
>> GCC doesn't have __has_attribute, does it?
> 
> It does, since at least gcc 5.  And now I realize that's only a reorganization
> of the support and not when it was introduced.

Hmm, still we support 4.8 and always_inline is much older than that.  So
I'm not sure it's useful to test it.

Paolo


