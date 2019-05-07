Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18DDC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7468206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgJcs7K6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7468206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNyr5-0002lJ-RA
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:05:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylq-0007ab-EF
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNyll-0003XP-7s
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNyll-0003PJ-0o
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id s15so21912548wra.12
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=rDd8j3zLrg/PkW3/m3AjSO85H/8lBtQfTCQzKKkNESw=;
	b=JgJcs7K697m0+LElRqtx6dBE9S4ixMNTXwpCTaLfGp5WT3ZYVibgc0kWNRD1uwlvRT
	4+6RPNSDUO5WG9h3ANXVbLKUKtKp+VjzA6lVXlhNjWrmTKfiyGqjkrPiRvskg4QTec61
	dcBxDgEwsk0YMlz0GlWI84LJvnrUX7WLcVNh3kPAb2eYXid7iTpO1fVYHxvlltwLUoi8
	MhNQ+Fs3XIJHGwAwBc7uIN8wRKfirNWo3yDAQK1vhQ1ByYmrHvoP8uTizY/DcaxIuHxg
	GR9G/Hfwh9sO+aIrmy/kX2LI5Pmtck0w5JM+7QuH9uav0IloQF/38MlqM92XYACMLhwx
	R5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=rDd8j3zLrg/PkW3/m3AjSO85H/8lBtQfTCQzKKkNESw=;
	b=Q/5wILZ26GZP3uJN7Auq+ggbZ/l0YcZCC/IdcKneU6cZRyEYo+CBq4eTtvhJb/Pshw
	v5iB3mkzndh3Ev4aT7/PNp5Kz5hjVyq2JKbu9OWth46nKewh9XzuVxy3DX40WmPcPfXk
	NYEIfxroQiZ2EcLVf6hragTMbo1EMtnzGi4Q9GVq1CmUt6PK+BGi33H7AXdFL4PBsHt7
	TcL7aNlGuUkU8f1CqUPjkWH2OAPHWzmOUzAN2loa0ryMMTmHF2wamB0PdDc9A6XxKRpQ
	O9/4nHkJez1sFRbBJDkcXHyE60Hf1+6e+ShPbECoQyNw3xh47rKuKSbe7ly810l+O8J5
	tDJQ==
X-Gm-Message-State: APjAAAWEKKGFRX9NL1I9tLnkRW/06+ApgLyv1Xd4/x8Tadd1187e//GD
	P+KzryFFiBQb4djLPBqGPVRpP2nYTvg=
X-Google-Smtp-Source: APXvYqy3XkZpNZ0z4xM6d6fh5otSu7YFD3G+iEl6zM+vVYhEedXyQakO6DrqibTExkVVmLGEPC/bSw==
X-Received: by 2002:adf:afcd:: with SMTP id y13mr6871079wrd.270.1557230420157; 
	Tue, 07 May 2019 05:00:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.18
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 13:00:00 +0100
Message-Id: <20190507120011.18100-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
References: <20190507120011.18100-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 04/15] hw/arm/raspi: Diagnose requests for too
 much RAM
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Raspberry Pi boards have a physical memory map which does
not allow for more than 1GB of RAM. Currently if the user tries
to ask for more then we fail in a confusing way:

$ qemu-system-aarch64 --machine raspi3 -m 8G
Unexpected error in visit_type_uintN() at qapi/qapi-visit-core.c:164:
qemu-system-aarch64: Parameter 'vcram-base' expects uint32_t
Aborted (core dumped)

Catch this earlier and diagnose it with a more friendly message:
$ qemu-system-aarch64 --machine raspi3 -m 8G
qemu-system-aarch64: Requested ram size is too large for this machine: maximum is 1GB

Fixes: https://bugs.launchpad.net/qemu/+bug/1794187
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 hw/arm/raspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 66899c28dc1..fe2bb511b98 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -175,6 +176,12 @@ static void raspi_init(MachineState *machine, int version)
     BusState *bus;
     DeviceState *carddev;
 
+    if (machine->ram_size > 1 * GiB) {
+        error_report("Requested ram size is too large for this machine: "
+                     "maximum is 1GB");
+        exit(1);
+    }
+
     object_initialize(&s->soc, sizeof(s->soc),
                       version == 3 ? TYPE_BCM2837 : TYPE_BCM2836);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
-- 
2.20.1


