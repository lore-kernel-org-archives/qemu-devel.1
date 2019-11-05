Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F615C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6082087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7SRDK8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6082087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS11b-0005gV-Em
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iS0zi-00045I-TE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iS0zg-0001uV-C1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:43:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45295
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iS0zg-0001sY-80
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572968623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qqDOS2zc80HTung0eHDbusxLC3ZrotuWCkGdnXC+zQE=;
 b=N7SRDK8vXqolDwe+MUd0riQKQxM9n8mSyVIpz9vLBx9ujaAMUhI/y/r6yZqc8/mefh+nE2
 zDX83h+Yj5PF3gvLu0YqNJgpp5YHsgP0kCvMTSZLYKRHubosW6rHa1eDz1tVWjJlVAMVBp
 utSMmNxab5Si8qNHMOpBEXF1IgpaHow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-2pGGTc-kM5OM0Rn0--4C5w-1; Tue, 05 Nov 2019 10:43:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BF371005500;
 Tue,  5 Nov 2019 15:43:41 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 845965D9CD;
 Tue,  5 Nov 2019 15:43:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] Block patches
Date: Tue,  5 Nov 2019 16:43:21 +0100
Message-Id: <20191105154332.181417-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 2pGGTc-kM5OM0Rn0--4C5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408=
:

  Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-s=
f1' into staging (2019-11-02 17:59:03 +0000)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 9fdd7860adec188ed50d2530e9a819e8d953f9bb:

  image-fuzzer: Use OSerror.strerror instead of tuple subscript (2019-11-05=
 16:36:11 +0100)

----------------------------------------------------------------
Pull request

Let's get the image fuzzer Python 3 changes merged in QEMU 4.2.

----------------------------------------------------------------

Eduardo Habkost (11):
  image-fuzzer: Open image files in binary mode
  image-fuzzer: Write bytes instead of string to image file
  image-fuzzer: Explicitly use integer division operator
  image-fuzzer: Use io.StringIO
  image-fuzzer: Use %r for all fiels at Field.__repr__()
  image-fuzzer: Return bytes objects on string fuzzing functions
  image-fuzzer: Use bytes constant for field values
  image-fuzzer: Encode file name and file format to bytes
  image-fuzzer: Run using python3
  image-fuzzer: Use errors parameter of subprocess.Popen()
  image-fuzzer: Use OSerror.strerror instead of tuple subscript

 tests/image-fuzzer/qcow2/__init__.py |  1 -
 tests/image-fuzzer/qcow2/fuzz.py     | 54 +++++++++++++-------------
 tests/image-fuzzer/qcow2/layout.py   | 57 ++++++++++++++--------------
 tests/image-fuzzer/runner.py         | 16 ++++----
 4 files changed, 63 insertions(+), 65 deletions(-)

--=20
2.23.0


