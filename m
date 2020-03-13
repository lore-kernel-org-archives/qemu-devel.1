Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E29C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C97206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MY+FZcjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C97206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpEX-0005Kf-Pd
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpBM-00082e-CN
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpBL-0002f8-B3
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39149
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpBL-0002dj-6Y
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S10AEwUkiwmQGgsU4J5LemLC20/NIYdtHAyFHsvDHiI=;
 b=MY+FZcjwk7C7bWDPDheuzYTMuaZLybStMwDO4Pw1owHauYQj8upz3KQ0QQWJxw0ojuQkE1
 6KJSG58nUkAGgR+P5IQFXyl/YoEJx1FTcNl/qDY+GbzXYRUMA4ivbrbBnirRlv+iijxjuV
 j42OiPk0I3rtuCMYtpTADx3G9gQ7GQw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-0ifv3u-dOkiKfaJSF3jy_w-1; Fri, 13 Mar 2020 14:37:13 -0400
X-MC-Unique: 0ifv3u-dOkiKfaJSF3jy_w-1
Received: by mail-wr1-f69.google.com with SMTP id c16so4756767wrt.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i8/Rx/aNeBnn+CcI3JJAXpd+80BCLbOpEr5mf5Uimz0=;
 b=PnCHrg/ce7AxejIoBxj8ZzBbDMTK0T/c5LncK/bIfGEJQyVSwWCyjw+9KOKzf2zADK
 M4OPODR6CiEiqyqtNmXN3NuEKTiBFX3PId7h9BSV/H1eaw1aXEM0N/tCc7g8NT4sIrrL
 D+9r7P8x0HSU1DAs8f6wdcusYsew3i7bdpYrqI5AF1GxARHmi7+zszBV+iXa/F/9Rci5
 pxqjJdq2a2nINjhs4Zk4JpKVDvbxPDkDG+H40PW1R+4HX9WMy2hjgWoTiJu2Z0aSA3Rs
 oC4O4+H0Qag90jtNJ8ni/bUf7+xtQVztlDho1frEZR8evcZQoXCBM7zawPj6HWqTzjPv
 9l3Q==
X-Gm-Message-State: ANhLgQ1v5zcL3uQxtxkJM883Rm7hOp4gwnX6uP1Htbaly2fol0E3fFcy
 lbvfVA0S16i/TgOwdBpnK0WiLfXnN1OtaeM0Quqf+qPIXqGV2Uzi9MyPgJGYFYmJ84+JfqhxyiL
 LZ4GZrCu2BoXz3Zc=
X-Received: by 2002:a05:600c:410b:: with SMTP id
 j11mr12489601wmi.86.1584124631693; 
 Fri, 13 Mar 2020 11:37:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu/qxzsZj4OctuTP1fk9ERHzqfCWjsfuuUpA+8Y3q0rSgZ7lUB+w0i6WGOhrqKLGDzRhHNS3g==
X-Received: by 2002:a05:600c:410b:: with SMTP id
 j11mr12489569wmi.86.1584124631400; 
 Fri, 13 Mar 2020 11:37:11 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q13sm29664354wrs.91.2020.03.13.11.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:37:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/14] tests/Makefile: Only display TCG-related tests when TCG
 is available
Date: Fri, 13 Mar 2020 19:36:41 +0100
Message-Id: <20200313183652.10258-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313183652.10258-1-philmd@redhat.com>
References: <20200313183652.10258-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 67e8fcddda..99db5eb3e0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -12,8 +12,10 @@ check-help:
 =09@echo " $(MAKE) check-speed          Run qobject speed tests"
 =09@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
 =09@echo " $(MAKE) check-block          Run block tests"
+ifeq ($(CONFIG_TCG),y)
 =09@echo " $(MAKE) check-tcg            Run TCG tests"
 =09@echo " $(MAKE) check-softfloat      Run FPU emulation tests"
+endif
 =09@echo " $(MAKE) check-acceptance     Run all acceptance (functional) te=
sts"
 =09@echo
 =09@echo " $(MAKE) check-report.tap     Generates an aggregated TAP test r=
eport"
--=20
2.21.1


