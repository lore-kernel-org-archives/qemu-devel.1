Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52281C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EAF2080A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIF+N4KZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EAF2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ77z-00056p-GZ
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ76h-00044L-G1; Wed, 07 Oct 2020 06:55:39 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:38549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ76f-0002Al-Jo; Wed, 07 Oct 2020 06:55:39 -0400
Received: by mail-pg1-x52b.google.com with SMTP id j33so1141859pgj.5;
 Wed, 07 Oct 2020 03:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aU0/ppJ4UFoywdQxLOg8ORAl3MTzk8SpPwA+YB/UwyQ=;
 b=lIF+N4KZQY5UVY1fYGx9n/mXDSBF+UAfRhmx7gjudGjDw9mwU53ckucMuU86BQCROc
 sy+GAp5IguohbvLrnE54qzsMhA22Ufz4lbGrVeqgte+YQCsEPmU9HHXxmtj7prhZMaEP
 WWLXyhwHm7gO5oJK/08J9I48AGq6iBEwcWpDYi3QiS/cGqrLz32qDUSfbm468geoJFOt
 bhLfyARbec045WRGPZym9FzGAcM19nSzDyULhuTbov6yvx4iqOtVK3/S2ylGxvKoEykn
 tIpY48CuJr9TUBpV6Bi8XOch5Qm0p2P+/fzWr6j+WQ+aKvXjqMiD6IhPbCbTfsEJmn5M
 NwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aU0/ppJ4UFoywdQxLOg8ORAl3MTzk8SpPwA+YB/UwyQ=;
 b=GV5TNUxg2bKBeXqaCQo+VAlhU0EDGUhIdEt9Oq7IQqF6xDIbpJ0XdFHikt7SOTyBn9
 JW/O/K1XdhftM0ko8Nc+1gTi9zU8o9jXZ9mfCVXo8u9Tj+HxIIN4JLUqXzKJ4Za9Un0L
 JUyX/EQXLRY6ov/Pq+kiWtw/GCg+bzik485sAVfOomChkfFf3O+4KzO6WBFuGZaN+7iR
 X4xvCe1TJmEmcL7W0Cx2UV/ustvb+shbdFihVla1isn62UCt/zwrMjy77LlTEp9JoVvA
 lGW7OvFCkIl/eUGVx0SQNr5Pyx90eU8i2iHUI8mc+ZnBLRdOJJngjETgWfb1PDFDZdiq
 EX2w==
X-Gm-Message-State: AOAM531Q5XYuEpsq71rDVaY6WXfyfDyOYtsRCW9+OKiNkPcDxjpvKFiX
 AGb2mxYCqDPq3/+IE4J23JTEXSvgwdK1sg==
X-Google-Smtp-Source: ABdhPJw8Xwoe1pUM6hsIOISdGFI+qh4d4dY9qhmGqB6ogXnm6Qq/hn3FpukUwHR+VDITfsySN+xMaQ==
X-Received: by 2002:a63:2145:: with SMTP id s5mr2354266pgm.288.1602068135152; 
 Wed, 07 Oct 2020 03:55:35 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id d6sm1947351pjz.12.2020.10.07.03.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 03:55:34 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] Improve cirrus msys2
Date: Wed,  7 Oct 2020 18:55:16 +0800
Message-Id: <20201007105518.1019-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52b.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes the broken msys2/mingw ci and speed it up.=0D
=0D
V3-V4=0D
Using cirrus cache to speed up msys2 ci instead of downloading archive file=
=0D
=0D
V2-V3=0D
Add one more patch:=0D
cirrus: msys2/mingw speed is up, add excluded target back=0D
Do not build sphinx on windows, that's failing=0D
set the number of parallel count to fixed number 8=0D
=0D
V1-V2=0D
Resolve the cirrus conflict=0D
=0D
Yonggang Luo (2):=0D
  cirrus: Fixing and speedup the msys2/mingw CI=0D
  cirrus: msys2/mingw speed is up, add excluded target back=0D
=0D
 .cirrus.yml | 107 +++++++++++++++++++++++++++++-----------------------=0D
 1 file changed, 60 insertions(+), 47 deletions(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

