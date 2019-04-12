Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30C5C282CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76ECE2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76ECE2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEv8d-0003o4-E4
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:18:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6i-0002h6-Mv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6g-0004V7-RR
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEv6g-0004Uf-Ky
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16CA6C0703C6;
	Fri, 12 Apr 2019 12:16:33 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-27.ams2.redhat.com
	[10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C88EE5D9CC;
	Fri, 12 Apr 2019 12:16:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Apr 2019 13:16:21 +0100
Message-Id: <20190412121626.19829-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 12 Apr 2019 12:16:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/5] misc set of fixes for warnings under
 GCC 9
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412121621.73Ihqa6jsEsyV8BpRpw7FYSwK0dnFIphZapvZVsrGbk@z>

This series addresses all the warnings I see when building on Fedora 30
x86_64 with GCC 9 (gcc-9.0.1-0.10.fc30.x86_64).

Changed in v2:

 - Dropped patches mistakenly included due to not correctly rebasing
 - Dropped s390x patches already merged
 - Dropped usb-mtp patches which need much more work to be correctly
   handling untrustworthy guest data.

Daniel P. Berrang=C3=A9 (5):
  linux-user: avoid string truncation warnings in uname field copying
  linux-user: avoid string truncation warnings in elf field copying
  sockets: avoid string truncation warnings when copying UNIX path
  hw/usb: avoid format truncation warning when formatting port name
  qxl: avoid unaligned pointer reads/writes

 hw/display/qxl.c     | 55 +++++++++++++++++++-------------------------
 hw/usb/hcd-xhci.c    |  2 ++
 linux-user/elfload.c | 10 ++++----
 linux-user/uname.c   |  2 +-
 util/qemu-sockets.c  | 12 ++++++----
 5 files changed, 39 insertions(+), 42 deletions(-)

--=20
2.20.1


