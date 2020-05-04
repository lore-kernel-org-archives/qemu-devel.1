Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0738AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08D7206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08D7206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdes-0001A3-V6
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVy-0001PB-CE; Mon, 04 May 2020 12:00:18 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVw-0005nY-5U; Mon, 04 May 2020 12:00:17 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MA7X0-1jPXum20HS-00Bccv; Mon, 04 May 2020 18:00:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/19] elf_ops: Don't try to g_mapped_file_unref(NULL)
Date: Mon,  4 May 2020 17:59:44 +0200
Message-Id: <20200504155956.380695-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f+vpvirZHuRjvIciBk9UcbBzY51RKB7hnElLVSfcmmYBp6mxs0J
 HxuKMLIMnjBJhT31m5V0SPS6c2U+ywNe1Y12Als2WuZl9cRnh5frwzmijdOwUzeUduhM6HW
 qnLDcKEX4p7BosWThczVeDqiBCjiCxuG3KWYCX3KT191c+B+JTCQsLc/NFrth278ORe088P
 mWQAqwPaLzlEvYeIfnNlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zt1BNX0Nszg=:87pJDOrPwdPruObCNNdWMh
 0FrqtSD0/+QZqvoGPyoPy/tcGcv1ErgfL5gj77iMStR3cM/q+Donm7I/RPGvszC8qwfcym6W1
 O0CvlpIDAyF45xKkwFW9YWJPbbPWq57rtv4H6KpspF9IQI81Vba1FpisjCwtZYntEK+a1QalQ
 VTeIVA+60uE8JgTtAvf7cBtYb9Fmkm/fdYlwsF/NyxtLzlx3tqUa+I/lD7TTRA+fsyoSMnbTO
 xTmh6eZTcs4DSSXwPN3pf1CvhLS8JdOx4kDX6VBF9HJlJhTEWnkhJkIs9vGG9QZhDd1zU7GEK
 ucUVBqTMOGqmJaNDrBhyRiwtz7B0AHcyHsNqC/ISIdEP3aH8se9KKShG54LJ5y6lBVRGVX6fw
 ea7vDqy/cdZkm5Jy5EIIlXdRz78V/HoBGs4FtfKVUj6QjiK/+2sikKziQSU2W30pCHTUL0ONp
 lqpqUR8Xi4Zk36AAwGUpIdA6DbgDZu5AeGPljWWREFKU2Eju+DIxs5vDxgj35Y+mZDzBNK4Jo
 npKauCzU+3NgP6kI/GMCQtI2Fusn1Ehfw8zjCp/H7KS53PMUDH8jiUy+qX7FmLNtmiQq5BKjc
 Awx9ZTpCRRs3yclNDe2t1h6vZI3AJT14AsR2KQl9H3yZbMbVwDLvd4TLvvxngcDG4rK5UM935
 by9Jk/Z0eFRZMlqJgQ4bzlAkNSXBlp4bwDI51nRIjCi7hogzAqp81FabWEYbkV+/a7g91XXR6
 OxPPKTQlffT4e8MbZSMzx9fXK1I01C04tTO26oJA58eEpfkGXrM5Wt+DF4/7l2/u5TpQFnpPl
 OgA/iNujadxhb5F1oKzgLcckFRd6eaG+/mw8+L8Ln9WRiDgEUBllYrAM+QbSIZP7q8xLDsN
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 11:59:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Randy Yates <yates@ieee.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Calling g_mapped_file_unref() on a NULL pointer is not valid, and
glib will assert if you try it.

$ qemu-system-arm -M virt -display none -device loader,file=/tmp/bad.elf
qemu-system-arm: -device loader,file=/tmp/bad.elf: GLib: g_mapped_file_unref: assertion 'file != NULL' failed

(One way to produce an ELF file that fails like this is to copy just
the first 16 bytes of a valid ELF file; this is sufficient to fool
the code in load_elf_ram_sym() into thinking it's an ELF file and
calling load_elf32() or load_elf64().)

The failure-exit path in load_elf can be reached from various points
in execution, and for some of those we haven't yet called
g_mapped_file_new_from_fd().  Add a condition to the unref call so we
only call it if we successfully created the GMappedFile to start with.

This will fix the assertion; for the specific case of the generic
loader it will then fall back from "guess this is an ELF file" to
"maybe it's a uImage or a hex file" and eventually to "just load as
a raw data file".

Reported-by: Randy Yates <yates@ieee.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200423202011.32686-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/elf_ops.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index e0bb47bb678d..398a4a2c85bb 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -606,7 +606,9 @@ static int glue(load_elf, SZ)(const char *name, int fd,
         *highaddr = (uint64_t)(elf_sword)high;
     ret = total_size;
  fail:
-    g_mapped_file_unref(mapped_file);
+    if (mapped_file) {
+        g_mapped_file_unref(mapped_file);
+    }
     g_free(phdr);
     return ret;
 }
-- 
2.26.2


