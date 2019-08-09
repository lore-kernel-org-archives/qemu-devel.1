Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FE8C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE542166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE542166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1kp-0004Wu-Co
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54670)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw1k2-00043z-MA
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw1k0-0002lR-PI
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:03:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw1k0-0002lD-Jn
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:03:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id b3so5301948wro.4
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 03:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WjpAJl9+FVyhf8XRxz3H1lMc/wkhvaFGJXxr4ailmv8=;
 b=JW+naMBNjjG/c+Gm2uGHud7La9y8oyUvanBzH7EhCuDTSzFawfBIaFlq/FPnSpt8Ld
 4DCiSSO8hR88ierO5eiPwQSKkM6lP4wh8DyZgx+fIMJGyIkhvO/7PtNT+GiY8VGl2Z9d
 WEOFss/F0NVEsRnaxtEcbw3OLmuTRK+GbqJy34CPSuBk5LWgVvLvFFXlL/01j/0naVLg
 AXR3PcwYHFOALZUoeEFeYy57GcpLq0bhAkuHvH2q7lvwb7Fs1iStfrE3Kb/Ft6kStFOF
 lBhtEzP4JPOTdiCd8hq90iOXY5ZDf6dqQ/eFgfUxm8dtDvJjGJk0YWljgoD7kixG+5tK
 dA1Q==
X-Gm-Message-State: APjAAAVungTpwrgYKjgmJUjL6SZcaLsVQ2ZCTcVNq5xtEITfB5ry0Lb/
 7HPIv//03vXndwFUl01Hd9iAmMfa20s=
X-Google-Smtp-Source: APXvYqzWQsZBkHih1zEKms01+lLP9+P4MpZdv3JmYo3fSqM1l7arMp/nRje/jg1GP4V5X16TfGoq2A==
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr21577910wra.328.1565344999509; 
 Fri, 09 Aug 2019 03:03:19 -0700 (PDT)
Received: from [192.168.50.36] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id e10sm15446116wrn.33.2019.08.09.03.03.16
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 03:03:18 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190809064645.22656-1-armbru@redhat.com>
 <20190809064645.22656-17-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <51dd49f0-4327-9211-0163-b2d9c4dbb446@redhat.com>
Date: Fri, 9 Aug 2019 12:03:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809064645.22656-17-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3 16/29] Include exec/memory.h slightly
 less
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 8:46 AM, Markus Armbruster wrote:
> Drop unnecessary inclusions from headers.  Downgrade a few more to
> exec/hwaddr.h.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/audio/lm4549.h                   | 1 +
>  hw/display/edid-region.c            | 1 +
>  hw/display/tc6393xb.c               | 1 +
>  hw/net/can/can_sja1000.h            | 1 +
>  hw/net/ne2000.c                     | 1 +
>  hw/xtensa/xtensa_memory.h           | 1 -
>  include/hw/arm/boot.h               | 1 -
>  include/hw/arm/fsl-imx7.h           | 1 -
>  include/hw/arm/soc_dma.h            | 2 +-
>  include/hw/block/flash.h            | 2 +-
>  include/hw/boards.h                 | 1 +
>  include/hw/char/parallel.h          | 1 -
>  include/hw/display/milkymist_tmu2.h | 1 +
>  include/hw/display/tc6393xb.h       | 2 --
>  include/hw/display/vga.h            | 2 +-
>  include/hw/hw.h                     | 1 -
>  include/hw/i2c/pm_smbus.h           | 1 +
>  include/hw/i2c/smbus_eeprom.h       | 1 +
>  include/hw/misc/auxbus.h            | 1 +
>  include/hw/ppc/xics.h               | 1 +
>  include/hw/usb.h                    | 1 +
>  include/hw/virtio/virtio.h          | 1 +
>  migration/colo.c                    | 1 +
>  migration/migration.h               | 1 +
>  migration/postcopy-ram.c            | 1 +
>  migration/rdma.c                    | 1 +
>  26 files changed, 20 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


