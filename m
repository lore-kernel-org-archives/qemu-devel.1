Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF33C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 20:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C16F2339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 20:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAfFVdWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C16F2339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0tGm-00011O-Mk
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 16:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i0tFC-0008VL-T0
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 15:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i0tFA-0002de-SZ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 15:59:38 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:38438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i0tF9-0002cG-6L; Thu, 22 Aug 2019 15:59:36 -0400
Received: by mail-qk1-x741.google.com with SMTP id u190so6295187qkh.5;
 Thu, 22 Aug 2019 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z7eU+F8hJG4dP1DHt1U2Q9cR9W0uzmXi+9seVpOzU00=;
 b=YAfFVdWHoV1hExhNhv0L9mBEuwqbMNqI40Mctk9WW1M8LxNe1j3Zt7cVtXEDP2fCvO
 nHED+melg90ItMZIeXmqwe2CQR4Xox+6r5q+BkFNKPOZgf46ROmdFkwIET1a7ymo6efx
 GLWgKSe2eKAMyVrvZdtVpDuXQPsB3xsfgMYP0koL9kPvnEFLBuK9k5mOqioGf+BBCAZi
 1jOiNR3xipmh/BlC32HudT+ElSlHhuKfw5kuBewOcVr2o5pGuvX+beucRSDOPExyAf7o
 ATZTkT8nFywREslb4yVKnwxVyZmhEj6PLmjb/jgywG1HY2c53/9eTur9wCVNrmYqEL9v
 R1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z7eU+F8hJG4dP1DHt1U2Q9cR9W0uzmXi+9seVpOzU00=;
 b=MT025+N/5mZEUWT/QzzOA3uW4d6FnrKCDMN4RdQJnG1w0pkfdJEirls5nAE6SggKiN
 m1dYpEugdkdN49Cub+x1F7f+aRfgLgWNg3bPMB5kSQh31N3WeUWBgEn/vPnTQda6yc+q
 5SXgJ8NEx/sODNL7KtDqJ+2QyUo6Nk8clplUIrSz5vLCSkB8YiOW1D2VqME5sGpvuHni
 K/epF/OkP0sZ0M5vAGsVlcELwXHfK9ZXjeuo2cceoGzvGzwKiUAjxo4LKhXTrbHORCOK
 rOyQGDPKaTd7WWU3wacZ5qJmzz/oBLfUUrBhdut9YMfBkZplsP+bVDe8m5uKh9M3U8BO
 6E+w==
X-Gm-Message-State: APjAAAXgooy5aAcjSorV7llU2+O5/HAaEqI0acsFOUqDkprIC1PjxVFv
 NWofHyn/fy4KX+GLuGiqxsjFRGq8dgs=
X-Google-Smtp-Source: APXvYqyBjEAsLHDdzQ19pJCbGwavQ/uCfHVrViYwcAbQ5s34n2x3zAqQZplJXiHPt8o/aTnh+SkXdQ==
X-Received: by 2002:a05:620a:71a:: with SMTP id
 26mr781565qkc.374.1566503973586; 
 Thu, 22 Aug 2019 12:59:33 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:a89e:6051:b512:a55a:eccd])
 by smtp.gmail.com with ESMTPSA id o9sm247785qtr.71.2019.08.22.12.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2019 12:59:32 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 16:59:18 -0300
Message-Id: <20190822195918.3307-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [PATCH v1 1/1] spapr_pci: remove all child functions
 in function zero unplug
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is nothing wrong with how sPAPR handles multifunction PCI
hot unplugs. The problem is that x86 does it simpler. Instead of
removing each non-zero function and then removing function zero,
x86 can remove any function of the slot to trigger the hot unplug.

Libvirt will be directly impacted by this difference, in the
(hopefully soon) PCI Multifunction hot plug/unplug support. For
hot plugs, both x86 and sPAPR will operate the same way: a XML
with all desired functions to be added, then consecutive hotplugs
of all non-zero functions first, zero last. For hot unplugs, at
least in the current state, a XML with the devices to be removed
must also be provided because of how sPAPR operates - x86 does
not need it - since any function unplug will unplug the whole
PCIe slot. This difference puts extra strain in the management
layer, which needs to either handle both archs differently in
the unplug scenario or choose treat x86 like sPAPR, forcing x86
users to cope with sPAPR internals.

This patch changes spapr_pci_unplug_request to handle the
unplug of function zero differently. When removing function zero,
instead of error-ing out if there are any remaining function
DRCs which needs detaching, detach those. This has no effect in
any existing scripts that are detaching the non-zero functions
before function zero, and can be used by management as a shortcut
to remove the whole PCI multifunction device without specifying
each child function.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_pci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index deb0b0c80c..9f176f463e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1700,11 +1700,13 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
                 state = func_drck->dr_entity_sense(func_drc);
                 if (state == SPAPR_DR_ENTITY_SENSE_PRESENT
                     && !spapr_drc_unplug_requested(func_drc)) {
-                    error_setg(errp,
-                               "PCI: slot %d, function %d still present. "
-                               "Must unplug all non-0 functions first.",
-                               slotnr, i);
-                    return;
+                    /*
+                     * Attempting to remove function 0 of a multifunction
+                     * device will will cascade into removing all child
+                     * functions, even if their unplug weren't requested
+                     * beforehand.
+                     */
+                    spapr_drc_detach(func_drc);
                 }
             }
         }
-- 
2.21.0


