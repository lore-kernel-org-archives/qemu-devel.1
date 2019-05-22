Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62466C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39009217D4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39009217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39848 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTOWj-0002Q5-F1
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 06:31:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hTOVQ-0001jS-GG
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hTOVP-00059H-In
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:29:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hTOVP-00058Z-Cj
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:29:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id f204so1659043wme.0
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 03:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FIJ17jfOhg95N8FH17P449CIgHx99VfxRPbLIeRnIVw=;
	b=haJ44mSiTTSg3AC4LGMRjp5CuMzgZnDi9ZHIkvacVBqOdMsC0iB8FBe2usJqIN+ylr
	KiCSPci5XC3Y++3D9owAXi2984CBEnfRCZkDyu/6vsqkQuFPETeuckFyGiZx12z90mLw
	0gaHrNU7uQyHLqED50bgCM1uRGFzlXm2rC/KGNmk7J1INipFWn5Hl6L0UyNWu6XzgtPa
	lI65vtTKIG+Rj7Su0fNuIwb9/gaFG6Di6WnJdltkfEvuaPfFGELY0WxD0F4Qqz8EuHdN
	Y8w9kfyZ9T7gK91x/4ZznP8Hqfr0C9OPHE1WnbBKrzT/PeZ0z54ypwbtXU1ZpiGxgQqb
	HhBg==
X-Gm-Message-State: APjAAAW9NKsJeBtiJNSsSjJs97eNQD1vuecaTxr54pUII1F+pEsgHPTf
	F87EWK5UMzx7+DW5hrYOzfmXWQ==
X-Google-Smtp-Source: APXvYqynPS5UMMCQT+g0dIELP7726wnmy0u2E2xGgcd7y8qEWz63vZ0fvKwsypHRz6XG/dggP4i7iA==
X-Received: by 2002:a05:600c:254e:: with SMTP id
	e14mr6365781wma.70.1558520994382; 
	Wed, 22 May 2019 03:29:54 -0700 (PDT)
Received: from [10.32.181.147] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
	by smtp.gmail.com with ESMTPSA id
	a128sm5368403wma.23.2019.05.22.03.29.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 03:29:53 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1557813999-9175-1-git-send-email-wanpengli@tencent.com>
	<dcbf44c3-2fb9-02c0-79cc-c8a30373d35a@redhat.com>
	<20190520210525.GE10764@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ebc26122-d6a8-a3a0-1b42-aa2cc6522c2b@redhat.com>
Date: Wed, 22 May 2019 12:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520210525.GE10764@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] i386: Enable IA32_MISC_ENABLE MWAIT bit
 when exposing mwait/monitor
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
Cc: Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org,
	kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/19 23:05, Eduardo Habkost wrote:
> What if enable_cpu_pm is false but we're running TCG, or if
> enable_cpu_pm is true but we're not using -cpu host?
> 
> Shouldn't this be conditional on
>   (env->features[FEAT_1_ECX] & CPUID_EXT_MONITOR)
> instead?

Yes, it should.  I fixed it locally.

Paolo

