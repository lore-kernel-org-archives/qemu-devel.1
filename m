Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A95C28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BF720679
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJtSV0VP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BF720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKiq-00023z-0k
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51060)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKgF-000890-Bt
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKgE-0001XO-Bu
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:49:47 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1haKgE-0001WS-3G; Mon, 10 Jun 2019 09:49:46 -0400
Received: by mail-pf1-x441.google.com with SMTP id x15so5377220pfq.0;
 Mon, 10 Jun 2019 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WpQTGyTo9qkJp1Rc3SIkhVrtWPIrh5hywek1GByQLqQ=;
 b=BJtSV0VP9clsJLeLVSwScoklo9lGUV6Bt2KaJpFA4EAp2gfZunKF7CEvNhzhQDB+1T
 cWUv2uVyWR6MYTN8aTBp4IJ7M2HzA2G7K5c0I6/grPyeKpdlg6o8WyTeXdvbcmF0NjTa
 lvR/b9PqNVYK9cKj0qgcGKR2v1mDSW7AC8kuMf4U2PjDU/muvC8/WWXCgduNTWG3nDzC
 f70QRnVcB87jOW8rFIDNDlyZRzOKXWW1EEZxx/W/p428lkCoOrHx5PSV8H+GBhIOVTPA
 NduO12O64jKszMBgnVSAESDQ6/hfwXG8J1OILnfOO0hOYol1sxawj3Qzs3p90EdeWc1q
 0Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WpQTGyTo9qkJp1Rc3SIkhVrtWPIrh5hywek1GByQLqQ=;
 b=QeAF3dk/uL6hl1jdHyMLNVEFq0PHTD+EXYvHTrtEsBL+WfjVhJKjUzTlOKOM089Gpk
 VhnO5ieu9OQNjw72b1ukxH1RE+yWyGkgUWTbEEsgzyyFoV6m6VCMcuuGIkteZMXq7ncv
 43zwXCOSGhqplGc2E6szPsD1jY6aoioSkoLclx8LYrqlrAD/2WcvlGorCY5nJ5pcmPn5
 alDgAOjMnsq5u2pEFBD/MPFLYBK+dWS/4b9W0mJGxpl2DGw+zaaaILAsRFvNBvzlpben
 mm8WmMjT3VwyuQdLGWSPdB7kbvy5OPPSRF35NGyJDfZg5GEHL70mk7Yl8IX9RkNc0Xh/
 CZuA==
X-Gm-Message-State: APjAAAXlLo19/RxHA3udNrw84Wv9Yfb3S9QZdYdIM5Lc10w9G0CfTv8C
 2WmV/UH4TQFL3yBx6LuaNWhOKn6vL3zqYw==
X-Google-Smtp-Source: APXvYqz2F1MMZhlayqq5rabZFLPySlf1qAbYyNY/GCb09Tcstean2GVRETedqau5B4p6VP8xJlV5Bw==
X-Received: by 2002:a65:4c4c:: with SMTP id l12mr14638865pgr.404.1560174584348; 
 Mon, 10 Jun 2019 06:49:44 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
 by smtp.gmail.com with ESMTPSA id d4sm13969837pfc.149.2019.06.10.06.49.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 06:49:43 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 19:18:55 +0530
Message-Id: <20190610134905.22294-3-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610134905.22294-1-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v5 02/12] qapi/block-core: add option for
 io_uring
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
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Option only enumerates for hosts that support it.

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1defcde048..db7eedd058 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2792,11 +2792,13 @@
 #
 # @threads:     Use qemu's thread pool
 # @native:      Use native AIO backend (only Linux and Windows)
+# @io_uring:    Use linux io_uring (since 4.1)
 #
 # Since: 2.9
 ##
 { 'enum': 'BlockdevAioOptions',
-  'data': [ 'threads', 'native' ] }
+  'data': [ 'threads', 'native',
+            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' } ] }
 
 ##
 # @BlockdevCacheOptions:
-- 
2.17.1


