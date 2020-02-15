Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E387C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584402073A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSyQd6zB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584402073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vvl-0007nO-If
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpT-0004bG-I8
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpS-0006ul-As
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpS-0006ud-6P
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UVEYZ/2oANGrGX14n+SNwUo6fQXygrsb0eO5PszyY4=;
 b=YSyQd6zBKgr66tQ5V5jjlJVPDP7qgjEDLZUSa+9iRZZyVaKNjuYGuycg6qhelXwbE5r7Sx
 EInrizLpkX1mi89ZkoDyJjhZSWww/jKOMacc46f6Db/Uo8BNGGSfWM7NujIq00/9jT9ui1
 xBphgdWOP/0b8/2rH3wRfzwZWEnnWxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-aupoDPC4Mpy9W4HisdJEFQ-1; Sat, 15 Feb 2020 06:41:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78590107ACCC;
 Sat, 15 Feb 2020 11:41:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDD375C1C3;
 Sat, 15 Feb 2020 11:41:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 526971136366; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/18] qapi: Add blank lines before bulleted lists
Date: Sat, 15 Feb 2020 12:41:31 +0100
Message-Id: <20200215114133.15097-17-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: aupoDPC4Mpy9W4HisdJEFQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

We would like to switch the doc comments to rST format. rST
insists on a blank line before and after a bulleted list, but our
Texinfo doc generator did not. Add some extra blank lines in the doc
comments so they're acceptable rST input.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200213175647.17628-17-peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 1 +
 qapi/char.json       | 2 ++
 qapi/trace.json      | 1 +
 qapi/ui.json         | 1 +
 4 files changed, 5 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 082aca3f69..13dad62f44 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4757,6 +4757,7 @@
 #
 # Once the tray opens, a DEVICE_TRAY_MOVED event is emitted. There are cas=
es in
 # which no such event will be generated, these include:
+#
 # - if the guest has locked the tray, @force is false and the guest does n=
ot
 #   respond to the eject request
 # - if the BlockBackend denoted by @device does not have a guest device at=
tached
diff --git a/qapi/char.json b/qapi/char.json
index 8a9f1e7509..6907b2bfdb 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -133,6 +133,7 @@
 # @data: data to write
 #
 # @format: data encoding (default 'utf8').
+#
 #          - base64: data must be base64 encoded text.  Its binary
 #            decoding gets written.
 #          - utf8: data's UTF-8 encoding is written
@@ -167,6 +168,7 @@
 # @size: how many bytes to read at most
 #
 # @format: data encoding (default 'utf8').
+#
 #          - base64: the data read is returned in base64 encoding.
 #          - utf8: the data read is interpreted as UTF-8.
 #            Bug: can screw up when the buffer contains invalid UTF-8
diff --git a/qapi/trace.json b/qapi/trace.json
index 4955e5a750..47c68f04da 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -53,6 +53,7 @@
 # Returns: a list of @TraceEventInfo for the matching events
 #
 #          An event is returned if:
+#
 #          - its name matches the @name pattern, and
 #          - if @vcpu is given, the event has the "vcpu" property.
 #
diff --git a/qapi/ui.json b/qapi/ui.json
index e4bd3d8ea7..89126da395 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -934,6 +934,7 @@
 # Input event union.
 #
 # @type: the input type, one of:
+#
 #        - 'key': Input event of Keyboard
 #        - 'btn': Input event of pointer buttons
 #        - 'rel': Input event of relative pointer motion
--=20
2.21.1


