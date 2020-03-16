Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AB9C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F78320663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvdnnAMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F78320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDeNm-0000Me-Um
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 21:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdLm-0008B7-7C
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdLl-0003pO-08
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55707
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdLk-0003nQ-SY
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gRsLFuJ+39CvQ6Xhe9Lqzsuk7Wpp36Eav8te/BpLAQE=;
 b=BvdnnAMeyyZR8M8seHu382DkwF1BU+ZVeztxlMuo4xikx77UsGDFQCP0RLersspoZ4kYMd
 Z+9ovInhvWu734dhDF0XkjqpWowtvlJ4s0cGOTJzcEuIZgO+vAzKv2LLxXvwoewx9gaDbN
 ti8EKeZEHoBDXpFMvzFqNDyvMyWGuzc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-MDF9jbMXMJSqAs4en_Ljiw-1; Sun, 15 Mar 2020 20:11:16 -0400
X-MC-Unique: MDF9jbMXMJSqAs4en_Ljiw-1
Received: by mail-wm1-f69.google.com with SMTP id a23so5027991wmm.8
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wmcP5vH6JJTG8WT2DHX8rmUvESkkPngmR30VgSpi6G8=;
 b=WXJIFUm5Mlwnmj1p06EkAM9eeMnQCcAoYW/SZW+gnmgehK1M7An0RbtdV6Rh3wv64W
 wJ5keZ0zemJYZG3jcG91jGVD2PCeY1niFP0+t2X18V1S6YWoAFp/i4dBzZaU8pfXLh/x
 G2Iv3dBxTD+c74fhtQLcoW+H4cqRdbicbvdS51mBFm+Cyh6vp2krKHcn2Wpa8KH/TzzW
 cSsinwpsPEDSNOd36Y8BIBlB0krLHzL71etX84jwHNRy7CQ+qQsOf1gkrxmcSRgIwFPR
 8PPipP2Eg01sVvz+2LQZ/s7Xd72mDPcO66nydnMcJlK7Wd+Bwpx+vJLk3acjL1gfvN0h
 pLUg==
X-Gm-Message-State: ANhLgQ0qCsaRQ8/zuKu4FgS6nTWytA2wYzjE34LX6YPgev0DMxT4+h/X
 h3KZGgQlcitq04ravu2gQM2u/ebGyUrUh17+mfdrev8alwFsjK3Lkn9W+3JeXKvRhfDFfFMuHWI
 dKzE/Uh0X5TXwffM=
X-Received: by 2002:adf:9796:: with SMTP id s22mr5968541wrb.31.1584317474560; 
 Sun, 15 Mar 2020 17:11:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt8kJ5Wm7Dqo7B0A0JNPhNFT6gxa3efBrzDpLmnUES3ZyYzL5F4iIAHIonf8YOPArJh4oG7dQ==
X-Received: by 2002:adf:9796:: with SMTP id s22mr5968517wrb.31.1584317474286; 
 Sun, 15 Mar 2020 17:11:14 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id t126sm26973778wmb.27.2020.03.15.17.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:11:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] user-mode: Prune build dependencies (part 3)
Date: Mon, 16 Mar 2020 01:11:02 +0100
Message-Id: <20200316001111.31004-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the second part of a series reducing user-mode
dependencies. By stripping out unused code, the build
and testing time is reduced (as is space used by objects).

Part 3:
- Extract code not related to user-mode from hw/core/qdev-properties.c
- Reduce user-mode QAPI generated files

Since v1:
- Addressed Richard and Paolo review comments

Patch missing review: #2 'Use qemu_strtoul() in set_pci_host_devaddr()'

v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg688486.html

full series available at:
repo: https://github.com/philmd/qemu/
branch: usermode_pruning-v2

Based-on: <20200316000348.29692-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (9):
  hw/core/qdev-properties: Use qemu_strtol() in set_mac() handler
  hw/core/qdev-properties: Use qemu_strtoul() in set_pci_host_devaddr()
  hw/core/qdev-properties: Fix code style
  hw/core/qdev-properties: Export enum-related functions
  hw/core/qdev-properties: Export qdev_prop_enum
  hw/core/qdev-properties: Export some integer-related functions
  hw/core/qdev-properties: Extract system-mode specific properties
  hw/core: Add qdev stub for user-mode
  qapi: Restrict code generated for user-mode

 hw/core/qdev-prop-internal.h     |  28 ++
 include/hw/qdev-properties.h     |   1 +
 hw/core/qdev-properties-system.c | 602 ++++++++++++++++++++++++++++-
 hw/core/qdev-properties.c        | 643 ++-----------------------------
 hw/core/qdev-stubs.c             |  20 +
 hw/core/Makefile.objs            |   3 +
 qapi/Makefile.objs               |  37 +-
 7 files changed, 714 insertions(+), 620 deletions(-)
 create mode 100644 hw/core/qdev-prop-internal.h
 create mode 100644 hw/core/qdev-stubs.c

--=20
2.21.1


