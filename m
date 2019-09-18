Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4F7C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F8420856
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F8420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAa3J-0000zH-Mk
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 09:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAZtu-0008O9-El
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAZtt-0002bz-7f
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:21:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iAZtq-0002aL-0l; Wed, 18 Sep 2019 09:21:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B60610CC203;
 Wed, 18 Sep 2019 13:21:37 +0000 (UTC)
Received: from localhost (unknown [10.36.118.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9260A5D6A5;
 Wed, 18 Sep 2019 13:21:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 14:21:12 +0100
Message-Id: <20190918132112.10418-4-stefanha@redhat.com>
In-Reply-To: <20190918132112.10418-1-stefanha@redhat.com>
References: <20190918132112.10418-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 18 Sep 2019 13:21:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/3] trace: Forbid event format ending with
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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
Message-id: 20190916095121.29506-3-philmd@redhat.com
Message-Id: <20190916095121.29506-3-philmd@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.21.0


