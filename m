Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3BAC83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F78206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM9hl7S7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F78206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTL0B-0006LN-4f
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 03:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gorbak25@gmail.com>) id 1jTJpG-000062-Fz
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <gorbak25@gmail.com>) id 1jTJkc-000808-PZ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:34:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gorbak25@gmail.com>)
 id 1jTJkc-0007zt-9X
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:29:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id k13so23235276wrw.7
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 23:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6BE++WsHDYO/WOBqJLui7tOCRnqB8ihSSf6W8ZHJC58=;
 b=nM9hl7S7+RQTxl+m0wJsf+Uu39xU2juocV+4M9QJrHIoCFJvGsuda+dbtbNNNC/9/9
 mVR8wmkJ/tJRrYnmlLK4j1TcQwphdLKdugvkCOYO6oZXIfwLH4JGEAQUC0zUS633O5bH
 rLVNnETO10FU58TlVyXSCb4qyjobuNqSUn3sRZ5/M+6BLkAmigKTu/9rErt+DYJgO+x1
 UeiUS5fGO5n2RRKGY0yR8Ubx+h7aTmb3FbV4osINY5RLLa9a371bXCr7MChrtwdPuqoJ
 6utk6llcKNACK+u1/711wpRJJRLljc1j1q5eS+Ai0alnoDUWafB2vpccVKZtKav+Ws+I
 ziIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6BE++WsHDYO/WOBqJLui7tOCRnqB8ihSSf6W8ZHJC58=;
 b=aUKocfLdAaMTSIZRYUXWmTopsXt6MObVOwy0K3wT58woIUKKtw2wrcFiqO0E3aBheH
 rjuOLbuITFrjeY07cMeIwR+WuRzisaAxtkbE5+oxBiFEhElVaYVHkHdFqWVaz25ELjzO
 Otm/Za6SoWqMMpKIW9qBqLqnPHgOkoYHv9YHIg/wkfNOXsc3sxWhqliO0nOLaCJF8GZ6
 syulOEQh6JF72qluMMjIKCbI++Bz4l2twYHfajHX6vVnuSbUusgjnyh8pL/xoaM8qWnA
 EFtJMpoIIkyXD9pQaFNRZ4YwJWqKuueGnaS1AAYzUdQEeHar4hhSXUE7D9PPxZqD0zoF
 fb3g==
X-Gm-Message-State: AGi0PuZrJwizdatk+UGu9q4/XOLlgzQkD2Yu/ZgDgf4QOGb0okz7eRbE
 KTTQV6cwUbffNarKminPhnhQKCLZnCbFEg==
X-Google-Smtp-Source: APiQypKMJeOYX3PcohWzIS41hAKPeyC3HjuX1SjsDhBdVcAyjumoMDzsHpT/1m0Gnu0C1B4RG+D8jw==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr31936913wrl.308.1588055387873; 
 Mon, 27 Apr 2020 23:29:47 -0700 (PDT)
Received: from localhost.localdomain (public-gprs351065.centertel.pl.
 [37.47.2.154])
 by smtp.gmail.com with ESMTPSA id a205sm2030564wmh.29.2020.04.27.23.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 23:29:47 -0700 (PDT)
From: Grzegorz Uriasz <gorbak25@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fix QEMU crashes when passing IGD to a guest VM under XEN
Date: Tue, 28 Apr 2020 06:28:45 +0000
Message-Id: <20200428062847.7764-1-gorbak25@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=gorbak25@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
X-Mailman-Approved-At: Tue, 28 Apr 2020 03:48:46 -0400
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
Cc: artur@puzio.waw.pl, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, jakub@bartmin.ski,
 marmarek@invisiblethingslab.com, Grzegorz Uriasz <gorbak25@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, j.nowak26@student.uw.edu.pl,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi,

This patch series is a small subset of a bigger patch set spanning few projects aiming to isolate the GPU
in QUBES OS to a dedicated security domain. I'm doing this together with 3 colleagues as part of our Bachelors thesis.

When passing an Intel Graphic Device to a HVM guest under XEN, QEMU sometimes crashes
when starting the VM. It turns out that the code responsible for setting up
the legacy VBIOS for the IGD contains a bug which results in a memcpy of an undefined size
between the QEMU heap and the physical memory of the guest.

If the size of the memcpy is small enough qemu does not crash - this means that this
bug is actually a small security issue - a hostile guest kernel might determine the memory layout of
QEMU simply by looking at physical memory beyond 0xdffff - this defeats ASLR and might make exploitation
easier if other issues were to be found.

The problem is the current mechanism for obtaining a copy of the ROM of the IGD.
We first allocate a buffer which holds the vbios - the size of which is obtained from sysfs.
We then try to read the rom from sysfs, if we fail then we just return without setting the size of the buffer.
This would be ok if the size of the ROM reported by sysfs would be 0, but the size is always 32 pages as this corresponds
to legacy memory ranges. It turns out that reading the ROM fails on every single device I've tested(spanning few
generations of IGD), which means qemu never sets the size of the buffer and returns a valid pointer to code which
basically does a memcpy of an undefined size.

I'm including two patches.
The first one fixes the security issue by making failing to read the ROM from sysfs fatal.
The second patch introduces a better method for obtaining the VBIOS. I've haven't yet seen a single device on which
the old code was working, the new code basically creates a shadow copy directly by reading from /dev/mem - this
should be fine as a quick grep of the codebase shows that this approach is already being used to handle MSI.
I've tested the new code on few different laptops and it works fine and the guest VMS finally stopped complaining that
the VBIOS tables are missing.

Grzegorz Uriasz (2):
  Fix undefined behaviour
  Improve legacy vbios handling

 hw/xen/xen_pt.c          |  8 +++++--
 hw/xen/xen_pt_graphics.c | 48 +++++++++++++++++++++++++++++++++++++---
 hw/xen/xen_pt_load_rom.c | 13 +++++------
 3 files changed, 57 insertions(+), 12 deletions(-)

-- 
2.26.1


