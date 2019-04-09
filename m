Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF104C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F662084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKWoLD40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F662084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45294 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtD9-0005AQ-PW
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:02:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5u-00085V-GB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5t-0004h5-5l
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDt5s-0004Yt-OZ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id c1so2754825wml.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=GhKLXN4x2Bh28KK1khKEa4UYDz15n5B2iNQEOKiXWDU=;
	b=cKWoLD40bDwygYPNvWRBvY3qZSsxFEhVr8mEw0aqsYbO/2XBcwjPyYlEiRfhaknMhg
	3Ytt06vf7abySROspb2mKhtA/+gXBlywU6eW/mkpawFNbplJdZ+raOMwR7p2WYh0hUGY
	yWqWYNjzIpI0r56ZzqB6CEEg2bThvgPHkIwhdXw9idbLZLPgTe+JqULeoVFDPuJNMw/+
	uFFSpTJH5Kbja7Hm4mFLZhv1j4JV5eroC+vU8/rgLmsKmrqoFFC+SoPrC7oxp1imWaCZ
	+jFWhbFscP6kRtNYeBAAbCSpiTsWOjstyudyb5Mzcuamw7g3gyK8rS8yTa6Ropm7xpKS
	OnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=GhKLXN4x2Bh28KK1khKEa4UYDz15n5B2iNQEOKiXWDU=;
	b=E7D2lL8MBQYDEN3Ikf3GhkFF2eZXVaYXNpU+WjcZqG4mc3WivDLD2sTj6m7pY7HbEl
	d0xUD0ha2nbOLApaaKwUZlllFjidB3umOoq1ofpf68l8Qi15g+lk9HBEHU/Ctpg7hOdu
	4TtydmiFovr+tcNi8pEat8wE2N1KZ/mth6SZsu6BNra9Jd1x0780fXD/j0ENvc/uy1wS
	cU/c2FO5026j+GyqPX0vuePrmnreumPheqLaV7r6HQahFinKFr3jbBbChCN+LgJmMgy4
	Wz0zOPKZmr0i+WAI627k2eitgEuDk2lPXw1M4wf40QbCo2Wt+AjziCqFIeNPrVAqXSsU
	pLAQ==
X-Gm-Message-State: APjAAAVlMwhK+mJuHbFq/9yBA06ia7AyMlyVtHjoN1hLlGSatoRwdhxZ
	gP4n2pRb4/Gp8gB0tiCuXcYqcaNT
X-Google-Smtp-Source: APXvYqytC9j4er2lGii0cKFz5V5jD7BDBwqhBO91bKHMXoVcQqtKWGhairomXfOoLK2JLKg4D93r5Q==
X-Received: by 2002:a1c:808c:: with SMTP id b134mr21818519wmd.16.1554825318737;
	Tue, 09 Apr 2019 08:55:18 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	g84sm23117586wmf.25.2019.04.09.08.55.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 08:55:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 17:55:12 +0200
Message-Id: <1554825316-33288-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
References: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 1/5] roms: Rename the EFIROM variable to avoid
 clashing with iPXE
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409155512.AsCryHoI0PvtpcWgHL9TqP68aTQLJJBARU5kkoh0qtg@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The iPXE's 'veryclean' recipe removes $(EFIROM) even if the EFIROM
macro originates from elsewhere:

  $ git checkout f590a812c21~
  $ make -C roms clean EFIROM=$(type -P EfiRom)
  make: Entering directory '/source/qemu/roms'
  [...]
  make -C ipxe/src veryclean
  make[1]: Entering directory '/source/qemu/roms/ipxe/src'
  rm -f bin{,-*}/*.* bin{,-*}/.certificate.* bin{,-*}/.certificates.* bin{,-*}/.private_key.* bin{,-*}/errors bin{,-*}/NIC ./util/zbin ./util/elf2efi32 ./util/elf2efi64 /usr/bin/EfiRom ./util/efifatbin ./util/iccfix ./util/einfo TAGS bin{,-*}/symtab
  rm: cannot remove '/usr/bin/EfiRom': Permission denied
  make[1]: *** [Makefile.housekeeping:1564: clean] Error 1
  make[1]: Leaving directory '/source/qemu/roms/ipxe/src'
  make: *** [Makefile:152: clean] Error 2
  make: Leaving directory '/source/qemu/roms'

Before f590a812c21 this variable could be overridden or unset,
and the 'veryclean' Makefile rule would not complain.

Commit f590a812c21 enforces this variable to the Intel EfiRom
tool provided by the EDK2 project.

To avoid the name clash and make the difference between the
projects obvious, rename the variable used by the EDK2 project
as EDK2_EFIROM.

Fixes: f590a812c21074e82228de3e1dfb57b75fc02b62
Reported-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190409134536.15548-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 roms/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 78d5dd1..d28252d 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -47,7 +47,7 @@ SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
 # We need that to combine multiple images (legacy bios,
 # efi ia32, efi x64) into a single rom binary.
 #
-EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
+EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
 
 default:
 	@echo "nothing is build by default"
@@ -102,8 +102,8 @@ pxe-rom-%: build-pxe-roms
 
 efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
 
-efi-rom-%: build-pxe-roms build-efi-roms $(EFIROM)
-	$(EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
+efi-rom-%: build-pxe-roms build-efi-roms $(EDK2_EFIROM)
+	$(EDK2_EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
 		-b ipxe/src/bin/$(VID)$(DID).rom \
 		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
 		-ec ipxe/src/bin-x86_64-efi/$(VID)$(DID).efidrv \
@@ -120,7 +120,7 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
 
-$(EFIROM):
+$(EDK2_EFIROM):
 	$(MAKE) -C edk2/BaseTools
 
 slof:
-- 
1.8.3.1



