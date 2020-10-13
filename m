Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF7EC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1BD20708
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq3AmudC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1BD20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS80P-0003k8-KU
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7z6-0002Qj-NL; Mon, 12 Oct 2020 20:16:08 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:37089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7z4-0003Mk-0X; Mon, 12 Oct 2020 20:16:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id 144so15341089pfb.4;
 Mon, 12 Oct 2020 17:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5tAdlJMST8XLCnDBUVt7rtPNSwbFQfHXKMvXLu8naAE=;
 b=bq3AmudCmbtkJlhMe/pOsj1/dtOMYji71oZaPUEKs40Wo6qvkqXNK+WjVfLFs0cK0W
 lf5SOdpJonoetzw6wrGS4f5axS9dyC0+2Lp93FhqGzICn1WcmjOGTeJe87ZtLcp/uJwK
 HdHDczrUNcozRJc5b2+WDb3vyWo9C39QpGO3R/gfO0DgB+SyteRJrQW+tHPs1ba4IHtU
 wSpW2I220y5XtsU3gsCvp+M1ikJVomGccvvYhw1VKxc2ViO7x9gZIpuuY73wBOkUHs4e
 PG36q7AYMGJhFQRbXYaKoE0ilgZq4Q5W8fhADKhk5oAbm6s7mJiXeNdTZYloHF1+VevL
 pOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5tAdlJMST8XLCnDBUVt7rtPNSwbFQfHXKMvXLu8naAE=;
 b=ZLn2RbYR5ljWSxwkQ+jjW9aT1H6wNQ/QcvvgLNSzEeEgrHpBVzGtr9BRLjLaCRpDr2
 SJmiYZjvB/fVMBHJjaBdQsZcOIJkP5bVtL2mmXuNy4wvCHLoSsS+PFlyCvmSVSbGzwnG
 8f5kLTJIBwpYrXX+xMej2+IPdL4xpGjS8lcflUG6Hn6ZeYwt80ZyDDxuTEVCR4to3BPw
 LRCfS7z73IiLyXhRo34c67HlD0cBfUI6IL8bwNPrip+XfPfiVIVRLEg6W8woXMxB8gZh
 YXXoRGQWT2EizkNALfSTzlNT+GR+K9dnGRRT7oPr2MCGvlX/VOj9PPFTMJcurX/RbuUs
 qqdg==
X-Gm-Message-State: AOAM532S+UU60pJzoBoj1lt7Gc6Ae1gjVxqfemCzma1QV6UdylQHdx1B
 vc4i/3xMfilUMhrQtOY6GXb0mQazOnMjWA==
X-Google-Smtp-Source: ABdhPJw/lZXlNpZTa7zK9ruzs0nDSfbAOPEya870uGpB7aMJ2MWf8HctY+3Tf/XhdDIvvsILwejN9Q==
X-Received: by 2002:a65:4107:: with SMTP id w7mr7511127pgp.361.1602548161080; 
 Mon, 12 Oct 2020 17:16:01 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id e5sm5902961pfj.99.2020.10.12.17.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 17:16:00 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Fixes building nfs on msys2/mingw
Date: Tue, 13 Oct 2020 08:15:43 +0800
Message-Id: <20201013001545.1958-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>, Peter Lieven <pl@kamp.de>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V1-V2=0D
Apply suggestion from  Peter Lieven=0D
=0D
Yonggang Luo (2):=0D
  block: Fixes nfs compiling error on msys2/mingw=0D
  block: enable libnfs on msys2/mingw in cirrus.yml=0D
=0D
 .cirrus.yml |  1 +=0D
 block/nfs.c | 15 +++++++++++++++=0D
 2 files changed, 16 insertions(+)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

