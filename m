Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1842C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 16:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838AC21479
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 16:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pk9++IoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838AC21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44358 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHABZ-0004FX-I0
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 12:46:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thatlemon@gmail.com>) id 1hH9Bv-000695-DQ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thatlemon@gmail.com>) id 1hH9Bu-0003Nu-Ab
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:43:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <thatlemon@gmail.com>) id 1hH9Bt-0002mS-TS
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:43:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id h4so3514602wre.7
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:mime-version:content-disposition
	:user-agent; bh=IOSzyUnCp7kikxdidSvoyq683jfE6j+woUoO45uv1Hs=;
	b=pk9++IoHSXm5HwkyTYef8ci7JBaSyN9TuIlMyYKZOOc15xuL94+fLta9eGj1fBgdA+
	j771abj2sA+tFX88b2CQate32I3Qj/F5wdfSrAKbH403kvkbNY19qNFkSHYsIMgBG+0R
	/mLrb8X+jCDHPqTnfSuR9NdbjZi2hUXpJVaPjXHLIG3GykjgCOpuLgCWC/5saXa1q4M+
	Ps645CpovOqIhVkpUU98FvKvduNI3PRV07t2SQLkvePKnDBxTP12ebjOw/LPVYMpGATK
	Od/CoLF02giUe0IghTBbmdxOTUlR67CxkVlFvqqf1HLbAYdmTuId8jzuN0gvv4TKERuY
	SpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition:user-agent;
	bh=IOSzyUnCp7kikxdidSvoyq683jfE6j+woUoO45uv1Hs=;
	b=oBaHfaf6riJSohMJIuCmt6xHh+1sBC9nMqRU5lmQj/h9oa4DG4FrNId7SmDQudKeNB
	OGTl2D8Ssyqa5b7DqtmiQwmiMigF3R4/F1uXg/O9ek2q3lp+F2m5+z5gDWNv4I1m2I8V
	6ZDNrLI7uUHE4EN3TMJq4+IpufMeBLsEwSqSaIqWJZC2y1fnxb6ZiyhGv8aUNmVZUrui
	iozC2j11X/1MDn9/h2+4ft9CtvA93OasIVcAa/orQu9Basfx44m2E0CTgZ8No8FXduLa
	KWeYQ9PpmX2LZ85dPtrh/6FCSwlR9U+Kp6kAtfxc+Rmipu+KVgVn3NLtTgW58LOzLAb4
	AC2w==
X-Gm-Message-State: APjAAAW9Cczgfsm6b0GirAAVx3J2btkM6hvk/RgJnbXkbDFiRYSRxu+z
	9eIgw6M/mh/WxrTqlRgzDuQ=
X-Google-Smtp-Source: APXvYqwyjWXIqGNiFPYSV1px9G8nmtcyheAZS6+6PiUGzCnQoZvYuPwuyxPfhUa8TXgIovgFKsEF0w==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr66623207wrn.29.1555602179702; 
	Thu, 18 Apr 2019 08:42:59 -0700 (PDT)
Received: from debian (93-43-183-29.ip93.fastwebnet.it. [93.43.183.29])
	by smtp.gmail.com with ESMTPSA id f1sm1540227wrt.87.2019.04.18.08.42.58
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 18 Apr 2019 08:42:59 -0700 (PDT)
Date: Thu, 18 Apr 2019 17:42:55 +0200
From: Giuseppe Musacchio <thatlemon@gmail.com>
To: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20190418153631.rl3lgadzrqqof72p@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
X-Mailman-Approved-At: Thu, 18 Apr 2019 12:45:54 -0400
Subject: [Qemu-devel] [PATCH] linux-user: elf: Map empty PT_LOAD sections
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
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418154255.fTwvJT5nr4gwzEJ8bUCgokPowSPOysnI0l7cyBJiyqs@z>

Some PT_LOAD sections may be completely zeroed out and their p_filesize
is zero, in that case the loader should just allocate a page that's at
least p_memsz bytes large (plus eventual alignment padding).

Calling zero_bss does this job for us, all we have to do is make sure we
don't try to mmap a zero-length page.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
---
 linux-user/elfload.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a2602..e9a0951 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2366,11 +2366,17 @@ static void load_elf_image(const char *image_name, int image_fd,
             vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
             vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
 
-            error = target_mmap(vaddr_ps, vaddr_len,
-                                elf_prot, MAP_PRIVATE | MAP_FIXED,
-                                image_fd, eppnt->p_offset - vaddr_po);
-            if (error == -1) {
-                goto exit_perror;
+            /* Some sections may be completely empty without any backing file
+             * segment, in that case just let zero_bss allocate an empty buffer
+             * for it. */
+            if (eppnt->p_filesz != 0) {
+                error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
+                                    MAP_PRIVATE | MAP_FIXED,
+                                    image_fd, eppnt->p_offset - vaddr_po);
+
+                if (error == -1) {
+                    goto exit_perror;
+                }
             }
 
             vaddr_ef = vaddr + eppnt->p_filesz;
-- 
2.20.1


