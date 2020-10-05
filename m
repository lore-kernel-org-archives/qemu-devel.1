Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0ADC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD3A2075A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxLYpJY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD3A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPOA4-0004Yf-6m
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPO7D-0001da-8h
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPO7A-0001eC-P2
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601895187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbiHNjQke6HODK9Aq4q/LEwhaKtx/GjpAuwA6iwInj8=;
 b=GxLYpJY3LVYVld/qE2/5OZh/7QF0TlOGnH4KznP8UTKMtLpknVN89MuZ9B10huygDUzrDS
 /chFKEmJIadrzq6s5ErDEPURt6knOWUviM3AI3mT8B4xCrU6Kdqr1k3HO3QiQyGbRNfS34
 FP2SQaGt/SKtCc+VHXlgOR5hF8FtAj0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-B7OiFN1-MXOshFMUkMQpXw-1; Mon, 05 Oct 2020 06:53:05 -0400
X-MC-Unique: B7OiFN1-MXOshFMUkMQpXw-1
Received: by mail-wr1-f71.google.com with SMTP id i10so3833823wrq.5
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 03:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kbiHNjQke6HODK9Aq4q/LEwhaKtx/GjpAuwA6iwInj8=;
 b=LCfZNaPoztGBYy0LpSaHd23vhEmcXyLUXzJjXv3whfV3F9FJA/l89zVH/U0DhZdXIi
 1l+r3tt+8cR7eHm3a/oxexOA/glB/5Lpm23Pgk2gVNLYXr7PIS9RdHTWaGcryKyr8Mu5
 OGm0LFYDHoddWlPb++ApAQiY76664eaqtZJvUKJ3tNTPP0deDuFnQKjh4vC/lmZHpuQY
 lZCOWRbTSd6z1DGpxmaIhBwO3PWIv+KXeHCT98S42pUknA32N81Pb/UI84r9TUQPKNa9
 yopywvLGQ55ry/WFQW3OzSoVbfKLWH6DyQhHNfVIDAfSaz3+48CQJbxkjNl3tpYXKDqK
 ILiw==
X-Gm-Message-State: AOAM531ygeZttzMvt1REiigcBtOb7RVskkwL2hLc0A3kkL3PXQVIRfOg
 lQz+r1kZBlK4MaHC6pVpiZNljxkkSRwNWndWI7uOlAt02mwebWfn54B7vx21nVrkIX9O6jNuhWD
 jsMXY5gQWnQHN0PI=
X-Received: by 2002:a1c:111:: with SMTP id 17mr15948750wmb.126.1601895184071; 
 Mon, 05 Oct 2020 03:53:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy30tyA/gUzbfN4GfzcirYYgq3wPlEjkNGuczMbEveLo5Ma7OijnoB+fYprt4GnFnU65+AICg==
X-Received: by 2002:a1c:111:: with SMTP id 17mr15948727wmb.126.1601895183801; 
 Mon, 05 Oct 2020 03:53:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2e86:3d8b:8b70:920c?
 ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id k190sm8882949wme.33.2020.10.05.03.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 03:53:03 -0700 (PDT)
Subject: Re: [PATCH v3 17/19] hw/arm: Automatically select the 'virt' machine
 on KVM
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-18-philmd@redhat.com>
 <CAFEAcA-Rt__Du0TqqVFov4mNoBvC9hTt7t7e-3G45Eck4z94tQ@mail.gmail.com>
 <CAFEAcA-u53dVdv8EJdeeOWxw+SfPJueTq7M6g0vBF5XM2Go4zw@mail.gmail.com>
 <c7d07e18-57dd-7b55-f3dc-283c9d13e4b5@redhat.com>
 <8253ddd7-3149-17d9-1174-6474c4bde605@redhat.com>
 <36629bed-9b32-01a0-fdc2-831b10e4bad9@redhat.com>
 <f3b931f5-c785-1d98-edd1-e5fcc91ff0ce@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c371698-b41a-82ba-9fe9-022a37a86a01@redhat.com>
Date: Mon, 5 Oct 2020 12:53:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f3b931f5-c785-1d98-edd1-e5fcc91ff0ce@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/20 11:22, Philippe Mathieu-Daudé wrote:
> List of arch-indep Kconfig using arch-defined selectors:
> 
> hw/acpi/Kconfig:42:    depends on PC
> hw/intc/Kconfig:31:    depends on ARM_GIC && KVM
> hw/intc/Kconfig:36:    depends on OPENPIC && KVM
> hw/intc/Kconfig:40:    depends on POWERNV || PSERIES
> hw/intc/Kconfig:49:    depends on XICS && KVM
> hw/intc/Kconfig:60:    depends on S390_FLIC && KVM
> hw/mem/Kconfig:11:    depends on (PC || PSERIES || ARM_VIRT)
> hw/pci-bridge/Kconfig:8:    default y if Q35
> hw/timer/Kconfig:14:    default y if PC
> hw/tpm/Kconfig:18:    depends on TPM && PC
> hw/tpm/Kconfig:24:    depends on TPM && PSERIES
> hw/vfio/Kconfig:16:    depends on LINUX && S390_CCW_VIRTIO
> hw/vfio/Kconfig:38:    depends on LINUX && S390_CCW_VIRTIO
> 

I don't think that's a problem, and also I'm not sure this patch is a
good idea.

See docs/devel/kconfig.rst: "Boards default to false; they are enabled
by the ``default-configs/*.mak`` for the target they apply to".

Paolo


