Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B213C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2FD21A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2FD21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDReF-00043w-Go
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDRbb-0000jU-7F
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDRba-0003ge-CH
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:06:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDRba-0003gQ-6W
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:06:38 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3CC2D796E0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:06:37 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id w10so790308wrl.5
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 04:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PkMGqgYWt3Gf7eQ05dGXIl/v6GZPje6Xp/gtekkLkt0=;
 b=JVT6RXwI2I+5zlEkXupa0xf0gYExm3MBezENVX/djeuFYf81yqJ3u0SSjubFpFzRqM
 ZSmL1xu+p9xvRbPDJCfLFzbaMiWFatmRNW8V7T5y9IBUg8OumQAO1oorMNZM+jBm7Xbp
 tssJQWD4uD18QHdB+Sm6vYUlhjgz4dMWdlh1sT5YDdlGDPas1aZgZvin3TojX0ZUK9e6
 cD/z6PnLxKKLbULHvUYjoFls85NCFmkc3Wn8IHfNTkeJ1HHJsmt0HTMRIhEF/X3GnDqC
 BRMhySZxvAIhoqGQdGiqpiAMuedMcf22bf7yXzAnnLNFwwC6jUiwWaSEFFyKpN06jxgS
 Wnhg==
X-Gm-Message-State: APjAAAWweUA/mYZwy4Erf9mjG5vDkPhqGzlTXUzZZ73ujjfpcq0Vk5jV
 8CEbdWW0C5oF+/JUlvD587gpSPclBF3dW3nKTa8Pfg31zu1LuElrXSJ20iDDYfj8/E7K9T22Erc
 bT9QlUptfXJPzG5M=
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr2401742wmc.175.1569495995906; 
 Thu, 26 Sep 2019 04:06:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQrGxIgH3fh5wU6G2A9z5I2GCLVFkwBrGl8q4783w1TwX+r7lNJl9jUizu6Q0Rj7vGt/zDxQ==
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr2401717wmc.175.1569495995617; 
 Thu, 26 Sep 2019 04:06:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id l18sm2052337wrc.18.2019.09.26.04.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 04:06:34 -0700 (PDT)
Subject: Re: [PATCH] i386: Add CPUID bit for CLZERO and XSAVEERPTR
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, qemu-devel@nongnu.org
References: <20190925214948.22212-1-bigeasy@linutronix.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ae0c4623-5b1f-ae6b-2062-12b13ecc7a77@redhat.com>
Date: Thu, 26 Sep 2019 13:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925214948.22212-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/19 23:49, Sebastian Andrzej Siewior wrote:
>  #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
>  
> +#define CPUD_800_008_EBX_CLZERO		(1U << 0) /* CLZERO instruction */
> +#define CPUD_800_008_EBX_XSAVEERPTR	(1U << 2) /* Always save/restore FP error pointers */
>  #define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and

Well, there are obvious typos here but I can fix them for you.

Which processors have these?

Paolo

