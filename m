Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07584C10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 12:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD6D213F2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 12:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD6D213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hD6Tb-0000mX-QE
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 08:00:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hD6S7-0008PR-Jv
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 07:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hD6S6-0007KU-IA
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 07:59:11 -0400
Received: from smtp4.iitb.ac.in ([103.21.127.18]:35308 helo=smtp1.iitb.ac.in)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
	id 1hD6S6-0007JR-63
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 07:59:10 -0400
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 47CA71027500
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 17:29:06 +0530 (IST)
Received: (qmail 3764 invoked by uid 510); 7 Apr 2019 17:29:06 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from
	<skrtbhtngr@gmail.com>, uid 501) with qmail-scanner-2.11
	spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/25412} 
	Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.284111 secs;
	07 Apr 2019 17:29:06 +0530
X-Envelope-From: skrtbhtngr@gmail.com
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
	by ldns1.iitb.ac.in with SMTP; 7 Apr 2019 17:29:03 +0530
Received: from jeeves.cse.iitb.ac.in (miller.cse.iitb.ac.in [10.129.3.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id AB38A360033
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 17:29:03 +0530 (IST)
Received: by jeeves.cse.iitb.ac.in (Postfix, from userid 51934)
	id 9FD858C2BD1; Sun,  7 Apr 2019 17:29:03 +0530 (IST)
Received: from localhost.localdomain (unknown [10.130.4.191])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jeeves.cse.iitb.ac.in (Postfix) with ESMTPSA id 1FD4D8C2BC6;
	Sun,  7 Apr 2019 17:29:03 +0530 (IST)
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  7 Apr 2019 17:28:38 +0530
Message-Id: <20190407115839.25054-2-skrtbhtngr@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190407115839.25054-1-skrtbhtngr@gmail.com>
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
MIME-Version: 1.0
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 103.21.127.18
Subject: [Qemu-devel] [PATCH RESEND v2 1/2] hvf: declare hvf_handle_io if
 NEED_CPU_H is defined
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Roman Bolshakov <r.bolshakov@yadro.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407115838.ZdRHcjE4ybm1ZjzH2ejH6U8Z9fbs_2i-k4V0GjMEs2w@z>

hvf_handle_io needs the poisoned type CPUArchState as its argument.
Declaring it if NEED_CPU_H is defined enables include/sysemu/hvf.h
to be included for common object compilation as well.

Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
---
 include/sysemu/hvf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index aaa51d2c51..7eca3ec7be 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -63,8 +63,12 @@ typedef struct HVFState {
 extern HVFState *hvf_state;
=20
 void hvf_set_phys_mem(MemoryRegionSection *, bool);
+
+#ifdef NEED_CPU_H
 void hvf_handle_io(CPUArchState *, uint16_t, void *,
                   int, int, int);
+#endif
+
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
=20
 /* Disable HVF if |disable| is 1, otherwise, enable it iff it is support=
ed by
--=20
2.20.1


