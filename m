Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C612C4320D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D0F2168B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D0F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClX3-0005S9-Rh
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCkc8-0000cx-W3
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCkc7-0002y1-Ux
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:12:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCkc7-0002xf-PK
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:12:19 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ECCD7796E4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 13:12:18 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id c1so550749wrb.12
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tEOE9hZZ/W3u4arNVlLiKz0fXOL0n+HPkK/pipNCdZY=;
 b=h63fXbKTPoa0taM9Jiv1I7Y5EUH9DZf6ci583IRylpE6LCAF/bJgY67AJXg9IA/a4F
 M8Ur5Pkye97slqEpsA4ikluy99acPK0MAR0uxKXhMoBgKbZUjbY6w1AhVBdIozg1bipr
 WDCqgg9M59NxEo8dZbIrMxkkBa54+HKzB2557MI21tIvLevUll0YCxhazGGzUkqkrQsA
 tGf6YYimyLqqOPIS4+oaK49277TSlI90l5SowOQvk5S09ppLhyCaIYw+aKfRqiCM/y9u
 2MWm77XllnHlpllySZO7CyPjUoyzJTqslVWWyTxeBELpbHj5rgH/TP1CVcEpXmZrHAZL
 TfzQ==
X-Gm-Message-State: APjAAAUFpivwreH2PhhPJm292oVl+FwvpOIvEqd0kaJm6uHgRx3giX/g
 nW8QdjdTK1Xs6q7tEVLcfaZ1P9vzdvC42FTRtgCI/j8FemK33UBPNkiN5dfIPRFJZjUhh64eJz0
 MRoQxmGCkHi/hKeo=
X-Received: by 2002:a5d:6043:: with SMTP id j3mr2108968wrt.337.1569330737555; 
 Tue, 24 Sep 2019 06:12:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxM30vRdrzgViBjPlQOUXryf1ZvluMBKXcKl1g35ITeSbKDGdaqkmzot/F2m8Ft2auYYQ9OCw==
X-Received: by 2002:a5d:6043:: with SMTP id j3mr2108946wrt.337.1569330737303; 
 Tue, 24 Sep 2019 06:12:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id x5sm3050597wrg.69.2019.09.24.06.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 06:12:16 -0700 (PDT)
Subject: Re: [PATCH v4 8/8] hw/i386: Introduce the microvm machine type
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-9-slp@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2cbd2570-d158-c9ce-2a38-08c28cd291ea@redhat.com>
Date: Tue, 24 Sep 2019 15:12:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924124433.96810-9-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, lersek@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, imammedo@redhat.com, philmd@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/19 14:44, Sergio Lopez wrote:
> microvm.option-roms=bool (Set off to disable loading option ROMs)

Please make this x-option-roms

> microvm.isa-serial=bool (Set off to disable the instantiation an ISA serial port)
> microvm.rtc=bool (Set off to disable the instantiation of an MC146818 RTC)
> microvm.kernel-cmdline=bool (Set off to disable adding virtio-mmio devices to the kernel cmdline)

Perhaps auto-kernel-cmdline?

Paolo

