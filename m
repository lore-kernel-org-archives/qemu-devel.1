Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1557CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AF420775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GBizKqAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AF420775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrxd-0006sv-PJ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmY-0007vM-LM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:35161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmW-0007kl-4F
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599149272;
 bh=H5JPwn7sdL9qt3epmhF198eI25wSovorGX/V5kbV1ms=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GBizKqAXvf/1tbZmjfERiX0yR4h6GkCVd1fm9HsnF8IIPDCRxl2Qb8x8W2GaGMr5j
 UbSdQjHQ1zbfSlNAmLNdgwoVj7wLBeSXVhP/BHSJaZ1o4O9bv8Y25Hcg1HPRq50Ng9
 gLAHKrkgrsjviSyyGyTUUw4hEuUzttLRp8SuQ7Qk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJlc-1kx8A80F1g-00jF4M; Thu, 03
 Sep 2020 18:07:52 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 10/10] hw/display/artist: Allow screen size up to 2048 lines
Date: Thu,  3 Sep 2020 18:07:46 +0200
Message-Id: <20200903160746.27491-11-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903160746.27491-1-deller@gmx.de>
References: <20200903160746.27491-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cld1Dn/+HaoTtA3c2o9coZRs7CXZjv6fhURxD2ytZR0AqJ5M5BJ
 NQgSajCZt0i/1Ei3pHg4J8Zsetm1AwBiBfcDSUmhln73D1uNzYgN6V9iijiSrqiYO81wdd2
 gaPUXbUTcMRSKHM8Ou16IuW9dr7Yt79IcBolTwS57azpQGBcel1lr0lAzMyW46b844iU+rY
 qQIRLyOHYZ+z2twTaGbUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Orz5K+VNxyk=:1jwkFhVNir//rXrxkdXKA/
 PfXMOFRlRWEFgsIiBUvFqJcldf9LSzrUZ0VB+y9SX4GoVEwSjaxRAr/h8WZ/iUs+UKQR0+Z30
 tPLZ18diU4K3ANPjDgAqCywECqeThHCx/dOwCNp7D4JMwGkQ9ZNKKeiP/O5bwec9+oxkpIXFG
 ypm64keuhNNgxCQq6hCvPQgZeXtKe1qaF0J1XIS48F/770kGZLT1Dc0NRZaqFOh53ESiUqBdj
 RIDuf3HhUyYzvVEc4KanBiB24U1nVkpg4YBz+Vfyz3xe+3A5OfGFIPoi/XIcbm+1kztHWR8jI
 R86cObARxrSAKUWveQMR/eypiqa4W7bfmRVDW9xBct8+Y+W7vktKH1ijL22iTKcXwiZ6z9Io/
 4m1yt9L3O92jTYa+jig2BP+EJO7jRjzQQmnE++Ojm6tllSi8X7nfZHNhJzKXO2tGKmX6gUjgg
 TDV2WnmFU2mzFucFuy9hX/g1QfvcuDXVUYySk9oeVUQxFa9TB8x5Xp+8UTuctrBWtaICwE0kP
 1N2AydfUY3EeCCUP3M08gvrV2f8PSoDYCKgvlW7VsLtMcuvmporym0Bha9bzRMT9YqyeSzRJJ
 vVci4GI3Es3Ll1u6M1FLcxQ85u3o+BfLXBWqRoehu9QqUeG1+u6S5IHBYl/cPjtXTjQvMycPJ
 sbPPZoENt4zFr9oB5keirqWh7Qq7LPyR+X+VFf16mY+NUr9cBNNu+xqehCpWZtqmzN7Ypdrre
 nP30FO52fNDydCeOZpx7aT3vm6lm3v3wb5kycKJZ7q3W4AdPQ5O9UVoe9hJH2LS7ydesuBd9x
 EHIw6QyrTzhOu8ehpLR+NtphIkYd/Zalzw+bPzKgMFTcXT+2aq/wd8aS2df44ebM7XJcwGQGA
 GuujbBcXF6zjJ3AWlTT0fQmkjI6bN+yNELRE27mNGVb5AACiic1EVhEKsJyKBwAkHeyykKP9L
 s0JZt+j1qgS7zzCagim0xmyP07TPnpMWSJdaL7R6nG4EMRCqHkqvrECL5hRFoly6pB2yeGmQq
 3cEhEKeolEnR9cKcAjSRINRb7cxujj3JWbgCCU5SnN+xhBfW1S7N7pnaOh+VwBZrNfgcKIpQA
 nBKpxFknFSTQ9gVTt1pSRdmjF91TYOjdOOCq2SIw0o9jl2164P/ULS75Idipb8dTz+ozaaJob
 cniyWJpPwEVPyq24evjwqcFq3RNYl1fC7TqWVHdAnKuVMlFoUhUd/HJ4eIJYWlLJiRjhf5V5r
 v/Uyc0ogvxmJO1Kzk
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:08:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adjust the ADDR_TO_Y() macro to extract 11 bits, which allows userspace
to address screen sizes up to 2048 lines (instead of 1024 before).

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
=2D--
 hw/display/artist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 16d85c65f8..955296d3d8 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -193,7 +193,7 @@ static const char *artist_reg_name(uint64_t addr)
 #undef REG_NAME

 /* artist has a fixed line length of 2048 bytes. */
-#define ADDR_TO_Y(addr) extract32(addr, 11, 10)
+#define ADDR_TO_Y(addr) extract32(addr, 11, 11)
 #define ADDR_TO_X(addr) extract32(addr, 0, 11)

 static int16_t artist_get_x(uint32_t reg)
=2D-
2.21.3


