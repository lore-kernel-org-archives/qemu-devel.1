Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C6EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A1D2559A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz1shILo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A1D2559A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwrJ-00022a-4P
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqH-0000Ho-B8
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:13 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqF-0007uP-JO
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:13 -0400
Received: by mail-lj1-x244.google.com with SMTP id f8so6496351ljc.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hl2zUBqT9Q02UHEKkMWWwMmcZaqXnD6sNC1J/cTQNpo=;
 b=Tz1shILo65cbNZiA8BuNaaWXEsyPzGaUx05mJbDGZZ4DtjHsmXEw2+VSmBUR/PUpWP
 MwJpRloLH5nKKa8+L0xMhUMzfG39t3Tf167EHVMhrCgWGzE6zP2IRlWtRbbhuoxY8dYc
 VZlhjWbAzeQY+ThtK7dprip2j98HEFmfry0o3InGSLhELfQS6hprpq3V14oDd8LMwCq0
 rbBzEdEm/xWrZAZRU9leHT5mmoXK4/sEyfv8+pHKTXaIySZJoa9G3sueSNeAeq/IliEQ
 1IBcLwQlYa32V6vCc5kmaqyebUos53cVqG0bLfxUg05xy/jNL+Nva2wo4nTEk9p6JMar
 IUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hl2zUBqT9Q02UHEKkMWWwMmcZaqXnD6sNC1J/cTQNpo=;
 b=aUQ8plHkZhTv/GWNZtH/aXVyBT7MV3xjNXxBTeiRJbeF79k5e+n8jGLirdFdsUGFw+
 po3Dq3dfjP2dH81mixmjkX2romuEhPkek+bOh0WJveU9DO8XkfO/7DCAE3MAufoMihEp
 +1hzcJrdchUWLbT6f/IGXeEvk9irmRcU30BVx8ns2/bDhS+kKg67emAns/Lu3YHVTHVl
 kLcYxf9MhFZAoDLOetRmpI8Zegirw3PN2s6BtFl7IBWZWTZZaXt1lSMN2iffnKz4H3c6
 N1oZN+Dzt7ymuS69UA/CHASkLjjtaXDabQU0X2Suv8S/vK7ZEjpZ4FB0zITB8IneuvGU
 UsWQ==
X-Gm-Message-State: AOAM532U6A+ZZbQLD2xRC7tWSGkJY+2jpASyRTSJ4ul4aXmnJjgATLc5
 Grpohux3+NtP++VVAzomLU3FCLf3wV9y3g==
X-Google-Smtp-Source: ABdhPJwql9An/okZY9NNAK0RX7i0NhDwgars+V2njhkkv4lQ4DWgcclkOzLjMsAM/5iBHEEdITzzkw==
X-Received: by 2002:a2e:8347:: with SMTP id l7mr8921097ljh.182.1593448868057; 
 Mon, 29 Jun 2020 09:41:08 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id o1sm37641lfi.92.2020.06.29.09.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 09:41:07 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/9] virtio-console: notify about the terminal size
Date: Mon, 29 Jun 2020 18:40:32 +0200
Message-Id: <20200629164041.472528-1-noh4hss@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=noh4hss@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: lvivier@redhat.com, berrange@redhat.com, amit@kernel.org, mst@redhat.com,
 Szymon Lukasz <noh4hss@gmail.com>, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The goal of this series is to have a resizable terminal into a guest
without having to set up networking and using, e.g. ssh.

The virtio spec allows a virtio-console device to notify the guest about
terminal resizes in the host. Linux Kernel implements the driver part of
the spec. This series implement the device part in QEMU.

This series adds support for a resizable terminal if a virtio console
device is connected to the stdio backend. 

This series also introduces resize messages that can be sent over QMP to
notify QEMU about the size of the terminal connented to some chardev.
In the libvirt setting, it will allow to implement a resizable terminal 
for virsh console and other libvirt clients.


v3:
add resize messages over QMP, as suggested by Daniel

v2:
fix adding a new virtio feature bit to the virtio console device

Szymon Lukasz (9):
  chardev: add cols, rows fields
  chardev: add CHR_EVENT_RESIZE
  chardev: add qemu_chr_resize()
  char-mux: add support for the terminal size
  main-loop: change the handling of SIGWINCH
  char-stdio: add support for the terminal size
  qmp: add chardev-resize command
  virtio-serial-bus: add terminal resize messages
  virtio-console: notify the guest about terminal resizes

 backends/cryptodev-vhost-user.c   |  1 +
 chardev/char-fe.c                 | 13 +++++++
 chardev/char-mux.c                | 18 ++++++++-
 chardev/char-stdio.c              | 29 ++++++++++++++
 chardev/char.c                    | 26 +++++++++++++
 hw/block/vhost-user-blk.c         |  1 +
 hw/char/terminal3270.c            |  1 +
 hw/char/trace-events              |  1 +
 hw/char/virtio-console.c          | 63 +++++++++++++++++++++++++++++--
 hw/char/virtio-serial-bus.c       | 42 ++++++++++++++++++++-
 hw/core/machine.c                 |  1 +
 hw/ipmi/ipmi_bmc_extern.c         |  1 +
 hw/usb/ccid-card-passthru.c       |  1 +
 hw/usb/dev-serial.c               |  1 +
 hw/usb/redirect.c                 |  1 +
 include/chardev/char-fe.h         | 10 +++++
 include/chardev/char.h            |  7 ++++
 include/hw/virtio/virtio-serial.h |  5 +++
 include/qemu/main-loop.h          |  4 ++
 monitor/hmp.c                     |  1 +
 monitor/qmp.c                     |  1 +
 net/vhost-user.c                  |  1 +
 qapi/char.json                    | 25 ++++++++++++
 ui/curses.c                       | 11 +++---
 util/main-loop.c                  | 21 +++++++++++
 25 files changed, 274 insertions(+), 12 deletions(-)

-- 
2.27.0


