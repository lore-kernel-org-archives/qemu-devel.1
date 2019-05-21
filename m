Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704E9C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DEB42173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOZi1FuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEB42173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52731 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3uW-0005XZ-Dh
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:30:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3q2-0001SD-QT
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3px-0005GO-2B
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:48 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:38529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT3pw-00057F-Om
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:44 -0400
Received: by mail-wm1-x334.google.com with SMTP id t5so2694773wmh.3
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=8SOMLkZr4NB3XMui3lU6laKTlnUoguc42H2phVbp83Q=;
	b=DOZi1FuK9945umJVeVpsmdNtdtHLNtnhz579D1BPh57g92AwEyGTGJPgvSPHqxe6BK
	TrpzqSqylljDXqZ8o5WX12HHLmQ9+nECzL8rQFjvfkvSRNCyWJDZTJbX/l7Mb6VkTH3A
	7cHgfjd22OxY/qECsiGCp+5QUxxtvjEFs+i38IZVmb9b3fyfVz92I9QUtlcDuESFkBLG
	PQd7HqWTKQnouXlroIRKv8YbOyhT/tiStAvlh5DgWeaTPubSrHFXLSwUV1dkKnNwPsuH
	sf5AERvKxqchnD9w192Y1scG1KNNBMRou4AjMt0U0UlGHMBBfa100YmxAMe3NCVoBQl8
	EuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8SOMLkZr4NB3XMui3lU6laKTlnUoguc42H2phVbp83Q=;
	b=j9JQqOwGlpfLWHKy1PW40oqitvMrcOHlsDWJHqbkrsCGvVuqsJcYhwFu5/8t8UXt5f
	oIwwnbEuwnri+sk1ipVswr46C8qM0fjdLTmYr8vw72FuFV+tOl13+oXrRky4074xnYNE
	TmhkXujlvZ9O2GsUf139z2ajgKucKfr2uIphlDOiyS3X4yfgqUZmSyeeg0eHOK0VEJFf
	zvR9q09Mm2KHUYL5i27uxaamk9eTB5PTU3s+bLb8DOgmuadf4bVY416GCSnfNOLP5QkP
	6tqM4lZdX7usPp2H0cbHo6+bn2864Xu4uz0+v2W+K72aEJD5MnLIX7NMnNYwWurpkQ9Q
	fwww==
X-Gm-Message-State: APjAAAWZ2AmhTVZJOSxiJKsMGQnj9SetbLI7Mor5PtARRJXWmEXqsNox
	Df6t1OCsw281fdSSzbAj/ZxOYwGrUKE=
X-Google-Smtp-Source: APXvYqys3euLW2REhX8jlQHZPrL4vSe6EGBlig49irm2gvwKROv4Yk0S+tatAZWoVgRBf2W9DgTWQQ==
X-Received: by 2002:a1c:3c2:: with SMTP id 185mr3301459wmd.91.1558441530029;
	Tue, 21 May 2019 05:25:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	u11sm12233393wrn.1.2019.05.21.05.25.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 05:25:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 13:25:14 +0100
