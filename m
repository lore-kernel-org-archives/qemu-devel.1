Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A861AC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8321421850
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8321421850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj1mM-0000rd-A6
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 09:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49822)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hj1lq-0000Qm-94
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hj1lp-00026u-3j
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:27:30 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:39375)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hj1lo-00025g-11
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:27:29 -0400
Received: by mail-wm1-f51.google.com with SMTP id z23so6169532wma.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 06:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:openpgp:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=9bNfa+rht8LTjqZSJ+IiaBnNXiGV+TWnxL2WRoy4RFw=;
 b=G897e1SJ9ITf8sxL4hZLx3eZVxNcAuEPD5QURSvZeYUpCR4o+BdM7WyO2Bde8SDBn1
 N5NK0GFk6T3U85i6HQ8wr5mNAGCuHxlhi0olWh/ofzhcMmqsRxpG6zjFqCPzavdHo2wk
 4h0E7um73KmKdHtZmM8Ih3LcnFJxlisOARSJmOLBrImLEAxueBB4Y28yo4+G3XqjbBK8
 hA3bmMq2iv+wb0rYddpkp9iseJtdFcZJ+HOTCq8MhfOcqgsLoJgqRN68g4d3bDbHqCGq
 52AFqLhlyT/2BRbjosfRKV4qvG92+xNvFt9JpjZLlrwubhPwEuQ4zlPJGTNVa95ISclB
 9EPQ==
X-Gm-Message-State: APjAAAW4rIFVsvkM1AUbHO2JSHedS/ujkxKLDMmJDoW/ywNodmJQEnSw
 0qr5wyw2/lTrHk4D4FfLnZUChw==
X-Google-Smtp-Source: APXvYqzzl1r+GxaSdJc3/jYQx9lkuXVZVu0EmOMwkgPCfm2uFKcnOJ1jIh4ksiaHMRMvZXsHp3Cg3Q==
X-Received: by 2002:a1c:3:: with SMTP id 3mr12868156wma.6.1562246846634;
 Thu, 04 Jul 2019 06:27:26 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id v4sm5782915wmg.22.2019.07.04.06.27.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 06:27:26 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers
 <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>,
 Paolo Bonzini <pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <41536801-f8ac-b3c6-a74a-4a7ead43695f@redhat.com>
Date: Thu, 4 Jul 2019 15:27:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.51
Subject: [Qemu-devel] hw/display/vga: Why architecture specific code?
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

Hi Gerd,

I'm looking at:

static const MemoryRegionPortio vbe_portio_list[] = {
    { 0, 1, 2, .read = vbe_ioport_read_index, .write =
vbe_ioport_write_index },
# ifdef TARGET_I386
    { 1, 1, 2, .read = vbe_ioport_read_data, .write =
vbe_ioport_write_data },
# endif
    { 2, 1, 2, .read = vbe_ioport_read_data, .write =
vbe_ioport_write_data },
    PORTIO_END_OF_LIST(),
};

which comes from:

$ git show 09a79b4974f
commit 09a79b4974fbeee660660d79ab45bd37ec416741
Author: bellard <bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
Date:   Wed May 26 22:58:01 2004 +0000

    partial big endian fixes - change VESA VBE ports for non i386
targets to avoid unaligned accesses

@@ -1774,19 +1804,27 @@ int vga_initialize(DisplayState *ds, uint8_t
*vga_ram_base,
 #ifdef CONFIG_BOCHS_VBE
     s->vbe_regs[VBE_DISPI_INDEX_ID] = VBE_DISPI_ID0;
     s->vbe_bank_mask = ((s->vram_size >> 16) - 1);
-    register_ioport_read(0x1ce, 1, 2, vbe_ioport_read, s);
-    register_ioport_read(0x1cf, 1, 2, vbe_ioport_read, s);
+#if defined (TARGET_I386)
+    register_ioport_read(0x1ce, 1, 2, vbe_ioport_read_index, s);
+    register_ioport_read(0x1cf, 1, 2, vbe_ioport_read_data, s);

-    register_ioport_write(0x1ce, 1, 2, vbe_ioport_write, s);
-    register_ioport_write(0x1cf, 1, 2, vbe_ioport_write, s);
+    register_ioport_write(0x1ce, 1, 2, vbe_ioport_write_index, s);
+    register_ioport_write(0x1cf, 1, 2, vbe_ioport_write_data, s);

     /* old Bochs IO ports */
-    register_ioport_read(0xff80, 1, 2, vbe_ioport_read, s);
-    register_ioport_read(0xff81, 1, 2, vbe_ioport_read, s);
+    register_ioport_read(0xff80, 1, 2, vbe_ioport_read_index, s);
+    register_ioport_read(0xff81, 1, 2, vbe_ioport_read_data, s);

-    register_ioport_write(0xff80, 1, 2, vbe_ioport_write, s);
-    register_ioport_write(0xff81, 1, 2, vbe_ioport_write, s);
+    register_ioport_write(0xff80, 1, 2, vbe_ioport_write_index, s);
+    register_ioport_write(0xff81, 1, 2, vbe_ioport_write_data, s);
+#else
+    register_ioport_read(0x1ce, 1, 2, vbe_ioport_read_index, s);
+    register_ioport_read(0x1d0, 1, 2, vbe_ioport_read_data, s);
+
+    register_ioport_write(0x1ce, 1, 2, vbe_ioport_write_index, s);
+    register_ioport_write(0x1d0, 1, 2, vbe_ioport_write_data, s);
 #endif
+#endif /* CONFIG_BOCHS_VBE */

     vga_io_memory = cpu_register_io_memory(0, vga_mem_read, vga_mem_write);
     cpu_register_physical_memory(isa_mem_base + 0x000a0000, 0x20000,
@@ -1814,11 +1852,9 @@ int vga_initialize(DisplayState *ds, uint8_t
*vga_ram_base,
                                PCI_ADDRESS_SPACE_MEM_PREFETCH, vga_map);
     } else {
 #ifdef CONFIG_BOCHS_VBE
-#if defined (TARGET_I386)
         /* XXX: use optimized standard vga accesses */
         cpu_register_physical_memory(VBE_DISPI_LFB_PHYSICAL_ADDRESS,
                                      vga_ram_size, vga_ram_offset);
-#endif
 #endif
     }
     return 0;

What is X86-specific here?

Thanks,

Phil.

