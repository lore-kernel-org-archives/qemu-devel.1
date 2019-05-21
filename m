Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69573C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED402173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="daR/x1bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED402173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3xU-0007qD-DQ
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:33:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3q2-0001SH-RM
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3px-0005HP-JL
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:48 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:38683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT3px-00058d-8b
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:45 -0400
Received: by mail-wr1-x435.google.com with SMTP id d18so18397815wrs.5
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=R2n/a/9G76Yi92R/Ho6SyZIUaGzncWttQDNv3ZwW0cE=;
	b=daR/x1bhZwTFeUyso7yuHYeAUMb94czQdx2FJ7KWqJyV/COHfFzYYjHPcYgo8/xAh8
	q6Vswi6pltIJLEga1/MYgPl0Tj8VdYBK12GzKyoxa4yDIH6Gf/EDPbql/QrEdQb0rdS1
	yOSBheA22pIAhykYovCVWujL7Q1jodNedDxt2tHKaTVV+YL7DSSSCxADTGNF3gIqN1gI
	X82qC/6tTjOQJHiPOMx/dR0nrvZjh2VVim7BqFL+Ug0G+jM2f+joxRNXtfY68fmDAI9q
	Uev0clPsHD0edfp+bbPflz4jxj/TkZuzax1jJbjgkzV0uXxFWwGO4l9K15sX7aLbmI4m
	CROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=R2n/a/9G76Yi92R/Ho6SyZIUaGzncWttQDNv3ZwW0cE=;
	b=LaJni3of+sO9s4Ra9tmIJU04J9LVRDkOGekKilS3JJbWfwhl0GGM8ph+sCKttripfx
	K74JSDtzE9W3LcxRIGA2fm2wS2xrHZyMi6a1JuRMZrpFrl6KdsgD81GUfA8r+aCPiVp2
	vbzLItg8WT5e6psTQAC7mQYnuWd3DiVI/to4ROu35vQBtmsw/4wP0PHaWprI0BE/LhwL
	HDmLXVtZJ8YRpsd/FKXJQkQTIFy4rJgLWIm4T5G5/2sK+V3UzbhcIB/LYENpuWJBezzC
	IayP/dKm3tkfvxW6W8KhWWcAj553y/4OGbXzeBgQlYF21tKgC7bujO9Hy9FOa4MG6MRd
	dwmQ==
X-Gm-Message-State: APjAAAXnqAIHnx10gVDdBH7WVra77DjoCC9kFLtVK6Ha7RSQEwa2OOw2
	zNhEa3P4wzCJ+npavue3v60lLb9+s6g=
X-Google-Smtp-Source: APXvYqxSDXRoT40s5TujUbbb6L96UFY5Z5mh1MA7NUk5sdFbqt5ecPVa0EA+AYGXmclBi0BOJ/Y0bw==
X-Received: by 2002:adf:9bd2:: with SMTP id e18mr577759wrc.210.1558441532719; 
	Tue, 21 May 2019 05:25:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	u11sm12233393wrn.1.2019.05.21.05.25.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 05:25:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 13:25:16 +0100
Message-Id: <20190521122519.12573-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521122519.12573-1-peter.maydell@linaro.org>
References: <20190521122519.12573-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [RFC 07/10] memory.h: Fix kerneldoc syntax issues
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

If you try to use kerneldoc to extract the doc comments from
memory.h and run sphinx on it, it generates some warnings:
 * various functions are missing a parameter in the docs
 * some 'unexpected indentation' warnings where a list
   isn't marked up with the leading/trailing blank lines and
   bullet markers that rST expects

These aren't the only issues, but they are the only ones
that are actually warned about (as opposed to generating
misformatted output).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9144a47f571..8447a16ded1 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -907,6 +907,7 @@ void memory_region_init_rom(MemoryRegion *mr,
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
  * @ops: callbacks for write access handling (must not be NULL).
+ * @opaque: passed to the read and write callbacks of the @ops structure.
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -995,7 +996,7 @@ static inline IOMMUMemoryRegion *memory_region_get_iommu(MemoryRegion *mr)
  * Returns pointer to IOMMUMemoryRegionClass if a memory region is an iommu,
  * otherwise NULL. This is fast path avoiding QOM checking, use with caution.
  *
- * @mr: the memory region being queried
+ * @iommu_mr: the memory region being queried
  */
 static inline IOMMUMemoryRegionClass *memory_region_get_iommu_class_nocheck(
         IOMMUMemoryRegion *iommu_mr)
@@ -1558,6 +1559,7 @@ void memory_region_add_subregion_overlap(MemoryRegion *mr,
 /**
  * memory_region_get_ram_addr: Get the ram address associated with a memory
  *                             region
+ * @mr: the memory region to get the ram address for
  */
 ram_addr_t memory_region_get_ram_addr(MemoryRegion *mr);
 
@@ -1650,6 +1652,7 @@ bool memory_region_is_mapped(MemoryRegion *mr);
  *
  * Returns a #MemoryRegionSection that describes a contiguous overlap.
  * It will have the following characteristics:
+ *
  *    .@size = 0 iff no overlap was found
  *    .@mr is non-%NULL iff an overlap was found
  *
@@ -1657,11 +1660,12 @@ bool memory_region_is_mapped(MemoryRegion *mr);
  * relative to the returned region (in the .@mr field), not to the
  * @mr argument.
  *
- * Similarly, the .@offset_within_address_space is relative to the
+ * Similarly, the @.offset_within_address_space is relative to the
  * address space that contains both regions, the passed and the
  * returned one.  However, in the special case where the @mr argument
  * has no container (and thus is the root of the address space), the
  * following will hold:
+ *
  *    .@offset_within_address_space >= @addr
  *    .@offset_within_address_space + .@size <= @addr + @size
  *
@@ -2107,6 +2111,7 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
  * @addr: address within that address space
  * @attrs: memory transaction attributes
  * @buf: buffer with the data transferred
+ * @len: length of the buffer
  */
 static inline __attribute__((__always_inline__))
 MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
-- 
2.20.1


