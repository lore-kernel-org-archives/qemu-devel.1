Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D95CA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 02:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F2A20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 02:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKgm5IVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F2A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTAs-0005nk-Gx
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 22:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNT90-0002Zd-UT
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNT8y-0005bR-Pd
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:46:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24127
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNT8y-0005aL-BR
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571885190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0hPOoSsVE5OT1g+vyrBN3KrgdvY6TolQj348RFePwqk=;
 b=QKgm5IVcffwS8GIsF4DJiY3JzUVW/bLDtntmCqzJqW2JFSWfFZF4EYifdRSFLEwEOC196s
 8AiEDLtRbzGZn+XtbfRUgpXrWBCA3V55wLR0bMrFhqOb8IvBs28j/cvmBk/T4R4j90TLT9
 Ztzmqn1ypgfONAMWbVFXA+SCVvFt+PM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-7JpHOaxBM4mTqXq4Q8Oz6g-1; Wed, 23 Oct 2019 22:46:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF569800D5B;
 Thu, 24 Oct 2019 02:46:25 +0000 (UTC)
Received: from localhost (ovpn-116-56.gru2.redhat.com [10.97.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B287194B6;
 Thu, 24 Oct 2019 02:46:25 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 0/4] x86 and machine queue, 2019-10-23
Date: Wed, 23 Oct 2019 23:46:19 -0300
Message-Id: <20191024024623.18848-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 7JpHOaxBM4mTqXq4Q8Oz6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f78398bfe544db81a974825b0a2aa826f6576414=
:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-10-22' int=
o staging (2019-10-23 16:06:13 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 6a3a2e828220d9c86425930178445b868ea3c3c4:

  hppa: drop usage of memory_region_allocate_system_memory() for ROM (2019-=
10-23 23:37:42 -0300)

----------------------------------------------------------------
x86 and machine queue, 2019-10-23

Features:
* Denverton CPU model (Tao Xu)

Cleanups:
* Eliminate remaining places that abuse
  memory_region_allocate_system_memory() (Igor Mammedov)

----------------------------------------------------------------

Igor Mammedov (3):
  sparc64: use memory_region_allocate_system_memory() only for '-m'
    specified RAM
  ppc: rs6000_mc: drop usage of memory_region_allocate_system_memory()
  hppa: drop usage of memory_region_allocate_system_memory() for ROM

Tao Xu (1):
  target/i386: Introduce Denverton CPU model

 hw/hppa/machine.c    |  5 ++---
 hw/ppc/rs6000_mc.c   | 15 +++++++++-----
 hw/sparc64/niagara.c | 25 ++++++++++++-----------
 target/i386/cpu.c    | 47 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 20 deletions(-)

--=20
2.21.0


