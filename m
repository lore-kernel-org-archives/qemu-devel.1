Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3145BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE6B2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE6B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0s6B-0006Fl-5E
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 14:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0s3e-0005E6-85
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0s3b-0004Bv-DG
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:43:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0s3Z-0004AV-CL
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:43:35 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A206686668
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 18:43:30 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id o13so3576790wrx.20
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 11:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P+iZ7eff/mtxbw5SeFKvX0vAId/eNH1mdIuXWMYiyvs=;
 b=jgVfZFvikPyaFlriMdenz78AXNEhacRn0GKXqYlGmOuZ/w5fojzQX97WSkjG1YL9nZ
 IeaNGPwQ5MCaeG8+KBsstaG/J0REODdm1llY7BmUbiRQbbmOZfhSgQlejdHUNDR91Br1
 LKeqN//WZFhgl9L+ovsHtLDhO0BDRKBOPs4woDitZFcZlZUFpcRuxx4XAb8siT6XrLJy
 G4icyUsQmmw/rNtnNWiqOOuw3AEHkyN4o2kPx5lrD/Gu2dfDuRFJSbJKRx2mqr5GV7Be
 cXEEmjxDbNM1E6vrfWVx9ASR/aSRiO2S6fz+J2Ip+DvR/BAWq+QrdhCiBmZYvRuZFnyv
 f8EA==
X-Gm-Message-State: APjAAAXsRT3LnbwVqPvaVZydvXWsXEeMOUuuyav+Gd+BwfwPYx+QE+Ls
 MXv8S9Hhwmzgy7SzRc1KnypJ1ecQFBRvYofGAthIRVDPaotgjhs+jGNOrviGvyhwTiZiEaybF6h
 pTaEoK2F+a1grnKo=
X-Received: by 2002:a7b:c632:: with SMTP id p18mr558826wmk.114.1566499409370; 
 Thu, 22 Aug 2019 11:43:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyY//0n+OyqaS9jehP4Z7m/rrqvZlbbBa2mENX4WQfuwPEqhY/3CSABhoecKbKBME9DdlYJUA==
X-Received: by 2002:a7b:c632:: with SMTP id p18mr558760wmk.114.1566499408786; 
 Thu, 22 Aug 2019 11:43:28 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id w13sm974366wre.44.2019.08.22.11.43.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 11:43:28 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>,
 "Kinney, Michael D" <michael.d.kinney@intel.com>,
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
 <b3907432-b149-3f96-6d93-f443f215e0f8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2b4ba607-f0e3-efee-6712-6dcef129b310@redhat.com>
Date: Thu, 22 Aug 2019 20:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b3907432-b149-3f96-6d93-f443f215e0f8@redhat.com>
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
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/08/19 19:59, Laszlo Ersek wrote:
> The firmware and QEMU could agree on a formula, which would compute the
> CPU-specific SMBASE from a value pre-programmed by the firmware, and the
> initial APIC ID of the hot-added CPU.
> 
> Yes, it would duplicate code -- the calculation -- between QEMU and
> edk2. While that's not optimal, it wouldn't be a first.

No, that would be unmaintainable.  The best solution to me seems to be
to make SMBASE programmable from non-SMM code if some special conditions
hold.  Michael, would it be possible to get in contact with the Intel
architects?

Paolo

