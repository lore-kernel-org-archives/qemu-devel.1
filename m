Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847A6C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 11:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A682076D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 11:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxcKEWoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A682076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD5QS-0003Wq-Cy
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 07:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jD5Pl-00032m-Tt
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jD5Pk-0000N5-SG
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:57:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37794
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jD5Pk-0000MV-Ow
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584187032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RDGrCEDAnanedxqDRAPayWeL+3o1d/ZHi8nvCpSYCQ=;
 b=cxcKEWoTvzoufnEnipYAp432IQkaIM4OcaSiGi4JJ2euQ6U939Ww1XcAi8E1dx+Aaov2VU
 CaXM5tPnYqVB/Hbz5MeL8h/GLGL+IzRq9ZL5LY/P7OlH4o/umSkspHZZRnWmR2yAepNv6g
 +Uy93d+lPUleB1VITVcfsUTNjRJTnjE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-uHpijvfJM0ukZCpY0eLJKw-1; Sat, 14 Mar 2020 07:57:08 -0400
X-MC-Unique: uHpijvfJM0ukZCpY0eLJKw-1
Received: by mail-wr1-f69.google.com with SMTP id u18so5800097wrn.11
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 04:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/RDGrCEDAnanedxqDRAPayWeL+3o1d/ZHi8nvCpSYCQ=;
 b=Ldio1ycuArkuoEy105wPE6bXG8F5enm+2753Xrj9TD9vmAYoO3v1bgGQR2nhQSkosz
 qtkM4Am4BuHsBk0HwKGrYPvqTqcGGhvkab+r+3LIxJFbQiR3xH+tijQwBTB30UIN0/tk
 0InoBBYiMz+swiTi0DJUXU/vzqvltBXdE0JK+fRfb06qSpU8wU+E+V8IjxlVpWOdq3bJ
 oWmvHBDdSWAY6lQdEgc6sbTxcCx9efCHWPuwVyVx9S/hi9f2nxp70aMRb9Rp6F8RJ3wW
 V2rAe0EQBur/5LN/6pbPAa3kUBvyvg/GJYa3GUsc5wRoLrVYCQ9K0EdjvzTPpYsciliQ
 QUYA==
X-Gm-Message-State: ANhLgQ3YgwZS2skE0ykmglq0AQynkg2CONFZyDuNeIPsWntB3kKaFHuT
 oEtQ7pRDo2kATxL+w4vHFo1cNGb+D+bIzWxEVjcjVc70axehDQeff4C6pVEXQYvwAMldD26nYbq
 9MTn0+YSOae3L1WE=
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr24224768wro.386.1584187027676; 
 Sat, 14 Mar 2020 04:57:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsZygnv+c0/s3Zg9yoN8czLoU36+Mn3N5U+B6997si62TFYDxL9m68VQ5XzeGI/LuScXUcPdA==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr24224734wro.386.1584187027381; 
 Sat, 14 Mar 2020 04:57:07 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.174.5])
 by smtp.gmail.com with ESMTPSA id n2sm16375368wrr.62.2020.03.14.04.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 04:57:06 -0700 (PDT)
Subject: Re: [PATCH 0/8] Misc hw/ide legacy clean up
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <22f580a9-7919-773a-c1a9-cc59af7166da@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <402c7097-2198-d43a-1064-22261408eb9b@redhat.com>
Date: Sat, 14 Mar 2020 12:54:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <22f580a9-7919-773a-c1a9-cc59af7166da@ilande.co.uk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 hpoussin@reactos.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 philmd@redhat.com, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/03/20 12:45, Mark Cave-Ayland wrote:
> On 13/03/2020 21:14, BALATON Zoltan wrote:
> 
>> These are some clean ups to remove more legacy init functions and
>> lessen dependence on include/hw/ide.h with some simplifications in
>> board code. There should be no functional change.
>>
>> BALATON Zoltan (8):
>>   hw/ide: Get rid of piix3_init functions
>>   hw/ide: Get rid of piix4_init function
>>   hw/ide: Remove now unneded #include "hw/pci/pci.h" from hw/ide.h
>>   hw/ide: Move MAX_IDE_BUS define to one header
>>   hw/ide/pci.c: Coding style update to fix checkpatch errors
>>   hw/ide: Do ide_drive_get() within pci_ide_create_devs()
>>   hw/ide: Move MAX_IDE_DEVS define to hw/ide/internal.h
>>   hw/ide: Remove unneeded inclusion of hw/ide.h
>>
>>  hw/alpha/dp264.c              | 15 +++------------
>>  hw/hppa/hppa_sys.h            |  1 -
>>  hw/hppa/machine.c             |  3 ---
>>  hw/i386/pc_piix.c             | 20 +++++++++-----------
>>  hw/ide/ahci_internal.h        |  1 +
>>  hw/ide/pci.c                  | 10 ++++++----
>>  hw/ide/piix.c                 | 31 +------------------------------
>>  hw/isa/piix4.c                | 14 +++++---------
>>  hw/mips/mips_fulong2e.c       |  6 +-----
>>  hw/mips/mips_malta.c          |  6 ++----
>>  hw/mips/mips_r4k.c            |  4 +---
>>  hw/ppc/mac_newworld.c         |  2 --
>>  hw/ppc/mac_oldworld.c         |  2 --
>>  hw/ppc/prep.c                 |  3 ---
>>  hw/sparc64/sun4u.c            |  7 +------
>>  include/hw/ide.h              |  6 ------
>>  include/hw/ide/internal.h     |  3 +++
>>  include/hw/ide/pci.h          |  3 ++-
>>  include/hw/misc/macio/macio.h |  1 +
>>  include/hw/southbridge/piix.h |  3 +--
>>  20 files changed, 37 insertions(+), 104 deletions(-)
> 
> This looks like a good clean-up to me, but certainly it would be good to get a second
> opinion from people more familiar with the IDE code internals.
> 
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Yes, it looks good to me.  Thanks!

Paolo


