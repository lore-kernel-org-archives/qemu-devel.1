Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3F2C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809042077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcXSB2wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809042077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41217 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKcp-0008VF-Aj
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXm-0003Kj-RU
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXl-0001Bz-ER
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:50 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:32778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ieKXl-0001Ak-8Y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:49 -0500
Received: by mail-wr1-x429.google.com with SMTP id b6so16593459wrq.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yB185R7vRAPf6g0hUwD5ydBSy9wds6hweJHZ+kNDoeo=;
 b=kcXSB2wkrei7hyeqMJdTCIvAHEdh+MJlAo8rsAgZeP8ryAxUFKllwxZR7w75963EFQ
 B5cHz4As1TMnlDw7ORSjIy3HNkhztVrB90I+pBGBxM0Zpwhghp6PUye4cnUTVYgoKsYq
 kY3lx7g6P5s2uDWOCHwcrFeGrqem5NqZawhTxbHmZuJAnhX+SdrB9we9k2apwdLV6IYo
 0m+Tgja7DSzq5wnCqvIm+Tt8zaOgZaT83K/SWUrovrTZ0NOCfT2i1JSConp5Wyz6XmEz
 +G0pIqixGkP97BbfDodi9mFWiXJKo1P2LaFiVXapoXLjH0slrDzmLFe98+Hvl6uf/30m
 pXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=yB185R7vRAPf6g0hUwD5ydBSy9wds6hweJHZ+kNDoeo=;
 b=Yio0yqYEMdWZVdDboo4/8H8zpO8s+iYn+5F6HAONPXzHhYGSfGSa4CE4KOAV3Qbk8q
 IcdK3F7O61Sh+e1Xpvmz289wgLNqnTziQU8o6SxxYxcL8MfN8jAnIlteJPzzvRgnmX8O
 URP24frvCwxwzIdImw3Rcl4Xf3Wn93iIWs/ywoWljNUcpy5WBwS2gDho1I3M7g7iwQoc
 L/PAM2Tmnu8DvnoSZZCmn7ONizjac1GQykg2qKX0Vl0LZvgLgmfCy+MJv3usq/zSdAOC
 wBsl4QJCpMgDcDf5efPCu+Ka1nVF6FeiktlLrI+xqBT9GMW9+FiEcAIMCEfK4jW0IjJC
 GNGw==
X-Gm-Message-State: APjAAAVR5OUbnPvuL6vnfM0EaAMZ83yCuf2ogjdszr4AmuhX4/lOToKK
 VAmQH+UJmepwOmGKuCH6yZ7UiLNE
X-Google-Smtp-Source: APXvYqwEmCtMhtYRFGPXGil3Tx2okfCEMnigaNB2ZFJ8/p02PvJIOm8MUJMl9Huxf7By+0jcqKdshA==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr2626362wro.360.1575903707479; 
 Mon, 09 Dec 2019 07:01:47 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g9sm27219371wro.67.2019.12.09.07.01.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:01:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/18] Complete the implementation of -accel
Date: Mon,  9 Dec 2019 16:01:27 +0100
Message-Id: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series completes the implementation of -accel:

- Alternative accelerators can be specified with multiple -accel options,
  and each -accel option will configure the respective accelerator.
  This is implemented in patches 1 to 6, with a small addendum in patch 7.

- Accelerators can now support arbitrary options, which are implemented
  in terms of QOM properties.  This is implemented in patches 8 to 11,
  together with the conversion of the sole existing "-accel" option to QOM.

- Accelerator-related machine options, and legacy options such as -tb-size,
  forward to accelerator objects for backwards compatibility, but they
  do not exist anymore as QOM properties.  This is implemented in patch
  6 for "-machine accel" and patches 12 to 16 for everything else.

Paolo

v1->v2: improve bisectability by moving patch "vl: move icount configuration
        earlier" towards the beginning of the series

        new patch to compile accel/accel.c just once

Paolo Bonzini (18):
  memory: do not look at current_machine->accel
  vl: move icount configuration earlier
  tcg: move qemu_tcg_configure to accel/tcg/tcg-all.c
  vl: extract accelerator option processing to a separate function
  vl: merge -accel processing into configure_accelerators
  accel: compile accel/accel.c just once
  vl: introduce object_parse_property_opt
  vl: configure accelerators from -accel options
  vl: warn for unavailable accelerators, clarify messages
  qom: introduce object_register_sugar_prop
  qom: add object_new_with_class
  accel: pass object to accel_init_machine
  tcg: convert "-accel threads" to a QOM property
  tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"
  xen: convert "-machine igd-passthru" to an accelerator property
  kvm: convert "-machine kvm_shadow_mem" to an accelerator property
  kvm: introduce kvm_kernel_irqchip_* functions
  kvm: convert "-machine kernel_irqchip" to an accelerator property

 Makefile.objs             |   1 +
 accel/Makefile.objs       |   2 +-
 accel/accel.c             |  73 +--------------
 accel/kvm/kvm-all.c       | 117 ++++++++++++++++++++++--
 accel/tcg/tcg-all.c       | 149 +++++++++++++++++++++++++++++-
 cpus.c                    |  72 ---------------
 hw/core/machine.c         | 141 -----------------------------
 hw/ppc/e500.c             |   4 +-
 hw/ppc/spapr_irq.c        |  10 +--
 hw/xen/xen-common.c       |  16 ++++
 include/hw/boards.h       |   7 --
 include/qom/object.h      |  13 +++
 include/sysemu/accel.h    |   4 +-
 include/sysemu/cpus.h     |   2 -
 include/sysemu/kvm.h      |   7 +-
 memory.c                  |   5 +-
 qemu-deprecated.texi      |   6 ++
 qemu-options.hx           |  30 ++++---
 qom/object.c              |  28 +++++-
 target/arm/kvm.c          |   8 +-
 target/i386/cpu.c         |   8 +-
 target/i386/kvm.c         |   6 +-
 target/mips/kvm.c         |   2 +-
 target/ppc/kvm.c          |   2 +-
 target/s390x/cpu_models.c |   4 +-
 target/s390x/kvm.c        |   2 +-
 vl.c                      | 225 ++++++++++++++++++++++++++++++++--------------
 27 files changed, 532 insertions(+), 412 deletions(-)

-- 
1.8.3.1


