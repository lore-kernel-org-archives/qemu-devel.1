Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD27C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 883282173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vnEU13DR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883282173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT40I-0001Pw-RU
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:36:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3q4-0001U6-Mm
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3pw-0005G3-Vd
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT3pw-00057w-N0
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id e15so18403506wrs.4
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=uepm/tgVGvk2ZbI1+hCKv4c6WBeYrsTqZ1hQF2HFmEo=;
	b=vnEU13DRzO/+QhfrSenmnXb8vqzq/j7ubcYC+eMNcXj/H/niDAgNMIUlGxiPPxTbeN
	bnEgqupVUJwa+6kGz1SbC+5Ee73bhFI0p9XGn+wxTkbkFuqwqa1OxKjwBU+WoFemRoSY
	UQi89+fVxc3XaiS027YOk02WQhJWLYp/RCfcXYKDjoEs5R86guZgD2hvyn8aaUaiH/GW
	4mT4goHvHEYij6D+eM2kj9hO/2ocPw1t9lxVHuPaCHXUa93ZQu/ogJeUQ0dtwqkLtlJM
	jSXltd5Py0V4PSpqc7es/KeZ39PIvUkWPULR7DT/BzAjBAlHC9dwEyP6k6t8LsOZn0ct
	7pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=uepm/tgVGvk2ZbI1+hCKv4c6WBeYrsTqZ1hQF2HFmEo=;
	b=RYAmVjdcvopr4H5dC0nVY/JB9FhZV9UyrOVPiT1qBRdCvAX36KWBfWPVTs1ZIu+dN3
	3M4kyPDns4vxyMSUwp+lqqz0HDvj4jWuOOLp3IMVSpYW3OYXxJ/fjAGcGeU8Ky2xnXRb
	l5fdiE1ZuAP2BhNsgv8kxoVT504xzW6ZVRh1GZNMVXJkbdKoDhret4V7S18gPyFDvBts
	YTLXtglWs/X2S0wAgybboL3A7B0Y2ObAa9cAYobu7z/6alYpjzfDBWMgzZeXiWg1Dcr4
	84qbJpPi19UkkMOLLuVBzXs9krfzDUUrHfuFVfSpAb6pslHMSwJAS8r3u+QNEdokKtTe
	MWzg==
X-Gm-Message-State: APjAAAWNNSH108M/zAr8tTvswlR/Bn0B60Zdh8X5D88FaIKztEfYpVVk
	XXFUxekkAaT2w2o9NM1BrGXLmNqJpwA=
X-Google-Smtp-Source: APXvYqweJlDeUrjOYsija94FGi9SwtnDdp6HnxGL1nhZ60Utin63umGk8YbBKOZwdZWAIp/uyETn1w==
X-Received: by 2002:a5d:55c9:: with SMTP id i9mr985311wrw.261.1558441531476;
	Tue, 21 May 2019 05:25:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	u11sm12233393wrn.1.2019.05.21.05.25.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 05:25:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 13:25:15 +0100
Message-Id: <20190521122519.12573-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521122519.12573-1-peter.maydell@linaro.org>
References: <20190521122519.12573-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [RFC 06/10] docs: Create bitops.rst as example of
 kernel-docs
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

Create a bitops.rst which is just a container for the
kernel-doc comments in qemu/bitops.h.

This is mostly a test of the kernel-doc extension machinery.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/bitops.rst | 8 ++++++++
 docs/devel/index.rst  | 1 +
 2 files changed, 9 insertions(+)
 create mode 100644 docs/devel/bitops.rst

diff --git a/docs/devel/bitops.rst b/docs/devel/bitops.rst
new file mode 100644
index 00000000000..6addaecf8d7
--- /dev/null
+++ b/docs/devel/bitops.rst
@@ -0,0 +1,8 @@
+==================
+Bitwise operations
+==================
+
+The header ``qemu/bitops.h`` provides utility functions for
+performing bitwise operations.
+
+.. kernel-doc:: include/qemu/bitops.h
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 2a4ddf40ad3..49cb212a8b4 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -21,3 +21,4 @@ Contents:
    testing
    decodetree
    secure-coding-practices
+   bitops
-- 
2.20.1


