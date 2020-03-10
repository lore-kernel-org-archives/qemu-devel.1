Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FE7C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78CA24677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S46wYjze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78CA24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaM0-0007tv-Vw
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jBaJO-0004gy-MM
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jBaJN-0003bj-MM
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58436
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jBaJN-0003ZZ-IE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583829144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tLMLrQ4LMi6fMCDqHB4JPGR9tJgfJkVEuRNRBpCYqTU=;
 b=S46wYjzeyWy76tsTCCWStVTC/9V06i6JWO82LYLS/vrMs8Ya5aYmSGZrjjqzZAMFMGAi61
 PuD+xT0Z6H6sEh9UgrEilaOqZZ+IvOr1Sh45X9z6NiaTSPd0tV/pAcurc5W1DAvjg5uB9S
 wRUdvlKZQW/DzvRrUvIawkkdpVLgTp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-O8pK_YRdNWKktq3T-doXBA-1; Tue, 10 Mar 2020 04:32:23 -0400
X-MC-Unique: O8pK_YRdNWKktq3T-doXBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7C338017DF;
 Tue, 10 Mar 2020 08:32:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF7015DA60;
 Tue, 10 Mar 2020 08:32:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1FD649D1F; Tue, 10 Mar 2020 09:32:18 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] tests/vm: minor install tweaks, update netbsd & freebsd
Date: Tue, 10 Mar 2020 09:32:14 +0100
Message-Id: <20200310083218.26355-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Gerd Hoffmann (4):
  tests/vm: write raw console log
  tests/vm: move vga setup
  tests/vm: update FreeBSD to 12.1
  tests/vm: update NetBSD to 9.0

 tests/vm/basevm.py   |  7 ++++++-
 tests/vm/fedora      |  1 +
 tests/vm/freebsd     |  5 +++--
 tests/vm/netbsd      | 24 +++++++-----------------
 tests/vm/openbsd     |  1 +
 tests/vm/ubuntu.i386 |  5 ++++-
 6 files changed, 22 insertions(+), 21 deletions(-)

--=20
2.18.2


