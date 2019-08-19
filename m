Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F4C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 23:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4C820644
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 23:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4C820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzrJR-0000N7-Pp
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 19:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1hzrIm-0008H1-UJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 19:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hzrIl-0002R9-8j
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 19:43:04 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:24818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hzrIl-0002OR-2T
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 19:43:03 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 3743674581E;
 Tue, 20 Aug 2019 01:42:59 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 11F9B7456E3; Tue, 20 Aug 2019 01:42:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0E1807456D5;
 Tue, 20 Aug 2019 01:42:59 +0200 (CEST)
Date: Tue, 20 Aug 2019 01:42:59 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <20190819061545.7qeiyonvvqe3s6up@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1908200126020.56805@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1908190208150.57965@zero.eik.bme.hu>
 <20190819061545.7qeiyonvvqe3s6up@sirius.home.kraxel.org>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: Re: [Qemu-devel] Machine specific option ROMs
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019, Gerd Hoffmann wrote:
> On Mon, Aug 19, 2019 at 02:38:09AM +0200, BALATON Zoltan wrote:
>> I know about the possibility to set the option ROM of a PCIDevice with the
>> romfile property (that we can set on command line or in a device's init
>> method) but is there a way to set it depending on the machine that uses the
>> device? If this is not currently possible what would be needed to allow
>> this?
>
> Should work with compat properties.  That is a list of device, property
> and value which a specific machine type should use.  Typically they are
> used to make versioned machine types behave simliar to older qemu
> versions (this is where the name comes from).  Using them to use
> non-default properties on ppc platform should work too.
>
> For example in qemu 1.5 the nic roms got EFI support and there is a
> compat property which switches the pc-i440fx-1.4 (and older) machine
> types to the non-efi versions.  Grep for pxe-e1000.rom to find the code.

OK thanks, looks like something like this works:

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index c5bbcc7433..8ee937e3ce 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -569,6 +572,10 @@ static int core99_kvm_type(MachineState *machine, const char *arg)
     return 2;
 }

+static GlobalProperty compat[] = {
+    { "VGA", "romfile", NDRV_VGA_FILENAME },
+};
+
 static void core99_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -587,6 +594,7 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7400_v2.9");
 #endif
     mc->ignore_boot_device_suffixes = true;
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     fwc->get_dev_path = core99_fw_dev_path;
 }



Mark, do you think this could replace the current way of passing this 
driver via fw_cfg and would you accept patches to OpenBIOS to revert the 
ndrv patching to replace that with this solution? (The vga_config_cb 
already adds the driver from the ROM when set as above so no further hacks 
are necessary. If we want we can keep the vga-ndrv? option to control this 
adding NDRV from ROM after the current use of this setting is no longer 
needed.) I think this would allow some simplification and also avoids 
patching ati-vga with this driver without needing to add vga-ndrv?=false 
manually. (In the future this same way can also be used to pass proper 
FCode ROMs to OpenBIOS.)

Regards,
BALATON Zoltan

