Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C623C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A2D2075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A2D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38761 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWba-0006Nu-H1
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:43:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLt-0007yS-8X
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLr-0003Zy-UT
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:41 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51901)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWLr-0003Yq-IV; Fri, 03 May 2019 07:27:39 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1Mmhs6-1gvfmw3Cty-00jruY; Fri, 03 May 2019 13:27:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:26:53 +0200
Message-Id: <20190503112654.4393-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503112654.4393-1-laurent@vivier.eu>
References: <20190503112654.4393-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Yr6N8DVUuZAek6d2wIuyKkCulINgbzvSwJs77413ZEOeSlYO+1k
	DhJEgZCCHuvHdyBsNqrx1P7P+RuElo0e3mL8i15Gd1gLR73wZ9+dbABkcKjIm/y9DZbjDk6
	cxlNzWYvaigJwrL5xY83Z8Kl5AZP8jQV5ezLDuZytdBFhnvgSE+YVWos1DHHCmbjLFRpkrt
	FKJ26tniVeGz9Q8zqWKRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ldkHbtITqlE=:CCU2hx6y84NcCvOwpyx2jG
	4M188hiX8HxLd5cscIXGiAcRVb7K+pGc7NCfKl378rJJKji7i4aG5474D+MymO9llCeM8c7vT
	JLcLvJeHs4edYHxmiRreylmYnDQx8uqLZ9mGubxZAdWwhkpmPP00Rrd6woM/GVaq8NQ/k/fnt
	mYJoSvLe1h8Ftrmc4lqdCfH9TH+AcCBo8HUpvk+Qq7wCZmqu+ZNAEO37wmBj2IW21rN2RUr9S
	o9iF9ncZnjDPuuL0bqSlguMPJrmoyRyWNggS7CX8R6nD/r0/N4VplToVv2+VW9CvE9cj33DLX
	7IQYFjQgOb6/lQsziYcfF/cxzvAKN/UAMICurHFY/tskF2mnvfYAqFU9mp8SCIYeTa1L7yeYQ
	wOPO13LK+y8gt8n+tppZDUCEqeokJrZAFD/lXglGzedDFhObbO9ayfnT5yTze9gunxVxOevCJ
	uNr6YYm8XY10y5esEVD1kB8yFT8N6KWt7Si4xQ83Qp76KrPTtCabMkQ22GHLiB2FKdTHErGfc
	qJpbJqSRiEwffFtvaufk9EE/CPYTF/CMS3IMLAlgHy/9U04yN5aCSMGJjWVDxta6N2SWb7/kM
	bV+SLp7U3MlR4RBcFALNxBpkM8pZaSes+GdYjrm6SXxUYk1az6I9BYPHFrQyOh2iA74HPKCK2
	JkfFc9vI/+N9w1pOGJJjjU5G0ena3XVK16NwkLwYVynVl1SCfL5Vy7Rrbc7JU3haazOxccJLV
	uPp0n7d2R1HqR205EH9x/RVM4YnbYYE+No/1ANO5D4ySLcZpbR4cPtuBN8g=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL v2 11/12] hw/sparc/leon3: Allow load of uImage
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	KONRAD Frederic <frederic.konrad@adacore.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503112653.TfqnQ8FR26cU_XMsJ-YqmekEJXNmwx0i3hsB_oMzCoI@z>

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


