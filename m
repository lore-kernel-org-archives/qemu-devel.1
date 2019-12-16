Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C57C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54953206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihI3bH1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54953206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtpK-0000WB-Fk
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFJ-0005K0-JT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFI-0007s3-AZ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:21 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFI-0007nQ-3e
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:20 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so513676wru.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0e9iZbZwVOF2w7GIO2zU28bMFshOQAQOAmPOJxZU0us=;
 b=ihI3bH1Af1arfVQ8V1v6qv1i0+khnzm5cOc0IYbXXd1Q/mTclZcEt4YF6HlnObQUbB
 h/AxDJN3JwMI4qEn/7uu/Nhf/Yl68ecb39Yf1xgZYoGLxENsp0JhNyzKuXxI8QGDGeqj
 u+qgWCgea5OZJy31YsSpMb19SoHh/+ccrwAQjxZHeXn1yLK4AWvVJCMEHPjCos4CoUIS
 XzavnQ2jqBNdVvOacHKMlfz8IcItCsn/rBTndJURbS4fHIL97HRLud8VF5pFor29f3t4
 R+VHJ9iVCztnZROJetcWWRP35LfZNezqBCV9X4O4rpKKKhD51fAEDn13DWkl5FC0tQUJ
 yN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0e9iZbZwVOF2w7GIO2zU28bMFshOQAQOAmPOJxZU0us=;
 b=ujbAEnLgLN8WdWgIL51BMDVvrJgVYrDPM7gvQCniWcbQSdVBjPWcdS7CH1IX6Z1qWC
 0aLMwWFCe53HhIuHXMCDd1mWSSzb4BXGK3Yo+Rkat589v8QF18It1WI10hboMPCISyYj
 XImDlpvv1atoHyw9PoRi2U6cBS2ayPfELhrPvE8/CaU8dql4XSdcU0Emm2EBcceppIb0
 APXFKun9gArZ4yBOgaxRtLPdrrOXe5i2CCjqyq/hE7iykUldpvjv4rdGTPtiKZyJMw8b
 d8Rni39796SXtudg9PEqDHxWPGn8UwgtfczU76vU7YFJoGMr+uKil7PduAQ2KAKt96RJ
 SuWg==
X-Gm-Message-State: APjAAAXsUMexH4Kte11Kqe0EQp0X5vKlOSXf7naeo7vDrirYOjdl70pS
 qkbL1NC5eSGw9pSvZ+qOwRslAVyy
X-Google-Smtp-Source: APXvYqx5pVLKSXGqHz6G21CQ1Egwfb3K4rjkd/hSRmEynmEb5VHaHtGAr4KvSzRhkIOwXyzVZaDSjw==
X-Received: by 2002:a5d:6206:: with SMTP id y6mr30350754wru.130.1576513758832; 
 Mon, 16 Dec 2019 08:29:18 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/62] object: Improve documentation of interfaces
Date: Mon, 16 Dec 2019 17:28:15 +0100
Message-Id: <1576513726-53700-32-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

QOM interfaces allow a limited form of multiple inheritance, at the
condition of being stateless. That is, they cannot be instantiated
and a pointer to an interface shouldn't be dereferenceable in any way.
This is achieved by making the QOM instance type an incomplete type,
which is, as mentioned by Markus Armbruster, the closest you can get
to abstract class in C.

Incomplete types are widely used to hide implementation details, but
people usually expect to find at least one place where the type is
fully defined. The fact that it doesn't happen with QOM interfaces is
quite disturbing, especially since it isn't documented anywhere as
recently discussed in this thread:

https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01579.html

Amend the documentation in the object.h header file to provide more
details about why and how to implement QOM interfaces using incomplete
types.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index f9ad692..bd68d19 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -200,8 +200,14 @@ typedef struct InterfaceInfo InterfaceInfo;
  *
  * Interfaces allow a limited form of multiple inheritance.  Instances are
  * similar to normal types except for the fact that are only defined by
- * their classes and never carry any state.  You can dynamically cast an object
- * to one of its #Interface types and vice versa.
+ * their classes and never carry any state.  As a consequence, a pointer to
+ * an interface instance should always be of incomplete type in order to be
+ * sure it cannot be dereferenced.  That is, you should define the
+ * 'typedef struct SomethingIf SomethingIf' so that you can pass around
+ * 'SomethingIf *si' arguments, but not define a 'struct SomethingIf { ... }'.
+ * The only things you can validly do with a 'SomethingIf *' are to pass it as
+ * an argument to a method on its corresponding SomethingIfClass, or to
+ * dynamically cast it to an object that implements the interface.
  *
  * # Methods #
  *
-- 
1.8.3.1



