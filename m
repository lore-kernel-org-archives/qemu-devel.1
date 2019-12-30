Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BD3C2D0CE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 18:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2DD20722
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 18:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRkOHTi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2DD20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1im02I-00015Q-1e
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 13:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1im00z-0008T1-R4
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1im00x-0007em-G5
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:43:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26101
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1im00x-0007dX-Bl
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577731418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uHBejMO0VJOYDpUEtcSyg5ZHdgKjYxNS6h9zoBUM7bU=;
 b=MRkOHTi4qrN6erSJ00sSUjtUvKH3n6AJlpsEPoZg2bjCZKHbmztSUy6atR5TLxtP/W6T1E
 fjxCNfxoodQIE/NCf0uocxxFanLg0yqE+csG36TvD7Dej+KJW386rZcBRsL4trHzZC1erS
 zMg+ApPwPmFLTI8WA/OYiiRdif5soNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-QhgfdF7APHaCn9lEBleWPg-1; Mon, 30 Dec 2019 13:43:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86453107ACC7;
 Mon, 30 Dec 2019 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-92.gru2.redhat.com
 [10.97.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAA2C78E77;
 Mon, 30 Dec 2019 18:43:29 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] travis: Improve log browseability
Date: Mon, 30 Dec 2019 15:43:25 -0300
Message-Id: <20191230184327.2800-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: QhgfdF7APHaCn9lEBleWPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While I was working on [1] I needed to check what dependencies
were missing on Travis environment to build a kernel. The test was
coded so that a build failure would cancel the test. As a result,
and because all tests pass'ed (or cancel'ed) I could not see
the Avocado logs (consequentely not able to check the missing
packages). That was the main reason for the Patch 01 in this
series. Also it seems pointless to print the log of the tests
that pass.

The patch 02 is a tentative to improve the browsing of build vs
test logs. Honestly I was expecting that Travis was able to
put the output of steps each on toggled text boxes (see the
'before_script' section, each command output has a
toggle). But that isn't the behavior of the 'script'
section. At least it prints the end of the build command
('The command "BUILD_RC=3D0 && make -j3 || BUILD_RC=3D$?" exited with 0.')
which can be grep'ed.

Git:
- Tree: https://github.com/wainersm/qemu
- Brach: travis_improved_browse

CI:
- Travis (FAIL): https://travis-ci.org/wainersm/qemu/builds/630948777
  QEMU keep failing with --without-default-devices

References:
[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg663432.html

Wainer dos Santos Moschetta (2):
  travis.yml: avocado: Print logs of non-pass tests only
  travis.yml: Detach build and test steps

 .travis.yml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--=20
2.23.0


