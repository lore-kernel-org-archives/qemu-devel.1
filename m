Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A29C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE4221655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE4221655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRu3-0000F1-NU
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kXRrf-0006nN-Vs; Tue, 27 Oct 2020 12:30:28 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kXRrd-0001Wo-Rt; Tue, 27 Oct 2020 12:30:27 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRBac-1klhUN2X7k-00N9tz; Tue, 27 Oct 2020 17:30:19 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] cpus: Drop declaration of cpu_remove()
Date: Tue, 27 Oct 2020 17:30:09 +0100
Message-Id: <20201027163014.247336-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027163014.247336-1-laurent@vivier.eu>
References: <20201027163014.247336-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pIuOhgWNYdI60OYV8kvtG8MvSqOqNu2IF+/4sR7V132059mt5hE
 OsPKzIdtc8ja3moKUeg5eMbUHhGHV7I0NlZAjLHuQPst+q/7yuJi+v0yOi/N0Ou1rwcWtJR
 BxiI6tNRBkghvJhorzYht3Bl+Kn4TK8pY7IY+s/tqhNfOQWQ4lbWL5QZk36b+sssijv6xIQ
 8x2+0/vRW5T463xl9941w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4TKJa6uW9tQ=:gu0/TynExGxtMIgrrsUXcc
 4Kia+X/L4gAEKNANzxzv7Dw2GP/QxYx2HEWIcIadChhQkoCW5KZN2vLoIsmkTeU3T/bdzmwDj
 nHy+CIBPLjOd4t2Zzr1V6V0vRLWhYSPLOAFtiDcf01cdgnctN49me0BZ4ZRcdtZmGAA8aHwsc
 36MBq5vc8Z/UG9Pnjhb6aSBCtoY51tEnXw8nG3lP74687cdn5tj2AxrtZ1XiBGwOBL1lu6Xe7
 MgwnCUfYKOvyJP2A2N+DwZS6894k2DhqlpkkuVSgyq8jYWQHnlVm3mZXdHwWHIWlkUwm6NhpX
 uIPY7CB9oIeE4dTQmgUyqXUjiP/DJi3fT88j6ok2Y2v8jY4L8GxD1A1AjZs49AVFOHAwhn7JS
 zhJPfYy1uoletifikkvwOCNDIccZudrxNQP9RM1cgu0jYuhWGvTjJyMi8q8Eim6nZ65hXygEF
 kjR6FZZQ0A==
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 12:30:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Greg Kurz <groug@kaod.org>,
 pbonzini@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

cpu_remove() got superseded by cpu_remove_sync() in commit dbadee4ff4a0,
but its prototype wasn't removed. We could possibly keep the shorter
cpu_remove() naming but it seems better to highligth that this blocks
until the CPU thread is joined.

Fixes: dbadee4ff4a0 ("cpus: join thread when removing a vCPU")
Cc: pbonzini@redhat.com
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <160268285707.1107461.15035929822602623985.stgit@bahia.lan>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/core/cpu.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 9c3a45ad7b11..3d92c967fffa 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -927,14 +927,6 @@ void cpu_exit(CPUState *cpu);
 void cpu_resume(CPUState *cpu);
 
 /**
- * cpu_remove:
- * @cpu: The CPU to remove.
- *
- * Requests the CPU to be removed.
- */
-void cpu_remove(CPUState *cpu);
-
- /**
  * cpu_remove_sync:
  * @cpu: The CPU to remove.
  *
-- 
2.26.2


