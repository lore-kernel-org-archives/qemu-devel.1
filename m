Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257D6C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AB020658
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7dVnrbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AB020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pOg-0007or-E9
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9pN6-0005j5-N7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9pN5-0000Gv-Ix
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20997
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9pN5-0000Gn-Fr
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583410378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+56ePGmcoq5HykhcZAo7kepR5r52+6ZEFhWUGu2Ti+0=;
 b=i7dVnrbn5HSOBmNFKOK1VddBPHlpsc9feKBw8XYlprWUSneKgYfs6qt3tR4CCFNFGCP2Bp
 zX61NmKanGZCHo8GeCRPUvuaDQBI8OPrKEIhTaoelH6y4iBSqdLJhaSIWk3QibgZTsz0n4
 hD9c+gMqlggN2McVXlbB83w3hzp7icU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-msrKl2yHNbGajcQISJ-Lsw-1; Thu, 05 Mar 2020 07:12:57 -0500
X-MC-Unique: msrKl2yHNbGajcQISJ-Lsw-1
Received: by mail-wm1-f70.google.com with SMTP id b23so2009529wmj.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:12:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b+3jo3N8d74YrpwOeB7pNboZd0jkS+c2ioGwyFUoFzI=;
 b=lIBhxv5kKmSywDfNjRIhmcZtaGfwN6vLDr7WI2Po04PSzDIWgnJSe3NctZg2krY85Y
 ZRrUpn1FRwns3+9Sf4O1uK5bpp+O2jR5TtC8QJP/f0h+xzBT3w2NN6PW2J+uLk4gMP3V
 SqsnNBSVDYjNgcxvQ4wKLYvT1ZG5lGLOgbDwHX2ae/ECUjeSKVkhg9eUOyfnKyifhzV1
 US9bWScXWsbskzbPbRCv6Opyl2Y2mwIGZVlkiq5nlRxzLFljG84GXSMLVsHnVND7p7WX
 oMIQ7h2qB5Syu1yH5mn1RqJJXAA++zPOGcqoHoFuRJGua6dLSjpnDLbqV8t9OTMX/aOa
 +NNA==
X-Gm-Message-State: ANhLgQ2OGdvsJDrySyHun2oCxr0AgSrgT5Gga3uXDW8zeNTsjoCvUP/K
 +UBBUDRxA+3tcWd/jaSlLZzmo3dbFKYkMch+fv6hYhKyBr7U3GY1gas0xfrC8egewsH6vjSMEXJ
 JiK9jyTi8QcLf6W8=
X-Received: by 2002:a7b:c391:: with SMTP id s17mr9426458wmj.116.1583410376032; 
 Thu, 05 Mar 2020 04:12:56 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtOg2OYMFkXseO6aX/PFLVwFGALH7wLn6zIGjdxv5vPJMXDH9J7kVGhSVFjNXx+wk1qI/E5kA==
X-Received: by 2002:a7b:c391:: with SMTP id s17mr9426436wmj.116.1583410375830; 
 Thu, 05 Mar 2020 04:12:55 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a26sm9260336wmm.18.2020.03.05.04.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:12:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] hw/scsi/spapr_vscsi: Fix time bomb buffer overflow
Date: Thu,  5 Mar 2020 13:12:46 +0100
Message-Id: <20200305121253.19078-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes a possible buffer overflow.

Simples patches first (dissociate the buffer holding DMA
requests with pointer to SRP Information Unit packets) to
clean the issue in the penultimate patch.

v3:
- Fixed typo reported by Greg Kurz
- Addressed Paolo Bonzini review comments as an extra patch
- Added another patch converting a fprintf() call while here

v2:
- Addressed David Gibson review comments

Supersedes: <20200305083135.8270-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (7):
  hw/scsi/viosrp: Add missing 'hw/scsi/srp.h' include
  hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of sizeof flexible
    array
  hw/scsi/spapr_vscsi: Simplify a bit
  hw/scsi/spapr_vscsi: Introduce req_iu() helper
  hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA buffer size
  hw/scsi/spapr_vscsi: Prevent buffer overflow
  hw/scsi/spapr_vscsi: Convert debug fprintf() to trace event

 hw/scsi/viosrp.h      |  3 +-
 hw/scsi/spapr_vscsi.c | 72 +++++++++++++++++++++++++------------------
 hw/scsi/trace-events  |  1 +
 3 files changed, 45 insertions(+), 31 deletions(-)

--=20
2.21.1


