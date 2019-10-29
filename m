Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1510C47E49
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2FB2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dweuGei3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2FB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPark-0007Gp-No
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPaq1-0005av-Og
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPapw-0000as-KM
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:23:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53301
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPapr-0000Q1-0D
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572391413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UcUSWi/ozLHXErxM7WBqzFz1fI/nZC8xpiQVI2IZe7k=;
 b=dweuGei3GLCDg/d06DNtWi8CFbAKhORE49nLfQyE+BW35kCpPEQNe9/zy7bd6VsCmNOe9E
 Y/ZWNfEphXSxH7NhOt8NJbJ7A0jSFD2g3XK8zBPAZ7K25oiEgLZfUmq06c9H2PMtOyFxbx
 rqa/almqvuivJyf6W6csZyQl2mUBuOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-IbqPeqxuNIa88dJrl0lBJg-1; Tue, 29 Oct 2019 19:23:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59E401005500;
 Tue, 29 Oct 2019 23:23:28 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F0235D9C3;
 Tue, 29 Oct 2019 23:23:22 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Acceptance test: update kernel used on m68k/q800 test
Date: Tue, 29 Oct 2019 19:23:18 -0400
Message-Id: <20191029232320.12419-1-crosa@redhat.com>
In-Reply-To: <20191028181643.5143-12-laurent@vivier.eu>
References: <20191028181643.5143-12-laurent@vivier.eu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: IbqPeqxuNIa88dJrl0lBJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Willian Rampazzo <wrampazz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The boot_linux_console.py:BootLinuxConsole.test_m68k_q800 was very
recently merged, but between its last review and now, the Kernel
package used went missing.

This updates the Kernel package, and protects the test from failing
if it gets updated again.

Cleber Rosa (2):
  Acceptance test: cancel test if m68k kernel packages goes missing
  Acceptance test: update kernel for m68k/q800 test

 tests/acceptance/boot_linux_console.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--=20
2.21.0


