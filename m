Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE6EC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00C6222B9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSad2GBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00C6222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQqHo-0004ix-IV
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 07:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQqG8-000398-Pj; Fri, 09 Oct 2020 07:08:24 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQqG3-0007zO-3F; Fri, 09 Oct 2020 07:08:24 -0400
Received: by mail-pf1-x443.google.com with SMTP id x22so6551486pfo.12;
 Fri, 09 Oct 2020 04:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CLMpqr1RBJrXatewwrrioY3Rh7CqjUKwPweayW2zROE=;
 b=kSad2GBJtvY3xzIy1BslHk1bRlFglZFQMFNkzXFXAAR2qSFGTs3wa5C8O1HVshLW0V
 UPo4jZ895NOa9IyOgJwD82/WBA2DoayFwGc3stQJB+Nta9uxejWPwghbxeUFP6MvXGEX
 pcbSRWtnhc9tAWbLh0LtHH0QHpVUY3fBSHZ4ZyAAZp6vOmATYF9oo9TG0ClH0ycUxid4
 n2MrovLWsE57itxHF5EPqvCROo53CIGtwz1HJxE0JkMds+w8ENvAve81GDty2HbLwyCG
 tGTK18hqy/OEB+qVKoY/16mZGEMNtF/t4yia1s3Bk82ixX8+PjlI4l1BTDYix/xLIp3e
 2/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CLMpqr1RBJrXatewwrrioY3Rh7CqjUKwPweayW2zROE=;
 b=le7SRk6hptJAMxWN4GiTW8xcVRxHtWXfoOoXWdvkhXzyXMJnBeNtP4Lm6+F1949SeP
 n71kKmTu5GvUiDC89/cjWajbLaReG/TdK2lexzx7FeuH03f1JpHY4/ep4CDbQd05dij3
 m3D/RQUUkDlugAHShbRc1INz6XpaBzaOrbcpeGp8dnimgLYthW6vgQhoKC/VXMhNV4z4
 N/jD7BnqiBmtb23CxkPC804DeBsm4WTiodm3L55E088rFyM5NSA23du3XG40QV10Rx7g
 8XVMWLY24SQ57g0gLl6rZwwgoDu6ysgQrHL3/ncSvpCMIXtqSwDAhBUmteW0kQVN2aXe
 qaCw==
X-Gm-Message-State: AOAM5313NRHWLtQuFloJIg49IlNecUjHoAfOWTPs93e3m2Hx0brgB1jH
 kChvXt0qbNs4rv+joO4f0n+cKwoUZ85AQX3i
X-Google-Smtp-Source: ABdhPJyw3HRi/LvyB6GjVL7lANuNogo4MQe5z26FCewnOMr3R4UE/whx/Vhg4c5Low7We3nx3sKOFQ==
X-Received: by 2002:a63:e354:: with SMTP id o20mr3045906pgj.317.1602241696848; 
 Fri, 09 Oct 2020 04:08:16 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id v1sm2619462pjt.2.2020.10.09.04.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 04:08:15 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/4] Improve cirrus msys2
Date: Fri,  9 Oct 2020 19:07:56 +0800
Message-Id: <20201009110800.432-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x443.google.com
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
V5-V6=0D
Remove the university mirror, the main repo are back.=0D
rename to setup_script.=0D
Add fixes for msys2/mingw rST document fixes=0D
=0D
V4-V5=0D
Now the cache are usefull by using 7zip to archive msys64=0D
Saved about 18min, compare=0D
https://cirrus-ci.com/task/5093551157542912=0D
https://cirrus-ci.com/task/6177196538593280=0D
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
Yonggang Luo (4):=0D
  cirrus: Fixing and speedup the msys2/mingw CI=0D
  cirrus: msys2/mingw speed is up, add excluded target back=0D
  docs: Fixes build docs on msys2/mingw=0D
  cirrus: Enable doc build on msys2/mingw=0D
=0D
 .cirrus.yml                   | 119 ++++++++++++++++++++--------------=0D
 docs/conf.py                  |   2 +-=0D
 docs/sphinx/kerneldoc.py      |   2 +-=0D
 scripts/rst-sanitize.py       |  21 ++++++=0D
 tests/qapi-schema/meson.build |   5 +-=0D
 5 files changed, 98 insertions(+), 51 deletions(-)=0D
 create mode 100644 scripts/rst-sanitize.py=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

