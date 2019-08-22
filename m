Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37912C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BA920578
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BA920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0vQG-0000iU-32
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 18:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0vPJ-0008SJ-Sk
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0vPI-00073f-4H
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:18:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0vPH-00072i-St
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:18:12 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9CCBB4E938
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 22:18:10 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id i4so3854357wri.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 15:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QaO7NdHQ77RlOZ6kzZ/1LkWPRELaT1fBysCQIepNC8U=;
 b=I04U/8Nfitf6Wz13DCxa8Fjh2r95xqrCL6xMRjFi1thW6SLMvCWHDEZsyfKzDcmvZA
 Rk7uNjSlI87NnNYdmYlHwBXFzFpWdcF3F7qUP7zWqNh5KeKgeRvNCBLFa/r0czNROlt7
 c3nCQJpjFqKsPttccBtwT0Y7/hTQJUPvDmV9HxLnycIDgURLA1/n7XqAGyEDjJZCtQup
 Iq7qMF1R+g/3OMinVOXyA18CsKEDb4NuRgaia5n4zjMBTRNp5wjwh2lu/AfppgkPEmGO
 LrPki8kQ2fnIuHZ98tN2SBuMZtad8JGQwS72+F0+0LhtXjNLrjTo+VXdzS30s8/Ja9Qg
 VYMw==
X-Gm-Message-State: APjAAAXGXLvBsae2kZsnjutyFZ56RAKw6HfcSimomxvzwe093Gmg+8jl
 BWAlcm3wjPwUQ7e458XT806F+ApP1wrUhoVRSCe28EkQteY0sUt4sTfKVkJa9iNyXRoL2H54aha
 JoPAiXH7an1aa6Ng=
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr1030361wrn.223.1566512289197; 
 Thu, 22 Aug 2019 15:18:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMOWDiTSDYe466QR5DyNqUv8ky8sswqRt8k2Bh0l1WKkn/nn3vWbvXHCukrbBBCV1l1j8EIA==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr1030335wrn.223.1566512288816; 
 Thu, 22 Aug 2019 15:18:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id o11sm836721wrw.19.2019.08.22.15.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 15:18:08 -0700 (PDT)
To: "Kinney, Michael D" <michael.d.kinney@intel.com>,
 Laszlo Ersek <lersek@redhat.com>, "rfc@edk2.groups.io" <rfc@edk2.groups.io>,
 "Yao, Jiewen" <jiewen.yao@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
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
 <b3907432-b149-3f96-6d93-f443f215e0f8@redhat.com>
 <2b4ba607-f0e3-efee-6712-6dcef129b310@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA209B@ORSMSX113.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7f2d2f1e-2dd8-6914-c55e-61067e06b142@redhat.com>
Date: Fri, 23 Aug 2019 00:18:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <E92EE9817A31E24EB0585FDF735412F5B9DA209B@ORSMSX113.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
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
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/08/19 22:06, Kinney, Michael D wrote:
> The SMBASE register is internal and cannot be directly accessed 
> by any CPU.  There is an SMBASE field that is member of the SMM Save
> State area and can only be modified from SMM and requires the
> execution of an RSM instruction from SMM for the SMBASE register to
> be updated from the current SMBASE field value.  The new SMBASE
> register value is only used on the next SMI.

Actually there is also an SMBASE MSR, even though in current silicon
it's read-only and its use is theoretically limited to SMM-transfer
monitors.  If that MSR could be made accessible somehow outside SMM,
that would be great.

> Once all the CPUs have been initialized for SMM, the CPUs that are not needed
> can be hot removed.  As noted above, the SMBASE value does not change on
> an INIT.  So as long as the hot add operation does not do a RESET, the
> SMBASE value must be preserved.

IIRC, hot-remove + hot-add will unplugs/plugs a completely different CPU.

> Another idea is to emulate this behavior.  If the hot plug controller
> provide registers (only accessible from SMM) to assign the SMBASE address
> for every CPU.  When a CPU is hot added, QEMU can set the internal SMBASE
> register value from the hot plug controller register value.  If the SMM
> Monarch sends an INIT or an SMI from the Local APIC to the hot added CPU,
> then the SMBASE register should not be modified and the CPU starts execution
> within TSEG the first time it receives an SMI.

Yes, this would work.  But again---if the issue is real on current
hardware too, I'd rather have a matching solution for virtual platforms.

If the current hardware for example remembers INIT-preserved across
hot-remove/hot-add, we could emulate that.

I guess the fundamental question is: how do bare metal platforms avoid
this issue, or plan to avoid this issue?  Once we know that, we can use
that information to find a way to implement it in KVM.  Only if it is
impossible we'll have a different strategy that is specific to our platform.

Paolo

> Jiewen and I can collect specific questions on this topic and continue
> the discussion here.  For example, I do not think there is any method
> other than what I referenced above to program the SMBASE register, but
> I can ask if there are any other methods.


