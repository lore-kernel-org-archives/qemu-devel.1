Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E15C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E1A208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJTbzUqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E1A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iae08-0001fV-Sp
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iadm8-0000qH-SV
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:45:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iadm2-0003nR-J5
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:45:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36151
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iadm2-0003XG-F1
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575024313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UgtVFDXucTfJvos37+lmqDN2c5cl43F3OlQXoONDYFk=;
 b=MJTbzUqJIz4uRS1QUSoRj+2V46gF41nM29d+8hJXltSAQ9d356tt8CGByVE5Sd8OmzU0op
 YqkJtmLBog+VCAJQ0XNyDEsNWuqjVNCnOmCTppkNCUnO0RFq2hYtNI50JjPGHE5Mqwca+Y
 7v76C27qRijpWJ3VZrhF2uSQgf4Pphg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-cV9K70h6NQy04pJoi9rVfw-1; Fri, 29 Nov 2019 05:45:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 790B280183C;
 Fri, 29 Nov 2019 10:45:10 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-255.brq.redhat.com [10.40.204.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 266D95D9E1;
 Fri, 29 Nov 2019 10:45:02 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-4.2? 0/1] roms/edk2: update submodule to edk2-stable201911,
 fixing low severity CVEs
Date: Fri, 29 Nov 2019 11:44:56 +0100
Message-Id: <20191129104457.1991-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: cV9K70h6NQy04pJoi9rVfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Laszlo Ersek <lersek@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Bruce Rogers <brogers@suse.com>,
 Cole Robinson <crobinso@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I had this commit ready for when the next EDK2 release were go out,
which just happened: https://edk2.groups.io/g/devel/message/51502

Laszlo doesn't think it's worth the churn to rush to get this update
into into 4.2-rc4: https://bugs.launchpad.net/qemu/+bug/1852196/comments/2

I agree with Laszlo, users shouldn't use the EDK2 bundled within QEMU
in production, and should rather build it from source. However some
distributions seem to rely on this convenience way to package EDK2,
and few CVEs are fixed in this new release. So it might be worthwhile
to get this into 4.2-rc4. Anyhow distributions don't use QEMU stable
tag directly and backport patches, so if there is no other rc4 patch,
we could skip this for after 4.2, as Laszlo originally planned.

Philippe Mathieu-Daud=C3=A9 (1):
  roms/edk2: update submodule from edk2-stable201905 to
    edk2-stable201911

 roms/edk2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.21.0


