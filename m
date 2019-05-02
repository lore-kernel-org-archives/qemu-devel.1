Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A85C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9662081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9662081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57526 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMH6f-0004q3-3i
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 15:10:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvx-0003x6-LN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvw-0003Ji-Gu
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:53 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMGvr-00037s-Ux; Thu, 02 May 2019 14:59:49 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1N18MG-1gbgno05v8-012YBD; Thu, 02 May 2019 20:59:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 20:58:34 +0200
Message-Id: <20190502185835.15185-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502185835.15185-1-laurent@vivier.eu>
References: <20190502185835.15185-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:etxrxyk3g6X+Z5FhH+RnYk0C83SJR5qHK8q7N9KYUZGb8a4tPZb
	iq/Y3sgd6Vw9JLD+pMqFifrsR+HUK9sk8TkF6KsxSD9uOY+7f7JLvbxtOl8hih1WYRZFOdZ
	zlGy7X3Y7iQM+IXG/OqMHyjKYXSmfXaLBpVT2d7Gvp60WBgSKXp+WRE8R3ESjDHoa3iEmft
	m3h5SOrU/lZwHa3Z/fHbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wWgyZLtQSP8=:i5VQcNGCsivLO7nHSV/6Hw
	lGumRQn5vy4nlg8RtkOiFj8SOkRRUP7TCfGFL4HPT6JGrzHdpwyLjQR84T2sE59+rf4XPsH5M
	FbEssvsyoBAXb6auDYZXdgqXNWUkaokgwMAlQjeNX8WlEWvrXOM/D4mtbBkCC0mWAH4kBB2cb
	OfLMVi1lMqQcuRn8hNB/743Xhplb1SYSR2oi7Nrag1D6A47NLjSkGd0cks2oK2Z2aD4ue+ZVD
	pooITY9NtF/5zwmJItsHgo3g6zpoznm4Md1ZeVp00l3FRZNTIP5KbLoEKJ/AXD1EhTJr7pERK
	t0KIkwZ/C50Oz1+OnOO3GeJgm3F8tHcuXBYSpHS6lkDAeN3t17HSeBQXnUS78XnLMN+UvNq19
	/YaFjr3EAsLac3AxAWV+IBBEg0f89OAqDvHaxG2/vmUkZCipjCA59SLvDRZwwNj7MQpbVzVbS
	3IJYDze40tXPW5s0YEb4ZTtY8FyzoCwbt+Q+7EecKCiglkyP4kvcogfpdKTOIwRobSCDta6lE
	Uvc9OukuRxBU+5YR/w8fS1szBZtaPRks/55io4DK3peim/6ZNDVpqhlxEWY0uh427FG5wOT6z
	JwdFZiz0LXsPAgNWbOEFD8E7IoisaOeb00iJlcBsY2nENXPj6kzRDmx2jD63F2fhW5hD0uA1i
	qrkwlUK05igTP/vgC1K7hgWak6uVExaT8nNBW2UuAUsr/LSvl5KLKWHBQqem/kBxC5VqfQFE+
	sjUHdmyQ2q+4knY6NUITACjvMwpDZIVIZ5WjlB7rgNLxHVKeJ7nA3YwtRZ8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PULL 12/13] hw/sparc/leon3: Allow load of uImage
 firmwares
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
	KONRAD Frederic <frederic.konrad@adacore.com>,
	Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Fabien Chouteau <chouteau@adacore.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502185834.MI3HEsB9W8l3INw9bntY1epW-5Nbuj1U-YIMiRr3Nz0@z>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20190427162922.4207-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/sparc/leon3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 774639af3393..0383b17c298f 100644
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
2.20.1


