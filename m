Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21650C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 04:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0F52083D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 04:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpRkcXdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0F52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35387 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGyZC-0005eq-RL
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 00:22:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsuryacse7k@gmail.com>) id 1hGyYL-0005Np-7a
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsuryacse7k@gmail.com>) id 1hGyYI-0001uf-5d
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:21:36 -0400
Received: from mail-it1-x131.google.com ([2607:f8b0:4864:20::131]:56141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsuryacse7k@gmail.com>)
	id 1hGyYF-0001sT-OB
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:21:33 -0400
Received: by mail-it1-x131.google.com with SMTP id y134so1300480itc.5
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 21:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=wF8jGICAtmnxWt+A1VweqI1UTtqMiOs8SiRChT6czME=;
	b=TpRkcXdfP5QTf4WISEzxVnZsA9IqC1/2zTpGbTHzNIBA2Tt6fqj6LRehP2KwWLDGkm
	mzzFDYT15YUOc5kXsVRiCRuefMJ+eDHSPfUEQj8uQZqpmH2iZsj1GacXk8YN2hM6VPtn
	DCc9ePq6kBzKRzWJnsSjkugSaO10kGSZxLMg9cLNFCDzxYGRWJVlnOEVpbWgj+N0SGVs
	R9TJTy/rQSAZIQqavjoJCBavOHVTZDdlLGzRxzHyW2ML/zo/CeC1YUUOGyrB8Rk1x2Yb
	zDk8QWLIdtroywDtHiaNf84KU1S5u6soOw9lWekFQoMsDh1HIkGfHcnzwN29Og6rIZ1l
	OIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=wF8jGICAtmnxWt+A1VweqI1UTtqMiOs8SiRChT6czME=;
	b=JS9hZuat2iPqyRkYORJVB7m3nYB6QuGOuKJ3tvxGq0nRc2K1fs2K3i8dMnLL6gnpSt
	xaSdVQBMgmnrTbnt32C9ERxSN0Asc8MLWP4PGfo2mn2K8VssR2IpJq9MT9EPml4NTOO1
	smGFaMRtr0fID66kvvoKiUVxWZRPnWgmBdiV+c38ib67Lq5AXBIIEZLvNTUeox9HwWRn
	rfW5V/h1HLgnT52JSiaYP/HjRTIs9k1nWOzxB3LszKY1BsYYSCfR2GzLf2cm0xigiQWh
	SSkyd4uYB1GWmFnhGcYsWGrBUdA4bdy92xPzMpMtXxgDRttr92Tvd6seGTfdbIvXjWgB
	guZQ==
X-Gm-Message-State: APjAAAUdlvBcTTC6saiR5xjBLdl0uhPvvybmPbbUB6jdSXVTlcL/q9Mo
	PWhIRjjLw1No0dPSo/15mUwJscQlYAgRbBvT5m9L9NswD/E=
X-Google-Smtp-Source: APXvYqxTfJqJpqshPU1/fQ6t2nvpz3bQkt2+st2MbrcPzdaCPrzKweXCabYKfdHV96ZtJ7ChIUqAfD9GBXLgSB9tsz0=
X-Received: by 2002:a02:828c:: with SMTP id t12mr13015466jag.18.1555561287588; 
	Wed, 17 Apr 2019 21:21:27 -0700 (PDT)
MIME-Version: 1.0
From: suresh gumpula <gsuryacse7k@gmail.com>
Date: Wed, 17 Apr 2019 21:21:16 -0700
Message-ID:
 <CAJOqHmgt6+FCWkunf9sch03QEw5_eHKeLjHvFeonFOVysHiJCA@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::131
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] Live migration fails with all 8 memslots used
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418042116.-z6sWMkXZhWRxFgPPoWDxVf2Wqd2enCTDqx35nXqBlU@z>

Hi,
I was trying to migrate a VM(CentOS7) which  started with 4G memory and hot
plugged 5 memslots with 1G each.  So the VM has total of 9G memory and
trying to migrate fails in vhost_dev_init() on destination host


    if (used_memslots >
hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {

        error_report("vhost backend memory slots limit is less"

                     " than current number of present memory slots");

        r = -1;

        if (busyloop_timeout) {

            goto fail_busyloop;

        } else {

            goto fail;

        }

    }


Debugged more into this and understood that, after vhost_dev_init()
used_memslots are 4


(gdb) show-vhost-dev-memory-regions 0x555556d27000

n_mem_sections:4

n_regions:4

Region0:

$101 = {

  guest_phys_addr = 0x100000000,        ; 1G above 4G

  memory_size = 0x40000000,

  userspace_addr = 0x7fffb4600000,

  flags_padding = 0x0

}

Region1:

$102 = {

  guest_phys_addr = 0xc0000,     ; 768k-896k

  memory_size = 0x20000,

  userspace_addr = 0x7ffef4200000,

  flags_padding = 0x0

}

Region2:

$103 = {

  guest_phys_addr = 0x100000,             ;;3G from 1M

  memory_size = 0xbff00000,

  userspace_addr = 0x7ffef4700000,

  flags_padding = 0x0

}

Region3:

$104 = {

  guest_phys_addr = 0x0,

  memory_size = 0xa0000,              ;   First 640K;   0 - 640k;

  userspace_addr = 0x7ffef4600000,

  flags_padding = 0x0

}

(gdb) p used_memslots

$150 = 4


And later on it coalesced the VGA region of 128k at 0xc0000( 768-896k) upon
guest config write

with  i440fx_update_memory_mappings(d);

(gdb) f 5

#5  0x000055555595b920 in i440fx_write_config (dev=0x5555572b8000,
address=90, val=51, len=1) at hw/pci-host/piix.c:168

168             i440fx_update_memory_mappings(d);

(gdb) l

163

164         /* XXX: implement SMRAM.D_LOCK */

165         pci_default_write_config(dev, address, val, len);

166         if (ranges_overlap(address, len, I440FX_PAM, I440FX_PAM_SIZE) ||

167             range_covers_byte(address, len, I440FX_SMRAM)) {

168             i440fx_update_memory_mappings(d);

169         }

170     }



(gdb) p used_memslots

$150 = 3


Since the destination QEMU does not know that the source host coalesced one
region,  vhost_dev_init for kernel started with 4 slots and  hot plugged 5
slots and then the vhost_dev_init for user fails since 9>8 is true.


    if (used_memslots >
hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {

        error_report("vhost backend memory slots limit is less"

                     " than current number of present memory slots");

        r = -1;

        if (busyloop_timeout) {

            goto fail_busyloop;

        } else {

            goto fail;

        }

    }


Can you guys please answer my questions here:

1)  Why is the VGA region of 128k coalesced on guest vcpu execution with
pci config write?

2)  We have memslots limit of 8 and 3 are pre occupied with initial memory
and we can only use 4 memslots for hotplug instead of 5 to migrate a VM.
Is there any reason for this?  We cannot hotplug 5 slots and migrate the VM.



Thanks much

Suresh.G
