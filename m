Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7B7C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8FA206E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iddFmDJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8FA206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwZ0-0007cB-Km
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKq-00036s-LR; Thu, 03 Sep 2020 16:59:56 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKo-0007KO-In; Thu, 03 Sep 2020 16:59:56 -0400
Received: by mail-ot1-x342.google.com with SMTP id c10so3972639otm.13;
 Thu, 03 Sep 2020 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BVrfXN+PksS1+3mj7WHwrA4ngS6G5v4nICiHt9L9Kw0=;
 b=iddFmDJ7CDJcp+Rogo00I29oCuWilvK0P6QrQDBwBudPYwTF+439RQhUg96w2iT+4r
 8Iygb6wE6XCluWQUGt37xA4XJoPTmAueXoDqxXMd6W5OeuZW7LXiW6056hgFvG/ctqmR
 CkqjJ7ju+zWqAO17iCRv6qHww9hR07GQgajGuC6OkxsjVl0Pxc2xu0j8TS365NaqIXxB
 EjxxovPIvGltgPwPtDfryDEssHES9ujnzleu6hl9srrX7oXgY1miypyA1p7MQ7iqufRz
 yy1EbBzWp8MplWGTwCbWGcAvjtAUvCDah3HG1m9cKiZhR8KEbKUCBBQ2T7R9lknKK/2O
 w7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BVrfXN+PksS1+3mj7WHwrA4ngS6G5v4nICiHt9L9Kw0=;
 b=Eg4/O77+7wE+CW4NgchLzGTHD6Rs5qh7OWXrm47PmiAUqGzI8tYiHGfDtMKLqN5o57
 qcs3x5kGsx5Buqp1i1ptT8L3k0qKKaESco6mkJU+VOk+gW4Djd7brp8sCXWrkoLYQsB1
 SRWRode10/Phl9103gl5pUxZWoKfqvVci/6XSNzLnTzUMmRKsTJMqczWQkKQQCS7rGpf
 0XZVbqfoTbGsNYuVET/MP8ugCGZD2+FalC9xcPV/Fx5qOKAWzL3qtT5luPgx3MKjTUY7
 +gDAehEpA/t2eWfiVJyoYIjO9T0ovVZobNBl4wfSbLBTKvjeZ1vyDC+Obr5UnXn0hCFv
 CrGw==
X-Gm-Message-State: AOAM532kB6kh3IjTzJc6GyN8NZHfWiT6jMKIxq6B9bx39oyp+by8R8tJ
 CGqQykQZF8/eEh06Ga9v6QVJFOLw6dg=
X-Google-Smtp-Source: ABdhPJzzCAQrLgn1gBYGKy6Y/ZxgeEvC+GrMTtHJMrnpBCaDRcoQLJTdDeZ+djXZF9CYrSGEf/BoxQ==
X-Received: by 2002:a9d:23c7:: with SMTP id t65mr2988703otb.275.1599166790542; 
 Thu, 03 Sep 2020 13:59:50 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id l63sm711386oia.56.2020.09.03.13.59.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 13:59:49 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/77] virtio-balloon: unref the iothread when unrealizing
Date: Thu,  3 Sep 2020 15:58:27 -0500
Message-Id: <20200903205935.27832-10-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>, Wei Wang <wei.w.wang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

We took a reference when realizing, so let's drop that reference when
unrealizing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: qemu-stable@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200520100439.19872-4-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 105aef9c9479786d27c1c45c9b0b1fa03dc46be3)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-balloon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 3e3b5ff0f8..e20f90dad4 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -820,6 +820,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev, Error **errp)
 
     if (s->free_page_bh) {
         qemu_bh_delete(s->free_page_bh);
+        object_unref(OBJECT(s->iothread));
         virtio_balloon_free_page_stop(s);
         precopy_remove_notifier(&s->free_page_report_notify);
     }
-- 
2.17.1


