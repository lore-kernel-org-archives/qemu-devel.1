Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B68FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA73E20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAomaseg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA73E20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDc4-0002MZ-7l
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDYt-0005mn-Py
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29068
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDYs-0006Zq-6H
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595419765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ir1mQoDZtpCFjemMlgBAUOy/k9rxHtJelilQmy3Q970=;
 b=RAomasegoyjdtXJfDmRNS38qOg0LNPTvAipJLutRNEDCeAtt6cLMtkHGyAghozi7UUUEPq
 VYqsJEHT+bdJaHP9yKBU6DHRMfWhE3V7aoyOTNtr/naul4g0qSGmgPpIf+Yo1mKRMy0N94
 c+EAW84JKH/Qv8Lc+9HRZFaqk8OBn+Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-qJhZDVm0OUeX_JBPBfcIEQ-1; Wed, 22 Jul 2020 08:09:23 -0400
X-MC-Unique: qJhZDVm0OUeX_JBPBfcIEQ-1
Received: by mail-wr1-f70.google.com with SMTP id w7so549766wrt.9
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ir1mQoDZtpCFjemMlgBAUOy/k9rxHtJelilQmy3Q970=;
 b=Mr1bKiZkiJu7WYfV6LOfdLpzQdfmw7ckYYKk03gZ2w7laYQacv8iUr7iT5I3naepsR
 Q+PmlFV3XuUqgozvR7UsIOSGX328jJmPha6iZtiLcaPpNCxK7lXoiLQnh5zZ8Rq37lex
 nBtUOhIGuTqk4NRB+kaC1RD4ndvgWtgxK6Ej257LAuqs/5oxu10CzllIv5AHzRX/3sXO
 gUkAx8ftSZs4ZAqFnxrn5XLf1kOj40cN2MaV4IjMatOTjwYYV5dDuyU94dvK3fYAGPKR
 0tqvpM26Vwz5rpwOvl5eoZGwE0LsCDNGyO+ttTtuiRugRMTL9kkVeWaj45gIuqYVBmHC
 AN6w==
X-Gm-Message-State: AOAM530UvQ+SkEdeAuGE90izyuF5VUAs+N4fQwWVC/og7p2GM+9G+Nu8
 l/Pu5aXPZ/iy0UBZy3QthMeXZNjNxqqzwgUvMByYZ0BdhmxIqGdsiQGGDOzBU+arR6anAOpo9Vf
 Y776phpA0x4joRf4=
X-Received: by 2002:a05:600c:2907:: with SMTP id
 i7mr8035514wmd.40.1595419761630; 
 Wed, 22 Jul 2020 05:09:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHYfJo3ILHK3pe9Ds7U7OQuEX9nm9YVgEFeh9KCfcXuJ7ardN7LFIOYjqRWumZw4wxoRoAwg==
X-Received: by 2002:a05:600c:2907:: with SMTP id
 i7mr8035500wmd.40.1595419761451; 
 Wed, 22 Jul 2020 05:09:21 -0700 (PDT)
Received: from redhat.com (bzq-79-182-82-99.red.bezeqint.net. [79.182.82.99])
 by smtp.gmail.com with ESMTPSA id
 u17sm41322377wrp.70.2020.07.22.05.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:09:20 -0700 (PDT)
Date: Wed, 22 Jul 2020 08:09:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] virtio-balloon: Prevent guest from starting a report when
 we didn't request one
Message-ID: <20200722120853.9144-4-mst@redhat.com>
References: <20200722120853.9144-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722120853.9144-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Based on code review it appears possible for the driver to force the device
out of a stopped state when hinting by repeating the last ID it was
provided.

Prevent this by only allowing a transition to the start state when we are
in the requested state. This way the driver is only allowed to send one
descriptor that will transition the device into the start state. All others
will leave it in the stop state once it has finished.

Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-Id: <20200720175115.21935.99563.stgit@localhost.localdomain>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index e670f1e595..ce70adcc69 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -526,7 +526,8 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
             ret = false;
             goto out;
         }
-        if (id == dev->free_page_report_cmd_id) {
+        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED &&
+            id == dev->free_page_report_cmd_id) {
             dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
         } else {
             /*
-- 
MST


