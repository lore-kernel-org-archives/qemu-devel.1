Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AC2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74E02067C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXFyb+2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74E02067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3Ow-0001KQ-06
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw3NW-00086Q-Sa
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw3NV-0006Uc-QU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39893
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw3NV-0006UH-Mv
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Jc86VGyRXAzh7XP119MdxeIwEvowZRRLVmYtLF/WfyQ=;
 b=VXFyb+2ijk4lI304EHasUFoa7E5IcR/ojARm38ykw9Q/LEHBHpZIExaLJ9UgQNeY8KbFPQ
 0RMiCSIXOlXNrLu9Y7zWAlbYMDxPaWzo9EItzWxG5SU6pDHT5skt3qUV99/BN3KT9MGd1o
 IrH9BaIRUPz63iO1R4/lcqKJgKEQ9OU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-xriFoNvENTK71_HXkG1baQ-1; Mon, 27 Jan 2020 07:20:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 319DE800D41;
 Mon, 27 Jan 2020 12:20:23 +0000 (UTC)
Received: from localhost (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9683A1001B08;
 Mon, 27 Jan 2020 12:20:22 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/15] s390x update
Date: Mon, 27 Jan 2020 13:20:01 +0100
Message-Id: <20200127122016.18752-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xriFoNvENTK71_HXkG1baQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 760df0d121a836dcbf3726b80b820115aef21b30=
:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into sta=
ging (2020-01-27 09:44:04 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20200127

for you to fetch changes up to 4103500e2fa934a6995e4cedab37423e606715bf:

  s390x: sigp: Fix sense running reporting (2020-01-27 12:13:10 +0100)

----------------------------------------------------------------
s390x changes:
- kvm: re-enable adapter interrupt suppression (AIS)
- fixes and cleanups

----------------------------------------------------------------

Cornelia Huck (3):
  s390x: adapter routes error handling
  s390x/event-facility: fix error propagation
  docs/devel: fix stable process doc formatting

Daniel Henrique Barboza (3):
  s390x/sclp.c: remove unneeded label in sclp_service_call()
  intc/s390_flic_kvm.c: remove unneeded label in kvm_flic_load()
  s390x/event-facility.c: remove unneeded labels

Janosch Frank (1):
  s390x: sigp: Fix sense running reporting

Philippe Mathieu-Daud=C3=A9 (1):
  target/s390x: Remove duplicated ifdef macro

Richard Henderson (5):
  target/s390x: Move struct DisasFields definition earlier
  target/s390x: Remove DisasFields argument from callbacks
  target/s390x: Pass DisasContext to get_field and have_field
  target/s390x: Move DisasFields into DisasContext
  target/s390x: Remove DisasFields argument from extract_insn

Thomas Huth (2):
  target/s390x/kvm: Enable adapter interruption suppression again
  hw/s390x: Add a more verbose comment about get_machine_class() and the
    wrappers

 docs/devel/stable-process.rst   |   6 +-
 hw/intc/s390_flic_kvm.c         |  18 +-
 hw/s390x/event-facility.c       |  35 +-
 hw/s390x/s390-virtio-ccw.c      |  16 +-
 hw/s390x/sclp.c                 |  16 +-
 hw/s390x/virtio-ccw.c           |   4 +
 target/s390x/excp_helper.c      |   7 +-
 target/s390x/kvm.c              |   9 +-
 target/s390x/sigp.c             |   4 +-
 target/s390x/translate.c        | 982 ++++++++++++++++----------------
 target/s390x/translate_vx.inc.c | 649 +++++++++++----------
 11 files changed, 874 insertions(+), 872 deletions(-)

--=20
2.21.1


