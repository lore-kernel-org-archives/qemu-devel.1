Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC05BCA9EBE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACDD21D81
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcCavdqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACDD21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO03l-0003ap-66
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNzvI-0005oo-4P
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNzvG-0000G9-UO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45434
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNzvG-0000FY-Ps
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572011194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LmVcNHa9B5kNKFQQUGalT3WNHrDuoUQ+ime7RscTJRk=;
 b=gcCavdqitlpCDlXC0v3sw0sJH2ypu8UOedUJ97Mkam/6Bfc9jUSa3XXxYn29SPvqngQTSw
 eRYw8kDgqrLJbY9wPtbEii6dtcgxCsQ42LddK6eMtGbAVdzl9+YcW9wZMscEkthWKRW6go
 ZRISqRphmS2zFkWRPa/qZHjMIxXECCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-3PBTY-ISOPSwpwUBgwh7Zw-1; Fri, 25 Oct 2019 09:46:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48D93107AD31;
 Fri, 25 Oct 2019 13:46:27 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-223.ams2.redhat.com
 [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 686355D70E;
 Fri, 25 Oct 2019 13:46:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 5/7] doc: Describe missing generic -blockdev options
Date: Fri, 25 Oct 2019 15:46:09 +0200
Message-Id: <20191025134611.25920-6-kwolf@redhat.com>
In-Reply-To: <20191025134611.25920-1-kwolf@redhat.com>
References: <20191025134611.25920-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3PBTY-ISOPSwpwUBgwh7Zw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We added more generic options after introducing -blockdev and forgot to
update the documentation (man page and --help output) accordingly. Do
that now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-options.hx | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 996b6fba74..19709f973d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -864,7 +864,8 @@ ETEXI
 DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
     "-blockdev [driver=3D]driver[,node-name=3DN][,discard=3Dignore|unmap]\=
n"
     "          [,cache.direct=3Don|off][,cache.no-flush=3Don|off]\n"
-    "          [,read-only=3Don|off][,detect-zeroes=3Don|off|unmap]\n"
+    "          [,read-only=3Don|off][,auto-read-only=3Don|off]\n"
+    "          [,force-share=3Don|off][,detect-zeroes=3Don|off|unmap]\n"
     "          [,driver specific parameters...]\n"
     "                configure a block backend\n", QEMU_ARCH_ALL)
 STEXI
@@ -900,6 +901,25 @@ name is not intended to be predictable and changes bet=
ween QEMU invocations.
 For the top level, an explicit node name must be specified.
 @item read-only
 Open the node read-only. Guest write attempts will fail.
+
+Note that some block drivers support only read-only access, either general=
ly or
+in certain configurations. In this case, the default value
+@option{read-only=3Doff} does not work and the option must be specified
+explicitly.
+@item auto-read-only
+If @option{auto-read-only=3Don} is set, QEMU may fall back to read-only us=
age
+even when @option{read-only=3Doff} is requested, or even switch between mo=
des as
+needed, e.g. depending on whether the image file is writable or whether a
+writing user is attached to the node.
+@item force-share
+Override the image locking system of QEMU by forcing the node to utilize
+weaker shared access for permissions where it would normally request exclu=
sive
+access.  When there is the potential for multiple instances to have the sa=
me
+file open (whether this invocation of QEMU is the first or the second
+instance), both instances must permit shared access for the second instanc=
e to
+succeed at opening the file.
+
+Enabling @option{force-share=3Don} requires @option{read-only=3Don}.
 @item cache.direct
 The host page cache can be avoided with @option{cache.direct=3Don}. This w=
ill
 attempt to do disk IO directly to the guest's memory. QEMU may still perfo=
rm an
--=20
2.20.1


