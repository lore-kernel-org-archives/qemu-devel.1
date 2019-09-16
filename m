Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EF4C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABD4206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABD4206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ni9-00012x-8F
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i9nfe-0006Ss-Th
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i9nfd-0008Jm-Kg
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:51:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i9nfa-0008Ig-S4; Mon, 16 Sep 2019 05:51:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 11D2283F3B;
 Mon, 16 Sep 2019 09:51:42 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-115.brq.redhat.com [10.40.204.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 843A75C1D6;
 Mon, 16 Sep 2019 09:51:38 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 11:51:21 +0200
Message-Id: <20190916095121.29506-3-philmd@redhat.com>
In-Reply-To: <20190916095121.29506-1-philmd@redhat.com>
References: <20190916095121.29506-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 16 Sep 2019 09:51:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/2] trace: Forbid event format ending with
 newline character
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Event format ending with newlines confuse the trace reports.
Forbid them.

Add a check to refuse new format added with trailing newline:

  $ make
  [...]
    GEN     hw/misc/trace.h
  Traceback (most recent call last):
    File "scripts/tracetool.py", line 152, in <module>
      main(sys.argv)
    File "scripts/tracetool.py", line 143, in main
      events.extend(tracetool.read_events(fh, arg))
    File "scripts/tracetool/__init__.py", line 367, in read_events
      event =3D Event.build(line)
    File "scripts/tracetool/__init__.py", line 281, in build
      raise ValueError("Event format can not end with a newline character=
")
  ValueError: Error at hw/misc/trace-events:121: Event format can not end=
 with a newline character

Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: "\\n\"" -> r'\n"' (jsnow)
---
 docs/devel/tracing.txt        | 2 ++
 scripts/tracetool/__init__.py | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 76e492a489..8231bbf5d1 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -112,6 +112,8 @@ Trace events should use types as follows:
 Format strings should reflect the types defined in the trace event.  Tak=
e
 special care to use PRId64 and PRIu64 for int64_t and uint64_t types,
 respectively.  This ensures portability between 32- and 64-bit platforms=
.
+Format strings must not end with a newline character.  It is the respons=
ibility
+of backends to adapt line ending for proper logging.
=20
 Each event declaration will start with the event name, then its argument=
s,
 finally a format string for pretty-printing. For example:
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index 6fca674936..04279fa62e 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -277,6 +277,9 @@ class Event(object):
         if fmt.find("%m") !=3D -1 or fmt_trans.find("%m") !=3D -1:
             raise ValueError("Event format '%m' is forbidden, pass the e=
rror "
                              "as an explicit trace argument")
+        if fmt.endswith(r'\n"'):
+            raise ValueError("Event format must not end with a newline "
+                             "character")
=20
         if len(fmt_trans) > 0:
             fmt =3D [fmt_trans, fmt]
--=20
2.20.1


