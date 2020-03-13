Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BFBC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A490820658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiDNwJBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A490820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpUv-00021H-RF
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpK2-0000Dk-L7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpK1-0005rR-Go
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54566
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpK1-0005rA-Ct
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584125173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b/bZXqUSTVYLQExxJKFDId7JNaoZ8/c1zpMS0JObmi4=;
 b=GiDNwJBrYkP0xlYI/zPMrWnJYYQ1aYBXdTern7m/0TKzG9Ui2L4/p36ayXYVcz0vKNjDO0
 7iyKwgi6bmpEzuEQSSzKNIB78QFsW5KcBDdL1CdZeN9ijjjj0i73drQnhHLXHguLpjKDIE
 QNaB2lTeSBFfAem5A/84XTHlpb+SY80=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-c2vZPNddNAersb04xTGHoQ-1; Fri, 13 Mar 2020 14:46:11 -0400
X-MC-Unique: c2vZPNddNAersb04xTGHoQ-1
Received: by mail-wr1-f70.google.com with SMTP id q18so4716266wrw.5
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oMNFQeNumH/3LQXuQx2Xr87E8EKP5lYopTvY6ST+mqg=;
 b=XubfAgYTyLNtC2s7NKLvgG6XRp+dUM5vU8yhIz2AjJNa54Ywu+Qs9Jj23/LbKo9Lqt
 nVyxsjjUUkmiUUfNbVPBT8Ba/kDX4psoEc2Zd84/f6nl6iW536rBsRydycKRgmUBKRZk
 wA00HBUT92QLD4KY3k2XRcY/ABgCX4eF39vGFOzc0vCZ9usfdXP+YulPClBgnKACSL08
 zh3KWoQsmLFpSbkTFYLRRChipaeqFaePGv03GlXeTR4D/v/VNrijMyneatkco8teAi/Y
 K5l3aJk25VE1RD1AZDWocYZa+dTsa6cXO42s9BgqCkwgepcaL2UhMe86O5qxzwPZP/09
 hOXg==
X-Gm-Message-State: ANhLgQ2r47uBiXg++Qbzh4PogjwrvjOy08o52zjwVqcSA2Wy/UoMQyFR
 awj41nptM7QVcDPqxQnZA9G5Z7znyrKBvVTCFHizERVfzhbdQxffdf8rn7kQzTClnQOrOCRBiZQ
 +dlDhGzoQ6za7KqQ=
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr12065518wmb.8.1584125169589; 
 Fri, 13 Mar 2020 11:46:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvYZlGh/CPYA64HNoPlEsirsLUvo1Ts4p61sc7fV/iPYctgQUdUfe9j5X8Aww3JfimljcUXWg==
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr12065501wmb.8.1584125169412; 
 Fri, 13 Mar 2020 11:46:09 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id x5sm19380305wrv.67.2020.03.13.11.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:46:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/9] user-mode: Prune build dependencies (part 3)
Date: Fri, 13 Mar 2020 19:45:58 +0100
Message-Id: <20200313184607.11792-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
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

Based-on: <20200313184153.11275-1-philmd@redhat.com>

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
 hw/core/Makefile.objs            |   1 +
 qapi/Makefile.objs               |  37 +-
 7 files changed, 712 insertions(+), 620 deletions(-)
 create mode 100644 hw/core/qdev-prop-internal.h
 create mode 100644 hw/core/qdev-stubs.c

--=20
2.21.1


