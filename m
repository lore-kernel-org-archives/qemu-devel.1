Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F2C4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C192070C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C192070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBET6-0003zX-6D
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iBEQl-0001Z0-H3
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iBEQk-0002iT-8H
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iBEQj-0002iI-Kv
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:38:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E917910C0929
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 08:38:16 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-165.rdu2.redhat.com
 [10.10.120.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA72060BF1;
 Fri, 20 Sep 2019 08:38:10 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH v2 0/2] edk2 build scripts: eliminate python 2 dependency
Date: Fri, 20 Sep 2019 10:38:06 +0200
Message-Id: <20190920083808.21399-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 20 Sep 2019 08:38:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1 URL:
http://mid.mail-archive.com/20190918171141.15957-1-lersek@redhat.com

Updates are noted on each patch.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks
Laszlo

Laszlo Ersek (2):
  edk2 build scripts: honor external BaseTools flags with
    uefi-test-tools
  edk2 build scripts: work around TianoCore#1607 without forcing Python
    2

 roms/Makefile                  |  1 +
 roms/edk2-build.sh             |  4 ++--
 roms/edk2-funcs.sh             | 17 +++++++++++++++++
 tests/uefi-test-tools/Makefile |  5 ++++-
 tests/uefi-test-tools/build.sh |  6 ++++--
 5 files changed, 28 insertions(+), 5 deletions(-)

--=20
2.19.1.3.g30247aa5d201


