Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E38C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A819D205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vULuy4NF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A819D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42622 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH8ac-00079K-RA
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:04:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsuryacse7k@gmail.com>) id 1hH8YX-0005xw-Hp
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsuryacse7k@gmail.com>) id 1hH8YT-0006Am-BG
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:02:29 -0400
Received: from mail-it1-x133.google.com ([2607:f8b0:4864:20::133]:37712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsuryacse7k@gmail.com>)
	id 1hH8YN-00068Z-Tx
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:02:21 -0400
Received: by mail-it1-x133.google.com with SMTP id u65so3793624itc.2
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 08:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=iy/g46S05GMJGziCabELzns1S66TAEfgZo5PbakS0VY=;
	b=vULuy4NFvmYtnbB9z2cvNofN4nW9a2sntAT2go3sGQ6+3Z7lMYqeSh7HFFZCc7hHcP
	plHo6xnsDOFPFoXUyTLEC4WsL4IFfon2dOStrAcfEMbMJKJt3XMwVhLlGCx9oWf2bYmp
	QALojNshLYnCiUEzsYAzC4xg6KIZYH8UoI1tKLK3Uw9Ig6cDyU8ePsmboyLWhk05xYff
	xfbG0pAtAw5YLOmAo5AFY2D1+6TLGCvFxDk8bCxwj+Rlc8CPcJCokbGoz/O9eh1d2sv0
	T6UQGDD93G690akKY50rnTjWA7YKiefRWSXmVQfHrGgWHojHfYWP//wrE3TQA2C6+bmh
	Lbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=iy/g46S05GMJGziCabELzns1S66TAEfgZo5PbakS0VY=;
	b=UjySab3i6H+yIJusDH5s/2pSi5bOb/X8/G3ZH/oZw60kRTa7UnBYxe6f29iM7CFWcS
	MVa+t4ZNzwqYHsem9cCcD4R13KXRm3EnSip3NsmzXBtqxFVRgmGr9c6fFWK3rhgi0b9K
	JWqFb4arnOUZ0VmKOpJtUmIUTVEBJ2CT315yPt/SiiLzfK1ELTYQJVfbpo4ZEH6R+Rha
	ysuLUeJadxqSgPronAp6yUjWYtj00gxaYhAeFzQ1iCPmBf+frEgX/rLeFPRfeRkR2MCr
	4KNIgE1V3NXdavvW7FfiMKf3QEimTJgv2sFB4dQKWTBPJpxB59cUG0AcAin8tvsK9Z5v
	o00w==
X-Gm-Message-State: APjAAAXR/FoUrpFY7yQjFJ57bY1urQv/kmO/ytvXliuv5N3o2JXGNHdY
	+e/SCSm4hG6JqAmiBIJ45ghmcwlEMlAqp00R2fRjQ3nWWUc=
X-Google-Smtp-Source: APXvYqxqsg/ceAJIwN3FExtUVmFO5QU2uZkL6oN4gdxdn91PzGUq2jfo5AnlUZO4PA5MR7eqCvrNF4S3UZ57+Tvwc2A=
X-Received: by 2002:a24:5a51:: with SMTP id v78mr4011024ita.49.1555599738162; 
	Thu, 18 Apr 2019 08:02:18 -0700 (PDT)
MIME-Version: 1.0
From: suresh gumpula <gsuryacse7k@gmail.com>
Date: Thu, 18 Apr 2019 08:02:07 -0700
Message-ID:
 <CAJOqHmiHMKcDiwzCFR0QDr1U59_8GwXUFDZGj=1yyjKmT=uwkQ@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::133
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel]  Live migration fails with all 8 memslots used
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
Message-ID: <20190418150207.xH9ugJauPqACkiWCzHaGg4dqsA1FezJVBVtQC8logvw@z>

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
