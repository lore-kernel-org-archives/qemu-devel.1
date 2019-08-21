Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69ACC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB999214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB999214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VXG-0006IJ-EA
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UaU-0005Hq-Qg
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UaT-000295-Pv
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:39:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58008)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UaT-00027A-Hi
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:39:57 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5A2F5AFE9
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:39:55 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id r1so1474489wmr.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3fIbpvs6SbC2YcldVU0fUEsoUNj38bm721AqOi/WasY=;
 b=fxYm3txxr+P/URNuiWFmyUfP1GkDY2eVzvLbh/LKETu4K9rpQriDGOi0JP4cab4uWT
 xjnX1wxrU/1o9OjcBroSnI/2SzQpcsNjXKckCIZvDhEE0ao6Axmnlo08cUKkrp3OTP92
 gPOvn+xXW2+7OKTDLTh9RW+5QqVaWv18ybwWCHjDHxWz7jBmoggmzGtQn019GDtTLvY9
 XETYH0P8Fn4Ze8fSQ7FqMRM/2ZRfjLfHox2LVJmZE6tUsPsFXyTcvWNfZUY4G/cr3/1p
 wVStJ0XnuhQVs7jKO80rNOn6cj33PnllqxqJPL00LFK/EBu8sQSjWFzP1EVE6Yh4jyNL
 WdxA==
X-Gm-Message-State: APjAAAU5sg0Tpi2YqNtp61vECzC7QGxGKj6J7fx8C3+ggPeZ2h5WEpCx
 xhHWboG8mELOCmTowuXsAp0Q2CdrsTckKGecwD/DZ/iSSDGqG3OCHDqH/6CNXAj3RL2z0jjUA0r
 qZXSSCrCJ/89FdMI=
X-Received: by 2002:a1c:cb01:: with SMTP id b1mr1356236wmg.69.1566409194575;
 Wed, 21 Aug 2019 10:39:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwOlsiuoI8bDDbDdjGjhf3ZCdr2vxHB6S5LHFmsN/e4KHtKJvvUqplimeFuI/HyjgvFW2dbLg==
X-Received: by 2002:a1c:cb01:: with SMTP id b1mr1356216wmg.69.1566409194282;
 Wed, 21 Aug 2019 10:39:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id l5sm390331wmj.4.2019.08.21.10.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 10:39:53 -0700 (PDT)
To: "Kinney, Michael D" <michael.d.kinney@intel.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>, "Yao, Jiewen"
 <jiewen.yao@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
 <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
 <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
 <20190816161933.7d30a881@x1.home>
 <74D8A39837DF1E4DA445A8C0B3885C503F761B96@shsmsx102.ccr.corp.intel.com>
 <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
 <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9C671@ORSMSX113.amr.corp.intel.com>
 <a76014e2-2f0a-afce-6d15-1c45c5c1e467@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9D74A@ORSMSX113.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <adf3f3b8-1dc9-79e1-7411-4d9131657a1f@redhat.com>
Date: Wed, 21 Aug 2019 19:39:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <E92EE9817A31E24EB0585FDF735412F5B9D9D74A@ORSMSX113.amr.corp.intel.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [edk2-rfc] [edk2-devel] CPU hotplug using SMM with
 QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Laszlo Ersek <lersek@redhat.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/19 19:25, Kinney, Michael D wrote:
> Could we have an initial SMBASE that is within TSEG.
> 
> If we bring in hot plug CPUs one at a time, then initial
> SMBASE in TSEG can reprogram the SMBASE to the correct 
> value for that CPU.
> 
> Can we add a register to the hot plug controller that
> allows the BSP to set the initial SMBASE value for 
> a hot added CPU?  The default can be 3000:8000 for
> compatibility.
> 
> Another idea is when the SMI handler runs for a hot add
> CPU event, the SMM monarch programs the hot plug controller
> register with the SMBASE to use for the CPU that is being
> added.  As each CPU is added, a different SMBASE value can
> be programmed by the SMM Monarch.

Yes, all of these would work.  Again, I'm interested in having something
that has a hope of being implemented in real hardware.

Another, far easier to implement possibility could be a lockable MSR
(could be the existing MSR_SMM_FEATURE_CONTROL) that allows programming
the SMBASE outside SMM.  It would be nice if such a bit could be defined
by Intel.

Paolo

