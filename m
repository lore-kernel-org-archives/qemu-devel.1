Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22BEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8B3207FC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlWmCBFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8B3207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GJw-00065w-NN
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3GEo-0006Is-Sl
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:01:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59991
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3GEn-0000Vi-6j
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596621692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dKyBKP++PhfY9ZHK8HEySO+iLqc7ualR6moE9MY47/s=;
 b=KlWmCBFa1tBbilkWi8gDvzQ611RXmxcbliUZbdPNjI9GUEXvOuyFoZukCipcM5yXl1rnIo
 rCGH0lfh1+1/ySZspt2lUlUA08229nM49PH7kGWp6TmebRiH5v2EblG5VpeAwu2gG6C2Fq
 J5pJAq0/bwiWyV4sOWqWpOfMRU2D4CU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-GgzjgW9JMz6AWEFBfw2ZCw-1; Wed, 05 Aug 2020 06:01:31 -0400
X-MC-Unique: GgzjgW9JMz6AWEFBfw2ZCw-1
Received: by mail-wm1-f72.google.com with SMTP id z1so2510738wmf.9
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 03:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dKyBKP++PhfY9ZHK8HEySO+iLqc7ualR6moE9MY47/s=;
 b=ZGJzDwYcHkguVdFMwHov5YCC92kIcuXqpedPAbut1Nblj57gE1TNeGZRR3n85kDVwk
 wHTeRpHhaB+cyyY7DjquH4nK+Ya/IBSAv7vpZBA69sJqMGNCpF4dNkPzMXOoZbkTk7H9
 57ICaDXbJuZFys4m8l8FCIGc9GzhYO4IIBxic4Dpv3CbArVUNt4/otrNrjox/dbFPEXq
 zZNoVTAAZ6oO074aCfNSIsJCEjx6CNhIxrHTcSTnNOLel8D9DJUm/F9P5kMkQUEy9JCK
 CS2/f7HXv9zYjsIfafVh2DMy6kPPZPMYHCW5Ldbi/a6gsWfZd1OuV9fGXUEV+iW08P9f
 9ZRg==
X-Gm-Message-State: AOAM5304spXyVbNA30L2x2y2WXHsIRXPSACntlr3bi5iulLdrR6IXCkH
 d+uRRWVkI1/OZeheve/HD+kN8BY1/JJ9/wh40fQm2xBbV2sP2582e3/jEwKjQuix3+BjgFdGC0B
 5TQLPCRSQ2BzMRVQ=
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr2496985wmc.40.1596621689703; 
 Wed, 05 Aug 2020 03:01:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9hvf5w67Rlf1/5yOTPy5mRntSTnO+eAj2B3hFsdRXunS0T3wmTCdHcOW+L6aVeeLUmImeYA==
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr2496969wmc.40.1596621689480; 
 Wed, 05 Aug 2020 03:01:29 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id a10sm2004181wro.35.2020.08.05.03.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 03:01:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 0/2] stubs: Fix notify-event stub linkage error on
 MinGW
Date: Wed,  5 Aug 2020 12:01:24 +0200
Message-Id: <20200805100126.25583-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

2 trivial patches to fix the link error reported by Thomas:

  LINK    tests/test-timed-average.exe
 libqemuutil.a(main-loop.o): In function `qemu_notify_event':
 util/main-loop.c:139: multiple definition of `qemu_notify_event'
 tests/test-timed-average.o:/builds/huth/qemu/tests/../stubs/notify-event.c:5: first defined here
 collect2: error: ld returned 1 exit status
 rules.mak:124: recipe for target 'tests/test-timed-average.exe' failed

Since v2:
- Remove incorrectly added abort() in qemu_timer_notify_cb()

Philippe Mathieu-Daudé (2):
  exec: Restrict icount to softmmu
  stubs: Remove qemu_notify_event()

 include/sysemu/cpus.h  | 4 ++++
 exec.c                 | 4 ----
 softmmu/cpus.c         | 7 +++++++
 stubs/cpu-get-icount.c | 2 +-
 stubs/notify-event.c   | 6 ------
 stubs/Makefile.objs    | 1 -
 6 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 stubs/notify-event.c

-- 
2.21.3