Message-Id: <20190521122519.12573-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521122519.12573-1-peter.maydell@linaro.org>
References: <20190521122519.12573-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [RFC 05/10] bitops.h: Silence kernel-doc complaints
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	"Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix the problems with kernel-doc/sphinx syntax in the
doc comments for the shuffle and unshuffle functions:
 * mismatch between comment and prototype for argument name
 * the inline bit patterns need to be marked up so they
   are processed properly and rendered as monospace

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/bitops.h | 52 ++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 3f0926cf40c..f6e76b5952d 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -423,13 +423,16 @@ static inline uint64_t deposit64(uint64_t value, int start, int length,
 
 /**
  * half_shuffle32:
- * @value: 32-bit value (of which only the bottom 16 bits are of interest)
+ * @x: 32-bit value (of which only the bottom 16 bits are of interest)
+ *
+ * Given an input value::
+ *
+ *   xxxx xxxx xxxx xxxx ABCD EFGH IJKL MNOP
  *
- * Given an input value:
- *  xxxx xxxx xxxx xxxx ABCD EFGH IJKL MNOP
  * return the value where the bottom 16 bits are spread out into
- * the odd bits in the word, and the even bits are zeroed:
- *  0A0B 0C0D 0E0F 0G0H 0I0J 0K0L 0M0N 0O0P
+ * the odd bits in the word, and the even bits are zeroed::
+ *
+ *   0A0B 0C0D 0E0F 0G0H 0I0J 0K0L 0M0N 0O0P
  *
  * Any bits set in the top half of the input are ignored.
  *
@@ -449,13 +452,16 @@ static inline uint32_t half_shuffle32(uint32_t x)
 
 /**
  * half_shuffle64:
- * @value: 64-bit value (of which only the bottom 32 bits are of interest)
+ * @x: 64-bit value (of which only the bottom 32 bits are of interest)
+ *
+ * Given an input value::
+ *
+ *   xxxx xxxx xxxx .... xxxx xxxx ABCD EFGH IJKL MNOP QRST UVWX YZab cdef
  *
- * Given an input value:
- *  xxxx xxxx xxxx .... xxxx xxxx ABCD EFGH IJKL MNOP QRST UVWX YZab cdef
  * return the value where the bottom 32 bits are spread out into
- * the odd bits in the word, and the even bits are zeroed:
- *  0A0B 0C0D 0E0F 0G0H 0I0J 0K0L 0M0N .... 0U0V 0W0X 0Y0Z 0a0b 0c0d 0e0f
+ * the odd bits in the word, and the even bits are zeroed::
+ *
+ *   0A0B 0C0D 0E0F 0G0H 0I0J 0K0L 0M0N .... 0U0V 0W0X 0Y0Z 0a0b 0c0d 0e0f
  *
  * Any bits set in the top half of the input are ignored.
  *
@@ -476,13 +482,16 @@ static inline uint64_t half_shuffle64(uint64_t x)
 
 /**
  * half_unshuffle32:
- * @value: 32-bit value (of which only the odd bits are of interest)
+ * @x: 32-bit value (of which only the odd bits are of interest)
+ *
+ * Given an input value::
+ *
+ *   xAxB xCxD xExF xGxH xIxJ xKxL xMxN xOxP
  *
- * Given an input value:
- *  xAxB xCxD xExF xGxH xIxJ xKxL xMxN xOxP
  * return the value where all the odd bits are compressed down
- * into the low half of the word, and the high half is zeroed:
- *  0000 0000 0000 0000 ABCD EFGH IJKL MNOP
+ * into the low half of the word, and the high half is zeroed::
+ *
+ *   0000 0000 0000 0000 ABCD EFGH IJKL MNOP
  *
  * Any even bits set in the input are ignored.
  *
@@ -503,13 +512,16 @@ static inline uint32_t half_unshuffle32(uint32_t x)
 
 /**
  * half_unshuffle64:
- * @value: 64-bit value (of which only the odd bits are of interest)
+ * @x: 64-bit value (of which only the odd bits are of interest)
+ *
+ * Given an input value::
+ *
+ *   xAxB xCxD xExF xGxH xIxJ xKxL xMxN .... xUxV xWxX xYxZ xaxb xcxd xexf
  *
- * Given an input value:
- *  xAxB xCxD xExF xGxH xIxJ xKxL xMxN .... xUxV xWxX xYxZ xaxb xcxd xexf
  * return the value where all the odd bits are compressed down
- * into the low half of the word, and the high half is zeroed:
- *  0000 0000 0000 .... 0000 0000 ABCD EFGH IJKL MNOP QRST UVWX YZab cdef
+ * into the low half of the word, and the high half is zeroed::
+ *
+ *   0000 0000 0000 .... 0000 0000 ABCD EFGH IJKL MNOP QRST UVWX YZab cdef
  *
  * Any even bits set in the input are ignored.
  *
-- 
2.20.1


