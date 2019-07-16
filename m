Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33E4C76195
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE6521721
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTDD9aQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE6521721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIZ1-0000xq-HM
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59754)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYV-0007sH-7G
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYU-000386-27
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYT-00036d-N0
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id r1so19825043wrl.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hZAdpmh3ofD5CtmSnrzTVd4lkwPQzmzagWI6t0vwsew=;
 b=sTDD9aQUXrjkpfcgRXg6wIgI4f6CGq5sTgzqh2HgKffBHJ5hlEPnMREe+lv0DCuCNr
 gSc/hMaysPqbVzDtBU09T7AVv10wleL74Jq27F1MgUdMJJjRsiRPQiyTTISSisAnhM5K
 cF3ymj7wKaonsD50wdPwYZTY8d/XSDo+W5TNxChw97/E1l15R9W+R8e4BgdaEEDFIUkh
 qPf+7KnPIz28briyenOjqBDEaBZj2FF3aIPJunmbU8QbF9KKamej0BdRizPPBI+sA330
 BKLj0Ryd6Btm07n6MSXlilQmqRls4ERrrUiPqaHMI8YfflR7ejbBp3IebBCn4pfBwA7s
 J7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=hZAdpmh3ofD5CtmSnrzTVd4lkwPQzmzagWI6t0vwsew=;
 b=OzezIwCYaAA5PN5/gUCvlmL0K74NByMNcowRl8WTVTLAtv4cuAEiPSQGs3IuGQVOb9
 G7utalvfxVpLHFjaZb9uO6PVY2YNfJhhtHOFnvJOtDehVW12JTmgBrgF1WRbKFzPtVzn
 Ffiv6qcZzAjKNjrEqeAi7FmApcO2w/zIBqcIuREHGAyAEt+m6Li6BiMmcJD+RtVm7u1U
 RsnGZFdtEnn/qwq5raxGqmN1dQ935lGNT18XWCKrnQ7to+9hmXlhEpKEb3oB5NNr/txP
 VI+G4sTTPkVTy38poLSaMjpV+/5NcT1+krCMXBFAbYnkK0y0SabFd0UWjDL9mqvojm37
 OI0g==
X-Gm-Message-State: APjAAAWlZ9UpltG8d/hxa1p6XBuVnvxSyte8FqYGhRc3aC/cDLdmiAG+
 638V4g+0Umk7vmYli4x8Gh3KRk1BqwY=
X-Google-Smtp-Source: APXvYqy/JsBAJYGe54ZncCt3ksUNKg9l+5gh47Vv2jsvhguyKOICCdGYS5MeVI4dQMNblg6sKzZaOQ==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr35258068wrk.229.1563264679485; 
 Tue, 16 Jul 2019 01:11:19 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:10:58 +0200
Message-Id: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 00/19] Bugfix/cleanup patches for 2019-07-16
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 46cd24e7ed38191b5ab5c40a836d6c5b6b604f8a:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-07-12 17:34:13 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 45d8bc3adedeceaf449d758aee1810bfbe6feff4:

  vl: make sure char-pty message displayed by moving setbuf to the beginning (2019-07-16 09:27:16 +0200)

----------------------------------------------------------------
* VFIO bugfix for AMD SEV (Alex)
* Kconfig improvements (Julio, Philippe)
* MemoryRegion reference counting bugfix (King Wang)
* Build system cleanups (Marc-André, myself)
* rdmacm-mux off-by-one (Marc-André)
* ZBC passthrough fixes (Shinichiro, myself)
* WHPX build fix (Stefan)
* char-pty fix (Wei Yang)

----------------------------------------------------------------
Alex Williamson (1):
      target/i386: sev: Do not unpin ram device memory region

Julio Montes (1):
      hw/i386: turn off vmport if CONFIG_VMPORT is disabled

King Wang (1):
      memory: unref the memory region in simplify flatview

Marc-André Lureau (2):
      build-sys: remove slirp cflags from main-loop.o
      rdmacm-mux: fix strcpy string warning

Paolo Bonzini (8):
      scsi: explicitly list guest-recoverable sense codes
      scsi: add guest-recoverable ZBC errors
      iscsi: fix busy/timeout/task set full
      iscsi: base all handling of check condition on scsi_sense_to_errno
      util: merge main-loop.c and iohandler.c
      checkpatch: detect doubly-encoded UTF-8
      Makefile: do not repeat $(CONFIG_SOFTMMU) in hw/Makefile.objs
      create_config: remove $(CONFIG_SOFTMMU) hack

Philippe Mathieu-Daudé (3):
      hw/lm32/Kconfig: Milkymist One provides a USB 1.1 Controller
      hw/usb/Kconfig: Add CONFIG_USB_EHCI_PCI
      hw/usb/Kconfig: USB_XHCI_NEC requires USB_XHCI

Shinichiro Kawasaki (1):
      scsi-disk: pass sense correctly for guest-recoverable errors

Stefan Weil (1):
      Fix broken build with WHPX enabled

Wei Yang (1):
      vl: make sure char-pty message displayed by moving setbuf to the beginning

 block/iscsi.c             |  29 +++++-----
 configure                 |   2 +-
 contrib/rdmacm-mux/main.c |   2 +-
 hw/Makefile.objs          |  61 +++++++++++----------
 hw/i386/Kconfig           |   4 +-
 hw/i386/pc.c              |   5 ++
 hw/lm32/Kconfig           |   1 +
 hw/scsi/scsi-disk.c       |  15 ++++--
 hw/usb/Kconfig            |  11 ++--
 hw/usb/Makefile.objs      |   5 +-
 include/scsi/utils.h      |   1 +
 memory.c                  |   5 +-
 scripts/checkpatch.pl     |  16 ++++++
 scripts/create_config     |   2 +-
 scsi/utils.c              |  53 ++++++++++++++++--
 target/i386/sev.c         |  11 ++++
 target/i386/whpx-all.c    |   4 +-
 util/Makefile.objs        |   3 +-
 util/iohandler.c          | 135 ----------------------------------------------
 util/main-loop.c          | 110 +++++++++++++++++++++++++++++++++++++
 vl.c                      |   4 +-
 21 files changed, 276 insertions(+), 203 deletions(-)
 delete mode 100644 util/iohandler.c
-- 
1.8.3.1


