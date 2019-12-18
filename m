Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E98AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEFD2218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du4VCRyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFD2218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYpr-00006X-Md
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3r-0007JR-HJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3p-0003KD-Jh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:15 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:36362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3p-0003C7-9p
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:13 -0500
Received: by mail-wm1-x336.google.com with SMTP id p17so1621725wma.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vTtE2quRQYcYlfKRpBZjr5cgNUsYu4H3G5CXjyyh7e0=;
 b=Du4VCRyhtJDAIY+Y+wKdBs50YBKdbAFO9QlO02+wvB8GZuRTIxPuMmnTpzywj689kI
 bMtPBriuV3NqbScGiIWPjT4PlZnEpU8aPZmAscRX+60ONaOLHuymHzQn7LqphnNT2ShR
 BWDc4afBgH07YJyRfPY+nMrTn9CpuIEFhQ+clCvdG18WVMUhsHiCmHFUrmyjPfjNs1p5
 xROgiSII18eFvVmewRKyQU3vsEUtYyMNnSeFYT6p9eGRWLP6u+zNhw3jx39ayH57Yhob
 x+U8HP0/S+q+LDI/TSj2PUkEeQD5gkvcVPCgjYyyISRHchUvuHxxbgGE3x/7GL+1YVzN
 EtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=vTtE2quRQYcYlfKRpBZjr5cgNUsYu4H3G5CXjyyh7e0=;
 b=sTC11z3+17sGZ18Oxds/+fCVUJflzBY8VgF3aJyHJwBJjUN+8MbAbz6OG+6T+VzXMD
 ZQccqiTGGgwQCMBRZfwu3FYzhyfoBMk5z9aGNVmIbDGH9AOiSnDlfDuVGoxDKIvIG7pg
 r3ZVAik9HH5/FhblBPW929LKKRaglRv6EH2MT5Bqdro5q4V2asdrgYooS257mfPnVbRr
 oqQhnprplTsnIc2+im7HIN4m6XRPXA/2Ew6GqKesSnni2JTpDqaw1P50Mx9XTNw8n+wB
 /lxX0oTE9rtyt5AbxTZ1y1OCr0EqaLQ+LcGA42YoqHQbaMLJF0TUabjDpVXIUg12G0cQ
 qtEw==
X-Gm-Message-State: APjAAAWvUeIm1xYjp5mxAW4agR2IS4qyn6ewXHWth7HDtwP4D7qUj9so
 DbMyHEUrsKCTDsKH1SRpoCGWL2JP
X-Google-Smtp-Source: APXvYqyBhjpuOnqcgmy0piy5oQtLMae+vmTSZ6xxxexR9pgvWLMnlCCRsGBaKqGTv+8tIL2qXnJV+w==
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr2956081wmc.111.1576670650922; 
 Wed, 18 Dec 2019 04:04:10 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 68/87] bitops.h: Silence kernel-doc complaints
Date: Wed, 18 Dec 2019 13:02:34 +0100
Message-Id: <1576670573-48048-69-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Fix the problems with kernel-doc/sphinx syntax in the
doc comments for the shuffle and unshuffle functions:
 * mismatch between comment and prototype for argument name
 * the inline bit patterns need to be marked up so they
   are processed properly and rendered as monospace

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190521122519.12573-6-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/bitops.h | 52 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index ee76552..02c1ce6 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -424,13 +424,16 @@ static inline uint64_t deposit64(uint64_t value, int start, int length,
 
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
@@ -450,13 +453,16 @@ static inline uint32_t half_shuffle32(uint32_t x)
 
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
@@ -477,13 +483,16 @@ static inline uint64_t half_shuffle64(uint64_t x)
 
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
@@ -504,13 +513,16 @@ static inline uint32_t half_unshuffle32(uint32_t x)
 
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
1.8.3.1



