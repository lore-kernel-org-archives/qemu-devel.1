Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B39C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8BA2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8BA2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jHo-00073C-N5
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j80-0004kk-Na
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j7z-0002DN-AT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:28 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48975)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j7z-0002CC-1q
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:27 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M3D7V-1i8Z8K2Mur-003gFE; Tue, 10 Sep 2019 18:36:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:53 +0200
Message-Id: <20190910163600.19971-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8PuUuQxpps+wGdANSUaUT5KRfXwI2yvSl82GB/fy8bNwTtWQ/25
 Rt2kjnf70qVUBpL76pgVd/F1VpC/GGwwP/a6TWZo7APfgMlZ8EfVEmubDa+3BZJnQHm574x
 ZyB6WGnz9uCGB4ZG9TPJ2jGdbWVlPqIs0+vzkcOiF8sMH0r3Kbwm6ue3ywmEjtg6jFK/nWZ
 GEGsu5wxTqtLki0L1cG/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T9nXBAJdT98=:fSoo2oRLEhiZ4orgYZh4Hy
 myTMbFW44J8cWZakmnlJPPs4JEh9qYh9E3Ii5qsgDyyae+duGUT5NMnKTBTt94JkZy8kk0bTw
 OUUlTrLplIF/Ii0Qm+ht+4qs66VpYvqZ/GB2tediG3InHvi54lJZXUiWbc5quRa2zrJN+Nv1Q
 z+IbYA0LMFiZfzenm+GrBZJU71xglsbE30N2uc+9XGPcg6qfmzw96maXlw4jc5VbiUeuaEm+s
 IOyaLs6kEAWL4//eozSoq6EfzsKwMsH8nMn43BwCXq5qr91ZAl2YakQT1R0AHXI1YlNS/2vaO
 vO0hvMwYrNqhfDnsCw9IY2WlTgc3x/yqdBby0Or+xGKqs0NMUasSrSQzC4ryMYmoTEMlPfN53
 iIkNHGIW7qCoMQ1T2+7MVZQtYoa/sKdHqf4j2yom7berMIWpcrQccRz1vjPe02s66CdYpvQXU
 wYQYonVFZq9hhgjiIX9fdgDeP0lbiQuWvTV8GnZA3MGrFOcWaaH1uV+n52lfl0BFVd7ncil3S
 tOXo6soIq409AV5Tcmoz4BqVgYi7G7LBXLgAIlDeUwzhTftpRZlKp3rBcH9ApcR5SVwnbBiPc
 EDktiWauoS41U1u6vgytnSF0yw6JsJ3Gs3/ntEAhbAzcrEHr8jdGIRq2Se+2CAXH3HeX6iy46
 nFP9JOSOVYFQ6qZnXkFTQknGzCRbnfpDj1S7jqM/DDE3v+9IHRbsNTKVlv1VXkDS3NN9MR/LO
 y8Ruj+I1XyLL1JicO8mrHQe6AerPBmAlt4hhKHIZaBtClRkb/BEuz1kZiJSDXeiXdLjFbtTZl
 1xdFFA0mBR/UZWEpVXdH8okcqLUplCvnxC0H24ETenomai/i7c=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL 08/15] linux-user: Support gdb 'qOffsets' query
 for ELF
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Josh Kunz <jkz@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Josh Kunz via Qemu-devel <qemu-devel@nongnu.org>

This is needed to support debugging PIE ELF binaries running under QEMU
user mode. Currently, `code_offset` and `data_offset` remain unset for
all ELF binaries, so GDB is unable to correctly locate the position of
the binary's text and data.

The fields `code_offset`, and `data_offset` were originally added way
back in 2006 to support debugging of bFMT executables (978efd6aac6),
and support was just never added for ELF. Since non-PIE binaries are
loaded at exactly the address specified in the binary, GDB does not need
to relocate any symbols, so the buggy behavior is not normally observed.

http://sourceware.org/gdb/onlinedocs/gdb/General-Query-Packets.html#index-qOffsets-packet

Buglink: https://bugs.launchpad.net/qemu/+bug/1528239
Signed-off-by: Josh Kunz <jkz@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190816233422.16715-1-jkz@google.com>
[lv: added link to documentation]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 43c16a846d33..f6693e576098 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2403,6 +2403,8 @@ static void load_elf_image(const char *image_name, int image_fd,
     }
 
     info->load_bias = load_bias;
+    info->code_offset = load_bias;
+    info->data_offset = load_bias;
     info->load_addr = load_addr;
     info->entry = ehdr->e_entry + load_bias;
     info->start_code = -1;
-- 
2.21.0


