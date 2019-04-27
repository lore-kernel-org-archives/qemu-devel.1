Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11A5C43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 16:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB862206A3
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 16:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkh4NTGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB862206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKQQ6-0005nG-W2
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 12:43:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hKQL4-0001bR-CL
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hKQ7v-0000oA-DL
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:24:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hKQ7t-0000k8-AT; Sat, 27 Apr 2019 12:24:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id c5so8859007wrs.11;
	Sat, 27 Apr 2019 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=UFl3d6OROUfKX72fgu6kYlFsyoEb1nmfkEro+y9FYv8=;
	b=Kkh4NTGRUQxWdkrGVUckXkwkA8qEKjBoBuNR7mBL3kjuhxjM60ly3mKdP3r3gKGEbz
	OGCsXSEg4qkg3HKDuD3Kp+EMqfG8/PT6I6KPr6zaq1XIpAmLvvZ1JQMWdp9b39eyHv29
	utNe8bAu8MEga9filOfdAh/M/o9lC7fwMVyc7juzF6wXl9VIhpkRKxlYybdw+Dux613h
	c9Od20Y3iEHRgjFGv0LHwD27HqKB5w/G2eNxbbpMXE9UaZkW5flKoFXowJtxR8mGM0zh
	dcgERG3oQdw1FTIqHAJyYzto4sPuSQ8rcip5pyoXJ5UzK6r135TjcM30NEOaCZBKNzpE
	sccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=UFl3d6OROUfKX72fgu6kYlFsyoEb1nmfkEro+y9FYv8=;
	b=VCQQ3O+5ajlmo+Mc65eWZCz4SRlBiSeHd47g1U8jVSlo8UuPZ5+MJT3abkwlcMr0Ld
	02SetCvvetkTf8m/UzWyWPlpz2gzWu1QzpDGumqT4ILL6NnTgp0SJuPHxxsxj5zzkyyC
	vhPFDL94gSiShiiya3BQl5Jb3I/uFe3ft8DRvshAJ44r4o2MBYY3jmuvoT8p3YMp/4wv
	wRsGUwkWoq0iEHKuoi5vySp4FUuQcXZd762u+WF4DIpDwVrXrVAXAlgu+OBvMZOwA3WM
	wG/shQBUhlFviXFDvNA+0IkLqmg/p0VYzm9myfcpzrqCA27rl5nO/Z5KrLgAsMNyp7E4
	N7Hg==
X-Gm-Message-State: APjAAAV31FHLxpP7X1v5fKXHvzNFBPf4E8Shjd5dcF5SeCT2xTPgTze8
	Q5Ik5SP2PomNVuWffezpd25sv3xK/44=
X-Google-Smtp-Source: APXvYqwb3SKFKF3q/QCHx6JDDpPUk3RTZsB4Awzk7MulCoz611m2Cb1nD36hSDy1BU82IJ5vU+mZGQ==
X-Received: by 2002:a5d:4111:: with SMTP id l17mr14603244wrp.242.1556382271115;
	Sat, 27 Apr 2019 09:24:31 -0700 (PDT)
Received: from x1.local (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	t76sm39420036wmt.8.2019.04.27.09.24.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 27 Apr 2019 09:24:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Date: Sat, 27 Apr 2019 18:24:29 +0200
Message-Id: <20190427162429.3617-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH] hw/sparc/leon3: Allow load of uImage firmwares
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Fabien Chouteau <chouteau@adacore.com>,
	KONRAD Frederic <frederic.konrad@adacore.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427162429.4lf5hAspzM4DrJLD49ynw-j3t69Qknhv5Mcx9q8llhA@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Currently the Leon3 machine doesn't allow to load legacy u-boot images:

  $ qemu-system-sparc -M leon3_generic -d in_asm \
      -kernel HelenOS-0.6.0-sparc32-leon3.bin
  qemu-system-sparc: could not load kernel 'HelenOS-0.6.0-sparc32-leon3.bin'

  $ file HelenOS-0.6.0-sparc32-leon3.bin
  HelenOS-0.6.0-sparc32-leon3.bin: u-boot legacy uImage, HelenOS-0.6.0,\
    Linux/ARM, OS Kernel Image (Not compressed), 2424229 bytes,\
    Sun Dec 21 19:18:09 2014,\
    Load Address: 0x40000000, Entry Point: 0x40000000,\
    Header CRC: 0x8BCFA236, Data CRC: 0x37AD87DF

Since QEMU can load uImages, add the necessary code,
so the Leon3 machine can load these images:

  $ qemu-system-sparc -M leon3_generic -d in_asm \
      -kernel HelenOS-0.6.0-sparc32-leon3.bin
  ----------------
  IN:
  0x40000000:  b  0x400007a8
  0x40000004:  nop
  ----------------
  IN:
  0x400007a8:  save  %sp, -136, %sp
  0x400007ac:  call  0x40000020
  0x400007b0:  sethi  %hi(0x4000b800), %i1
  ...

Tested with the following firmware:
http://www.helenos.org/releases/HelenOS-0.6.0-sparc32-leon3.bin

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sparc/leon3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 774639af33..0383b17c29 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -193,6 +193,10 @@ static void leon3_generic_hw_init(MachineState *machine)
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, NULL, NULL,
                                1 /* big endian */, EM_SPARC, 0, 0);
+        if (kernel_size < 0) {
+            kernel_size = load_uimage(kernel_filename, NULL, &entry,
+                                      NULL, NULL, NULL);
+        }
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
-- 
2.19.1


