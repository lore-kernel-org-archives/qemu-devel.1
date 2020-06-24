Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FE3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4050920663
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyMZa9g2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4050920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2fp-0002Og-G5
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jo2f0-0001aG-AQ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:29:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:33017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jo2ex-000857-NW
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:29:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id j94so1766482wrj.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=L/M44pw6Sj0jQWJNPY8bz6QSJKszKrTbkOfiJgdRQek=;
 b=hyMZa9g2LwQq2bNyRHjHVcBMtvyxaNClreQTHyu0tZWF91VEgE6oZmacss4GjgSkY+
 u39aWTKO7HGT8igc6iob4PPqflkB54QBBF9iS9fWfM4UJsUFIXzGARc/wQOfR+UEFLTP
 ljNLB0/A+sRqJQui5OcDuXf1tRGz5vg0r6lK01qiZAzfbBB2YivPRYCTsbyx/79sE4/+
 PKOa9KfLumpomoYN7ciSDWHpasR8L/AA+3eX0I9dt48zAyyiKGn+/v0IDINHy0blMIhg
 bPE6UMiNocQBNzwsZpVfqq6GwIxFBYGGI2tTgC6KlxQ1nxyE1e/d1emwEVWhqBiuTDEr
 BGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=L/M44pw6Sj0jQWJNPY8bz6QSJKszKrTbkOfiJgdRQek=;
 b=Ev4wvKasJadA3G31vXVfeb6eHcfjU6rQMbZHNzJ12Fu5NiY7k1auSsbcxKf1ZA7dke
 h9b45lX1F4vXu7bd7paXZSUubsxbWd23EcOOcZW+CPvobqIYlNSPbDN2j9I7m2N78Oda
 UeWKQ54JW3Qh7wYlUqpi9YuGbh0r74zI/6cUuBOLCRCRLtLIvnIRp3P/y6AYgjymBJcR
 /Eyd+0NFB2wg7pdY3dZFLCjimSVcxLfnw1AuAlOBkAU9Y/lszPX99crLI15Jl6tuKYs2
 P1HnRqX4qCY5gJurYTYmE50Jib+bXNad6NR0SqqlGWSLySLSF0evvKGuixRI28wscDU9
 dtJQ==
X-Gm-Message-State: AOAM5308dRBHZNFm2w3P9v0ezyJonzY0+aD32AbxJQIjMH2rC4ieIgkj
 9XozJuB9+RT6Z+mAFLr7tcg=
X-Google-Smtp-Source: ABdhPJxE9feSwol6Kklwvh3VZkAguHITTU8sBNe2WESkl417qGR/iAhk29Jn3pdBYy/8JQSBkI1htg==
X-Received: by 2002:adf:f350:: with SMTP id e16mr27815906wrp.43.1592994578119; 
 Wed, 24 Jun 2020 03:29:38 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-236.amazon.com. [54.240.197.236])
 by smtp.gmail.com with ESMTPSA id e5sm24855173wrs.33.2020.06.24.03.29.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jun 2020 03:29:37 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Jason Andryuk'" <jandryuk@gmail.com>
References: <CAKf6xpuSD3NC2bLPQN75e2pR8asu9Ey1xTGxTNeCR_1MGsnPOg@mail.gmail.com>
 <ac4dfe3b-7981-49bb-25a2-08578da150d5@ilande.co.uk>
 <CAKf6xpvs6mNowsiAzbfQGLGp0aY0zKgUD=DVpSorWHycm--J8g@mail.gmail.com>
 <87k0zykwdl.fsf@dusky.pond.sub.org> <000001d64953$f67a1f00$e36e5d00$@xen.org>
 <CAKf6xpt02SndxVkhqy52z7ZPCHtOhX1R5d7JQbeC8tVauBRm4Q@mail.gmail.com>
