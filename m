Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F4FC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F8B2084E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acz5XkZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F8B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbinT-0005c6-SH
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40783)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hbieM-0004oG-Qq
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hbiYr-0000j2-JC
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:31:54 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hbiYr-0000iS-DR
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:31:53 -0400
Received: by mail-pg1-x544.google.com with SMTP id s21so1205554pga.12
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=IA28pcpBdiEvMh8kWXD6ZCj/yjRms4/rSndJ9xOTZr8=;
 b=acz5XkZFze7EQ/b7r8mvQTmConW6V9FekK8fdM1YYXi0pd0FngGM0d04xElUu5sYmQ
 MDhMUXtKyPOwPETSdOAC6eOgHVXA7j3egaTXEvE7skL3TzapqGi3ysfZwtVcQaMWoJqj
 Daly6Jc736jcC/vqBYmWZVfYr//FbTe8j/NAIx4K29Xpr+50dNKeqL+A/X5fU18rWFtU
 W5luN7MVgetjRF996O11GM3yjFuIkoktME5xL6k382Dw9gxHwHAXp+xT30+9hVjXrQNo
 YSpKtBahBtK3dN+oNkEpAhL5HyYAeAu7r3NLrkp87SY0dZvEBQMWrl6PazHBpnuJ+kzp
 2vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=IA28pcpBdiEvMh8kWXD6ZCj/yjRms4/rSndJ9xOTZr8=;
 b=Ih/jNMOpZ2DPb4HgbHvCdvlL+zJI1Mgg/7XvmVyxGTw/84XMkASgr6Nb2rv0oe9Hk4
 XsbnpQ5xeQsmZ1dg8/BqkmCQk4ONTUhpj6/0JC9JWQDJBM7xXMzbHVsAZJ+TvWS+2a+1
 qT5BRVFVdsT3znD6QhwxPVuQZrrPbN5TiGTqef6RtbHTJanxsip+37JOXsVyhAE/1DIk
 JZtpNHvTHp/FxjoOWBiZo9+FKJCfB7qjppz8ROAySKmnz+biT7uJhAJdN6XTXmWKiTBn
 uoD47g65viMzeg6Y86A+X/P2bWOVSrXIYg2oSX+uDZX0py5Ooc7V2g3FlZ0KfYa7sgI6
 2jvw==
X-Gm-Message-State: APjAAAVoKy7WrviC2z6kPPr8MOQOpocJKYO1EVUujtzN7SVNhCfSRCMS
 L7hmmpb2jlTEGmJ8GO1jEAY=
X-Google-Smtp-Source: APXvYqz2rTsGZORv4eP+8ZW7SWE7OKxreSEcfYZ8+DBBhGHmT5qAxcR13JhbVTYsX9CNJHUGZfs2JQ==
X-Received: by 2002:aa7:9190:: with SMTP id x16mr84966532pfa.86.1560504711913; 
 Fri, 14 Jun 2019 02:31:51 -0700 (PDT)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id o2sm3735655pgp.74.2019.06.14.02.31.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Jun 2019 02:31:51 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Fri, 14 Jun 2019 17:31:16 +0800
Message-Id: <20190614093121.5580-1-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 0/5] virtio: fix some issues of "started"
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
Cc: qemu-devel@nongnu.org, Xie Yongji <xieyongji@baidu.com>,
 dgilbert@redhat.com, ehabkost@redhat.com
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
 hw/core/machine.c          |  8 ++++--
 hw/virtio/virtio.c         | 53 ++++++++++++++++++++++----------------
 include/hw/virtio/virtio.h | 23 ++++++++++++++++-
 4 files changed, 61 insertions(+), 27 deletions(-)

-- 
2.17.1


