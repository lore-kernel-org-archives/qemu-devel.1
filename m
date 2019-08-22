Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDD8C3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554852173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554852173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0wIF-0003Gd-8I
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 19:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0wFI-0000EV-QO
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0wFH-0006U6-Qm
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:11:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0wFH-0006TR-Is
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:11:55 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A333D85550
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 23:11:54 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id q9so3915844wrc.12
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 16:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tp6E29Xulh5T3HhK6UTKnmiv1JjHwZhKttMpdhCOSEY=;
 b=UHY0BB4/L4lkIklUP3Uo5sCiTIP1IDxS0iCxPurnlhmRBOYAqu/IB4wqK8V13r1xlU
 h183tGp9tC8jLZH+o8lHX130wqYV6bgaCLIXo0sPGMbyG05IC+Ktmj3RLV0u666fnXo+
 v+pCKuYaVSpHyTlkYYJ8RXV+mlg6TzLNyk4MD1RHs4BIVaAobJWD94Ee+2zKdCTo50q5
 /zWjTsji/z+GZ6XL79jAvv5sCvTnWBdKcCq8M+OEqFfiZspvfXhLRCy1GT94Mt3vBtYi
 KDDNEzH/x/Jo2WjuTQUpC3tvJBKfXip193okThTUX7COoE83jXe1RpjhD+7waNTYbz5I
 1C+g==
X-Gm-Message-State: APjAAAURoJ7UqJ8/s1c8cJRNFwqI5dOAxX0ndA4YkkVvE65+MJ/Y2TWX
 /00eJlw/mFVR4du2YtGTh7y8gqnehrLp9lFzZXussyUVK140uXL9buu2uQHeMQ0LowNP0TcXHLe
 dFLy5HGu2Rv0zppw=
X-Received: by 2002:a1c:a70d:: with SMTP id q13mr1425424wme.26.1566515513281; 
 Thu, 22 Aug 2019 16:11:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy+Z1R+9XFpfcAdpBHfczyr/Xb59z476Pium03ZfQiDMTnWGw0QMVb8AM+RuAnNMREgCHdJZg==
X-Received: by 2002:a1c:a70d:: with SMTP id q13mr1425407wme.26.1566515512988; 
 Thu, 22 Aug 2019 16:11:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id 7sm645799wmj.46.2019.08.22.16.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 16:11:52 -0700 (PDT)
To: "Kinney, Michael D" <michael.d.kinney@intel.com>,
 Laszlo Ersek <lersek@redhat.com>, "rfc@edk2.groups.io" <rfc@edk2.groups.io>,
 "Yao, Jiewen" <jiewen.yao@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
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
 <7f2d2f1e-2dd8-6914-c55e-61067e06b142@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA218F@ORSMSX113.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3661c0c5-3da4-1453-a66a-3e4d4022e876@redhat.com>
Date: Fri, 23 Aug 2019 01:11:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <E92EE9817A31E24EB0585FDF735412F5B9DA218F@ORSMSX113.amr.corp.intel.com>
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

On 23/08/19 00:32, Kinney, Michael D wrote:
> Paolo,
> 
> It is my understanding that real HW hot plug uses the SDM defined
> methods.  Meaning the initial SMI is to 3000:8000 and they rebase
> to TSEG in the first SMI.  They must have chipset specific methods
> to protect 3000:8000 from DMA.

It would be great if you could check.

> Can we add a chipset feature to prevent DMA to 64KB range from
> 0x30000-0x3FFFF and the UEFI Memory Map and ACPI content can be
> updated so the Guest OS knows to not use that range for DMA?

If real hardware does it at the chipset level, we will probably use
Igor's suggestion of aliasing A-seg to 3000:0000.  Before starting the
new CPU, the SMI handler can prepare the SMBASE relocation trampoline at
A000:8000 and the hot-plugged CPU will find it at 3000:8000 when it
receives the initial SMI.  Because this is backed by RAM at
0xA0000-0xAFFFF, DMA cannot access it and would still go through to RAM
at 0x30000.

Paolo

