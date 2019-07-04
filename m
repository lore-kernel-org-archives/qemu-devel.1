Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A0FC06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9EA21882
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9EA21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiyXB-0004FJ-9u
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 06:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40934)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hiyWP-0003q9-Ok
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hiyWO-0001nY-H9
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:59:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hiyWO-0001nB-BK
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:59:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so5445867wme.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 02:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ViFFkLn9HJ+2jcHiZ2/PsMU96iM3GlbhZ0Iy4+d3pBQ=;
 b=MupGaF/bpso+WtVPfjUbgmi4RCMWwNT1Of1nZ26IfRXlh19IwsStgh3cCGFPZFiGnY
 pYISkyH+7pfiVP7vKjnttSX+JtM4Z0tXNknLH9L0lLOzNWktV70TbyXRbBjObtNPs7yC
 GKppRXVf2DOgziyfLTqHEYR5iuPFQefBcN5ChKsc7G8mYzx1rd01BludymTVvm34fcTl
 QMGmS9cBVayscU7I8m3yLXAAWQLAna7bKo2JfeA43ZuQQSlMqDsWK2ekU+dOP8omoJXb
 KcD5aKu9EBd8lb8Jlv8MxUMrxQ2qU4EdOUZyjtXp3p1Bne3mkMo+5O1wexZ0HH5bYPe6
 h4/Q==
X-Gm-Message-State: APjAAAUioeIsRTkNeTV977z6F5xWmZPeb4Elp/LmDtT/xQ0FMAhAo7zQ
 Gn4X98FAUu1fxK+g2HA42Q7T4Ivb2RqQJg==
X-Google-Smtp-Source: APXvYqwv6X2vyl5fNYwHLZJKCI4OVQYGGvUqZNNKeWEyiYa/CYmLb7z/QWx1uy+BH9V68mIMusXU2w==
X-Received: by 2002:a1c:1d83:: with SMTP id d125mr11807477wmd.63.1562234359095; 
 Thu, 04 Jul 2019 02:59:19 -0700 (PDT)
Received: from [10.201.49.68] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id x129sm4626392wmg.44.2019.07.04.02.59.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 02:59:18 -0700 (PDT)
To: Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>
References: <cover.1550842915.git.berto@igalia.com>
 <20190423165501.GA27867@redhat.com>
 <b5fe7ed7-c11c-4f36-4973-c86031cbe046@redhat.com>
 <9a76848c-f499-6355-70ca-1d638dad3e8e@redhat.com>
 <1c1c3302-a87c-6e3e-d1d7-c805972a7384@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1d226f3-f80e-f764-01a7-c18fa79d2248@redhat.com>
Date: Thu, 4 Jul 2019 11:59:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1c1c3302-a87c-6e3e-d1d7-c805972a7384@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v3 0/3] char-socket: Fix race condition
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/07/19 19:51, Max Reitz wrote:
> On 05.06.19 21:36, Max Reitz wrote:
>> On 26.04.19 09:51, Paolo Bonzini wrote:
>>> On 23/04/19 18:55, Daniel P. Berrangé wrote:
>>>> ping - paolo/marc-andré - unless I'm missing something, it looks like
>>>> this chardev series slipped through the cracks and missed 4.0
>>>
>>> Yeah, it had a bug unfortunately.  I'm looking at it RSN.
>>
>> I’ll just leave another ping here

I haven't forgotten. :(

Paolo


