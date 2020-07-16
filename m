Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3EFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB1120739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA9l6EiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB1120739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw39P-0001sR-LP
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 08:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw38T-0000GG-Sl; Thu, 16 Jul 2020 08:37:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw38R-0002tz-Gs; Thu, 16 Jul 2020 08:37:13 -0400
Received: by mail-wm1-x334.google.com with SMTP id 22so10147177wmg.1;
 Thu, 16 Jul 2020 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G5sq9E9UDOnIr1aJgtoFVrLHsTos8+IaCLhksEowqzI=;
 b=XA9l6EiVlZzlbxHORQGsXcyp3vsil3xpF2im2hzpEfWVcmC7O75p+0YEKm3qeqs8gS
 QQRrZbZQmPKph88kE7PY/ZdUba/yzS6pNIb4zDgjxFa6Ge9Ovjp6dTZ+BWzLEqQ3HvCw
 dwzxMAVNCldSl6TKnRCtMhGp0oyThLDZ9I5+qVord9YFhNqmY42BP6aBQm3nEffu4EdR
 FL6sf5bKQDFl1c8XCsCgbmi5KxnvBAv+CuQRJanggG5UMy0p+an7A/tJKI7iTHjXwJN8
 7hbD0ga9bU3ln8RZB9mARbjebQId1iY6ONSkhv6Qf61BiACUkHuhnjXnjpxmR1WDn8Pa
 QJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=G5sq9E9UDOnIr1aJgtoFVrLHsTos8+IaCLhksEowqzI=;
 b=hujEVYtwTMNjTG06QQWXoNrBwMQn1VxHux6wPs62PQ//8LPLvtYR4Sp5LTpqAIQCBu
 rAEuTHr9O/suKwCxT+tg64EWsPT7kXQaq8IMnOtwgHA8BXhQPvDw9NDKc+WjYLecsQym
 0R5F2Usq4HSz6Hoh8y9BUd1kxZfc0Uk0E5hnG3UW1COz0FbmmA/SISswsl/4Fksutagu
 arpBN/ePpaOHnUugXOvweDpvNG7fAd2Ecm0tPOgnGml+YeaSgJ4O+lGOyubwPxUMotru
 8hPSxIyNMdpE+KKnBZ1BKkBXMLmqg64LzUL9tROqWcRxYcn4NKHUWI9wElDNHADlWhvf
 k8gg==
X-Gm-Message-State: AOAM530QvQh0QQ1nRNK7WeV/zWQ2WX7ILWG3Q5Y31hZdQu6d9+5PVZIQ
 hL7ixW1diOTEjtuV7fe2wM4=
X-Google-Smtp-Source: ABdhPJxNr5sWe/rAQ0WwFmtNZQKrc+IVyitTjIZZS8rdOwUabdDJ5fZYRWatelaG7xt8QwLRVW+hrA==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr4196642wmg.48.1594903029736; 
 Thu, 16 Jul 2020 05:37:09 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c194sm8336673wme.8.2020.07.16.05.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 05:37:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 1/2] block/block-backend: Trace blk_attach_dev()
Date: Thu, 16 Jul 2020 14:37:03 +0200
Message-Id: <20200716123704.6557-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200716123704.6557-1-f4bug@amsat.org>
References: <20200716123704.6557-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a trace event to follow devices attaching block drives:

  $ qemu-system-arm -M n800 -trace blk_\*
  9513@1594040428.738162:blk_attach_dev attaching blk 'sd0' to device 'omap2-mmc'
  9513@1594040428.738189:blk_attach_dev attaching blk 'sd0' to device 'sd-card'
  qemu-system-arm: sd_init failed: blk 'sd0' already attached by device 'sd-card'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 block/block-backend.c | 1 +
 block/trace-events    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 0bf0188133..63ff940ef9 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -888,6 +888,7 @@ void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm)
  */
 int blk_attach_dev(BlockBackend *blk, DeviceState *dev)
 {
+    trace_blk_attach_dev(blk_name(blk), object_get_typename(OBJECT(dev)));
     if (blk->dev) {
         return -EBUSY;
     }
diff --git a/block/trace-events b/block/trace-events
index dbe76a7613..aa641c2034 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -9,6 +9,7 @@ blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags
 blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
 blk_root_attach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
+blk_attach_dev(const char *blk_name, const char *dev_name) "attaching blk '%s' to device '%s'"
 
 # io.c
 bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
-- 
2.21.3


