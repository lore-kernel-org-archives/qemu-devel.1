Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794BC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D727820674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEdD+nsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D727820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHHk-0006SZ-2E
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBHFa-0003ba-05
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBHFW-0008GS-Ut
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:11:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56888
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBHFW-0008Fq-MD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583755869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cPI4zNorbWHS6HjxG0B3SiZTh2w729y+VHbYK0yShfc=;
 b=NEdD+nsktsHLFaBMVERMq1krhuDYYNKkufsIRoldv/ijJyltf/5QQUtW8VHTYRGMDK81c9
 spLMaQ2cuTxaSKxuB+KJISSl8Nzl4poLTl8EeTyI+7rNBGa4w4Mm4QejRty98bobQw6mU2
 Hqgu2apfUcOxGFewekX11DlgZv+blkY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-4lfbrDdiOge0Ym0NNR-yRg-1; Mon, 09 Mar 2020 08:11:08 -0400
X-MC-Unique: 4lfbrDdiOge0Ym0NNR-yRg-1
Received: by mail-wm1-f72.google.com with SMTP id m4so2445647wmi.5
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 05:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QRRKJgovBYHISJ7BzEKk+7D8fpDhIeHZpbnoQFsGQ/I=;
 b=nNvwwzHLtBbDC1Q+P1xruI/UMdYm+VkT4T/AupZQjr25P+i71toCqm9z1jaO1qE/1x
 WEwIJm7WryNNf3om7JxAwM68PWqpKYT648MK1AAYJ/zui+7nJNzWeAupZ4o0jYK6H+cg
 N5cARannSDrMy6pu0eXr1bALLnDYXRwYSxiWWTSUl5CZt25cGWnHd7CpQvze5+GD3FnE
 QC/yhAlA9mLkrRrwKH4CN/VPa4C4s5K1uvQNxhEB8J7fOnlefFOiTnGZ3BphgLxi4ayp
 imZixemf6LfBXScBGVlJWcOdX/RsSJKgU6POXV+YZCpL3BB0h+8YjQO1wEX7i7fGafk4
 wmfA==
X-Gm-Message-State: ANhLgQ3r9sswwHp7HxGHEEkPCKzPpprj1jLEIbU2W8kevb0wfW40VJJv
 9u77POYfMvAOaaXHS+Y9+XZdEjnrDkewk62bhEBTNigStVnHbjtDZM4dY77p0jBnu6vEOUIKo4i
 I3FIIbPEFCQO9hGs=
X-Received: by 2002:adf:e742:: with SMTP id c2mr8771021wrn.361.1583755866999; 
 Mon, 09 Mar 2020 05:11:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtutV6sHjy7+X4Ed0YQIg8EwOHZEcLM53D+fV+ePOaC7xlvtw0+qff/Z4Uex3aud8B5siRqkQ==
X-Received: by 2002:adf:e742:: with SMTP id c2mr8770989wrn.361.1583755866749; 
 Mon, 09 Mar 2020 05:11:06 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t1sm66355565wrs.41.2020.03.09.05.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 05:11:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] cpu: Avoid latent bug calling cpu_reset() on
 uninitialized vCPU
Date: Mon,  9 Mar 2020 13:11:01 +0100
Message-Id: <20200309121103.20234-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two trivial patches to avoid each (new) architecture to track
a bug already resolved once on ARM: cpu_reset() modify fields
in the CpuState while the state is not yet allocated.

Philippe Mathieu-Daud=C3=A9 (2):
  cpu: Do not reset a vCPU before it is created
  cpu: Assert a vCPU is created before resetting it

 hw/core/cpu.c        | 1 +
 target/cris/cpu.c    | 2 +-
 target/lm32/cpu.c    | 3 +--
 target/m68k/cpu.c    | 2 +-
 target/mips/cpu.c    | 2 +-
 target/sh4/cpu.c     | 2 +-
 target/tilegx/cpu.c  | 2 +-
 target/tricore/cpu.c | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

--=20
2.21.1


