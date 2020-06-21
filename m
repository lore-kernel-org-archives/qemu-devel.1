Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505F8C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 16:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFA3251F1
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 16:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmnaU3WL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFA3251F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn2tP-0003Om-7Y
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 12:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jn2jj-0006nf-Vd
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 12:22:27 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:44012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jn2ji-0007xM-9C
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 12:22:27 -0400
Received: by mail-lj1-x244.google.com with SMTP id n24so16595203lji.10
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IOguhqHzl+6rnZ1RruVDptTZKoDbbWkfgRcLf840DCg=;
 b=UmnaU3WLNf9NQj17sJQFrvTBfXH1Q5OPQ39nYPfPd3Q5AgQIyt741n3KQ6pd2Wm7jo
 45oLvrUdLG7JIaevxt4lsEVlJG5zOcnYWB6DpU4CvkhO+zCmUgXJ5Q5lFC8j3RJ17tkQ
 R5XGsnK8uoR2W8eHeJIG65p5mQQCudjk01G2w6k0x6OE/Y6NH3oxGP3NNkAh+vpfycUO
 ZUpfT+E1KHsbl9Pb7h4znoT6xDPh06MqToinNmSLmua4wXq282sBpne3v7N3GTKy2iuT
 x+SyvpMC+88GAk8ia2RFXzXS8Ef1KjqoNjsYjXq1XCH0UH/xJhDjKkajJDuP2M2nuCqm
 0wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IOguhqHzl+6rnZ1RruVDptTZKoDbbWkfgRcLf840DCg=;
 b=GuPumCb6dc1hqWieK+VRXOT5B7xEUwlp7qmHCPt8lBb5V9LaJCtlZKOENfyJxsTBod
 YSvGL5jOEaNxCoZKYWNbITTgBF7xlya0PsuEfNWJzv1nk5UXr41vKZBUD3y558Gd7IJG
 VkHNXMgMyhUq2+E1lXO7mhNrDF2iZOSpVQOr/ZHRsIyU8nzqcdydYOxAjpKb3tWOJvJP
 MPviZafuaVMp52jGuROAmQLp51Bv9pVINVa9wf0/Zhtn4yhRHGdjn/yJu40bD7ayizXp
 vl3ZHQZNb8KmvGdOQuStvCOFPfl61oe8H6FWLIOTa4i5EZQ+AmF61OPQPzjE8RdSLXRZ
 QaDg==
X-Gm-Message-State: AOAM531qU9drMEtGS0yjrX8E3vimGS8qd7Jidjv4pOY7bD6tSNg9My1M
 FN3PfkqfTNn1lcLHke4L5sLKmgthYomIBw==
X-Google-Smtp-Source: ABdhPJwakudZncJ4JA5g/kgYWE3zxOhW+nWkCJU2OxcA/SunG0R2i/d21QZDowY8pJdDuDWgHiHhXw==
X-Received: by 2002:a05:651c:550:: with SMTP id
 q16mr6590600ljp.188.1592756543684; 
 Sun, 21 Jun 2020 09:22:23 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id k7sm2822838lfd.67.2020.06.21.09.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 09:22:23 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] virtio-console: notify about the terminal size
Date: Sun, 21 Jun 2020 18:21:26 +0200
Message-Id: <20200621162132.62797-1-noh4hss@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
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
X-Mailman-Approved-At: Sun, 21 Jun 2020 12:30:17 -0400
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
Cc: lvivier@redhat.com, amit@kernel.org, mst@redhat.com,
 Szymon Lukasz <noh4hss@gmail.com>, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The goal of this series is to have a nice terminal into a Linux guest
without having to set up networking and using, e.g. ssh.

The virtio spec allows a virtio-console device to notify the guest about
terminal resizes in the host. Linux Kernel implements the driver part of
the spec. This series implement the device part in QEMU.

In this series resize notifications are only supported for the stdio
backend but I think it should be easy to add support for the vc backend.
Support for tty/serial backends is complicated by the fact that there is
no clean way to detect resizes of the underlying terminal.

Also there is a problem with the virtio spec and Linux Kernel
implementation, the order of fields in virtio_console_resize struct
differs between the kernel and the spec. I do not know if there is any
implementation of the virtio-console driver that handles resize messages
and uses a different order than Linux.



Szymon Lukasz (6):
  main-loop: change the handling of SIGWINCH
  chardev: add support for retrieving the terminal size
  chardev: add support for notifying about terminal resizes
  char-stdio: add support for the terminal size
  virtio-serial-bus: add terminal resize messages
  virtio-console: notify the guest about terminal resizes

 backends/cryptodev-vhost-user.c   |  1 +
 chardev/char-fe.c                 | 11 ++++++
 chardev/char-mux.c                |  7 ++++
 chardev/char-stdio.c              | 34 ++++++++++++++++
 chardev/char.c                    |  1 +
 hw/block/vhost-user-blk.c         |  1 +
 hw/char/terminal3270.c            |  1 +
 hw/char/trace-events              |  1 +
 hw/char/virtio-console.c          | 65 +++++++++++++++++++++++++++++--
 hw/char/virtio-serial-bus.c       | 41 ++++++++++++++++++-
 hw/ipmi/ipmi_bmc_extern.c         |  1 +
 hw/usb/ccid-card-passthru.c       |  1 +
 hw/usb/dev-serial.c               |  1 +
 hw/usb/redirect.c                 |  1 +
 include/chardev/char-fe.h         | 11 ++++++
 include/chardev/char.h            |  2 +
 include/hw/virtio/virtio-serial.h |  5 +++
 include/qemu/main-loop.h          |  4 ++
 monitor/hmp.c                     |  1 +
 monitor/qmp.c                     |  1 +
 net/vhost-user.c                  |  1 +
 ui/curses.c                       | 11 +++---
 util/main-loop.c                  | 21 ++++++++++
 23 files changed, 213 insertions(+), 11 deletions(-)

-- 
2.27.0


