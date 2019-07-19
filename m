Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F53C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 22:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85352184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 22:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85352184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hobBA-0000YO-2A
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 18:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41073)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hobAw-00008z-4X
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 18:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hobAv-0008C9-53
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 18:16:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hobAu-0008BP-Ia
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 18:16:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so19926097wmc.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 15:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rcyEfyPfExdfSUdVmWQSM0W3jNRhHVhep0xtPe89yLw=;
 b=bmwipo5FmTPJDD9kx/2ppnzPU5xXgvq6b6XvQe/K4NTkXOUuYfHLnu++Jvvw/QQmYo
 BFhIUdL3ufYosls+GNrU/t4Afgmdg+mUeLkBtaz4fTSdfzcJ1ozZOHZd19MEfvuXS2OT
 Nze5dAGt/uuaRdZ9qVldZwa3NiKHWM79+9FvBqzclWBvOu4qm5VBd1zgKkpYziQcqJ6I
 u6EgIBgeq+ADUTQdi3xYtlfuNio7qOVzeKUPTyn8bmmnQXvATAaQ3lXfqlFLiZxKL8PP
 7GKEo2VntmAS03JdE+GH0jJlkBPFkv7ykRJopfiVMmNVdSMHRjqanr+v6kiQYOmEm/hB
 v8GA==
X-Gm-Message-State: APjAAAVJOwtxjBMpbrBttKW6noP5vtx53X4bALVxn9E/owrX6L3mqeyI
 htqcP1nTYPqmS3Ph30TdEiusew==
X-Google-Smtp-Source: APXvYqxZuTERhrnG11n1EGl3MFQXPXS0dWX/WYLuMkigAymD82hRcBgZLuHSneVx+5nU0zPGDO24cg==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr6685060wmm.62.1563574582976; 
 Fri, 19 Jul 2019 15:16:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8?
 ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id k17sm34812701wrq.83.2019.07.19.15.16.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 15:16:22 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190718134537.22356-1-den@openvz.org>
 <20190719205358.GB26800@habkost.net>
 <9583f8ad-67c8-d351-3763-4ede9fbf4acc@redhat.com>
 <20190719220550.GC26800@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2993221f-173e-490c-c556-778b627543e8@redhat.com>
Date: Sat, 20 Jul 2019 00:16:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719220550.GC26800@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
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
 "Denis V. Lunev" <den@openvz.org>, Jiri Denemark <jdenemar@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/07/19 00:05, Eduardo Habkost wrote:
>> Actually KVM does not mark it as supported:
>>
>>         const u32 kvm_cpuid_7_0_ebx_x86_features =
>>                 F(FSGSBASE) | F(BMI1) | F(HLE) | F(AVX2) | F(SMEP) |
>>                 F(BMI2) | F(ERMS) | f_invpcid | F(RTM) | f_mpx | F(RDSEED) |
>>                 F(ADX) | F(SMAP) | F(AVX512IFMA) | F(AVX512F) | F(AVX512PF) |
>>                 F(AVX512ER) | F(AVX512CD) | F(CLFLUSHOPT) | F(CLWB) | F(AVX512DQ) |
>>                 F(SHA_NI) | F(AVX512BW) | F(AVX512VL) | f_intel_pt;
> We can still add the feature name if we also set it on
> .unmigratable_features, but I don't see why it would be useful.
> Is anybody working to support exposing RDT-M to guests?

I don't think so.

Paolo

