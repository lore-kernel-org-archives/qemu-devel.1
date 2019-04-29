Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D804C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61D42087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJYgOnzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61D42087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60621 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9hD-0006qI-TE
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:04:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eB-0004DP-Ka
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9e6-0006PE-Oz
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9e4-00069E-19
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:48 -0400
Received: by mail-wr1-x430.google.com with SMTP id v16so14710340wrp.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=PoBbqKnm48icKHr+pnJggpSaSU4ZKCdGTaxhpvXU0VQ=;
	b=iJYgOnzHanS8MCyf/Y/TsyhGhNhp8j68clu7GSzxkV8oyNeseLQdQN2j6h2tpNu428
	tMJgG9tAwIJyWypDVL0m3M8m5uxisI4BK++pkqnj/BFNkWe9UouweFt7uUdWNqZPaBNU
	GrTsYbXNg3p9cvoM/1f05Z/1rbvdtYK1WwknUBdbA7cCwjv4dyAsysyBh/Fu35/W+wLa
	2FCIcu7uHQ8jNGBlgbjpH5Sx0dZfInLkrp2l4HXipqSwUV8ks6EPRUFLcUcLu3C6lNF2
	+lboKxs6Wu8lvz2YWaG2vZVyiaEiLmtfxdqX+pmSk70urzxEPQeqhcEuSWYkigVgn70M
	m6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=PoBbqKnm48icKHr+pnJggpSaSU4ZKCdGTaxhpvXU0VQ=;
	b=g5r6EJyAIAC0CaVmsqwQvMlMAXFLrChPAruHlylFJgIkz3AraZBg56p3/vSEe3ssMG
	t8ljKC49TZXSjOx0mCYsLDHjS5Oylq2SAaB7d+D59K/k40iTSGv4hgGbAWHQ2F69kguo
	OgjcPJSI3Lbdtvzf3twrSpH5rmMk2gwDKz8sZEp3AoXkonLnwYNrFJ927/898e83/po/
	iVt804+IkNQ1RYLXd6QymDgEbdNUFFtxxKbKOhsm69qyXZ/TYg6LTvvLHqAjQxEJBzur
	K/sW3IN025h86cHOeLRW5OJL6xqW7H0Js2eZoj0F4ube9hIeSdmuHAUcrteNez9vf/mE
	aVTA==
X-Gm-Message-State: APjAAAX59OWf0uMrnie6DZvV6NQ47kRNdELOFNl551teCO6ZigH+JqZS
	12oaIfxVrsgY5eOxyhhXJM2bfdA2V5E=
X-Google-Smtp-Source: APXvYqwFfkZebByq1LtSNfImSnhxYhHdNH0ZZTRptRdaE5tiXQ6g+wYUybsaLQZuT1uI/IlCFmzQSQ==
X-Received: by 2002:a5d:410f:: with SMTP id l15mr15384783wrp.6.1556557235470; 
	Mon, 29 Apr 2019 10:00:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.34
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 17:59:50 +0100
Message-Id: <20190429170030.11323-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 02/42] hw/ssi/xilinx_spips: Avoid variable
 length array
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429165950.OpsTVXje4K-0auotJUZ-vGpDhD1W_uPycdH6koF4ur8@z>

In the stripe8() function we use a variable length array; however
we know that the maximum length required is MAX_NUM_BUSSES. Use
a fixed-length array and an assert instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-id: 20190328152635.2794-1-peter.maydell@linaro.org
---
 hw/ssi/xilinx_spips.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 16f88f74029..c615058cc1b 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -429,12 +429,14 @@ static void xlnx_zynqmp_qspips_reset(DeviceState *d)
 
 static inline void stripe8(uint8_t *x, int num, bool dir)
 {
-    uint8_t r[num];
-    memset(r, 0, sizeof(uint8_t) * num);
+    uint8_t r[MAX_NUM_BUSSES];
     int idx[2] = {0, 0};
     int bit[2] = {0, 7};
     int d = dir;
 
+    assert(num <= MAX_NUM_BUSSES);
+    memset(r, 0, sizeof(uint8_t) * num);
+
     for (idx[0] = 0; idx[0] < num; ++idx[0]) {
         for (bit[0] = 7; bit[0] >= 0; bit[0]--) {
             r[idx[!d]] |= x[idx[d]] & 1 << bit[d] ? 1 << bit[!d] : 0;
-- 
2.20.1