In-Reply-To: <CAKf6xpt02SndxVkhqy52z7ZPCHtOhX1R5d7JQbeC8tVauBRm4Q@mail.gmail.com>
Subject: RE: sysbus failed assert for xen_sysdev
Date: Wed, 24 Jun 2020 11:29:36 +0100
Message-ID: <000801d64a12$5c7c11f0$157435d0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQIJfv1jP4fCJU6d0eNUL65zTb1lhAKJjZPCAZLY/IEByWeHdwFU8pWtAkUeRcOoNSQ3UA==
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reply-To: paul@xen.org
Cc: 'Anthony PERARD' <anthony.perard@citrix.com>,
 'xen-devel' <xen-devel@lists.xenproject.org>,
 'Mark Cave-Ayland' <mark.cave-ayland@ilande.co.uk>,
 'Markus Armbruster' <armbru@redhat.com>, 'QEMU' <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Jason Andryuk <jandryuk@gmail.com>
> Sent: 24 June 2020 04:24
> To: Paul Durrant <paul@xen.org>
> Cc: Markus Armbruster <armbru@redhat.com>; Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>; Anthony
> PERARD <anthony.perard@citrix.com>; xen-devel <xen-devel@lists.xenproject.org>; QEMU <qemu-
> devel@nongnu.org>
> Subject: Re: sysbus failed assert for xen_sysdev
> 
> On Tue, Jun 23, 2020 at 7:46 AM Paul Durrant <xadimgnik@gmail.com> wrote:
> >
> > > -----Original Message-----
> > > From: Markus Armbruster <armbru@redhat.com>
> > > Sent: 23 June 2020 09:41
> > > To: Jason Andryuk <jandryuk@gmail.com>
> > > Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>; Anthony PERARD <anthony.perard@citrix.com>;
> xen-
> > > devel <xen-devel@lists.xenproject.org>; Paul Durrant <paul@xen.org>; QEMU <qemu-devel@nongnu.org>
> > > Subject: Re: sysbus failed assert for xen_sysdev
> > >
> > > Jason Andryuk <jandryuk@gmail.com> writes:
> > > > Then it gets farther... until
> > > > qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly:
> > > > Assertion `dev->realized' failed.
> > > >
> > > > dev->id is NULL. The failing device is:
> > > > (gdb) p *dev.parent_obj.class.type
> > > > $12 = {name = 0x555556207770 "cfi.pflash01",
> > > >
> >
> > Having commented out the call to xen_be_init() entirely (and xen_bus_init() for good measure) I also
> get this assertion failure, so
> > I don't think is related.
> 
> Yes, this is something different.  pc_pflash_create() calls
> qdev_new(TYPE_PFLASH_CFI01), but it is only realized in
> pc_system_flash_map()...  and pc_system_flash_map() isn't called for
> Xen.
> 
> Removing the call to pc_system_flash_create() from pc_machine_initfn()
> lets QEMU startup and run a Xen HVM again.  xen_enabled() doesn't work
> there since accelerators have not been initialized yes, I guess?

Looks like it can be worked round by the following:

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1497d0e4ae..977d40afb8 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -186,9 +186,12 @@ static void pc_init1(MachineState *machine,
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory,
                        rom_memory, &ram_memory);
-    } else if (machine->kernel_filename != NULL) {
-        /* For xen HVM direct kernel boot, load linux here */
-        xen_load_linux(pcms);
+    } else {
+        pc_system_flash_cleanup_unused(pcms);
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
     }

     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index ec2a3b3e7e..0ff47a4b59 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -108,7 +108,7 @@ void pc_system_flash_create(PCMachineState *pcms)
     }
 }

-static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
+void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
     char *prop_name;
     int i;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e6135c34d6..497f2b7ab7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -187,6 +187,7 @@ int cmos_get_fd_drive_type(FloppyDriveType fd0);

 /* pc_sysfw.c */
 void pc_system_flash_create(PCMachineState *pcms);
+void pc_system_flash_cleanup_unused(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);

 /* acpi-build.c */


> 
> Regards,
> Jason


