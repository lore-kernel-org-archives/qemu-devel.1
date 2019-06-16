Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E90C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D3420679
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D3420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccuV-0003fB-16
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hccox-0006bN-8n
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hccov-0006RG-Ct
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:15 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:35531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hccot-0006Cs-Di
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:12 -0400
Received: by mail-qk1-f175.google.com with SMTP id l128so5072892qke.2
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=GjdudgScqcT2JwEznXV6ustGvWLY2fKaQutIdckwO0k=;
 b=QLpZqVvqo8WlOXV4vxD1uCTvRlntgro7/TFrZ1Qw48jztRA/H1LNjVRyzKS2OWrGoO
 djftJ6VSN9MkZEZZQ7prqfCujfLywJeMtkIPJgMXAI5/OkNZ55DdFMjESTFuG8wKpove
 Fxiy6RJhbFSzm8cjHiUojNW96Pp4rRztl81sJeA0OtZdHNYaMluHLPSAGnF3IQQZwaOy
 B1byGnUM7DgdMaDCDWf4VntIjIq9a7KT9ucpDX67ppL+voWGkz4ttKAbkX9NSyl7UZx+
 LvXIm7PZbGOwlcKgLCfE+c4EoXWoc0EUHnpiQnae/wAEpIFVlmKv1gm5k6kFYSm4jcGM
 8OTw==
X-Gm-Message-State: APjAAAXYlmy9+nc8cvIEXF88Z3LNKbBirqLKRI8NECO677gA6y6N7+5T
 LaRoqAGJqQRUBbjRuGG6Tb8iERKNeiQ=
X-Google-Smtp-Source: APXvYqxy6iQQ1aLDIEH2dPXjuTAT9opgx4SlkxDl6CQL1J+xW2Qac1sZO5IkcKYVv9hjFNOo71qM3w==
X-Received: by 2002:a05:620a:12c4:: with SMTP id
 e4mr35384017qkl.81.1560720965189; 
 Sun, 16 Jun 2019 14:36:05 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id v186sm5535290qkc.36.2019.06.16.14.36.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:36:04 -0700 (PDT)
Date: Sun, 16 Jun 2019 17:36:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190616213540.20430-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.175
Subject: [Qemu-devel] [PULL 00/11] virtio, acpi: fixes, cleanups
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f3d0bec9f80e4ed7796fffa834ba0a53f2094f7f:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-06-14' into staging (2019-06-14 14:46:13 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 5f6b3561bf58395fd6c906d7064a1a5693a2e426:

  tests/rebuild-expected-aml.sh: blow out difflist (2019-06-16 16:44:44 -0400)

----------------------------------------------------------------
virtio, acpi: fixes, cleanups

A bunch of minor fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Gerd Hoffmann (1):
      q35: fix mmconfig and PCI0._CRS

Li Hangjing (1):
      vhost: fix vhost_log size overflow during migration

Marc-André Lureau (6):
      vhost-user-gpu: do not send scanout update if no GPU socket
      vhost-user: check unix_listen() return value
      vhost-user: improve error report
      vhost-user-input: check ioctl(EVIOCGNAME) return value
      vhost-user-gpu: initialize msghdr & iov at declaration
      docs/vhost-user.json: some firmware.json copy leftovers

Michael S. Tsirkin (2):
      q35: update DSDT
      tests/rebuild-expected-aml.sh: blow out difflist

Wei Yang (1):
      hw/acpi: extract acpi_add_rom_blob()

 docs/interop/vhost-user.json            |   6 ++---
 include/hw/acpi/utils.h                 |   9 +++++++
 contrib/vhost-user-gpu/main.c           |  29 +++++++++++------------
 contrib/vhost-user-input/main.c         |  12 ++++++++--
 hw/acpi/utils.c                         |  35 ++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c                |  26 ++++++++-------------
 hw/i386/acpi-build.c                    |  40 +++++++++++++++++++-------------
 hw/pci-host/q35.c                       |  31 +++++++------------------
 hw/virtio/vhost.c                       |  10 ++++++++
 hw/acpi/Makefile.objs                   |   2 +-
 tests/data/acpi/q35/DSDT                | Bin 7815 -> 7841 bytes
 tests/data/acpi/q35/DSDT.bridge         | Bin 7832 -> 7858 bytes
 tests/data/acpi/q35/DSDT.cphp           | Bin 8278 -> 8304 bytes
 tests/data/acpi/q35/DSDT.dimmpxm        | Bin 9468 -> 9494 bytes
 tests/data/acpi/q35/DSDT.ipmibt         | Bin 7890 -> 7916 bytes
 tests/data/acpi/q35/DSDT.memhp          | Bin 9174 -> 9200 bytes
 tests/data/acpi/q35/DSDT.mmio64         | Bin 8945 -> 8971 bytes
 tests/data/acpi/q35/DSDT.numamem        | Bin 7821 -> 7847 bytes
 tests/data/acpi/rebuild-expected-aml.sh |   3 +++
 19 files changed, 127 insertions(+), 76 deletions(-)
 create mode 100644 include/hw/acpi/utils.h
 create mode 100644 hw/acpi/utils.c


