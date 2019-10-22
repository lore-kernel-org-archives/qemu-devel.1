Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CB0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A1020B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIgiFrcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A1020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52583 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqtc-0006zq-45
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iMqs7-000588-KC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iMqs6-0005ZX-Gf
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:54:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iMqs6-0005ZI-CX
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571738073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LVunaNzBnuEjlFRJBX4y9JIFFO/UKQhoDXliuhFEw+8=;
 b=NIgiFrcZAsqKCU0SJoDrB2BXgnxim+V91gNtRyv+BeQc+GOwqoZmfby5GwkTLJsDgwFqsI
 eFUWJ4W02hrMKXkJt1+a3pCCdpzBLEMGpuYiMOIeEYgbn3zEOBWoP8mOfnCHo4fVk8cjj2
 /Txi9KGgtek5x5fp2LwgFS3o6j2sqxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-J16qpOKmNc6c_4X6TbRtow-1; Tue, 22 Oct 2019 05:54:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 937E480183E;
 Tue, 22 Oct 2019 09:54:31 +0000 (UTC)
Received: from localhost (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4446860126;
 Tue, 22 Oct 2019 09:54:31 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/9] more s390x fixes
Date: Tue, 22 Oct 2019 11:54:19 +0200
Message-Id: <20191022095428.20780-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: J16qpOKmNc6c_4X6TbRtow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e9d42461920f6f40f4d847a5ba18e90d095ed0b9=
:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191018-pull-req=
uest' into staging (2019-10-18 14:13:11 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20191022

for you to fetch changes up to de60a92ea7b7977854420c58fd98f38cb6de6de6:

  s390x/kvm: Set default cpu model for all machine classes (2019-10-21 18:0=
3:08 +0200)

----------------------------------------------------------------
s390x fixes in tcg vector instruction handling and in the
cpu model code

----------------------------------------------------------------

Andrew Jones (1):
  s390x/cpumodel: Add missing visit_free

David Hildenbrand (8):
  s390x/mmu: Remove duplicate check for MMU_DATA_STORE
  s390x/tcg: Fix VECTOR MULTIPLY LOGICAL ODD
  s390x/tcg: Fix VECTOR MULTIPLY AND ADD *
  s390x/tcg: Fix VECTOR SHIFT RIGHT ARITHMETIC BY BYTE
  s390x/tcg: Fix VECTOR SUBTRACT COMPUTE BORROW INDICATION
  s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW INDICATION
  s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW COMPUTE BORROW INDICATION
  s390x/kvm: Set default cpu model for all machine classes

 target/s390x/cpu_models.c       |  1 +
 target/s390x/kvm.c              | 10 ++++++++--
 target/s390x/mmu_helper.c       |  4 +---
 target/s390x/translate_vx.inc.c | 30 ++++++++++++------------------
 target/s390x/vec_int_helper.c   | 18 ++++++++++--------
 5 files changed, 32 insertions(+), 31 deletions(-)

--=20
2.21.0


