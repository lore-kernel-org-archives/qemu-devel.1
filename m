Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31502C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F061320644
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDvnjP8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F061320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2tm-0000hE-6M
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jo2sw-0008R1-3d
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:44:06 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jo2su-00077Y-7o
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:44:05 -0400
Received: by mail-pl1-x644.google.com with SMTP id 35so924405ple.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=crJOGTJIhgzNMNcqLm3cWyp+Nn5GJBKZ9M1TJO+NThw=;
 b=iDvnjP8eQo3Z/sD44yErgBuEPFGrsJcvdioveH8K4Q9xx09siJFN/NSS4ShnNweRtB
 uz77JCC2Y1NfGg7K7ly9amOyTQrklmkbIHRhpRK0jAV2NVkaE8nzbtXanwskVPOXYztU
 LiqWLwf+aJ0WvN31l1O7Yt7Aulnj2heo9Ld0P+0aylW3XMeQfo1e5o5JTtsswCBAZa8c
 jCTKrVuVXPGcf3i+j0YBK20UPoRq5tEqHmhPhaIxytI2riM0EtT1n25XptmiYoowsfIW
 qJ3Iwt6zQEMjU6TzW02KwbaJcP4vM323P8i3vPMIx5trhSG6SHvC/gcJnbn5CNIcXrG5
 Ozdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=crJOGTJIhgzNMNcqLm3cWyp+Nn5GJBKZ9M1TJO+NThw=;
 b=i/NMIdWp+5bJx5AmJrb552uUrTtqvqr7vgKS7C7fkDXqycEWbt6AJtbLLZRTJ0Xw1y
 OKbiF3czkyNTS/sN8QoCu4vXlCGOLY89agsad5FJBO9nx+z/xymzy1Uq1y3bvg6oh6k/
 sffz+vBdXhFOKxha5N+PDgJskK7A3HNsb2lMMAUxrf7M5rNStkFCkGzmCU7+t4DR3Zd+
 t2JFRqr6DFEgmolfw5HewsrhU56Fyn4AjWHTBEs6gQSuinH9SvcofzXoMTmcqmpBld2E
 zEedUIU45mtFvtBQCF5ST0selsamJJD8d8JuwtmQvpqHRS0a59/sVo/7Ci29K/HhgCFI
 oEGg==
X-Gm-Message-State: AOAM530rCnwI3zX1Ia5mElh4FiR9LWZ684g4pC5L4qlyZVctp1gLmsU7
 GPFR+CzfN3QuelIptPnsxD0=
X-Google-Smtp-Source: ABdhPJw3nDrv+OGyQgFCPX7g8EmJ00NDSp31bio5AsfAZ+Ai50a1uUt9M5VBlbILcxNrY3J8HKZsDQ==
X-Received: by 2002:a17:90a:260b:: with SMTP id
 l11mr29252429pje.210.1592995442435; 
 Wed, 24 Jun 2020 03:44:02 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id q6sm19772395pff.163.2020.06.24.03.43.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jun 2020 03:44:01 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V6 0/4] mips: Add Loongson-3 machine support (with KVM)
Date: Wed, 24 Jun 2020 18:45:27 +0800
Message-Id: <1592995531-32600-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
Loongson-3A R4 is the newest and its ISA is almost the superset of all
others. To reduce complexity, in QEMU we just define two CPU types:

1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
   suitable for TCG because Loongson-3A R1 has fewest ASE.
2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
   suitable for KVM because Loongson-3A R4 has the VZ ASE.

Loongson-3 lacks English documents. I've tried to translated them with
translate.google.com, and the machine translated documents (together
with their original Chinese versions) are available here.

Loongson-3A R1 (Loongson-3A1000)
User Manual Part 1:
http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf
http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P1.pdf (Chinese Version)
User Manual Part 2:
http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf
http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P2.pdf (Chinese Version)

Loongson-3A R2 (Loongson-3A2000)
User Manual Part 1:
http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf
http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf (Chinese Version)
User Manual Part 2:
http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf
http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf (Chinese Version)

Loongson-3A R3 (Loongson-3A3000)
User Manual Part 1:
http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf
http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.pdf (Chinese Version)
User Manual Part 2:
http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf
http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.pdf (Chinese Version)

Loongson-3A R4 (Loongson-3A4000)
User Manual Part 1:
http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf
http://ftp.godson.ac.cn/lemote/3A4000user.pdf (Chinese Version)
User Manual Part 2:
I'm sorry that it is unavailable now.

We are preparing to add QEMU's Loongson-3 support. MIPS VZ extension is
fully supported in Loongson-3A R4+, so we at first add QEMU/KVM support
in this series. And the next series will add QEMU/TCG support (it will
emulate Loongson-3A R1).

We already have a full functional Linux kernel (based on Linux-5.4.x LTS
but not upstream yet) here:

https://github.com/chenhuacai/linux

How to use QEMU/Loongson-3?
1, Download kernel source from the above URL;
2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
3, Boot a Loongson-3A4000 host with this kernel;
4, Build QEMU-5.0.0 with this patchset;
5, modprobe kvm;
6, Use QEMU with TCG (available in future):
       qemu-system-mips64el -M loongson3-virt,accel=tcg -cpu Loongson-3A1000 -kernel <path_to_kernel> -append ...
   Use QEMU with KVM (available at present):
       qemu-system-mips64el -M loongson3-virt,accel=kvm -cpu Loongson-3A4000 -kernel <path_to_kernel> -append ...

   The "-cpu" parameter is optional here and QEMU will use the correct type for TCG/KVM automatically.

V1 -> V2:
1, Add a cover letter;
2, Improve CPU definitions;
3, Remove LS7A-related things (Use GPEX instead);
4, Add a description of how to run QEMU/Loongson-3.

V2 -> V3:
1, Fix all possible checkpatch.pl errors and warnings.

V3 -> V4:
1, Sync code with upstream;
2, Remove merged patches;
3, Fix build failure without CONFIG_KVM;
4, Add Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>.

V4 -> V5:
1, Improve coding style;
2, Remove merged patches;
3, Rename machine name from "loongson3" to "loongson3-virt";
4, Rework the "loongson3-virt" machine to drop any ISA things;
5, Rework "hw/mips: Implement the kvm_type() hook in MachineClass";
6, Add Jiaxun Yang as a reviewer of Loongson-3.

V5 -> V6:
1, Fix license preamble;
2, Improve commit messages;
3, Add hw/intc/loongson_liointc.c to MAINTAINERS;
4, Fix all possible checkpatch.pl errors and warnings.

Huacai Chen(4):
 hw/mips: Implement the kvm_type() hook in MachineClass
 hw/intc: Add Loongson liointc support
 hw/mips: Add Loongson-3 machine support (with KVM)
 MAINTAINERS: Add Loongson-3 maintainer and reviewer

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 MAINTAINERS                          |   7 +
 default-configs/mips64el-softmmu.mak |   1 +
 hw/intc/Kconfig                      |   3 +
 hw/intc/Makefile.objs                |   1 +
 hw/intc/loongson_liointc.c           | 241 +++++++++
 hw/mips/Kconfig                      |  11 +
 hw/mips/Makefile.objs                |   1 +
 hw/mips/loongson3_virt.c             | 978 +++++++++++++++++++++++++++++++++++
 target/mips/kvm.c                    |  20 +
 target/mips/kvm_mips.h               |  11 +
 10 files changed, 1274 insertions(+)
 create mode 100644 hw/intc/loongson_liointc.c
 create mode 100644 hw/mips/loongson3_virt.c
--
2.7.0

