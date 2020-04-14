Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739C9C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3C820656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNyZcK/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3C820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOgN-0005Zn-94
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOaT-0002Mo-Rq
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOaS-0004wh-T2
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20662
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOOaS-0004wE-Pc
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586882340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=koez+7od0Glqc6sday+QFparwc9/NCcVr4QiSRLmbpg=;
 b=jNyZcK/BGoR3qVkiyBxq34Ud79U4tUFtPQYINX5SypPk1xMOY8D/h1bSPyjjdxCqrhwvbP
 r4wmjCxXF/OLdN6crgKJ75TRhIUOeTYkKJoFbrFLPG/E9MZVJ30SUOVwF3gjZ60eArP/K5
 bgontHxX+yhdAjaU+qIS74xVWOKqjvI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-8pi7BX79PjKc7Gt20uCL5Q-1; Tue, 14 Apr 2020 12:38:57 -0400
X-MC-Unique: 8pi7BX79PjKc7Gt20uCL5Q-1
Received: by mail-wm1-f72.google.com with SMTP id q5so2637596wmc.9
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W/Dgz6FExAAkLBrtQit8Q/9TgU3qbUdxEuYU3AIEpyA=;
 b=FJV/AB/Bf5S0xIAhrMlAKdbL1ZkaTLtnUarO9ZNbanVcVekLQlwE/x2VyQBSv6n941
 Ys+jb/Q+oGq7xitOOegwJOfI5DMS16xlDyXL0BoxaVwTMAUa5cIuhXbjJ9JWl5QEkKLb
 vfxrDTxvGMRl7uv8qiebFD5w6PfpBFEzxk2QsWwZOQHmRreBkc06hp+tNQm28spP0hxJ
 Ubox+eZGckmSxQVUFAjUcoe8KJeMgw/4uGNi7PDdv8nOm/9DFTlHz/2TvyqR/IU9uWC3
 hWJ3YbCFgHJXF6x4tKprvDXib6xC3nuhvqT1kyq5tW9fCAgcNnd0QrIRYXISxahBPvZJ
 l66Q==
X-Gm-Message-State: AGi0PuZQpUy6jmDZ2LCOiqYIz/d2KQr1zWP+mW71sM+1/mqawS8aLlmw
 LzoJWVSWbqnHEWXauj3hgC0cJgajFMq+zv+HSdQDTxwwzrRXrxKVuyTX8/+SJaUFC3xDQN/CudN
 qAzimQE37Pwb8sBA=
X-Received: by 2002:adf:97d9:: with SMTP id t25mr14923295wrb.157.1586882336033; 
 Tue, 14 Apr 2020 09:38:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypJLvAe0U/TDlAq3qUEfjs/FwWpadYS4C/i3z3vICLHu816mz0ABy6XBreygQWZ/er/cr2SyMw==
X-Received: by 2002:adf:97d9:: with SMTP id t25mr14923276wrb.157.1586882335824; 
 Tue, 14 Apr 2020 09:38:55 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v7sm19916882wrs.96.2020.04.14.09.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:38:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v3 0/2] gdbstub: Introduce
 gdb_get_float32/gdb_get_float64 helpers
Date: Tue, 14 Apr 2020 18:38:51 +0200
Message-Id: <20200414163853.12164-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes for GByteArray (commits 462474d760c & a010bdbe719).

Based-on: <20200414102427.7459-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (2):
  gdbstub: Introduce gdb_get_float32() to get 32-bit float registers
  gdbstub: Introduce gdb_get_float64() to get 64-bit float registers

 include/exec/gdbstub.h          | 20 ++++++++++++++++++++
 target/m68k/helper.c            |  3 ++-
 target/ppc/gdbstub.c            |  4 ++--
 target/ppc/translate_init.inc.c |  2 +-
 target/sh4/gdbstub.c            |  6 ++----
 5 files changed, 27 insertions(+), 8 deletions(-)

--=20
2.21.1


