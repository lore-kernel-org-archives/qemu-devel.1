Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D434FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B012072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HECo2tFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B012072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGuL-0007tU-QQ
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbj-0000Tp-Ig
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbi-0007mU-AU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:55 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAGbi-0007ey-1f
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:54 -0500
Received: by mail-wr1-x42d.google.com with SMTP id y17so3266068wrn.6
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HxBRa5zP5bAdChIgC8UmIomdyrcpexWIdFB2HnoF5Oc=;
 b=HECo2tFGlBspdhsJe3z64FxVcnDeXR1LTZPzs7NhvlIIFDXGOd84iWPQBLA3tinzGT
 tJLzXzpSVvJdID2pMtwo2q1UzMye3acpBSwOW3a27NvthEcSSAkVLmmzwYkTBMi3yUNU
 eX4X/Z7N+NOsF5Ju529BLCVFIsxgw2T59gRstjnrnjzpxyKINMrU34Zaquk3q02CRlgQ
 LCmRjp7bucBwmhq6dW0w6ayq/7/ZLtGWSALW560eRTDfk0j/gO3Mc+v1QdXMvxoRe8HM
 paQlroWZX03Rn7/tYdgBVZc7HB/ALznL7kctIK8r1tnP8doGLYrLmIAsE6P335seAnuU
 v7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HxBRa5zP5bAdChIgC8UmIomdyrcpexWIdFB2HnoF5Oc=;
 b=AS2OmpYwhlcSicJaygiWRvVaus01gJtpAkBljn+hFgVpZUxOx3TdBZxIF08ZytB82Q
 kGB7X6YnGV6fNDVmAA6VMRk1VvBxntAIKbw4LxQcjKHAdG+Au3P0GZ+HhTllJ/DLVeMN
 n3y7IfqLfffCaRpy4Xv5ltIbbgwYHNI3NFUEN/RjtelVODkYLUQboQ1t1QtR6qhJzWRC
 LMaLwiU6xYe/ywkWXAHuqlEScP1guWNmK7qT4axXfytboJVKbK5Ovu7M6CL6kJ3WmXmC
 nAgc53JPiw5iJNDiRFTbs+3tDCMkFABz65Zo7rWbne5duYbUDxcpY4corliKh6ynwlMV
 KVbw==
X-Gm-Message-State: ANhLgQ30HSHOQm3W2LUBu30ByKvKZ4V+8QWfiKGeDlozRiLkKjxu8LmL
 k6O1hE99aYavkuw/DJlF/lMI8z2FlVozxg==
X-Google-Smtp-Source: ADFU+vsoCb3Ukiah8o1qb6Ul/0R0YZCllfi4s7mxBQCmfXnOhXO72IxOKWprRMRG72P4kXqzgIEi1Q==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr5007274wru.421.1583515071691; 
 Fri, 06 Mar 2020 09:17:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f8sm6948346wmf.20.2020.03.06.09.17.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 09:17:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] post-rst-conversion cleanups
Date: Fri,  6 Mar 2020 17:17:42 +0000
Message-Id: <20200306171749.10756-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series has some small cleanups now that the conversion
of qemu-doc to rST has gone into master:
 * reorder the index.html.in/index.rst as it looks a bit odd
   now that qemu-doc.html has gone from the top of the list
 * remove various bits of redundant code, makefile runes, etc
 * update some comments still talking about texi
 * add a missing dependency so that editing the Sphinx
   extension source code triggers a rebuild of the docs

thanks
-- PMM

Peter Maydell (7):
  Makefile: Remove redundant Texinfo related code
  Update comments in .hx files that mention Texinfo
  hxtool: Remove Texinfo generation support
  docs/sphinx/hxtool.py: Remove STEXI/ETEXI support
  Makefile: Make all Sphinx documentation depend on the extensions
  docs/index.rst, docs/index.html.in: Reorder manuals
  docs/qemu-option-trace.rst.inc: Remove redundant comment

 Makefile                       | 14 ++----
 docs/index.html.in             | 10 ++---
 docs/index.rst                 |  8 ++--
 docs/qemu-option-trace.rst.inc |  4 --
 docs/sphinx/hxtool.py          | 28 ++----------
 hmp-commands-info.hx           |  8 ++--
 hmp-commands.hx                |  8 ++--
 qemu-options.hx                |  8 ++--
 scripts/hxtool                 | 78 +---------------------------------
 9 files changed, 29 insertions(+), 137 deletions(-)

-- 
2.20.1


