Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53732C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BEA20702
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMDevag3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BEA20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3KY-0005Gx-AF
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3Ab-00041H-IW; Thu, 02 Jul 2020 13:38:45 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:40820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AW-0007Ko-2J; Thu, 02 Jul 2020 13:38:45 -0400
Received: by mail-ej1-x642.google.com with SMTP id o18so26302485eje.7;
 Thu, 02 Jul 2020 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aVFVOYAWhfYwzaeEi5hkCDaqCIjx9itvhl/E4hU5bvk=;
 b=XMDevag3Nro7fvdWUxDH946LaIkvStze+3tmq0btTGkE3C4n8R6AUsniy5bIlntLrZ
 JO86tzENXqTz7X2v+YEqC2GQxyhR9Q/Ut+Ur3yt+S58o59uKn75s52ei5p0VtwptPtTH
 bZBxFetzw1paBa0IdXisbdNnrkr3EuYqIdAt+5S2WfRcpm3+GNGHEre4IZAWHB+Snas3
 mhL7v1lQO50zDh7i2hTbSq9tJ8Zbm2pzKBD6X7M3sCwfEAjmZSXuZmYbAeyn5MAatyJ3
 xEHf9zYnd0RxI8+YoceoTfBpo9oxoZw1nDUHgh4VMAxGAPeK8oE49WHWS68B+fvfAvq/
 8pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aVFVOYAWhfYwzaeEi5hkCDaqCIjx9itvhl/E4hU5bvk=;
 b=c40LpXv3NRPiA3+dxyxCS/04c0DwjEDKeBTRr/2gsnSUmYmw22WAg1Mn/Klw0VaehT
 PlKD/tiEIohx85IKqok6jreQYJLlvj1kNJVSGXHlS4X7K2IK/vXomdMCaeZ6wO6wDi1f
 nInM75zlVxNP9ziTOAGmwDO835Xc98HxyBJUwwD7PG1fJ1U3yuA20undlUse9UY1d0wV
 M3tg4akQOb8/ogFKBaTTVXOuCFwE7nKH1X4mfAeKvurEJVNgkNSl+EBiBAa4K5EV4K/o
 lAlWa6QH5vkA9Sox6gx2lW9qZbt+kYh5TbT1+RBbyppLnRg/53mPd4xg6U9fjfDbw6ok
 Vn8Q==
X-Gm-Message-State: AOAM530c2/blJTZgnzCxNTKUxejyXHQs33ibBkdqIkZ9ft0/zw693LQs
 f/mGH3JVNB9jz7hliFW/JN2dEr3owM0=
X-Google-Smtp-Source: ABdhPJxAIvRwguxam70Vx3HLr8viLUkLrfrxvc2V7IqMBFHWjSljqR20Ihkm13nTJB64C0FJ9eciHA==
X-Received: by 2002:a17:907:9c6:: with SMTP id
 bx6mr28574049ejc.43.1593711515547; 
 Thu, 02 Jul 2020 10:38:35 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/19] .mailmap: Display correct email address for Michael
 S. Tsirkin
Date: Thu,  2 Jul 2020 19:38:12 +0200
Message-Id: <20200702173818.14651-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix Michael S. Tsirkin email address in the following commits:

  $ git log --committer='mst@robin.(none)' --oneline
  572992eefa msix: Switch msix_uninit to return void
  5a2c202981 msix: Allow full specification of MSIX layout
  d35e428c84 msix: Split PBA into it's own MemoryRegion
  2cf62ad742 msix: Note endian TODO item
  eebcb0a76a msix: Move msix_mmio_read
  b2357c484d virtio: Convert to msix_init_exclusive_bar() interface
  1116b53921 ivshmem: Convert to msix_init_exclusive_bar() interface
  53f949254a msix: Add simple BAR allocation MSIX setup functions
  118f2c2b48 msix: fix PCIDevice naming inconsistency
  393a98924e msix: drop unused msix_bar_size, require valid bar_size

Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 3219bb5d4f..eaed43a178 100644
--- a/.mailmap
+++ b/.mailmap
@@ -130,6 +130,7 @@ Marc Marí <markmb@redhat.com>
 Marek Dolata <mkdolata@us.ibm.com>
 Michael Avdienko <whitearchey@gmail.com>
 Michael S. Tsirkin <mst@redhat.com>
+Michael S. Tsirkin <mst@redhat.com> <mst@robin.(none)>
 Munkyu Im <munkyu.im@samsung.com>
 Nicholas Bellinger <nab@linux-iscsi.org>
 Nicholas Thomas <nick@bytemark.co.uk>
-- 
2.21.3


