Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F59BC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 02:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7278D2085A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 02:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM2mwxcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7278D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfxl9-0002pU-Iu
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 22:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48239)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hfxjH-0001W0-Pq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 22:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hfxj9-0001iR-Gk
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 22:32:06 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hfxj5-0001Y4-N7
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 22:32:01 -0400
Received: by mail-pl1-x641.google.com with SMTP id bh12so518708plb.4
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=TAl0nqcP224QX/pPpnsk83//p0CtvtlL6Rvc+QhPyC0=;
 b=VM2mwxcJZUWqi2BQNT3B66AQzDpK+/Vc49bQQrz4dHQtFZEl8xom9QaN0j4U681Zn9
 z9/5YuE5zIvnjCcocdN9dDeh6RI9goRRxiMIKwHrAMjBUd9PJ2KScg/MCYg2u+a/JV8S
 Hbc0Z1xaO92LWdqKcaaKOihHsacxiLn4BfW2+mhBF05tBgFlAs0FzXN+dH8N7xDUIHBO
 6ja0MLUcYOrt1qxmEjAJrxKX4TWy7jkBRMYweeD2EDSLddaJW0vCchnxTE+rbWWtrcDR
 K59+Hd76VUs87d7sndKtD9f+1SdCgP8+EHbkuV7uCJ2aOSQpjNG2ZhRJXjkMpaC/4a0x
 KCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=TAl0nqcP224QX/pPpnsk83//p0CtvtlL6Rvc+QhPyC0=;
 b=jf970R66uO0BlYL8L0ZA/QdIM5L3BptL2zQgh2FTlwY7R7t8twNEnUWJ3m7ifxQ+35
 1wvhpXvMS7qeZucFUuBjm7NegFYSlUb6WbER5lZe4wAi5al9fEVP7ijvJJKP5Xl690q9
 v/sPPQBMO02Bc18xdGai4hVWllcAR99hnJ0lst45uAvuJacddaZIAcJ/cICtxfm0v6h4
 xmbG5EyHSbvxYBRU88E4lNafReAnrjQDpkaM23EUDoJXOZmiG1hPGMhWSml3cK6+vbjp
 rTb49N4RLLWkI8or0zpD5IgFdTpKdncwx8XLF+Ub9d9BNy0DTVzI7UpOaTM33r6VSELJ
 8JyA==
X-Gm-Message-State: APjAAAXi93b4a8M1VSn/4hK7ISuiYW9JxQqVtWN4slVuS0CLML36hu7i
 FAxcjBgWp56N50L1tObQBXU=
X-Google-Smtp-Source: APXvYqxG3dG0Bthwflt0To9ZPUXw0LTvTDSyGIQV3EaGCbqqZfd1metPuKmldqamgzWaUxuBTx2Q7A==
X-Received: by 2002:a17:902:b215:: with SMTP id
 t21mr2204554plr.123.1561516311211; 
 Tue, 25 Jun 2019 19:31:51 -0700 (PDT)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id r6sm351163pji.0.2019.06.25.19.31.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 25 Jun 2019 19:31:50 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Wed, 26 Jun 2019 10:31:25 +0800
Message-Id: <20190626023130.31315-1-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v4 0/5] virtio: fix some issues of "started"
 and "start_on_kick" flag
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
Cc: lvivier@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

We introduced two flags "started" and "start_on_kick" to indicate virtio
device's state before. But there still are some problems with them. So
we try to fixup them in this patchset.

The patch 1 introduces a "use-started" property to avoid a migration
issue under Greg Kurz's suggestion [1].

The patch 2 set "start_on_kick" flag for legacy devices.

The patch 3 fixes a regression bug that old guest is not able to boot with
vhost-user-blk device.

The patch 4,5 fix some problems with "started" and "start_on_kick" flag.

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06247.html

v4:
- Patch 1 is rebased on commit 8e8cbed09ad9d5 ("hw: Nuke hw_compat_4_0_1 and
  pc_compat_4_0_1")

v3:
- change the order of patches
- Also disable "use-started" property by hw_compat_4_0

v2:
- Recalculate "start_on_kick" flag after migration instead of migrating
  it
- Set "start_on_kick" flag for legacy devices
- Avoid setting "started" flag when "use_started" property is true
- Set "use_started" to false by hw_compat_4_0_1 instead of hw_compat_4_0

Xie Yongji (5):
  virtio: add "use-started" property
  virtio: Set "start_on_kick" for legacy devices
  virtio: Set "start_on_kick" on virtio_set_features()
  virtio: Make sure we get correct state of device on
    handle_aio_output()
  virtio: Don't change "started" flag on virtio_vmstate_change()

 hw/block/vhost-user-blk.c  |  4 +--
 hw/core/machine.c          |  1 +
 hw/virtio/virtio.c         | 53 ++++++++++++++++++++++----------------
 include/hw/virtio/virtio.h | 23 ++++++++++++++++-
 4 files changed, 56 insertions(+), 25 deletions(-)

-- 
2.17.1


