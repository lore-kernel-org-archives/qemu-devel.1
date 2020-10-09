Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2958C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4067522265
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNPcE01p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4067522265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmNv-0006Kx-6D
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQmDF-00008I-CD
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQmDC-0001Zh-CF
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602226143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fSOz6XF4Imbu1oaMRGmSndDOX/5VPBYGRJHWpX9x1DI=;
 b=UNPcE01p8wB56mO+SJZggTSuXDkkYm2TglWRJJIvHPuTepgimqKlmH61nciBJ5TDiDuMDv
 OGx8WaFQkxLPANh7fBhBX5xgavezuR47+Y0R85Epv8gOdginpGFoNxNJgrMGj6Qtdr3l5T
 sn238VRB1pIP7aaDSvF7WFYZhpcO1fc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-8IVd4hoyNzWG8F2gE8YYig-1; Fri, 09 Oct 2020 02:49:01 -0400
X-MC-Unique: 8IVd4hoyNzWG8F2gE8YYig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 490C587950B;
 Fri,  9 Oct 2020 06:49:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A68160BFA;
 Fri,  9 Oct 2020 06:49:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8FA1E112CE10; Fri,  9 Oct 2020 08:48:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Error reporting patches for 2020-10-09
Date: Fri,  9 Oct 2020 08:48:56 +0200
Message-Id: <20201009064858.323624-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 497d415d76b9f59fcae27f22df1ca2c3fa4df64e:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201008-1' into staging (2020-10-08 21:41:20 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-10-09

for you to fetch changes up to 805d44961b9015716cc13c1d3e49457af3970d82:

  error: Use error_fatal to simplify obvious fatal errors (again) (2020-10-09 08:36:23 +0200)

----------------------------------------------------------------
Error reporting patches for 2020-10-09

----------------------------------------------------------------
Markus Armbruster (2):
      error: Remove NULL checks on error_propagate() calls (again)
      error: Use error_fatal to simplify obvious fatal errors (again)

 exec.c                     | 11 +++--------
 hw/net/virtio-net.c        |  8 ++------
 hw/s390x/s390-virtio-ccw.c |  7 +------
 hw/virtio/vhost.c          | 10 +++-------
 migration/colo.c           |  4 +---
 migration/migration.c      |  8 ++------
 6 files changed, 12 insertions(+), 36 deletions(-)

-- 
2.26.2


