Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C29FECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C3F222BF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C3F222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wjp-0000kC-JX
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wRk-00068w-J5
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wRj-0004Qc-13
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:44 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53909)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wRi-0004Pv-P2
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:42 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MF3Y8-1hsYDp3EXQ-00FVtr; Wed, 11 Sep 2019 08:49:30 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 08:49:13 +0200
Message-Id: <20190911064920.1718-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911064920.1718-1-laurent@vivier.eu>
References: <20190911064920.1718-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XctwPDcSm58FR8JIA/1GR/JKYqhEdsyYJBACwt7866Wxq36LhJo
 ExXa6FP1Ijad+wIKMsSoixv//jNPBC7RCf4cIQJUopfC49nf2dd89CgDlOIWfSieVZ5v3KT
 ZY1HadVsoeM7cbeqMsC2yAXBXYsSm0V/+CTRQ9XVEbK5zBx8o/J3USqFKkbWI/mj8BX9WSM
 ystkQ6HLtL36d3Mt5bGcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nh4AoSULLbY=:fhqEHJHpeFd6iS5Zi5PAAm
 O3lIEH2Az+zEY1X262R1pymeaOz89mU+NkjHhulGCl2AcpoOFlcc8oKTv5xJrcnmgYCDfrk9W
 nuiQyLrpGviSvq2tL3JAQoC37c/MgfxFAzjck7try7SIIzxltH4Mg9juY8fkgWvP5mABR/qmg
 YQ8GFc2kRE4CJfMo10HN8q+o6I//7Olgtjj/NH/bZBX8wVyIxKzOYa8EofRjdVHyDGwWIV/Tz
 heAxCN3AKHzqDgOHJphvgHmS2UxHcV87cwfDvEBOdZ698W8lY4YoBawfzieZuwX4UjqBB3bA+
 kuI8f9fguUwLCvqr09qc+VQrxFVYANDn1H0ozvsxZITzUihYxtgks2HQ1K4ZyoGw25cGfxNvz
 M3xsk0uphvhgw+4OA6ObVlnNucobcwMItlDf60hX4GWLXfQuYvgVucOna4NdRd8IAfqF1ydPe
 Jw8s9Md83QsvFKYjYyMbkCds1nJBB0b+2zp9QqxRVPpUxrAZNLaIKX3ksOQBQVWR3VpO2NtNz
 8KPxhqdKliYiZhIr1fgIF27Y20nnxRnlNWZab79WzPAfza6hKiy1XV+wg3eAARY+zos1NaNU/
 2+dwmH0wVwF12EAIlWNthay6G4smddkVLvpTWAkeH9ct4v/3FGknPwMgQwjTteJUKglHUZhH2
 Ho1p7o7zlAUOvYkp8e4k/hINrf1i2x7qKEYzR9mqPX56x5xIH8Z4tNtpbngHOUjtYW6pgjm3M
 wOfkws0l54thgqKIEkzIpG7tsydALHWbVhyAkOkA4Z3Gd9NErpJ09uOf4GfoRfEWl162g5WRP
 uo+hnX4o3wqGOvFXKg+5cfvc/yunovhw+d1HQUu9mGfgBYSNDA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: [Qemu-devel] [PULL v2 08/15] linux-user: Support gdb 'qOffsets'
 query for ELF
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

From: Josh Kunz <jkz@google.com>

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


