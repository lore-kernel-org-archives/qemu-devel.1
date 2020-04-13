Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B8CC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805512072C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKT0pZp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805512072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNwz4-00007X-NA
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 07:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jNwxh-0007My-Ne
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jNwxg-0006Cw-7X
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:09:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42807
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jNwxg-00066r-25
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586776147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l2G7/7BY03NJsc68R1Ud3k9GtQhnzdQKsvXvczURNoc=;
 b=WKT0pZp2eylJZnkDt7Lpq2KJR5iXqgD/5xOU39kV9MlQVyvZL2SDWLzOIlSIpE9WbvzTJJ
 zkyOPHLzEFk7jTMSiCj77NRw67UUDfp+BlbJDm+YWuxv/Myy+h2ar8aZRPa+9FNyzObgPZ
 TLEN3xSG92rdv+DFJSnZX2kMGVzWraA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-17tew4gePVig_Q_Gm5IKBg-1; Mon, 13 Apr 2020 07:09:05 -0400
X-MC-Unique: 17tew4gePVig_Q_Gm5IKBg-1
Received: by mail-wr1-f71.google.com with SMTP id f15so6572159wrj.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 04:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=y2fnQz1KkpUlYYVaXPOCVmK+wohNckDu0c/xrEAGqiw=;
 b=Pcl192ks2Cmts9ApW6pz+EIUMAfpop6XlvBDt/k/P5/1XFuyhyxLsml9hPPDLIKmsw
 +sGehhH16+2XQwbasUoogWZ33G9n7PtXFXMWwQ8c6JRtxkzL0jIf156SRqjZYNk4cOrj
 IHrBJfdwInH8gjQjC2aUqIMAeSRjTPRm1N0MuOnXZ+egYxUq52FJD7ftj86wyTL+Hheb
 I3pOObFplFESWpBQGQdx1K5Iy9iUfkCvX4kU/4OkkVC4U+toKLoEkP8uP0lOLPkK216j
 yRE2g4WSNH8yXteCD/SGCEKqvHNjCHVuZdCubxy68jIyKJbsRPQEwsF2xCVSwvrrwFpc
 0Uvg==
X-Gm-Message-State: AGi0Pub6LL55JOW/OkRWQLeUGa9rZLSliNZRanVRKcEOEzR5Yw/rlwEF
 hwsAm01E9KjSmw/XUGh+bU1xMehtruQ+rHWe4qbFuY331Br3uO3sE4KwWpdKhyfPirL84w2E+9H
 nFu/kmnIcrhPhAYI=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr6155714wrq.14.1586776144239; 
 Mon, 13 Apr 2020 04:09:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypKHcbQ8HI3KRAugvlo6SI4d56Ipgv9anNiXLmwShTe6vHjyxZxeZUPcWUnsL8MjeOrROee3Iw==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr6155700wrq.14.1586776144019; 
 Mon, 13 Apr 2020 04:09:04 -0700 (PDT)
Received: from redhat.com ([185.107.45.41])
 by smtp.gmail.com with ESMTPSA id y20sm15007755wra.79.2020.04.13.04.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 04:09:03 -0700 (PDT)
Date: Mon, 13 Apr 2020 07:09:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] pc: bugfixes, maintainers
Message-ID: <20200413110838.151374-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

The following changes since commit f3bac27cc1e303e1860cc55b9b6889ba39dee587=
:

  Update version for v5.0.0-rc2 release (2020-04-07 23:13:37 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to ce4adc0b6e6167091373389ef8befd379c61fddb:

  exec: Fix for qemu_ram_resize() callback (2020-04-13 06:55:54 -0400)

----------------------------------------------------------------
pc: bugfixes, maintainers

A couple of bugfixes.
Add a new vhost-user-blk maintainer.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Hildenbrand (1):
      exec: Fix for qemu_ram_resize() callback

Raphael Norwitz (1):
      MAINTAINERS: Add myself as vhost-user-blk maintainer

Shameer Kolothum (2):
      acpi: Use macro for table-loader file name
      fw_cfg: Migrate ACPI table mr sizes separately

 include/hw/acpi/aml-build.h |  1 +
 include/hw/nvram/fw_cfg.h   |  6 +++
 exec.c                      | 16 +++++++-
 hw/arm/virt-acpi-build.c    |  2 +-
 hw/core/machine.c           |  1 +
 hw/i386/acpi-build.c        |  2 +-
 hw/nvram/fw_cfg.c           | 91 +++++++++++++++++++++++++++++++++++++++++=
+++-
 MAINTAINERS                 | 12 ++++++
 8 files changed, 126 insertions(+), 5 deletions(-)


