Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DB8C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C301224658
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDCh+Sj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C301224658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9W2W-0008Op-R0
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 10:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9W1R-0006p3-SZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9W1Q-0003EI-91
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58922
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9W1Q-0003CE-5Y
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583335999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FRJZiT0C+nhIBW9S3s2Wkg6RZ5NpqpIs6j0r68DYwIw=;
 b=YDCh+Sj4znDg0A4Ohj1iGXWJdvZ8BAXIesHS5pSBBjUF4q0muy/kQi+w5hEWDXhp6ERH+C
 foz78UhJVz3kUy7DDSf9dJDyk/FoXoSbNI2a5+ku7mkDOAazqXCNyg/c+RA7A/D6Snf1gT
 p8qn1qIrZvSsfCwejIjIlrMwqkjsxd8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-5l4o-3pfMvahtsNcKm4SFQ-1; Wed, 04 Mar 2020 10:33:16 -0500
X-MC-Unique: 5l4o-3pfMvahtsNcKm4SFQ-1
Received: by mail-wm1-f71.google.com with SMTP id r19so1010576wmh.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 07:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=12J3KSBbIUK1hTaIcAnMxodJGRJ30hW9vyqEhy0EiQ8=;
 b=mT6eMbWnzYsjUEo45YwMoqi6L6SO8KuXJHhAbuw9l4tryPQ+dUD6CN3tLOaU1leW5U
 Lu6CQ9ZnUnC0tt2nIoxTLnKWlqBYMeTYfJr6Npk/sPgM5QMq4hQSbzpuP56TGOHPW7SK
 xzU2uSbXhyqaYBK7i03Hh4rIb/lAqagSTK7aNLKr1Ah4AMquB7xdt5DtZvAdOfyucfnj
 vlQPSz4qhCoLSoipcVhk5uEmYDCdS0pO+LxnBzM4KmkmRHZpV98eNm8vvSkp2BuMz+vD
 kWSZuC+6A480FnHZPZK5AzR/Yo3QsPe9YSipBcK41m8axarIelGlZoBQF5SU8AD/6z2S
 EAyA==
X-Gm-Message-State: ANhLgQ1yZXXeSdojgVm8wbLgcdvgnxsshnW2zmKEJ+S+EP808BtjFPcN
 ksHeyN/GMy5YB+ofn8bPyyYXkotCb5+V24iY3EyqNvdUCaGguMQowGM/yibbZedycX1CpkVtlxf
 2I/+zLnec3SdTHKw=
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr4304466wmc.134.1583335995087; 
 Wed, 04 Mar 2020 07:33:15 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtCXRyaWzollJQmcZx1VFtw0Dk/G9OpAz5CoHqa+YI0eDlGPfFTjc2WfawFbxD8bKfFXLiYaw==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr4304452wmc.134.1583335994850; 
 Wed, 04 Mar 2020 07:33:14 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a70sm4766584wme.28.2020.03.04.07.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 07:33:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw/scsi/spapr_vscsi: Fix time bomb zero-length array use
Date: Wed,  4 Mar 2020 16:33:06 +0100
Message-Id: <20200304153311.22959-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes a dangerous zero-length array use.
Simples patches first to clean the issue in the last patch:
dissociate the buffer holding DMA requests with pointer to
SRP Information Unit packets.

Philippe Mathieu-Daud=C3=A9 (5):
  hw/scsi/viosrp: Add missing 'hw/scsi/srp.h' include
  hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of sizeof flexible
    array
  hw/scsi/spapr_vscsi: Simplify a bit
  hw/scsi/spapr_vscsi: Introduce req_ui() helper
  hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA buffer size

 hw/scsi/viosrp.h      |  4 ++-
 hw/scsi/spapr_vscsi.c | 60 ++++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 27 deletions(-)

--=20
2.21.1


