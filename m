Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98896C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692FB20739
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ipcAzkzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692FB20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOrQ-000796-DA
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jCOqS-00068b-PC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jCOqR-00062c-AT
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:29:56 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:38072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jCOqQ-000618-Vc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:29:55 -0400
Received: by mail-pj1-x102b.google.com with SMTP id m15so2038147pje.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=fWm6ba1Z78PmHbDjv3mFvfgdbVhWqfDgRF9aol4iv50=;
 b=ipcAzkzbgVW/BHuN3GD5rnirXjlZaqgqsZ3/aTkGyDCrElMB0eAfqmzCQYIlGCFzkN
 VyExw2St0yyIybXopJLuDltEqZa1ycwNdGTSdSdL0GQCKWvZ2qwZjYdSfxHy7WfFlKV9
 +4kjiq5SvJGra9GyP+H4mD9v7D6YlXIub34hGZUQEZkZuMgTSSjBgKqdrq3eQZBdBTbJ
 L4S3Q2jsJAXiGkAeyjue0LDzKEOkNoUuZnMbe/zxa9GgY5/d/lJSZByclRSJ3ACy55ri
 EnCjBTDJSAKXhOFEAcnOlkcI4S+GmycV2xsCmcecMjApynVTA3PoEAOnfTn5sIptfFCT
 s5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=fWm6ba1Z78PmHbDjv3mFvfgdbVhWqfDgRF9aol4iv50=;
 b=khi4DV/9yBe0+p02YZKmO/s8JWHHVY7L14rGjXy5y/15fXKcaxOi5dWW0vPjNneJ9X
 CYCwjJUdejsGhQF5XS1R/SypSdqxx62HVNFqmHE+NM2dWo3UP0Pk+5Im6UMJK83J4ROy
 xwKr9jySY5NEU9+rn5QXcMZI2VrWhB4sWt5/tmVwHDoE5nAPhu+tZA0Kax8F7y2Ydd6u
 egeB6iw3g4/xTDduARSyXgSCyCIAGIWB5rZsCCbLZ6TQQZW+ao9ig5pHz1fedompr0Bp
 xTac0/E7bNQASp3au+zZGFpKBafaAsPwXRBi3wJQTHstVqas9zQ4lgRhjo/pcdou88NR
 r3MA==
X-Gm-Message-State: ANhLgQ0OL0hSwODBy/yDZ31rrdEt0A5h++SjV/ZqAg4Ekt0/asLNtqVA
 JCkHrq2sVysBtZVemz99G/XtUvEqHR4=
X-Google-Smtp-Source: ADFU+vs4vhqLm2NMJtxMPknXpFf3G2SZ1nf8L2jtXBRztmLVJCcUty/Gi6yM2GWC64etpZuOlNcUFg==
X-Received: by 2002:a17:90a:1b6a:: with SMTP id
 q97mr4237589pjq.187.1584023391664; 
 Thu, 12 Mar 2020 07:29:51 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:845e:b9f6:81a6:8f5e])
 by smtp.gmail.com with ESMTPSA id 63sm14832651pfx.132.2020.03.12.07.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 07:29:50 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/10] tests/vm: Add support for aarch64 VMs
Date: Thu, 12 Mar 2020 10:27:18 -0400
Message-Id: <20200312142728.12285-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102b
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is version 4 of the patch series to 
add support for aarch64 VMs in the vm-build infrastructure.
 - Ubuntu 18.04 aarch64 VM
 - CentOS 8 aarch64 VM

V3: https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg02805.html 

Changes in V4.
- Removed the target validation we had put into Makefile.include.
- Corrected a dependency on a later patch in gen_cloud_init_iso().
- Changed the consume console patch to make draining the console to a 
  buffer optional.  This fixes the acceptance test issue.

Robert Foley (10):
  tests/vm: Fix issues in gen_cloud_init_iso
  tests/vm: Add configuration to basevm.py
  tests/vm: Added configuration file support
  tests/vm: add --boot-console switch
  tests/vm: Add ability to select QEMU from current build.
  tests/vm: allow wait_ssh() to specify command
  tests/vm: Added a new script for ubuntu.aarch64.
  tests/vm: Added a new script for centos.aarch64.
  tests/vm: change scripts to use self._config
  tests/vm: Add workaround to consume console

 configure                         |  25 +++
 python/qemu/console_socket.py     | 162 +++++++++++++++++++
 python/qemu/machine.py            |  23 ++-
 tests/vm/Makefile.include         |  27 ++++
 tests/vm/aarch64vm.py             | 100 ++++++++++++
 tests/vm/basevm.py                | 253 ++++++++++++++++++++++++------
 tests/vm/centos-8-aarch64.ks      |  51 ++++++
 tests/vm/centos.aarch64           | 226 ++++++++++++++++++++++++++
 tests/vm/conf_example_aarch64.yml |  51 ++++++
 tests/vm/conf_example_x86.yml     |  50 ++++++
 tests/vm/fedora                   |  17 +-
 tests/vm/freebsd                  |  16 +-
 tests/vm/netbsd                   |  19 +--
 tests/vm/openbsd                  |  17 +-
 tests/vm/ubuntu.aarch64           | 117 ++++++++++++++
 15 files changed, 1072 insertions(+), 82 deletions(-)
 create mode 100644 python/qemu/console_socket.py
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml
 create mode 100755 tests/vm/ubuntu.aarch64

-- 
2.17.1


