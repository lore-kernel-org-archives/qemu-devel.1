Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1994AC3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D984720835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D984720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKwk-0001F2-VZ
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCKv0-0000Qw-6h
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCKuy-0001VS-7M
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:46:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCKuy-0001V6-1d
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:46:04 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 614D73C919
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:46:02 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id g82so6393047wmg.9
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 02:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QFu/bTVL3SJn7ltW2jYs1d3S6PVJ5qBf5P97DKsYMok=;
 b=XDcP67cDw6+4QNNq+wAjl73dLR2M1Jdabx64EJNnWLQQDSyZbmp+q3Yk8GFSZN8B3M
 ahZm3v5GEGWstdtkOuXY5U1Ka89TQJVnH6Pw1Nj3oHXOluZTrd5myUEEyldK4dKqgUcZ
 gzDr7w8KKKtssdm2Xcs/XKkFrfUgYdDDHWSbLeWkstQTQQVLcJw5SkYeqdsLh7ns0s8m
 L8zCYabxxS/rerMgQhH3mhadkdSXcDP6NxBMJm7JLbdTHRDVpCT66jp0bzD31QlxAnD2
 VLXqUEqWnDQcXQ5mb3GOMlAm4Ch+SrTsSFSV8+kz0COdGbpnvgMVeP2GZhH4nm1gmv7R
 m6GQ==
X-Gm-Message-State: APjAAAXyPcwFpPaAa0kenTdzjIhk64OVALkSjP1ZMmCZnxXBNoql/CKV
 p2c4CiNErRE+c1d0ZqEP5lOQGqDonsbubEc5VlrFFaTwDBOoCw89xKSYMz/W1O0cf3mTg+7kJgJ
 qjZ/b000u78dm0N8=
X-Received: by 2002:adf:e388:: with SMTP id e8mr20894773wrm.306.1569231961114; 
 Mon, 23 Sep 2019 02:46:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxomtePVyxX704Sac5CXz5JZPojGuJzuo0KkJE2XL3utUxI1M+CU6sIza8ESyRlWYC3wmKnww==
X-Received: by 2002:adf:e388:: with SMTP id e8mr20894753wrm.306.1569231960798; 
 Mon, 23 Sep 2019 02:46:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id u25sm8991153wml.4.2019.09.23.02.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 02:46:00 -0700 (PDT)
Subject: Re: [PATCH v3 08/20] cputlb: Disable __always_inline__ without
 optimization
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-9-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4c505d4b-751e-911d-4b2e-fe90a9d5ab02@redhat.com>
Date: Mon, 23 Sep 2019 11:45:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190922035458.14879-9-richard.henderson@linaro.org>
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

On 22/09/19 05:54, Richard Henderson wrote:
> +/*
> + * Forced inlining may be desired to encourage constant propagation
> + * of function parameters.  However, it can also make debugging harder,
> + * so disable it for a non-optimizing build.
> + */
> +#if defined(__OPTIMIZE__) && __has_attribute(always_inline)
> +#define QEMU_ALWAYS_INLINE  __attribute__((always_inline))

GCC doesn't have __has_attribute, does it?  I think you can just assume
that it exists and #ifdef __OPTIMIZE__.

Paolo

> +#else
> +#define QEMU_ALWAYS_INLINE


