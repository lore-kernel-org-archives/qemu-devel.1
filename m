Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF28AC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B3B2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B3B2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoagl-0005CD-O6
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36026)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hoaga-0004lH-AU
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hoagZ-0008Bp-Cz
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:45:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hoagY-00089I-J8
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:45:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so24541192wmd.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/KCHaPpnJcx02Awq6EXFPpxo9UvBPtyKp3OVEHIDIqc=;
 b=I158zW2JK27Zz4UsL4f1noq1+ceED+vJNAkK3Atq8O3r5r30GRKCjXb4tuBfk08WOj
 wBF0n3NNreG8Ut54uCPHkFDZllDh4Ic6D3TKs6FwCn/eRRK0e7ycAlDJ49Xvzsz2W8HN
 3Hrx1NHsmdSXinWavy/2PxzISIsSCxcGiDo66ZE+Hfj8NdUpjauMCLQV3K8xd2X/LY4x
 /8mHO3TpKvtFu49I3hx4Yv/h6EqXTALqU4XJJtA/GH5x4Ic8FvJcKMxh2tABIlu87vlY
 4oZEStlogzBNJgeEUeI83GgE+EVGj5irzmsimxslfWQ3lxEzuQBmFAF3fXerebx/W/qi
 TakQ==
X-Gm-Message-State: APjAAAWz0uOghzh+kxuFrMA9bToL36WyRgA/Xkikz+/TERrIviE05Jvj
 w39D4xT9jnhNbVDyhRYCTTWkjA==
X-Google-Smtp-Source: APXvYqzufrER7QQxn4ZXRRJOxKVIabprLMv9umCKkG3xDIuir0mxSgxdWagmt05U8k2ATJ7Crg+3/A==
X-Received: by 2002:a05:600c:21d4:: with SMTP id
 x20mr45574484wmj.61.1563572699337; 
 Fri, 19 Jul 2019 14:44:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8?
 ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id y6sm25596931wrp.12.2019.07.19.14.44.58
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 14:44:58 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, "Denis V. Lunev" <den@openvz.org>
References: <20190718134537.22356-1-den@openvz.org>
 <20190719205358.GB26800@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9583f8ad-67c8-d351-3763-4ede9fbf4acc@redhat.com>
Date: Fri, 19 Jul 2019 23:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719205358.GB26800@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 1/1] x86: add CPU flags supported inside
 libvirt
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
Cc: Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/07/19 22:53, Eduardo Habkost wrote:
> This is one is named "cqm" on Linux (X86_FEATURE_CQM).  I prefer
> to keep consistency with the name already in use by Linux than
> the one in libvirt that was never used.
> 
> You can still add a "cmt" alias property if you think it would be
> useful.

Actually KVM does not mark it as supported:

        const u32 kvm_cpuid_7_0_ebx_x86_features =
                F(FSGSBASE) | F(BMI1) | F(HLE) | F(AVX2) | F(SMEP) |
                F(BMI2) | F(ERMS) | f_invpcid | F(RTM) | f_mpx | F(RDSEED) |
                F(ADX) | F(SMAP) | F(AVX512IFMA) | F(AVX512F) | F(AVX512PF) |
                F(AVX512ER) | F(AVX512CD) | F(CLFLUSHOPT) | F(CLWB) | F(AVX512DQ) |
                F(SHA_NI) | F(AVX512BW) | F(AVX512VL) | f_intel_pt;

Paolo

