Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5426EC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FC92083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgD0HWrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FC92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heHvY-00027A-CO
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHki-0000nn-MV
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkf-0005wy-FH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHke-0005sg-Eo
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id x4so6228814wrt.6
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=r43n33nGY2axkM37zxfub6AARNJoo1eQ/uWxCMQ4hvk=;
 b=pgD0HWrOZPOtt3FOskFG89w8+4xDiM5azTIxrvmQDn5dLdmykuQ53OgZKET9cOPoDW
 M+F2s4pEXaXsDLrv4bfZDSguEQ5LPMcgCdOmkxN8xM7XQSJC0XHqdIFcFkDPkWyObavp
 3wt3wrjKCKdvnjQjTDqFgcYZJn6F4hbmhEur+MTsBksi7ik7DitHSWOrypu6KXSNt9d3
 5Reu3stbXrQc8n0twQ6UVe8+zaYWidDhYq7mFRXGng9kWwyekuQE6lwWxMBqpXOOMzAK
 SHjW1FunmO91pSLRrKV8LuUxOLU/Kvw3UfQ1GqUv6XCO4OnLkTVrLB7zPhnGSIUcUTUq
 vtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=r43n33nGY2axkM37zxfub6AARNJoo1eQ/uWxCMQ4hvk=;
 b=eeMOLQcHbujBhxcevZZ4FeupL20WhBL7DxgDb670ch8LLfLnzpz+Rvj30JqZQw/MD7
 pZ6bM+093i8aMVnZUHXU2maGu7+nFt1uVcaP1ye9cCC3B9rfZkaCHte2TmxkmLPIqbaU
 LMrdkUjeHm7FFNGarcy080XUcQOzl9mxUy/udDu35UyqR3iSDYyXXjVV3zND6ZoxMoxl
 raV9RnopOyXjDWiHGnx5cw3tVA4dKVXivH4qF8WLAoFgHT6a56zucCLMQ1G9iRmzBjoy
 S5OJvWTPOj0JxP54M3GtJHbEet7mSMmN7gsMCBT7mCaYopqNfh+SQ/m26aTPaNY80WXu
 nQBw==
X-Gm-Message-State: APjAAAVnQCXmJiSU9E2k4cTSLSrvsUuwzekUHMIxDIQlgFhx8DewFicg
 loKf4EzVj/Eio3YlvZ4lV+S5t0Yr
X-Google-Smtp-Source: APXvYqxxYzIy1xfgpI7+xU+AkIPVfJzjYyL79wrY5tbrzsdAWm4SPTPzhB0Atd7FtaR76CLRylPy1w==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr26260588wrt.20.1561116638916; 
 Fri, 21 Jun 2019 04:30:38 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:30:11 +0200
Message-Id: <1561116620-22245-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 16/25] target/i386: kvm: Re-inject #DB to guest
 with updated DR6
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

If userspace (QEMU) debug guest, when #DB is raised in guest and
intercepted by KVM, KVM forwards information on #DB to userspace
instead of injecting #DB to guest.
While doing so, KVM don't update vCPU DR6 but instead report the #DB DR6
value to userspace for further handling.
See KVM's handle_exception() DB_VECTOR handler.

QEMU handler for this case is kvm_handle_debug(). This handler basically
checks if #DB is related to one of user set hardware breakpoints and if
not, it re-inject #DB into guest.
The re-injection is done by setting env->exception_injected to #DB which
will later be passed as events.exception.nr to KVM_SET_VCPU_EVENTS ioctl
by kvm_put_vcpu_events().

However, in case userspace re-injects #DB, KVM expects userspace to set
vCPU DR6 as reported to userspace when #DB was intercepted! Otherwise,
KVM_REQ_EVENT handler will inject #DB with wrong DR6 to guest.

Fix this issue by updating vCPU DR6 appropriately when re-inject #DB to
guest.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20190619162140.133674-5-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index c763643..9864aa0 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3897,6 +3897,9 @@ static int kvm_handle_debug(X86CPU *cpu,
         /* pass to guest */
         env->exception_injected = arch_info->exception;
         env->has_error_code = 0;
+        if (arch_info->exception == EXCP01_DB) {
+            env->dr[6] = arch_info->dr6;
+        }
     }
 
     return ret;
-- 
1.8.3.1



