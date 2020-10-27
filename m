Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC932C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C30122264
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmBBi9QL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C30122264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXM9G-0003qo-2J
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXM6Z-0001Cj-Kk
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:21:27 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:38627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXM6Y-0008CA-09
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:21:27 -0400
Received: by mail-ej1-x62a.google.com with SMTP id ce10so1429984ejc.5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VB3pvcv08zLKqhwsEcLdqgh9YzTbyGlkseYk/hYu3K8=;
 b=GmBBi9QLmTy5zfVUxgRvNaRgZ+uq+jdsFox2sYSi+N8xcKLfg0KHx7TZ+sosg9s/JT
 njU6oRMCA4+WVcGLLRCBhU9RPMLcX3Jp/Gh77nuvoj4hsGZrKSDn65rW8UF7AhKD4Qxi
 DAOT7gz8nZHANw3v448NoH7X4BNs8vhjixY1F6qEIjM2KIW0LJe44QqvNR5Ve91UKx6l
 8eJfevRFlcna2Cz/VCXJFNSEJiOQps6KRn8Xt2hjwjsWnlu7Robd3VNh9rTlAhSpDrN3
 l1TQhAWvUKpRPhBv1/J9NIGEWzjVJD4gKiP4SFnWquVbi3gi1dmYz7DNv7R30AWu3vLd
 Xoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=VB3pvcv08zLKqhwsEcLdqgh9YzTbyGlkseYk/hYu3K8=;
 b=dSV9oqs2ZtsvRT6mHkHOlvQ/kWHnrKPnHGNvraYWKoeasRzBA5EQRUHuD9SETENeVh
 fW0xEub8h9eh5qt1I43iz4uoiKUh+aKwzh2jZLB/ck+50dq/z5t+7ccEmkowJs7hmlQ0
 qVl0+WaTLC5beGKryEBsphMKpS+XrzzK4gSQO/jSk9pyeLs74ZPqOfHikbLIPJF/tgGM
 d1ALFy6Ds0mXKqS4aS519luzUb6frtvpaqMcxeMSWxd4hS8FklzLspdZX0Bal+SD3H8j
 P5P12nx7AUMf6UYY67DyWu1aeniXOoUk3n7W0dy78QYeBk8KzZutzTeEN5qs/MR9S87q
 S5Lw==
X-Gm-Message-State: AOAM531/hdmBbqVoIOdY84b+G8bR0a+fRyIlwsql75Wyo2UYCgj5Gd/t
 NtV4wlu8ggtvnEb9fF9GqZSoAu2/aCw=
X-Google-Smtp-Source: ABdhPJxpph3P7IGHArdaqyomTM5gTb+raHrgxPZvjLjJbok1Kxg7IWPFlALnB52POWC6VwynWkkL8g==
X-Received: by 2002:a17:906:8610:: with SMTP id
 o16mr1568689ejx.209.1603794083546; 
 Tue, 27 Oct 2020 03:21:23 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z20sm656327edq.90.2020.10.27.03.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 03:21:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v4 0/1] tests/vm: Add Haiku VM
Date: Tue, 27 Oct 2020 11:21:20 +0100
Message-Id: <20201027102121.264963-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Intent to not get Alexander's patch lost.=0D
=0D
Since v3:=0D
- Grammar fix (eblake)=0D
=0D
Since v2:=0D
- No change, posted as single patch=0D
=0D
Since v1:=0D
- Addressed Thomas Huth review comments=0D
=0D
Alexander von Gluck IV (1):=0D
  tests/vm: Add Haiku test based on their vagrant images=0D
=0D
 tests/keys/vagrant        |  27 +++++++++=0D
 tests/keys/vagrant.pub    |   1 +=0D
 tests/vm/Makefile.include |   3 +-=0D
 tests/vm/basevm.py        |   5 +-=0D
 tests/vm/haiku.x86_64     | 116 ++++++++++++++++++++++++++++++++++++++=0D
 5 files changed, 149 insertions(+), 3 deletions(-)=0D
 create mode 100644 tests/keys/vagrant=0D
 create mode 100644 tests/keys/vagrant.pub=0D
 create mode 100755 tests/vm/haiku.x86_64=0D
=0D
-- =0D
2.26.2=0D
=0D

