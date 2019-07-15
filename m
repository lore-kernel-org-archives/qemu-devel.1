Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F32C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5035C20665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5035C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmz37-0003ut-Cv
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48670)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hmz2u-0003Ou-Ts
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hmz2t-0005LS-UT
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:21:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hmz2t-0005Kv-MM
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:21:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so16686205wrm.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 04:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XpM7q5nGE5in8iatsiRuS3mXGEMtUeDV4D74czZCweE=;
 b=F3Ks1lNjJZBQl0b6SbulOHYZNqKqudU5cEuwIQG5jWzGip99ZBtnw09OUdv4XUF7sl
 oXMX1mkvgCdsO6GCrgfEz0IjZGpQGsKhPpX7DA9A4JlqS/5qyhCCQOUdAZ2W1ywv2nbt
 ZhUyUD8NA4Bbm1CnHOO42MPr8GRvBLXuETwnWcT/vg1PDnEvb+hK/+MizHSIquWikha+
 2iSCGcBfr/8RoIeDtLcs3JllGfsVq/bSU5sXg9wo/hEQC5Wz90JoxqTPl2aBk/CvWdSM
 7uvzeC930VpFv4O8LnO1ZpvZEEmZNMCFhdIsYlNTwYD0dpk3+yrj+5iubY/WnTksIQ3e
 Jpng==
X-Gm-Message-State: APjAAAW5AD8aCocvxu2atc3yu4t3IEaQZbc9XuIwUBoFH/bo8rmyvJ5w
 pQpyTotn17YohFSnfnswfrZdbA==
X-Google-Smtp-Source: APXvYqySZXCkGKs4fJgtxWADvWLAaNT5g2s/8nxplP7Tc6HcE8N/DWpshk2KIhdbIiREWdcuot/JXw==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr27681990wrr.252.1563189686712; 
 Mon, 15 Jul 2019 04:21:26 -0700 (PDT)
Received: from [192.168.178.40] ([151.20.129.151])
 by smtp.gmail.com with ESMTPSA id p26sm23977275wrp.58.2019.07.15.04.21.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 04:21:26 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190715095545.28545-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b6d8e256-b6bf-6270-b2db-9d15403f6233@redhat.com>
Date: Mon, 15 Jul 2019 13:21:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715095545.28545-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/Kconfig: PCI & USB fixes
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/19 11:55, Philippe Mathieu-Daudé wrote:
> I actually wanted to clean the USB devices (i.e. to not have
> USB3 devices appear on OHCI buses) but this is too late for
> the next release, so let's post the patches accumulated.
> 
> Philippe Mathieu-Daudé (3):
>   hw/Kconfig: PCI bus implies PCI_DEVICES
>   hw/usb/Kconfig: Add CONFIG_USB_EHCI_PCI
>   hw/usb/Kconfig: USB_XHCI_NEC requires USB_XHCI
> 
>  docs/devel/kconfig.rst |  1 -
>  hw/alpha/Kconfig       |  1 -
>  hw/arm/Kconfig         |  4 ----
>  hw/hppa/Kconfig        |  1 -
>  hw/i386/Kconfig        |  1 -
>  hw/pci/Kconfig         |  1 +
>  hw/ppc/Kconfig         |  6 ------
>  hw/riscv/Kconfig       |  1 -
>  hw/sh4/Kconfig         |  1 -
>  hw/sparc64/Kconfig     |  1 -
>  hw/usb/Kconfig         | 11 +++++++----
>  hw/usb/Makefile.objs   |  5 +++--
>  12 files changed, 11 insertions(+), 23 deletions(-)
> 

ACK for 2 and 3.  Gerd is on vacation so I'm picking them up.

Paolo

