Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DA6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C672080A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqGKgtFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C672080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkAT-00084e-Sm
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFk9t-0007LK-GS
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:24:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34595
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFk9q-000718-P5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599596641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mqZDpH+5JMl4qVMGZ7a/PVdrlnG5B7zta3wr1NGj1Zk=;
 b=WqGKgtFLG2AILEybvYl2zKxLHDOXNHjKjs2SvRQ6nBXbw5J9/LyK2U+PPSiH/RD4ca2vwD
 Oenbz8XGcntlvbvoHOIS/sGTIFPSISkqiYLyj5iJN4H1K4Uh02J0jlI1ej4TkUj9v/hJo5
 x2E4LMqUBkbCOligT/OPtMQ9H59ixAE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-Q3u3trJPPhioxVBdpj63sw-1; Tue, 08 Sep 2020 16:23:57 -0400
X-MC-Unique: Q3u3trJPPhioxVBdpj63sw-1
Received: by mail-wm1-f72.google.com with SMTP id l26so186345wmg.7
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mqZDpH+5JMl4qVMGZ7a/PVdrlnG5B7zta3wr1NGj1Zk=;
 b=qUQcMiCauufpb5qy0CyLGf9YfcvRkyJjwtWROebnNc3xmg4AMhmqx4uRwxvgA+gblE
 KduN5Emp4u0aRqUg+BPYn+ce5DHIKbkWfJiMGWB3qWx/ft3YC4IvRwY8oH8JT9rfJ2lG
 v2KUKF2Lma7xo0X+znDDTUaxHYr81IyHXuibQpz0g2P7EH3XcnkTJWoHTdb8MlvRLHDg
 2YFOVh2Z2XyGrGk2HVNYUM3B/UaRniXG14crwE9e6gVKjL7QvgDmON6BnnrPFc2UiZ/J
 v5B0YKLT0ER0mf/NLE69d05E8NqKm+Prb/BXZG20btVjxu+uKPwbRl/QN/sEZ4hEZA8n
 5Yyg==
X-Gm-Message-State: AOAM533zip344TDIep2Axaut5AE9H46u3qMv9QoXfR8NMzFId4oDyaxK
 e+O8JJ1/Wf9IKFHmXz9bcYrIO42jhm2UTpQd+YPXGj7vwlxZCup4jyPsj8d6RoDXzfo37pp8pNh
 GKRVCNj/mTMOIEck=
X-Received: by 2002:a1c:e256:: with SMTP id z83mr156499wmg.33.1599596635880;
 Tue, 08 Sep 2020 13:23:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw01OtQfIuUJnKASa2sVy15ABB+O90pr8eNeE9iNPnqVRY84mCb2qguIuG8H9WXgoV45InOEw==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr156489wmg.33.1599596635744;
 Tue, 08 Sep 2020 13:23:55 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n4sm654305wmd.26.2020.09.08.13.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 13:23:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Acceptance Tests: update assets location and cancel
 tests if missing
Date: Tue,  8 Sep 2020 22:23:50 +0200
Message-Id: <20200908202352.298506-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cover from Cleber's v1:

  To minimize the inconvenciente caused by test and job failures in the
  future, an option is enabled that will cancel (AKA skip) tests early
  when those assets are not available.

Pavel Dovgaluk (1):
  tests: bump avocado version

Philippe Mathieu-Daudé (1):
  tests/acceptance: Add Test.fetch_asset(cancel_on_missing=True)

 tests/Makefile.include                    |  2 +-
 tests/acceptance/avocado_qemu/__init__.py | 12 ++++++++++++
 tests/requirements.txt                    |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.26.2


