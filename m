Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2062C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A751206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A751206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0cN-0001Jd-Lt
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Ur-0007l7-0Y; Wed, 10 Jun 2020 09:10:25 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46185)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Up-0003cY-4z; Wed, 10 Jun 2020 09:10:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M6lxe-1jrEUa0Fag-008JRU; Wed, 10 Jun 2020 15:10:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/16] Fix parameter type in vhost migration log path
Date: Wed, 10 Jun 2020 15:09:56 +0200
Message-Id: <20200610131011.1941209-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GC4QxVhoyRWPc2opmiANzOPcwFOhSvLfhoXfjQFiQAGmI5kg1fh
 ip2rXH5dOtjWESF9Z8A+xvyBu6sGdUETpHpTFL/RLAjZxhKnNnV1rHEBPkjLW9FarwC0Ze0
 osAGfGPjkmHPW9a1oYsUlqincWHaoSL/qs08z8FTFDdagrN/C2fa6cV0isCPITize/5JRNo
 eZDIIeoUSt35+5MvL+X9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/2BlOD/8RX0=:fiowDzPcbOKbIEeEYSVbNC
 eh66wg1Kpbpw92XQUGaHM3ByigAp7IPE3QCbPvLikJNZvrhbS6wbHcV/4MCVJYMix3/sHhgRl
 g/3KMh+gsf+c5H00Mv+VDuY07cE8eOxHIFR4p/Um3RyHZdvcdNy0aYsIuBhUthDuHNES3K/C2
 CXCfD3SO2Ogy6OOyYAb8nMUGltp3BBeCZwBNASeIfC4EQwoN6beb6FBOxpqGC4Vvk2TDV6Q4d
 XoSEA6AG1sPASRGw7K1dBmJsL7rNfy/UdaU2GBqullNepBA1rDkvZHqcz4w1HToD09HIha9Qe
 WtPrz3uRVZx1SHX8wA8ty69qM3nnSyX5Mo/uOGBRRcqkCM2x1Jw59g8BnolZvkLeKo/u9++92
 mFhiK6PPc7viYnAvx7pE/LsFtkZuqUCdsLFwpNt9zJfkwvv4UAZHcN2wG0DcaSivUxX+xRuXo
 WFSDtf7o6nnO5TqgZ51zxGRUqvuAqvUvc3ZHarJoCmO5j0FIJoIaklUQC2JhWFxjwKDQYGui7
 QruQXVbgeFoGitL76NimV0q2DQ1Knza+8jnvRQEhF2V3FxZq0AwPAzbnhv3QDKQs+0uD88ZsA
 k8Y3v0l/KZyRufkvYuW4IEvAvrjHPxI40v2uFuTwrrDY8G4Xa2H6aG/h+kInt6u69co1bympg
 AkUTvsMbW9EVyX+7yOKDBXYUYs6UFQe6prIx/TM6NPNvBAHsKDlgj1acopL2dT2dkIbGEy3QA
 E4j6TFcESqoJ/629RkhsLa7ZzLlEE/7Am2hfv64/AdI/u04WXzkSxLz2AdCNHD2QGO1MI6ip5
 k4d63rreD73W2SececyC6/MWysHgbRsdyV/SOmibp4hlif4qZdIBIzI0kq7bIyWzCwovQ7m
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Raphael Norwitz <raphael.s.norwitz@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.s.norwitz@gmail.com>

The ‘enable’ parameter to the vhost_migration_log() function is given as
an int, but "true"/"false" values are passed in wherever it is invoked.
Inside the function itself it is only ever compared with bool values.
Therefore the parameter value itself should be changed to bool.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <CAFubqFtqNZw=Y-ar3N=3zTQi6LkKg_G-7W7OOHHbE7Y1fV7HAQ@mail.gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/virtio/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index aff98a0ede56..aa06a3691919 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -809,12 +809,12 @@ err_features:
     return r;
 }
 
-static int vhost_migration_log(MemoryListener *listener, int enable)
+static int vhost_migration_log(MemoryListener *listener, bool enable)
 {
     struct vhost_dev *dev = container_of(listener, struct vhost_dev,
                                          memory_listener);
     int r;
-    if (!!enable == dev->log_enabled) {
+    if (enable == dev->log_enabled) {
         return 0;
     }
     if (!dev->started) {
-- 
2.26.2


