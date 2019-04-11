Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84AAC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B18420818
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKcSMSjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B18420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbMS-0001No-SH
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:11:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hEbKW-0000Dg-8z
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hEbKU-0003es-Ce
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:09:31 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:42459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fintelia@gmail.com>)
	id 1hEbKQ-0003b4-J0; Thu, 11 Apr 2019 11:09:28 -0400
Received: by mail-lj1-x235.google.com with SMTP id v22so5854185lje.9;
	Thu, 11 Apr 2019 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=GhmylOpb5Yv5dSJKFVWQF6g1fmd6lBnSdN6XJjjnrXM=;
	b=JKcSMSjH1gQoC7eSmzl0iq1rAUuY/3ThbEWoq14DClfPySb42ynCyP3p1Wzx1ncCaN
	IFTrT5avkGkH9v7tAO/la9tQgypBtMlbTsdguWyalad/mCsP4iGRiK6jIB/Nyt2mJyOx
	3FdnBN7HDVhGkNiAh7DNSgbCEWm9EbDfqZCGELBvDMEzld4+t3SLlFF1yFbk3xqK7Hy3
	RcExy3jyi8Qb+smNtTdRjqUe557uuqo9FYcSgzN1KN7vEyN9Zh1msgFq/UgPJwOqVZhn
	/wwCglpK5jJruc5wxY6st1xqbndk/pleNOBJWNtIy9n/exh4MWJ01D3RFF7zujFNPUZv
	bo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=GhmylOpb5Yv5dSJKFVWQF6g1fmd6lBnSdN6XJjjnrXM=;
	b=KlbyhZ1jsLAsaB7Kr1010IVaN+IHEbjFEqygcNhJJn3MrljN1I2buIDLBuDVzeND98
	n4VbNCpx3lFGEal98hxUJcAjlKmi205Hj7ylWqS+mrP2CBaoMFaDtyCH0Avlrkjy6TUS
	XF4Ox06wiw73HvIl05e9H6M7OFZNJQdG/gpgSyxip2SkiSvnzt2BdmFiW0nOmPswlPkZ
	purS6wIJJ2Z0VpQ0uKQwFqkrRHOBOZiHu8ZTZtnk9g4a48eutTu/BCj8221LkwNgQP+Q
	vxgbEaFvWI9Smydkzegm2GHPxV56TXtfKDHXMYxt9YsF896t3WW3GN3ro8iVdJnJ8e6N
	+zzg==
X-Gm-Message-State: APjAAAVVqAtoEsdK1Z35+uV0eYNYM3gDy8Nbi6yM7936gje62g48oWmj
	1YauWc9IrVmfOrOwGtTc0yc7Qdjj+9j9xFL7RZrMs4lvGSU=
X-Google-Smtp-Source: APXvYqxJgtSyxPInmxlpp7Mc6eimiiqvep4fOqZFpOhpB9+563HtulAG4Fbcc7/MVXMjOKVg6lLcpRnO6RhjChY328E=
X-Received: by 2002:a2e:9812:: with SMTP id a18mr23881501ljj.146.1554995364357;
	Thu, 11 Apr 2019 08:09:24 -0700 (PDT)
MIME-Version: 1.0
From: Jonathan Behrens <fintelia@gmail.com>
Date: Thu, 11 Apr 2019 11:08:57 -0400
Message-ID:
 <CANnJOVF2gE3b-C5zSb85SGoP+9cD9xOQQ5Z4tmsGouagR3xo0Q@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::235
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH v2] target/riscv: Remove unused include of
 riscv_htif.h for virt board riscv
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
	Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411150857.pmc2aHpcUqd2fei33x5TH4Mg5iW_xMOePFIih569K7w@z>

Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
---
 hw/riscv/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index fc4c6b306e..3526463034 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -29,7 +29,6 @@
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
 #include "target/riscv/cpu.h"
-#include "hw/riscv/riscv_htif.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_clint.h"
-- 
2.20.1
