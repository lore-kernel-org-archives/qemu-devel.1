Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB407C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C436321783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C436321783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUT40-0003TY-Qi
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUT2b-0001xA-3z
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUT2Z-0002N3-T5
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:04:53 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:39405)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iUT2T-0002Jc-Tv; Tue, 12 Nov 2019 05:04:47 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N94qX-1hrg712Gut-016BOh; Tue, 12 Nov 2019 11:04:36 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] numa: Add missing \n to error message
Date: Tue, 12 Nov 2019 11:04:27 +0100
Message-Id: <20191112100429.11957-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191112100429.11957-1-laurent@vivier.eu>
References: <20191112100429.11957-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1vcYrg0+LvVV941g910cFpeztGR7BbLAIO4J2uy2+wndIDdXaqX
 QQrjHxwlfvMTyxg5ZHj7I6FD8ugA72K1CyyF3hdKSNfJvri6dhS0lWF42+ECl2VvoDnBaEU
 858sIynsaHEflh3H8tkIP/UBhFDJFsMUb8l9Np3rUAZ59VmfVMwQDzlxT+GdbklddAW+GHQ
 0SdzzT/ZHB4EmowG/MDcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RSABOG9S6a4=:a++67xUUz3yi+zUuQ4SHMl
 5A9bYM1q3ecd02KSjezcnWNuNWs995RQcYwi7nhXafur6+Bl0OkpuM41yLSpey4VOthrKR1eO
 TlRe7oYjLjAMh3kcdHtZACpp5guZt4OFhJm03HXhXpnWjIINR2FzxLdproVH2pq1POFbQjbbX
 DLQw8QVE35bFb+XPQzHWOXm5uAUpZmKzZaSvpllxABSU7PUoZ/SC6pBUeDnKbCnro1gNMUrPe
 mj7LmAUxOcq9f9Xgwck2JJ7n7lP/0mtzBJsklYOi3V4kAxrHrBZCn+Q699Ctj1XYOUySUHF8q
 jrGMqzm8Kg7o/ds/3xJNQEyphgwfYf5bGPzHPqZJh5xtouUQrO3Z6P8gvtJ9DLQwlzDKBkOXr
 dvcxOT+Ukz7tWjQt8MtWj16ffMXggfKLVWPI79SmL4nJI7dLe1Eg5VO96C6n3zhY8iciDgNMA
 /vurNAi4++vWlQwsuJguV1rJMIG+KdGZHZL9L/Lf/a0CoAzDG00N+jUryaIdKqacjwbKJiqMc
 HWmy2EsQ3efU2TKgnYzMxv63OmXJo3MVYHVfoBx0IfKl0klAnqotpoaEdZWLuEja38kwZ2Tef
 s+OkGNCGUb2BXyJ51qXs2XMYXvtS30KGaZiZwf5ZE1b4aL4NTw/bK+5NYscouaeVNJELjjcIj
 YjGd3vSM+RWHcPwurSVNHo723tpMpLb0yO1Zcw+d/uVn1tJbf7R45S9f54XzLQfDGkch0cEhb
 wvWUH/B5zVtKrvLAg0cBCGiG4MmOllUpisTBJ/cqecK2SVnv8gnWTEg/8o7C3CkOFQvL/1bmU
 5yuds2xffULaULGc69vW8tk7vm/f5RJ0808OolE41Mp4gXwgRtnj+LDuGDsTTXaIn8Goe3GWF
 Pyk3kqXJcdc9HXmkXORaGFdKP9iOk3fJt0qt6vtGc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

If memory allocation fails when using -mem-path, QEMU is supposed to print
out a message to indicate that fallback to anonymous RAM is deprecated. This
is done with error_printf() which does output buffering. As a consequence,
the message is only printed at the next flush, eg. when quiting QEMU, and
it also lacks a trailing newline:

qemu-system-ppc64: unable to map backing store for guest RAM: Cannot allocate memory
qemu-system-ppc64: warning: falling back to regular RAM allocation
QEMU 4.1.50 monitor - type 'help' for more information
(qemu) q
This is deprecated. Make sure that -mem-path  specified path has sufficient resources to allocate -m specified RAM amountgreg@boss02:~/Work/qemu/qemu-spapr$

Add the missing \n to fix both issues.

Fixes: cb79224b7e4b "deprecate -mem-path fallback to anonymous RAM"
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <157304440026.351774.14607704217028190097.stgit@bahia.lan>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/core/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 038c96d4abc6..e3332a984f7c 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -503,7 +503,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
             warn_report("falling back to regular RAM allocation");
             error_printf("This is deprecated. Make sure that -mem-path "
                          " specified path has sufficient resources to allocate"
-                         " -m specified RAM amount");
+                         " -m specified RAM amount\n");
             /* Legacy behavior: if allocation failed, fall back to
              * regular RAM allocation.
              */
-- 
2.21.0


