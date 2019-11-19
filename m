Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A5BC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB73E2230C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgWVpmro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB73E2230C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWyRG-0002jj-1J
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 03:00:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elohimes@gmail.com>) id 1iWyOj-0000d4-U5
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1iWyOi-0003Va-Ub
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:58:05 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1iWyOi-0003Th-LZ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:58:04 -0500
Received: by mail-pl1-x643.google.com with SMTP id d7so11329305pls.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 23:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=soZDC3sPcccwkB8omLFcU90lXC+pRJIUN6L41pTdSf4=;
 b=lgWVpmrog50P2sobJieRZgOV2cnGFvcSVDDgS8IcxTOy2hnPEXDR3w9VoUEbJm/pXu
 A9pk2ipKcGdB0XHXtri+z5hsyq6uwsclqM/9+fKrroW+XQojuqSBBCsvxVCk00Y4+/C9
 Qnd4Y52NeV5VPoBJW2qr/cdNElEXhoH1IK8JbPBDIDQ4s12wx3O83tQT2aYGNto6jO2C
 VI2yW2k8WERIoC9kCR3X7rJw//s2NcWcP+nro2DJrEqM7Bbd9w3ApbBA322yoZab6d+e
 s4DjcCnkIKg1Krjdg7W3QXCrY8TzRPCnW+1EJCjto5z2CmWp4y0sxUcIMljXttXNvD/8
 fS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=soZDC3sPcccwkB8omLFcU90lXC+pRJIUN6L41pTdSf4=;
 b=k1oBGqmGpU8Aj+mOBdvwGWiJi7EbI6vYWIYYIjverE9Ppgbr3bbYLH6a/2FhRGFIva
 zHbM33ZW4xIVIFbITn4BtYhSC60BAbugEnrOQA/P/PZp4jYzPsc3+spuyGRyDmu6MTh6
 8eJNdGguuL+oj7l6wD+7NjwdHLs0ILfKVXNr9WVOYUMXH8fbj8QBLnIAc+gkHjavHS07
 fhZDnpEUTcITtpolD7/iII7yyrzCaP0xHPU7IHivSxMi9GUiQ3LG8Iqhy/8VSqLPQt8e
 VifOhXwoiE/O2aAjivgKRgYocKUgLEV4pNuDvCAM87l2gABBsaPcisdBJt4uWMQguDab
 qV8Q==
X-Gm-Message-State: APjAAAU29FVHe4/BjlFzPAt4T+io+STwPr7LkmExZyYuSXYlisyKjFEY
 3CxlARBXU7RbPcGcSDSFrOM=
X-Google-Smtp-Source: APXvYqx6MvhoVeGXUGqkXzm59EuXG4l0dcHnUJ+/ahjw0bOtJnSog9Xaqsl7/ZLno36DAEJg1hvRlg==
X-Received: by 2002:a17:902:b715:: with SMTP id
 d21mr33464161pls.312.1574150283165; 
 Mon, 18 Nov 2019 23:58:03 -0800 (PST)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id 7sm12855352pgk.25.2019.11.18.23.58.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Nov 2019 23:58:02 -0800 (PST)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v2] libvhost-user: Zero memory allocated for
 VuVirtqInflightDesc
Date: Tue, 19 Nov 2019 15:57:59 +0800
Message-Id: <20191119075759.4334-1-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Xie Yongji <xieyongji@baidu.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

Use a zero-initialized VuVirtqInflightDesc struct to avoid
that scan-build reports that vq->resubmit_list[0].counter may
be garbage value in vu_check_queue_inflights().

Fixes: 5f9ff1eff ("libvhost-user: Support tracking inflight I/O in
shared memory")
Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 contrib/libvhost-user/libvhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 68c27136ae..ec27b78ff1 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -992,7 +992,7 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
     vq->shadow_avail_idx = vq->last_avail_idx = vq->inuse + vq->used_idx;
 
     if (vq->inuse) {
-        vq->resubmit_list = malloc(sizeof(VuVirtqInflightDesc) * vq->inuse);
+        vq->resubmit_list = calloc(vq->inuse, sizeof(VuVirtqInflightDesc));
         if (!vq->resubmit_list) {
             return -1;
         }
-- 
2.17.1


