Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D29ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0289920684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0289920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpP2-0003eH-VG
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMpGH-0002jR-5p
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMpGF-00054q-So
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:25 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60673)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMpGF-00053n-JA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:23 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MkIAB-1hcinI192H-00kfrP; Tue, 22 Oct 2019 10:11:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] linux-user/strace: Let print_sockaddr() have a 'last'
 argument
Date: Tue, 22 Oct 2019 10:11:03 +0200
Message-Id: <20191022081104.11814-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022081104.11814-1-laurent@vivier.eu>
References: <20191022081104.11814-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+eWyWt+jEeAqX7ytazpX5umvzc8LjyX/xkhUAMODHFMpjd5Dly3
 yetQpVLUcQ2tvnl0D/zNYRr9yaUwhKsHk9c8F9cNCTdJz0NGDJT2i8+SWAwEqTdfI69a3zV
 SjCVrvRZD+kubO24PFuLQdf9BxuZvzMAyJJVzmiZAxFH6j3qCZ07YtmDWRCUmFgs/BFSjxQ
 thl8JfdsII27v/k04I8Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ddRbnsiiX34=:dcTAew5CMiDdxirgVkKVT4
 OS7CUi2h+ddAyoNLj0Ntvv+T60b6AIDlh2eU65YKAxvYyszp+DrOVXVi+7OA4TwbqdDGXioO6
 7DziRPRz5gsGVmQ7FQND6R33Pl8K0wc7BtjurGc4ZpaHE1eN2C9adXjaAq/FJsUmmRw2Ckg0F
 wteq8447K04zQoT7hHotX3tJlRBwR+PJehdUPOI64DgjyKakuytbUWIxQ3MVIi+RZVNhZPz6q
 fVR5KIwNumHa65ArMMN1oCIlIraEo1+vsdur0o58HeGIRE9OuCAGRfiXbL+ASO8TBCEKmDxHZ
 iWhe8cwKcPyg3PcJoZMo4ob5FgYNJzXmKUxLZ2jQ/S713L3iZ2SmURRQmqiDxUAhVya0EJPY8
 6kjD3zXDe20pYCDuhVS0iAtNvOJMQ1m/SgB7dZgK9s2kC0kGoznGL2Mmss6dVxiMbhrCgzE03
 5OZfCwmnp0fDDTZKaaP0EaPtCKnc/H6KKZ3JbwLmhhlc2Xnj6NbcMAPj4VZwtc2fuOTJU5vrF
 CjWG2VUwcwaNleOodpfan2hYQrv506HZbfxSf+ZMm7OjSz+MMYIcgvazRZwaLGK3E6gRmBL5h
 1U7PAxEg7IJ5huOgVIaDQ6bm+iJKlF5wa6sFwE7WTN16JFZPgepu+kk0xd4uDuC7ODr+XSmtt
 5TYha9GdGqhNYHRip9s0LTX25TMiWyb4FmJlPwv042fkG9u1oTw5GGnwkz3qL1Y7Q4s74lq5O
 4I1MG2M6CAQ1DntxQW7jhNPbZ3TvB2HXESrQeXZfjLxZ2kIQnxPiDXah5ZZL4YWVwMUygI89A
 hXqiVp/Ibtkna3XR2VH7DsZ5EpZuKU2v2dokonUIuzr0/5t2XK3sXsDVKK5NvHUwTVeVL/kiQ
 0n7ZAgs6AijKinRjbbV+E9MAtfams6XaW3z05fMMc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

If the format is not the syscall last argument, a comma is append.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191021114857.20538-9-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index cd92c77d3366..3d4d6844500e 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -67,7 +67,7 @@ UNUSED static void print_timeval(abi_ulong, int);
 UNUSED static void print_timezone(abi_ulong, int);
 UNUSED static void print_number(abi_long, int);
 UNUSED static void print_signal(abi_ulong, int);
-UNUSED static void print_sockaddr(abi_ulong addr, abi_long addrlen);
+UNUSED static void print_sockaddr(abi_ulong, abi_long, int);
 UNUSED static void print_socket_domain(int domain);
 UNUSED static void print_socket_type(int type);
 UNUSED static void print_socket_protocol(int domain, int type, int protocol);
@@ -336,7 +336,7 @@ static void print_siginfo(const target_siginfo_t *tinfo)
 }
 
 static void
-print_sockaddr(abi_ulong addr, abi_long addrlen)
+print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
 {
     struct target_sockaddr *sa;
     int i;
@@ -418,7 +418,7 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
     } else {
         print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
     }
-    gemu_log(", "TARGET_ABI_FMT_ld, addrlen);
+    gemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
 }
 
 static void
@@ -1751,7 +1751,7 @@ static void do_print_sockaddr(const char *name, abi_long arg1)
 
     gemu_log("%s(", name);
     print_sockfd(sockfd, 0);
-    print_sockaddr(addr, addrlen);
+    print_sockaddr(addr, addrlen, 0);
     gemu_log(")");
 }
 
@@ -1821,7 +1821,7 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
     print_buf(msg, len, 0);
     print_raw_param(TARGET_ABI_FMT_ld, len, 0);
     print_flags(msg_flags, flags, 0);
-    print_sockaddr(addr, addrlen);
+    print_sockaddr(addr, addrlen, 0);
     gemu_log(")");
 }
 
-- 
2.21.0


