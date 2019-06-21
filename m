Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2982AC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006CD2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006CD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heNKS-0002EV-40
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 13:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57531)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1heNJb-0001lB-4N
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1heNJa-000177-AG
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:27:07 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:35587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1heNJa-00016b-4H
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:27:06 -0400
Received: by mail-wm1-f53.google.com with SMTP id c6so7387785wml.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 10:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VfqyU+KbqTGgpolVPr0RsNKQAz1L3XqhPqCO2ensIuw=;
 b=nsTfCKDzg1QBLRNtlxFHIkNRGlmO3ge3svDOi7Gx0JSCRj8srJXm5ihDsaur+J5jOM
 YuqCuOVSqS9iSURimbZW8zcnpJJ9RiVlSqp6gk9UCzul8+KaRlYYIohRE8Un4cYjQmVV
 z3Frf5Nx1y/ofZSt3mlw/rZoUFtQOXxQKRUlxSKWR5Xl2ovFRdOKoqAXOxIUMSTFqVEu
 vDZR3p9mqfrNWmLPU/JV2xI8F+bCrl1v5bVuahT1Zwd91FLb3DulQ1Mwjm98Na4mlGi6
 AF2xhgqmIPLpLdt9jLGZAzlm8aJJaXaLHGqNytGsy8zOlezY+IPJjC/GsgVYsAMdok/w
 aIJQ==
X-Gm-Message-State: APjAAAXRuhTDSHM37fzbju95z1bo5uAjtsMyUgXdTChGkRxrOb5ZFGHr
 pCy6HRSv0RV3plOc/7bR/oDkh4foQPo=
X-Google-Smtp-Source: APXvYqwHBazHFVklOADTu+3VC5OaJfp/OGOpjmYD7uo+SpzA5XGPxQy8JfbieFVQP+7Z18EdYpy7uw==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr5014387wmc.55.1561138024936; 
 Fri, 21 Jun 2019 10:27:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:45fb:a0de:928e:79e8?
 ([2001:b07:6468:f312:45fb:a0de:928e:79e8])
 by smtp.gmail.com with ESMTPSA id g5sm3525497wrp.29.2019.06.21.10.27.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 10:27:03 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-23-git-send-email-pbonzini@redhat.com>
 <96A3CC63-2B7D-44C2-AA9A-C02AF8FC3691@oracle.com>
 <150eb2f8-3b1a-e0ab-df36-adcbd601055d@redhat.com>
 <672D2B0A-E79C-467A-A9F0-57DC414842C3@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab9169bb-5254-c928-c5f0-59fc3a7cd6d2@redhat.com>
Date: Fri, 21 Jun 2019 19:27:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <672D2B0A-E79C-467A-A9F0-57DC414842C3@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.53
Subject: Re: [Qemu-devel] [PULL 22/25] target/i386: kvm: Add nested
 migration blocker only when kernel lacks required capabilities
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/06/19 17:07, Liran Alon wrote:
>> So, overall I prefer not to block migration.
> I’m not sure I agree.
> It is quite likely that vCPU is currently in guest-mode while you are migrating…
> A good hypervisor tries to maximise CPU time to be in guest-mode rather than host-mode. :)

True, but it is even more likely that they are not using KVM at all and
just happen to have the CPUID flag set. :)

Paolo

