Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E5ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A026020679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq/iCStV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A026020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeq1-0004Eu-GS
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdiz-0007ss-8J
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdiy-0007lH-3b
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:25 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdix-0007ku-TS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id c22so2746815wmd.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LjDK3UIIIZQzr+ukaPn01yLRu1TJq8EAIxhDuDy+SXg=;
 b=Fq/iCStVsMtikAhxEuVBI29wx6aUgrAJ76Ha9z6NOX5XwEwa7KBFRBdg80DU+0ZmOo
 wY9ZEujr0+BNQkOXUyPRvveMgIbLq0wHANG1bid4aqHK/h7nh1GbgagzKihbZQinM0Ul
 Tuj795UBsYHt3+2CgGmgSD8eFHHaRAMQjpDaXkyP1PJLl6CsS1J8bX2FTHntyT6aD7TQ
 U2TYbGt0lz9ICx295CNfN59bJZkR4G2En0UO/bwTeIQnVcZNnP9kU8Jwa9z+iNOKQghQ
 h5BYqyPqXmcAf9NI+zeAm5QlhxWfQ/JpUf7dL7R8N23KKGWTyHmDZl+KbHcON3QWOgFb
 K9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LjDK3UIIIZQzr+ukaPn01yLRu1TJq8EAIxhDuDy+SXg=;
 b=uUw3inW8vDVu+nYjpm2LklBjkAz87zmyjNVuxVcUN8BjzVMhJlXn6HOA/6Y05KudDh
 YOSJxxK5J4xD2Nj2VWTxAbb+vAt54+8gauHAZaR98LY0Wjj4F36ZQpf8ql6YZ3jE0yce
 kDjsRtF/HblR0so+7IBlG7h56icqA36yPunBRConAyN2tM7XRVh+y4bUAqPJ/7KY5BBQ
 CxMsicnBw0/SvuhwiF/bLkYlUobVLXg48eeATUGZeSio/wUaUfj4QT17fhR7WwsvU/zW
 cgdGQmDAkHA47suWDaBWthY2uqHuPlstPnJvQxh80dmA7tcj6UtZdGF/txDFYOt2XhZa
 3g6A==
X-Gm-Message-State: APjAAAX6F1UiX+8LY9O8OVWaZ5YdLWOjqKZ2PZbzUFjU4QWHJRhWoJmN
 l2GDcLwcg2pmwjJ+kEeuuyB2hBFM
X-Google-Smtp-Source: APXvYqyY9vW16QAzONpJk+3GLp6dtHxXrtA5/Q4kUU1312KVwychF1s9x2RQWlWYXTdeHkY+e/FAkw==
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr5280064wml.142.1571925862669; 
 Thu, 24 Oct 2019 07:04:22 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/39] runstate: ignore exit request in finish migrate state
Date: Thu, 24 Oct 2019 16:03:39 +0200
Message-Id: <1571925835-31930-24-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

Trying to reboot a VM while a migration is running can
move to the prelaunch state (because of the reset) while
the runstate is in finish migrate state.
As the logical step after the finish migrate is postmigrate,
this can create an invalid state transition from prelaunch state
to postmigrate state and this raises an error and aborts:

    invalid runstate transition: 'prelaunch' -> 'postmigrate'

As we are not able to manage reset in finish migrate state the
best we can do is to ignore any changes and delay them until
the next state which should be postmigrate and which should allow
this kind of transition.

Reported-by: Lukáš Doktor <ldoktor@redhat.com>
Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20191017101806.3644-1-lvivier@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/vl.c b/vl.c
index 4489cfb..4a7d011 100644
--- a/vl.c
+++ b/vl.c
@@ -1744,6 +1744,9 @@ static bool main_loop_should_exit(void)
     RunState r;
     ShutdownCause request;
 
+    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+        return false;
+    }
     if (preconfig_exit_requested) {
         if (runstate_check(RUN_STATE_PRECONFIG)) {
             runstate_set(RUN_STATE_PRELAUNCH);
-- 
1.8.3.1



