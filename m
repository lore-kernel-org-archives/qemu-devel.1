Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BDEC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 12:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A382173E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 12:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A382173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyETr-0008KX-De
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 08:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hyET4-0007Wd-2e
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hyET2-0005i8-9t
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:02:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hyET1-0005ft-0g
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:02:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 25B8330832C6
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 12:02:53 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-203.brq.redhat.com [10.40.204.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED49395A50;
 Thu, 15 Aug 2019 12:02:50 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 14:02:47 +0200
Message-Id: <20190815120247.13413-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 15 Aug 2019 12:02:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] trace: Clarify DTrace/SystemTap help message
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most tracing backends are implemented within QEMU, except the
DTrace/SystemTap backends.

One side effect is when running 'qemu -trace help', an incomplete
list of trace events is displayed when using the DTrace/SystemTap
backends.

This is partly due to trace events registered as modules with
trace_init(), and since the events are not used within QEMU,
the linker optimize and remove the unused modules (which is
OK in this particular case).
Currently only the events compiled in trace-root.o and in the
last trace.o member of libqemuutil.a are linked, resulting in
an incomplete list of events.

To avoid confusion, improve the help message, recommending to
use the proper systemtap script to display the events list.

Before:

  $ lm32-softmmu/qemu-system-lm32 -trace help 2>&1 | wc -l
  70

After:

  $ lm32-softmmu/qemu-system-lm32 -trace help
  Run 'qemu-trace-stap list qemu-system-lm32' to print a list
  of names of trace points with the DTrace/SystemTap backends.

  $ qemu-trace-stap list qemu-system-lm32 | wc -l
  1136

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 trace/control.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/trace/control.c b/trace/control.c
index 43fb7868db..bc2fe0859d 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -159,12 +159,19 @@ TraceEvent *trace_event_iter_next(TraceEventIter *i=
ter)
=20
 void trace_list_events(void)
 {
+#ifdef CONFIG_TRACE_DTRACE
+    fprintf(stderr, "Run 'qemu-trace-stap list %s' to print a list\n"
+                    "of names of trace points with the DTrace/SystemTap"
+                    " backends.\n",
+                    error_get_progname());
+#else
     TraceEventIter iter;
     TraceEvent *ev;
     trace_event_iter_init(&iter, NULL);
     while ((ev =3D trace_event_iter_next(&iter)) !=3D NULL) {
         fprintf(stderr, "%s\n", trace_event_get_name(ev));
     }
+#endif
 }
=20
 static void do_trace_enable_events(const char *line_buf)
--=20
2.20.1


