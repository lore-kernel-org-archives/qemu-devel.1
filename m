Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED6C3B184
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A017D214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrgwZfCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A017D214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15Ja-0000IT-Rt
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 04:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j15IN-0006zV-Hr
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j15IM-0003zJ-Hy
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:23:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j15IM-0003yr-EW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581326638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=La7s4Lx+katkCa2ALZLy/fQgZHpMAHVQz8TB9ljvA/A=;
 b=RrgwZfCVGzspHW4GyRaU9VZnQC99ufhU1BzCsk1feVjbL8MKLizN0EM2E9f+InE5CxqNeN
 Rvk9NTr5/+sFVaYNGMqxAm0GqxZtFuYOWti8/yazFa/tOfAIL7vcNIg1CgJHesRNJJa1MP
 o4PtleSLvo5H6dt5hAfQODRH8b707OI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-EmbxMfIyPnafueyNlBTo2w-1; Mon, 10 Feb 2020 04:23:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13E5B800D41;
 Mon, 10 Feb 2020 09:23:54 +0000 (UTC)
Received: from localhost (unknown [10.36.118.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EACA860BF1;
 Mon, 10 Feb 2020 09:23:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Block patches
Date: Mon, 10 Feb 2020 09:23:46 +0000
Message-Id: <20200210092348.398611-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: EmbxMfIyPnafueyNlBTo2w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 346ed3151f1c43e72c40cb55b392a1d4cface62c=
:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-20200206.=
0' into staging (2020-02-07 11:52:15 +0000)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 11a18c84db4a71497d3d40769688a01b6f64b2ad:

  hw/core: Allow setting 'virtio-blk-device.scsi' property on OSX host (202=
0-02-07 16:49:39 +0000)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (1):
  hw/core: Allow setting 'virtio-blk-device.scsi' property on OSX host

Vladimir Sementsov-Ogievskiy (1):
  block: fix crash on zero-length unaligned write and read

 block/io.c        | 28 +++++++++++++++++++++++++++-
 hw/core/machine.c |  3 ++-
 2 files changed, 29 insertions(+), 2 deletions(-)

--=20
2.24.1


