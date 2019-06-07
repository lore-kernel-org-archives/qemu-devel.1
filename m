Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF8AC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94ABB208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9HPRoQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94ABB208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZLut-0006p1-S1
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 16:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58692)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chmeeedalf@gmail.com>) id 1hZK4B-0003wG-Ic
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chmeeedalf@gmail.com>) id 1hZK4A-0000Jb-6r
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:58:19 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e]:46990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chmeeedalf@gmail.com>)
 id 1hZK47-0000Cp-Vg; Fri, 07 Jun 2019 14:58:17 -0400
Received: by mail-io1-xd2e.google.com with SMTP id i10so2198068iol.13;
 Fri, 07 Jun 2019 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=pTlDTBeN6Va+KeL8S/f6Vzv4kGmmDInyghUhYEIvcFo=;
 b=F9HPRoQnsDq8IF4Tfova7/C+SiiGrd6lDA3sfMoIFpUdlCZKg/WroEOZA4RarKoDrG
 g7kaVol0MWFMbS48Kix8q7QiVJQU3LAbk/U86t2KFqe2etzix5a5w+RuVVnEo9tO3cem
 Atv4MGR0eMLgb/ByEvVcQe2X3CD7LUs0zTosyDFsnjFO+LgO8hl7hPTNAmDDMBAyXtiJ
 RmLJJQ3zDkLaP8BQ46WsOf2hYcXw6b50SCdJxa/isekiTm7mM3+SvruhW88VW6bs3tRb
 a2cSfLCNBYxwEdblVICHsru9zPaBn9WJ9WpiHteCBdNHhKqiDTxuuHLsd4VsSaNvcpZD
 YKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
 bh=pTlDTBeN6Va+KeL8S/f6Vzv4kGmmDInyghUhYEIvcFo=;
 b=LrEGfCYcU6v75qYub9bI9oCftBXUe2LUltVJQmzYX72IKdLsL/mHPWW4TtpS6wb3E1
 kbSqFB54mB9CZxEM8P+I5Vmbui8uwIm/OMZenFCohVkPtj9r0LZ+3cE/DpT+aEwN7yfK
 GdHQ+OlAPkD2RKrXEFPuOeCl778QBiWtuFeJldW2EHmOz1bPnOiz3mXuY8QjZHAYNbbV
 gp+O+aLgRu4bT1T7J1QtjJ2bt8K96iQAsJmf5UFaEqo6DadJtHJ0rhNunMTQX32JaLN1
 poy2NOlri71dWuWwfCM3VIIeB9vFKMZf+vq7ixarraFwAh3Jnm+A9Il8EyuoZEL7Wo2j
 1d3w==
X-Gm-Message-State: APjAAAUAEnpCCjRJBVrr0wU7hqYueMH3brYh/0IGcGPUUKHxAnio9YoK
 l0CJBY8j7VNt7Hy7k4vv62w4dyqZPF0=
X-Google-Smtp-Source: APXvYqxb32ur/zR/Z+NnuP4JL/F9kKJuT9TGVMuJHLjWwoa8oEVg8NqJqVk0gXi0v2Eo3Iyn832FlQ==
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr33942975ion.204.1559933892615; 
 Fri, 07 Jun 2019 11:58:12 -0700 (PDT)
Received: from titan.knownspace (173-25-245-129.client.mchsi.com.
 [173.25.245.129])
 by smtp.gmail.com with ESMTPSA id d75sm1250814itd.10.2019.06.07.11.58.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 11:58:12 -0700 (PDT)
Date: Fri, 7 Jun 2019 13:56:53 -0500
From: Justin Hibbits <chmeeedalf@gmail.com>
To: qemu-devel@nongnu.org
Message-ID: <20190607135653.6ece685d@titan.knownspace>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; powerpc64-portbld-freebsd13.0)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/qT1Dap1TZWA6QLObKmaNdK="
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2e
X-Mailman-Approved-At: Fri, 07 Jun 2019 16:55:30 -0400
Subject: [Qemu-devel] Fix cacheline size retrieval on FreeBSD/PowerPC(64)
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--MP_/qT1Dap1TZWA6QLObKmaNdK=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached very trivial patch fixes a startup bug that prevents at
least Qemu 3.1 and later from working on FreeBSD/powerpc64.

- Justin

--MP_/qT1Dap1TZWA6QLObKmaNdK=
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-Fix-cacheline-detection-on-FreeBSD-powerpc.patch

From 74a70fdcfa5347e7637aa36276c55781f19de72a Mon Sep 17 00:00:00 2001
From: Justin Hibbits <chmeeedalf@gmail.com>
Date: Fri, 7 Jun 2019 13:44:51 -0500
Subject: [PATCH] Fix cacheline detection on FreeBSD/powerpc.

machdep.cacheline_size is an integer, not a long.  Since PowerPC is
big-endian this causes sysctlbyname() to fill in the upper bits of the
argument, rather than the correct 'lower bits' of the word.  Specify the
correct type to fix this.

Signed-off-by: Justin Hibbits <chmeeedalf@gmail.com>
---
 util/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index eebe1ce9c5..516f837748 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -77,7 +77,7 @@ static void sys_cache_info(int *isize, int *dsize)
 static void sys_cache_info(int *isize, int *dsize)
 {
     /* There's only a single sysctl for both I/D cache line sizes.  */
-    long size;
+    int size;
     size_t len = sizeof(size);
     if (!sysctlbyname(SYSCTL_CACHELINE_NAME, &size, &len, NULL, 0)) {
         *isize = *dsize = size;
-- 
2.21.0


--MP_/qT1Dap1TZWA6QLObKmaNdK=--

