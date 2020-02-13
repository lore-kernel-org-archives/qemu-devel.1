Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A950C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BF9217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnknZD3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BF9217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2A6c-0006C7-9G
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 03:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2A62-0005gz-Ez
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2A61-00029E-C6
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:43:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41657
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2A61-00028v-8X
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581583420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cf3uOtlRRLDIa+I0zRzpCou8aAF2zMKJw1ETVevbkt8=;
 b=KnknZD3U5gvrIES/VhLrhsLnQuXK8co5Sv+OOf5JvZTr7Oh4sZGYgVn+UJtNcuxbOZdBiR
 lskImrz/7JTrhXWpcuvzRXx1ZJLdsvtdPOO/WeYzW7No0oUug03S6MjfQCykOYuSPTIs4R
 e8ml7pc22eR5a1nQRIFlXUWzDK+WjI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-Vkk2-lhcNOqWAOZXRCptiQ-1; Thu, 13 Feb 2020 03:43:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1F4D477;
 Thu, 13 Feb 2020 08:43:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E0D96E40A;
 Thu, 13 Feb 2020 08:43:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 05A9F11385C9; Thu, 13 Feb 2020 09:43:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-doc: Clarify extent of build platform support
Date: Thu, 13 Feb 2020 09:43:34 +0100
Message-Id: <20200213084335.15100-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Vkk2-lhcNOqWAOZXRCptiQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: jsnow@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Supporting a build platform beyond its end of life makes no sense.
Spell that out just to be clear.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-doc.texi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index a1ef6b6484..33b9597b1d 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2880,10 +2880,11 @@ lifetime distros will be assumed to ship similar so=
ftware versions.
=20
 For distributions with long-lifetime releases, the project will aim to sup=
port
 the most recent major version at all times. Support for the previous major
-version will be dropped 2 years after the new major version is released. F=
or
-the purposes of identifying supported software versions, the project will =
look
-at RHEL, Debian, Ubuntu LTS, and SLES distros. Other long-lifetime distros=
 will
-be assumed to ship similar software versions.
+version will be dropped 2 years after the new major version is released,
+or when it reaches ``end of life''. For the purposes of identifying
+supported software versions, the project will look at RHEL, Debian,
+Ubuntu LTS, and SLES distros. Other long-lifetime distros will be
+assumed to ship similar software versions.
=20
 @section Windows
=20
--=20
2.21.1


