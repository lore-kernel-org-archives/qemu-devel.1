Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829CDC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54691213F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54691213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDUcE-0005Mg-JS
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 09:47:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hDUal-0004Un-Le
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hDUak-0003fJ-J2
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:45:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:44108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hDUak-0003eC-5U
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:45:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Apr 2019 06:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; d="scan'208";a="149019414"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 06:45:37 -0700
Date: Mon, 8 Apr 2019 21:45:17 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190408134517.GA9047@richard>
References: <20190407092314.11066-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190407092314.11066-1-thuth@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PATCH for-4.0] hw/i386/pc: Fix crash when
 hot-plugging nvdimm on older machine types
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408134517.4HjrygZJ7FSq5ZyKMq73zz1JIgr6qeI2PtINEBGmCnU@z>

On Sun, Apr 07, 2019 at 11:23:14AM +0200, Thomas Huth wrote:
>QEMU currently crashes when you try to hot-plug an "nvdimm" device
>on older machine types:
>
>$ qemu-system-x86_64 -monitor stdio -M pc-1.1
>QEMU 3.1.92 monitor - type 'help' for more information
>(qemu) device_add nvdimm,id=nvdimmn1
>qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
> Assertion `*errp == ((void *)0)' failed.
>Aborted (core dumped)
>
>The call to hotplug_handler_pre_plug() in pc_memory_pre_plug() has been
>added recently before the check whether nvdimm is enabled. It should
>be done after the check. And while we're at it, also check the errp
>after the hotplug_handler_pre_plug(), otherwise errors are silently
>ignored here.

Thomas,

Thanks for pointing this out, while I have some different idea on how to fix
this.

The reason of the core dump is errp already been set in
hotplug_handler_pre_plug(), and this function check acpi hotplug capability.
The order of this check is correct, while we should  return when errp is set
in hotplug_handler_pre_plug().

I got a fix like this, which I have tested and looks good to me.


diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6077d27361..b11f3b15c1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2091,6 +2091,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 
     hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
+    if (*errp) {
+        return;
+    }
 
     if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");

>
>Fixes: 9040e6dfa8c3fed87695a3de555d2c775727bb51
>Signed-off-by: Thomas Huth <thuth@redhat.com>
>---
> hw/i386/pc.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>index 6077d27361..f2c15bf1f2 100644
>--- a/hw/i386/pc.c
>+++ b/hw/i386/pc.c
>@@ -2078,6 +2078,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>     const MachineState *ms = MACHINE(hotplug_dev);
>     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>     const uint64_t legacy_align = TARGET_PAGE_SIZE;
>+    Error *local_err = NULL;
> 
>     /*
>      * When -no-acpi is used with Q35 machine type, no ACPI is built,
>@@ -2090,13 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>         return;
>     }
> 
>-    hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
>-
>     if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
>         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>         return;
>     }
> 
>+    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
>+    if (local_err) {
>+        error_propagate(errp, local_err);
>+        return;
>+    }
>+
>     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
>                      pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
> }
>-- 
>2.21.0

-- 
Wei Yang
Help you, Help me

