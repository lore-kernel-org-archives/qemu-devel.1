Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599C6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D8A2063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjxD2eU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D8A2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hwK-0005ev-8S
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqf-000274-9L
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqd-00052R-BU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id r2so15584248wrs.8
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XcQr9DiPENUPIE3CD01s1WxYBmCB3zN6mRhoJ+NEZto=;
 b=DjxD2eU7f2SAT0L56uqL9rK+czAH3pk8lup4/uu/6rAHIteZHOSTY7a+vZraNMQxSq
 oloLQ/sN4K1VTpvzDbYNf6u/AY9yYu3GPKInq+az68tc5GDYQf56edswwqnEFf/zr4Qm
 W75p3JVwHwYls+IxLRrFlV5MHoUFzBJ1ROtbhaorp0cGTGjYWe9KO+m/I8/SyB+Yq7mV
 UbQrjSRAO1bJMDHoc1GWKo2bNjQEFrXZjstbwAN7F7o4Pr9TAUlc7D35znQ2n/SA0r81
 TNpYOHOMV0kJrLrFZFILZLxBu4SrdX3FvCqAvEbXcxSKV0uCGbqCevxmxL/W4tdDm5kJ
 VBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=XcQr9DiPENUPIE3CD01s1WxYBmCB3zN6mRhoJ+NEZto=;
 b=oaTobzuFCtir/Uo0SRJ0uU7dRFyZ6U68JXPvRgRAFqBTVpxWhNckbUpm1QqXvJrDwT
 /ACZS6ifjzUQm3JKrNyyM2gVQaMoFMYsFrZN9z+1QYp73jUmc1ny976Cwe9ILsiQHA/E
 HViTWw6H50+hlxYAT5juyzXw7CL2ZnQeeuaZhA01SBAP3FmxblOL2BR/q1I1+xdtd73k
 NhtWRG69Aexm75uMlFHNmE2ZPU+iB9ppE5oVQfV6Ce5zQQht7bFSAFrSEC5rPJa8O26d
 k7Mi18tdg+z5D+nQygaiZUWWA0qXC4/G1fIE8wAU3+x6ttAXqS86wvKIn1GmR+BWN6tw
 S4vw==
X-Gm-Message-State: AOAM533lcTwdGCm4+8ota4XkU63R1y3v5olSZaakejPHN//36sQACdT5
 CIRV5m3w4jbAGP31a1CQC/oy4SK9SEI=
X-Google-Smtp-Source: ABdhPJwVdfNfmVBxfhXBXJNk2DMMtw+pZ3nBWte4mwFabTKpyLUiHg+opOghTpC8kVA/5VHgNyPhrQ==
X-Received: by 2002:adf:b352:: with SMTP id k18mr16838828wrd.386.1597681136581; 
 Mon, 17 Aug 2020 09:18:56 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r3sm29535472wro.1.2020.08.17.09.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 09:18:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 0/9] hw/misc: Add support for interleaved memory accesses
Date: Mon, 17 Aug 2020 18:18:44 +0200
Message-Id: <20200817161853.593247-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a follow up on last year patch from Stephen Checkoway:
"block/pflash_cfi02: Implement intereleaved flash devices"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg613077.html

Instead of making the PFLASH device more complex, I went
implementing a generic interleaver device (that can be re-used
for other MMIO devices, probably pointless, still useful for
simple testing).

The series is available on [1] and is organized as:

1/ Fix a pair of issues in memory.c as we are not exercing much
the memory_region_[read/write]_with_attrs_accessor functions (see
also [2]).

2/ Allow to use qtest helpers with the 'none' machine (without any
CPU).

3/ Add the interleaver device

4/ Add a device to test the interleaver device (later I'll expand
it to other MMIO accesses, such access_with_adjusted_size, endianess
and unaligned accesses). Let the 'none' machine create this device
from command line.

5/ Add qtests using 4/ to test 3/.

6/ Add a way to display the interleaved memory (sub)regions in
the HMP 'info mtree' command.

Based-on: <20200816173051.16274-1-f4bug@amsat.org>
[1] https://gitlab.com/philmd/qemu/-/tree/interleaved_device-v1
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg730279.html

Philippe Mathieu-Daudé (9):
  memory: Initialize MemoryRegionOps for RAM memory regions
  qtest: Add local qtest_mem_as() getter
  qtest: Directly use global address_space_memory when no CPU available
  hw/misc: Add interleaver device to make interleaved memory accesses
  hw/misc: Add MMIO test device
  hw/core/null-machine: Allow to use the MMIO 'test' device
  tests/qtest: Add generic MMIO tests
  memory: Allow memory region to display its subregions own descriptions
  hw/misc/interleaver: Display subregions in 'info mtree'

 include/exec/memory.h         |   6 +
 include/hw/misc/interleaver.h |  40 +++++
 include/hw/misc/testdev.h     |  15 ++
 hw/core/null-machine.c        |   2 +
 hw/misc/interleaver.c         | 283 ++++++++++++++++++++++++++++++++++
 hw/misc/mmio-testdev.c        | 150 ++++++++++++++++++
 softmmu/memory.c              |  32 ++++
 softmmu/qtest.c               |  40 +++--
 tests/qtest/mmio-test.c       | 146 ++++++++++++++++++
 MAINTAINERS                   |   9 ++
 hw/misc/Kconfig               |   9 ++
 hw/misc/Makefile.objs         |   2 +
 hw/misc/trace-events          |   6 +
 tests/qtest/Makefile.include  |   1 +
 14 files changed, 728 insertions(+), 13 deletions(-)
 create mode 100644 include/hw/misc/interleaver.h
 create mode 100644 include/hw/misc/testdev.h
 create mode 100644 hw/misc/interleaver.c
 create mode 100644 hw/misc/mmio-testdev.c
 create mode 100644 tests/qtest/mmio-test.c

-- 
2.26.2


