Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED57C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F12A20722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDiFiahq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F12A20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZjVx-0004JI-SG
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 17:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZjTV-000368-O0
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZjTS-0004IX-K8
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:38:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZjTS-0004I4-DL
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574807901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GOI8hlh4rNYFnYi6cQyI2O84IzEY+5wysmDUx/JsS20=;
 b=PDiFiahqj7iRRtUDfQCyAUh4AYKYrCS0UnLadcb0aDpVVoZGN851crm0jtPa69FbAq6vMT
 K3ZFc+iDl0kZF+G1+vpC7XR32wStwf7x2wFDHETjIzT0E8EnlVPuek0SDE6PgDhJHWetcX
 6pJvOgXLby+H6qcubeVWZP7VYSp+8DU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-GW-uhDy_OhSFO1XUxsNsSg-1; Tue, 26 Nov 2019 17:38:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0EB5100551D;
 Tue, 26 Nov 2019 22:38:18 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-63.brq.redhat.com [10.40.205.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A614600C8;
 Tue, 26 Nov 2019 22:38:13 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-4.2? v2 0/2] tests/acceptance: Fix the m68k/q800 Linux test
Date: Tue, 26 Nov 2019 23:38:08 +0100
Message-Id: <20191126223810.20180-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GW-uhDy_OhSFO1XUxsNsSg-1
X-Mimecast-Spam-Score: 0
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Willian Rampazzo <wrampazz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Today someone (William/Beraldo?) complained this test was still
failing while fetching the asset. This test already handle the
OSError exception, maybe we are missing another one.

Regardless, it is easier to refresh my previous patch which use
a stable link, so the problem should be fixed.

It seems cleaner to add the 2nd patch after the 1st one, but we don't need
it for 4.2, so it can wait 5.0 (and I'll update its description to refer to
the 1st patch sha1).

William/Beraldo, can you test this please?

Thanks!

Phil.

v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg656892.html

Philippe Mathieu-Daud=C3=A9 (2):
  tests/boot_linux_console: Fetch assets from Debian snapshot archives
  Revert "Acceptance test: cancel test if m68k kernel packages goes
    missing"

 tests/acceptance/boot_linux_console.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--=20
2.21.0


