Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D680C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02592063A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02592063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAvh-0005P4-4p
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAom-0008KG-P6
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:24 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:60385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoi-0006lA-EY
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M2fQ9-1jfoZ93QBL-0048BE; Fri, 05 Jun 2020 13:47:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/19] Makefile: Only build virtiofsd if system-mode is enabled
Date: Fri,  5 Jun 2020 13:46:48 +0200
Message-Id: <20200605114700.1052050-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bEROMtZroekkaERMDWQMfVyBm/Mb1pysJf7hxC70V4IKzUewtOq
 ozxfqyzxhixEF8udt9rU2dm/WXfVPPlM3CSeqofr8Ro+4ExZMYqtrjfhFg+pwdiGLo5ngLU
 3l0Vd5+mAUn8lYUKZ4w72cTcLX/STm+wu+q7iEcxJjDAX0FPwgUiWdnKZH/mkxQH/zueKDe
 aEhge70Hk6ShJA5j0r4xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U9R+YuYYWHw=:e3tuDCwg3DNmX8HASVRs2/
 PpPDFqf8lmAERc6JemDKbOF1YnKkgKNebDK+yZVkIvo6MOvtx1ynbVMzvVLuRUzG+A4IpyoQ7
 IvhBd4bYx1KB2+3nlWNk1ZTyKUYrArZtsEJ+b36MRDIieg5hVld4VlxiB62h4KlkwBJzvuqKv
 qE/cJ+HdiXLf5ymFg8ZH49BQ/JFNxZKmgiAJA2vj0IY+7X0HFqwyZ3IJO0AToC4ZWKjlgBCcN
 /2h/4EjGxErwaFBTxIP2DsHIcg3XHkRitulHmRfY9jfHLJkqizr5r1RyTsZuySNLagn9VzWCf
 P2NMmOGRjSvkZx41LX0RRB1v24lUsHbPVPrU43xZyhZb4G9Us2WZ3T9pjnzXU3etSKQGybEcn
 TAIxwaN5yIYTJYPFYxoMhoD2xFevVNJMXMQnu7cg6Dg/tww9Ah6hvXMfQe4NLXgcnlICy/jK0
 AQYRGjk36pimk/7SjE/EIC9PD9TOnK1yvGw0Mzbjg+XbY5kycamBA+PckJfdi53Xcbck+5DPx
 Ae8Ynoe0nxVACdMp5Ly3f/RNWRNFfI7RLZiN/JFIsod0VKpt7NhsRD1hqAnQsF/5nVtl25yH/
 kjcqR3/ZEgQRpqZsD+FlW+V5qLCINauKAG3CQjruoHPWWyiTCOIeR9TawrB/ZgUP/jSJ/AcVo
 qJRTwZyC+Rb81jj7HH5W7x1wrOFyc6pj76I1tbyfdKACgh7ssPVvQpl5DO62Nlgcxk0D0HLAE
 1Ovr/Q+SzsZ25RiNksQmNAJpu3Sp6ebghwaWNuxWghe+mAntjAspdQODaJUeZm+Vuh0lUidbB
 DcIsCQFx5ZV/QZ5pbpeTZs3r2dfJKuxNA1beRNFiyKb7Xd0q+8rIGR3A8tW9JX/CZFZo/UO
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:47:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Do not build the virtiofsd helper when configured with
--disable-system.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 40e4f7677bde..d1af126ea194 100644
--- a/Makefile
+++ b/Makefile
@@ -345,7 +345,7 @@ HELPERS-y += vhost-user-gpu$(EXESUF)
 vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
 
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
+ifeq ($(CONFIG_SOFTMMU)$(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyyy)
 HELPERS-y += virtiofsd$(EXESUF)
 vhost-user-json-y += tools/virtiofsd/50-qemu-virtiofsd.json
 endif
-- 
2.26.2


