Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC147C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7502C20753
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4R6WnOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7502C20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQspb-0002eH-H8
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 09:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQsoM-0000vR-FD
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQsoK-0007FZ-FF
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59754
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQsoJ-0007Df-W5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587475174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+3dL7HK3IprfglwxQAI6iAJf43RxdhDjeGz0/Y+AVYw=;
 b=H4R6WnOqJyVAJRGD+UQfxcbDYTLct+5RcMcWVOESAClRyGE16aQnr6kxEfSmkktGDtv4SK
 +9gelKm7KrSEIl/qYLBv7U51/mIDKbM27+XCVb7IPQ58iphMI7N/gQxYxD+058x0OlFMQR
 HYpybTw3Znr0BDA9mODFlUrbISwO/VU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-f4hzrM5xPZ-Ea-AmUVDcBw-1; Tue, 21 Apr 2020 09:19:30 -0400
X-MC-Unique: f4hzrM5xPZ-Ea-AmUVDcBw-1
Received: by mail-wr1-f72.google.com with SMTP id e5so7444561wrs.23
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 06:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WpjSjga3RuM/g/+6VzdeggLnv5t7E2VEFN3uiqBE20A=;
 b=IeZuj6mUgndLbvd7HaSLb5jJugT0WVF/pVpnTU38St5OjTbRMHyxJi1YHnVLyES58f
 TrR2/uBmA6E2LkHpqERZ6IiiL+9qcLMvPgvbCUa7lKYWKBkhENEvU/CJKVx2XPej8+0S
 UockXtUlqleJ5xs9O6MGCieLJhcu4nZkALY0MuxxL39mJ+qUQd5AsE/yahs6X2Z68QlM
 xmsbVJHQ9v1NOjFSnu010vxuh0w4XTmCZSB7Thf/MENLkszdwpjKaIMwGxPWsKJRlVFD
 0Xz5JYjy3jdil0CxH+igUPu8VWaZlVm7J7Z9upxVezFGHxkIoT+GXU/49IeLEF4cBmm5
 cUMg==
X-Gm-Message-State: AGi0Pubcukf/Tpj0+tA7hyoKPYCUhf75RlH/0zx4PdyZScEHNIkzEjvn
 WSBE84vXrDEtoPGx5C0yJib7u97qpadsDWQPLJNMDOlQ2MqeAVHdHpDrNkJaLl2SbNfMnOdOquy
 IwFgeg0pygUoNvsU=
X-Received: by 2002:adf:fac8:: with SMTP id a8mr15975709wrs.311.1587475169198; 
 Tue, 21 Apr 2020 06:19:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypKpajtsaLumU84NBykAs/oFg060Jnjwmn8lICLqR06VAGCLG+2ARPu/jQCZOYqpBfAlqwhLfg==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr15975698wrs.311.1587475168992; 
 Tue, 21 Apr 2020 06:19:28 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id u3sm3538698wrt.93.2020.04.21.06.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 06:19:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] target/arm: Restrict TCG cpus to TCG accel
Date: Tue, 21 Apr 2020 15:19:20 +0200
Message-Id: <20200421131926.12116-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are the uncontroversial patches from "Support disabling
TCG on ARM (part 2)"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689168.html

The other patches are blocked by the "accel: Allow targets to
use Kconfig" series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689024.html

Sending this series now for review for 5.1.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (4):
  target/arm: Restric the Address Translate write operation to TCG accel
  target/arm/cpu: Use ARRAY_SIZE() to iterate over ARMCPUInfo[]
  target/arm/cpu: Update coding style to make checkpatch.pl happy
  target/arm: Restrict TCG cpus to TCG accel

Thomas Huth (2):
  target/arm: Make set_feature() available for other files
  target/arm: Make cpu_register() available for other files

 target/arm/cpu-qom.h     |   9 +-
 target/arm/cpu.h         |  10 +
 target/arm/cpu.c         | 657 +-------------------------------------
 target/arm/cpu64.c       |  27 +-
 target/arm/cpu_tcg.c     | 663 +++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c      |  17 +
 target/arm/Makefile.objs |   1 +
 7 files changed, 708 insertions(+), 676 deletions(-)
 create mode 100644 target/arm/cpu_tcg.c

--=20
2.21.1


