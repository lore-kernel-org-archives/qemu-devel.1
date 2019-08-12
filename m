Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC364C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 10:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D792085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 10:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D792085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx7u3-0003mm-J2
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 06:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56364)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hx7st-0002eU-Ln
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hx7ss-0005m3-Hq
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:49:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hx7so-0005cB-US
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:48:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so2197722wrt.4
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 03:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1s3kFElGR2bcICHTDK9jy5d6bFQVfdHz2rMsyJrYu0g=;
 b=B7n6cht0Ek+g1kkBwr5MSJAsWYqwZ51HRWMZCLHOGdM/ZpUgYdHEhL+p1yM00MV0Vi
 bMi/7AMw8kwvuv5M99SSJA1LjcNDYIY4gaxdPmABe8tSmQjcyIE9SduVbAAcH94Ncz0J
 ZpoJiXK59soqpaRclmgT1xaEBpqdnCKAplZjeg4g8FBRFtxgp3teTlXAGiFGV3PVDYWg
 JXo93MDsU1T0MBp4X0SpkspIphjdf9inpbkVAznhr53QEWmEXXDP7WOzpKtukirG7Cw1
 wzsMBE1E81a96IdP5pTGfUqxwQ/FglXSlP4n188UlIBEe8BHYkP1J8IsKWLx6r01XXO7
 oh4w==
X-Gm-Message-State: APjAAAXaAN6REGswWqz1Db5qCeOhzo0MEPs5CqWHP/GnzYAdwnyPaqO9
 dzU62GcPkfrqAZjh5k849q8aPIZJylw=
X-Google-Smtp-Source: APXvYqxlOWpEt4HoDCddhjxP0tA7GGmIjoLADlLZ41xIUp6bY4Qr5LGlfyLZ8L84aBMB4K1Y1Il8Ng==
X-Received: by 2002:adf:dc51:: with SMTP id m17mr41692909wrj.256.1565606934716; 
 Mon, 12 Aug 2019 03:48:54 -0700 (PDT)
Received: from [192.168.1.37] (225.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.225])
 by smtp.gmail.com with ESMTPSA id i5sm7665795wrn.48.2019.08.12.03.48.53
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 03:48:54 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190812052359.30071-1-armbru@redhat.com>
 <20190812052359.30071-10-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e005fcfa-88d1-1529-83f1-9745b448a13d@redhat.com>
Date: Mon, 12 Aug 2019 12:48:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190812052359.30071-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v4 09/29] Include
 migration/qemu-file-types.h a lot less
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

On 8/12/19 7:23 AM, Markus Armbruster wrote:
> In my "build everything" tree, changing migration/qemu-file-types.h
> triggers a recompile of some 2600 out of 6600 objects (not counting
> tests and objects that don't depend on qemu/osdep.h).
> 
> The culprit is again hw/hw.h, which supposedly includes it for
> convenience.
> 
> Include migration/qemu-file-types.h only where it's needed.  Touching
> it now recompiles less than 200 objects.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/hw.h             | 1 -
>  include/migration/cpu.h     | 1 +
>  hw/acpi/piix4.c             | 1 +
>  hw/block/virtio-blk.c       | 1 +
>  hw/char/virtio-serial-bus.c | 1 +
>  hw/display/virtio-gpu.c     | 1 +
>  hw/intc/apic_common.c       | 1 +
>  hw/intc/s390_flic_kvm.c     | 1 +
>  hw/nvram/eeprom93xx.c       | 1 +
>  hw/nvram/fw_cfg.c           | 1 +
>  hw/pci-host/piix.c          | 1 +
>  hw/pci/msix.c               | 1 +
>  hw/pci/pci.c                | 1 +
>  hw/pci/shpc.c               | 1 +
>  hw/ppc/spapr.c              | 1 +
>  hw/s390x/s390-skeys.c       | 1 +
>  hw/s390x/tod.c              | 1 +
>  hw/s390x/virtio-ccw.c       | 1 +
>  hw/scsi/mptsas.c            | 1 +
>  hw/scsi/scsi-bus.c          | 1 +
>  hw/scsi/scsi-disk.c         | 1 +
>  hw/scsi/scsi-generic.c      | 1 +
>  hw/scsi/virtio-scsi.c       | 1 +
>  hw/timer/i8254_common.c     | 1 +
>  hw/timer/twl92230.c         | 1 +
>  hw/usb/redirect.c           | 1 +
>  hw/virtio/vhost.c           | 1 +
>  hw/virtio/virtio-mmio.c     | 1 +
>  hw/virtio/virtio-pci.c      | 1 +
>  hw/virtio/virtio.c          | 1 +
>  target/ppc/kvm.c            | 1 +
>  31 files changed, 30 insertions(+), 1 deletion(-)

