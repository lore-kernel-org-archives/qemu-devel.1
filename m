Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD30BC4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A72206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXshjwy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A72206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3lp-0005H9-4b
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc3kK-0004J0-Pm
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:45:56 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:35847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc3kF-00032S-Gi
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:45:52 -0500
Received: by mail-wr1-x42f.google.com with SMTP id j7so691601wrp.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 01:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/q4o4BiIHWmBVIAtODv3UPM1kTXJig1tzzvjpmqNPpQ=;
 b=oXshjwy58XW4nOnK2QAPSmctnhXSDSl84kEoQ/WCKipy06AHZ7PgRMlNZ9hsm0s1di
 VgEos8EY3M3ciaUyFZvpsPreZAZiHxeSxc6x6l3hGQ02CKFw4tDnfvt/QDIJtvC16Q1x
 2btmMTcMltfDe60QRCx0l86+61soNuNi2eFeuw+eJmAq/7Zz8fWDeXf2vn70KfTg/QJ8
 diVMFr0Q2mB1S7ZZXhOMZ2o3+ik1AyJqb8Eju4WuOxxkxWPOTrq2yXrIVMWhrCDyfX7e
 qpcoYWKnji1/wQncrGWsAcMDj9FqnaeV+ZPLH4RE2gFRTFlAsgrP16o9JdTg6o4Hez8H
 MYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=/q4o4BiIHWmBVIAtODv3UPM1kTXJig1tzzvjpmqNPpQ=;
 b=UO1I24BiovI1CiKOauVOz9Shc/rdysSUMe8duSLlQuLCpR4Z0xItEZNm1YZssun/1Z
 KlnhSzJAwXX8TE64lAZ2cl7BJn6sy6kMHfMAoJXbpL0//1/5/V1vkAE+z9/73dixfitu
 2FV8+X4yQC66k+PwHBTPOl7GCCHN1ltvhFDC5W3p7J1l03Ptt+fpaoFbRnoJDIn1BU3x
 +FQR+jvMhuwhfAbjfIo4MA/MK9RI1mJ0Hb0FgSLUaImGi1SX9VHRtdchL+xylxYfzhel
 LmpcMyQhfEbHBRrLPLyUgTNbzoJ9Gt7jUAz9VXgd8BdVKcH4L/vSUEy7npvYyCcoCX6d
 EZlQ==
X-Gm-Message-State: AOAM533sExot/XyxIjhNkuVxeW4W44nrL5LFKfKQPbS9+VLDEHgbZXZV
 lGjFy8TyMqf7Ehng+AdHhWKAHvbptd4=
X-Google-Smtp-Source: ABdhPJypYLA8yDC42PAwQMJL5W7KWz1kEYPcRWXSp9aw20JGITNOoQXvJA/WTqE4S6Ta7XEGPjE77w==
X-Received: by 2002:a5d:4e0e:: with SMTP id p14mr16615971wrt.160.1604915149678; 
 Mon, 09 Nov 2020 01:45:49 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u81sm13094834wmb.27.2020.11.09.01.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 01:45:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] accel: Remove system-mode stubs from user-mode builds
Date: Mon,  9 Nov 2020 10:45:44 +0100
Message-Id: <20201109094547.2456385-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is pointless to build/link these stubs into user-mode binaries.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (3):=0D
  accel: Only include TCG stubs in user-mode only builds=0D
  accel/stubs: Restrict system-mode emulation stubs=0D
  accel/stubs: Simplify kvm-stub.c=0D
=0D
 accel/stubs/kvm-stub.c  |  5 -----=0D
 accel/meson.build       | 10 ++++++----=0D
 accel/stubs/meson.build | 12 ++++++++----=0D
 3 files changed, 14 insertions(+), 13 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

