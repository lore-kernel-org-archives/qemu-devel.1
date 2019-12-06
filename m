Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255FFC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50CA20659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXKj6bHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50CA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGNS-0000jE-3T
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1idFE9-0000xb-GO
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1idFE7-0000Vt-F8
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:09:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1idFE7-0000UZ-Ap
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575644942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MNiUvkiM0DD9iKxU0fe0AFvwNGHmzCfP+aLuS5lAodg=;
 b=XXKj6bHwihQnI/6y/8xDSklfBukpwFwOmSKq+aIVsMqUyGUE4F3OrvIWpQtuosxPWZ2rDD
 5NECe5tGxrmh2fE/t/DnNhOfTxYB9mPLCzOATgs2AfyIR6uUfwG7Zdd/A7ak2blzgAjSDV
 7Gn3pSMhP2wUthhMoyk+fxbvSB7RUro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-K0Y2f4suOHKEJsLQNdLJ6A-1; Fri, 06 Dec 2019 10:09:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D825DC29;
 Fri,  6 Dec 2019 15:09:00 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 061425D6C8;
 Fri,  6 Dec 2019 15:08:45 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/1] Fix for m68k/q800 acceptance test for QEMU 4.2-rc
Date: Fri,  6 Dec 2019 10:08:43 -0500
Message-Id: <20191206150844.20124-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: K0Y2f4suOHKEJsLQNdLJ6A-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 1bdc319ab5d289ce6b822e06fb2b13666fd9278e=
:

  Update version for v4.2.0-rc4 release (2019-12-03 17:56:30 +0000)

are available in the Git repository at:

  git://github.com/clebergnu/qemu.git tags/python-next-pull-request

for you to fetch changes up to 820649aa00ee343a0d473ad1002c59c70ba8c158:

  tests/boot_linux_console: Fetch assets from Debian snapshot archives (201=
9-12-06 09:48:35 -0500)

----------------------------------------------------------------
Fix for m68k/q800 acceptance test (Philippe Mathieu-Daud=C3=A9)

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (1):
  tests/boot_linux_console: Fetch assets from Debian snapshot archives

 tests/acceptance/boot_linux_console.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--=20
2.21.0


