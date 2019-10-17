Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DBDECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0D3214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0D3214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL2TJ-0005Hs-9n
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 05:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL2S9-0004RQ-Bj
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL2S7-0005fY-N7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:52:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL2S7-0005eX-Gz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:52:15 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 195D7368DA
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:52:14 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j2so660511wrg.19
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 02:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RplGin3fGtgMXDdqQRrbU9VfWvpGsxgt51JrIMmknc4=;
 b=Yv4NIoqtGJmhaDTKQCP9PEdF9cVl2P8tJ2InzgS6+HGLyvX8FKvm+105DDo1PYUmgZ
 rQzyz4Wnoag1tE8MMwo0vAFEQZQrT4k/g/qAbVNJXtyKpwsjAKa/CK7myaJFLR6rD9UL
 q2nlEBOfMvVRs5PaGkMvsysXTDs1zN9xDR1CLznTuHCoFzxP1C8qos/VhZB7VTujoV39
 zoASN5LSReyH74aHMjGfqP5Co3ZArvyADfpDNvmri6Mo0pL6Mup+cNexMl5ZtaM6UjGW
 dZ9A/Cn4BveGs4zChLLky8PfKDpimedH+kfSWON8XKDeyx3JfNIIZssipYMd1QBLTtjR
 tEWg==
X-Gm-Message-State: APjAAAWuI3xsPo3m0cfo7wgQA+eO8/ljt6TybngDPDRU0n3Y2MezdZfs
 Y3TvFSXJPOEtNfufYlGX0j0G37iRzAkySXmvK3DBNa2udxQ+FVtOkw1fLYRi6A6CsOGZs5rRKq4
 joWtGBHynuBs6byU=
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr2083127wmc.104.1571305932795; 
 Thu, 17 Oct 2019 02:52:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx4lNF+hUnLEbW/xifhdNOwd+1tDH4M+XaEiPru0tuVYqxpvt6OwHv4qMifTT2b6WyLkfoSyA==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr2083101wmc.104.1571305932600; 
 Thu, 17 Oct 2019 02:52:12 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id g185sm1769014wme.10.2019.10.17.02.52.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 02:52:12 -0700 (PDT)
Subject: Re: [PATCH v10 13/15] docs/microvm.rst: document the new microvm
 machine type
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191016101241.24405-1-slp@redhat.com>
 <20191016101241.24405-14-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d981516f-f23a-47f5-d825-a101fdaaf471@redhat.com>
Date: Thu, 17 Oct 2019 11:52:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016101241.24405-14-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: ehabkost@redhat.com, mst@redhat.com, groug@kaod.org, kraxel@redhat.com,
 pbonzini@redhat.com, imammedo@redhat.com, sgarzare@redhat.com,
 lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sergio,

On 10/16/19 12:12 PM, Sergio Lopez wrote:
> +Supported devices
> +-----------------
> +
> +The microvm machine type supports the following devices:
> +
> +- ISA bus
> +- i8259 PIC (optional)
> +- i8254 PIT (optional)
> +- MC146818 RTC (optional)
> +- One ISA serial port (optional)
> +- LAPIC
> +- IOAPIC (with kernel-irqchip=split by default)
> +- kvmclock (if using KVM)
> +- fw_cfg
> +- Up to eight virtio-mmio devices (configured by the user)

If we have VirtIO devices, why not use virtio-serial instead of the one 
on the ISA bus?

