Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F02C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E542173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDj+XYvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E542173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52841 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT404-0001BD-4E
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:36:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3q2-0001SM-Sk
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3pw-0005G1-W8
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT3pw-0005A4-NC
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id b18so18328012wrq.12
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/6fZvTwbiNEGi+N3ZL26FN4PNtHy8EurrYMXN2rAFp0=;
	b=UDj+XYvN3CAPWQnMdjGuz4CBG2eXrGv5r1RTbJ5659Pur1V7x/o2dqcIhR9uJmbk/s
	AcNGLJg0M6HRtF8iD9VgWFR4VBc2t8smBsx2Cen+BHEy4Bef3cy9FaJy3WlO7ARQXNjz
	QqTuMTW4f115rdGfd9Ln3ddpA1L4mqDoQ0wTJQoUsX18PISmGT643c/9yS5bOK/glGx8
	JzB/3kdwz0a1VSPLrdR9THRrwjoQA72s/WhlhVvYCC00giQLn2kqWOa2W4OMpjaNAdg5
	w1CyXIqjn1JVNCKWXVCA1cAHwnlp0Nt7SFjCjZZP5N8raTSx17ERl/bur5EH+pDL4V5V
	uYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/6fZvTwbiNEGi+N3ZL26FN4PNtHy8EurrYMXN2rAFp0=;
	b=sJOcm66bDn29Z4/dtKL6MLGrdpKLpjt60kJ2xiUhZrc3wBCAqZl8kOGQb1H95S2PRR
	G06qhOpsDj2U0B2gWpCjiH3jpH34YPzc8fJCDDsLoYe/dcjG+WJArLqgFgZWWU0fI8pr
	GVSwuPOc8hj2gUpjSeR9wtcE8rVA1/VNjUASNJEK+3YxPEbHS2lREdgsUI412clmVkW3
	wBLAMJNbpOPWbBDHk4eHvilT/jfmcVJba6lGsyi70ahsfvdgM7AmTPcPz/O+En8xqUfq
	BM7ZyJ5whOKLaUOeSUIv05Za26S5lHioult/rr+9NGY+wDNpjXTY7EeD7yd6rRp0XXGI
	DTpA==
X-Gm-Message-State: APjAAAW8dlLOV/AlthysvC2lrspekKKI1Iz2hAJDq6wqUML7YuoRrpyr
	NMXNW5nVPzcynI5f7uq9GyBBtRsIg+8=
X-Google-Smtp-Source: APXvYqxSErixkeNMSitVLX6eEjsluk4iknCHa8akyiEY8p1EsaSEmfLFRI2zEPo9MrWYXOMvz8DaZw==
X-Received: by 2002:a05:6000:1284:: with SMTP id
	f4mr38158764wrx.325.1558441535220; 
	Tue, 21 May 2019 05:25:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	u11sm12233393wrn.1.2019.05.21.05.25.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 05:25:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 13:25:18 +0100
Message-Id: <20190521122519.12573-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521122519.12573-1-peter.maydell@linaro.org>
References: <20190521122519.12573-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [RFC 09/10] memory.h: attempted kernel-doc fixes
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	"Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

kernel-doc needs the "struct" or it complains that it
can't parse a function prototype which is actually a struct
definition.

Note that this then creates a lot of warnings about
undocumented struct fields...
---
 include/exec/memory.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8447a16ded1..d0f35be1c3b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -208,7 +208,7 @@ enum IOMMUMemoryRegionAttr {
 };
 
 /**
- * IOMMUMemoryRegionClass:
+ * struct IOMMUMemoryRegionClass:
  *
  * All IOMMU implementations need to subclass TYPE_IOMMU_MEMORY_REGION
  * and provide an implementation of at least the @translate method here
@@ -224,8 +224,10 @@ enum IOMMUMemoryRegionAttr {
  * attributes and the output TLB entry depends on the transaction
  * attributes, we represent this using IOMMU indexes. Each index
  * selects a particular translation table that the IOMMU has:
- *   @attrs_to_index returns the IOMMU index for a set of transaction attributes
- *   @translate takes an input address and an IOMMU index
+ *
+ * -  @attrs_to_index returns the IOMMU index for a set of transaction attributes
+ * -  @translate takes an input address and an IOMMU index
+ *
  * and the mapping returned can only depend on the input address and the
  * IOMMU index.
  *
@@ -398,7 +400,7 @@ struct IOMMUMemoryRegion {
     QLIST_FOREACH((n), &(mr)->iommu_notify, node)
 
 /**
- * MemoryListener: callbacks structure for updates to the physical memory map
+ * struct MemoryListener: callbacks structure for updates to the physical memory map
  *
  * Allows a component to adjust to changes in the guest-visible memory map.
  * Use with memory_listener_register() and memory_listener_unregister().
@@ -432,7 +434,7 @@ struct MemoryListener {
 };
 
 /**
- * AddressSpace: describes a mapping of addresses to #MemoryRegion objects
+ * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
  */
 struct AddressSpace {
     /* All fields are private. */
@@ -472,7 +474,7 @@ static inline FlatView *address_space_to_flatview(AddressSpace *as)
 
 
 /**
- * MemoryRegionSection: describes a fragment of a #MemoryRegion
+ * struct MemoryRegionSection: describes a fragment of a #MemoryRegion
  *
  * @mr: the region, or %NULL if empty
  * @fv: the flat view of the address space the region is mapped in
@@ -1653,8 +1655,8 @@ bool memory_region_is_mapped(MemoryRegion *mr);
  * Returns a #MemoryRegionSection that describes a contiguous overlap.
  * It will have the following characteristics:
  *
- *    .@size = 0 iff no overlap was found
- *    .@mr is non-%NULL iff an overlap was found
+ * -   .@size = 0 iff no overlap was found
+ * -   .@mr is non-%NULL iff an overlap was found
  *
  * Remember that in the return value the @offset_within_region is
  * relative to the returned region (in the .@mr field), not to the
@@ -1666,8 +1668,8 @@ bool memory_region_is_mapped(MemoryRegion *mr);
  * has no container (and thus is the root of the address space), the
  * following will hold:
  *
- *    .@offset_within_address_space >= @addr
- *    .@offset_within_address_space + .@size <= @addr + @size
+ * -   .@offset_within_address_space >= @addr
+ * -   .@offset_within_address_space + .@size <= @addr + @size
  *
  * @mr: a MemoryRegion within which @addr is a relative address
  * @addr: start of the area within @as to be searched
-- 
2.20.1


