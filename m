Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791BFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4637620720
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBVgIU+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4637620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIc4-0004dc-Gc
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIb2-00033b-02
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44128
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIax-0005Uu-68
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593770818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mQ+vqooSJzMU58izcBnyW4ELKo6jiTephGduIy8EajA=;
 b=DBVgIU+AP9eFGqogz/tg5K3iWhdKoWjuHeTOgBH8b/RfdqyAZMurjszBqK/FZSD9C9jo0t
 vSzuQNOLOdbVcl2OxHkA5stE76nJ+bGSVTWd9uqAzG7JHkT0qgovxSOn0y1+6fsjX7JmR9
 5EifY0+JoJdnYgpN2XzAHuX61YZLzmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-gWq_8K78M1WtRzTf35dN6w-1; Fri, 03 Jul 2020 06:06:55 -0400
X-MC-Unique: gWq_8K78M1WtRzTf35dN6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F05A186A200;
 Fri,  3 Jul 2020 10:06:54 +0000 (UTC)
Received: from localhost (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A84D77923E;
 Fri,  3 Jul 2020 10:06:53 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/14] s390x update
Date: Fri,  3 Jul 2020 12:06:36 +0200
Message-Id: <20200703100650.621212-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 64f0ad8ad8e13257e7c912df470d46784b55c3fd:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2020-07-02' into staging (2020-07-02 15:54:09 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20200703

for you to fetch changes up to f196f6a8c7cca5e8bd1d6d37995447e1d6028223:

  Merge tag 's390-ccw-bios-2020-07-02' into s390-next-staging (2020-07-03 11:17:03 +0200)

----------------------------------------------------------------
s390 update:
- various fixes
- cleanup in the s390x-ccw bios

----------------------------------------------------------------

Halil Pasic (2):
  virtio-ccw: fix virtio_set_ind_atomic
  s390x/pci: fix set_ind_atomic

Janosch Frank (9):
  pc-bios: s390x: cio.c cleanup and compile fix
  pc-bios: s390x: Consolidate timing functions into time.h
  pc-bios: s390x: Move sleep and yield to helper.h
  pc-bios: s390x: Get rid of magic offsets into the lowcore
  pc-bios: s390x: Rename PSW_MASK_ZMODE to PSW_MASK_64
  pc-bios: s390x: Use PSW masks where possible and introduce
    PSW_MASK_SHORT_ADDR
  pc-bios: s390x: Move panic() into header and add infinite loop
  pc-bios: s390x: Use ebcdic2ascii table
  pc-bios: s390x: Make u32 ptr check explicit

Richard Henderson (1):
  target/s390x: Fix SQXBR

Thomas Huth (2):
  pc-bios/s390-ccw: Generate and include dependency files in the
    Makefile
  pc-bios/s390: Update s390-ccw bios binaries with the latest changes

-- 
2.25.4


