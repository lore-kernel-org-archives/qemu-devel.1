Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CBFC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD62A206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD62A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVa5f-0006Jq-2G
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjv-0003Ge-PV; Mon, 04 May 2020 07:58:34 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZju-0002Kt-PQ; Mon, 04 May 2020 07:58:27 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MoOpq-1ilZoK3HR2-00orfG; Mon, 04 May 2020 13:58:20 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] hw/timer/pxa2xx_timer: Add assertion to silent static
 analyzer warning
Date: Mon,  4 May 2020 13:57:58 +0200
Message-Id: <20200504115758.283914-21-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iqiCL93jf1udn3Aeou0tkXVxhcuNtePCHZfy+QO2oJqpuabBrYX
 rw5wXhAkgFStJRUuuR04fc3z+bOUkS+TCJxE/4D/0WMGjpZPtpE9HLRprdsTMCAg4/GS1tZ
 /WVcCeFyTD3hP7tiVHivpUHgq9fpiHgq5U6zG2k8gWRziyg3xU5J4MpqXdM380n6syjbd+a
 qNpGwycDNFZMOKarFyo2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gmTiqvLl1/M=:8jDdgjo5b5pCm68z3tmqxX
 Hb+rgmFCBQm79Xr7JuTU4iVVRGRr14REFHtz8i1ZL6u2Nkx9U47KXt9V3AjMTlqlmeN2y/mYa
 fDjUkxs1bd14EZTWFf/WdqeiIolemXmJQ9uRBHLy37qFaZnYNC6rvCi7JO6o2XooodANSuvLg
 LQ6S2Mtlo7/Wa5pvmoGTZ9tb2mLH0R+3vPFgmwQ2e1z+MzT1bOi4nZZpf/jH4k9ODEqHgI5MT
 WM42nXR6IVJ9h1D3Wx+KHqOPLAVX+7e+0Rol34MTb8z0de6qCEDFM7brGr50//L/F/VSYrhqZ
 gJVnyAm6z9X87/kV5aeIBK9nL6sxD1Qun75+PcHisU0HVRcfJE08Nm3AB5FTF3CaflIhXAQnN
 xjNyEfu0AOh9RaezrsTup1ymRh52jRBUp7UuDlVTt9ExGXDvc4WOtzo78yLKuH69UA7/FRmux
 S3xBQH2gMvjWmwKeS5wjYRfnKIO8Ig7YspTYWjSlQLjk+sj4c4EKyPjySOltVQRNdSVvfrVlK
 dFYdW877XnHtZ+1R6qZBw8bkh+9bZGi9YM2cm8YJtsPRAiahuGEtI4AnBP/M+rEWRmy6IHtE3
 dKGDl5esM6BULTSievMCJ69CQOnkdnhL+waT+Jj4+iJJ1HqSSZBBULWFBlR67x6iPSQks5WEr
 Pd5WWf/dUdwTW3KtMAm5hJDEMgNEI5Z4CwCMF888n9rkeXojAEI2gNLQO5XJ63rXZEPkxDxrs
 +4pKtdBYLOjFJWIB9cIPHtatovfREjAgBPhv/0YF5uhR2arMQOce+rVRNDSOyqwqKB6lHqqpz
 CooFgSP44kTJBGL9fqHWOrCjtQGDZ/ovC5mW/HwgSQtTHM+2/gvnT3P1Ek1u0p2Z+fN28wG
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

pxa2xx_timer_tick4() takes an opaque pointer, then calls
pxa2xx_timer_update4(), so the static analyzer can not
verify that the 'n < 8':

  425 static void pxa2xx_timer_tick4(void *opaque)
  426 {
  427     PXA2xxTimer4 *t = (PXA2xxTimer4 *) opaque;
  428     PXA2xxTimerInfo *i = (PXA2xxTimerInfo *) t->tm.info;
  429
  430     pxa2xx_timer_tick(&t->tm);
  433     if (t->control & (1 << 6))
  434         pxa2xx_timer_update4(i, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), t->tm.num - 4);

  135 static void pxa2xx_timer_update4(void *opaque, uint64_t now_qemu, int n)
  136 {
  137     PXA2xxTimerInfo *s = (PXA2xxTimerInfo *) opaque;
  140     static const int counters[8] = { 0, 0, 0, 0, 4, 4, 6, 6 };
  142
  143     if (s->tm4[n].control & (1 << 7))
  144         counter = n;
  145     else
  146         counter = counters[n];

Add an assert() to give the static analyzer a hint, this fixes a
warning reported by Clang static code analyzer:

    CC      hw/timer/pxa2xx_timer.o
  hw/timer/pxa2xx_timer.c:146:17: warning: Assigned value is garbage or undefined
          counter = counters[n];
                  ^ ~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200422133152.16770-10-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/timer/pxa2xx_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index cd172cc1e960..944c16588926 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -140,6 +140,7 @@ static void pxa2xx_timer_update4(void *opaque, uint64_t now_qemu, int n)
     static const int counters[8] = { 0, 0, 0, 0, 4, 4, 6, 6 };
     int counter;
 
+    assert(n < ARRAY_SIZE(counters));
     if (s->tm4[n].control & (1 << 7))
         counter = n;
     else
-- 
2.26.2


