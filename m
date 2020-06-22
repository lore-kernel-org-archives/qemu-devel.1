Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB5CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AAFF206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G49qDxmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAFF206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIKn-0001w8-CD
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIIr-0008Sc-2p
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:59:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46950
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIIp-0004vb-7x
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592816382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pgTJHKtzkCGhxUIiNpjvZ8+snfIdITLpdCrSqH17jcQ=;
 b=G49qDxmZMEhIZWL7Gix3l9hmD9TecKwLifo+0vJ/C1YpCiXgReHvTC8yWU0v+J4kXrr55V
 wPXLWO7RRJerGw36pXF2SEcEu6MmeuBhWmEMOVRfOyOfBN/a/tEgql9H2NnlYN2nUeHCGK
 VqcwLTS7g+ROL69dQn9qZXj0r8yoksc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-BHZAV0HdNd2R-eVBE_Sgpg-1; Mon, 22 Jun 2020 04:59:38 -0400
X-MC-Unique: BHZAV0HdNd2R-eVBE_Sgpg-1
Received: by mail-wr1-f70.google.com with SMTP id p10so10577533wrn.19
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 01:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pgTJHKtzkCGhxUIiNpjvZ8+snfIdITLpdCrSqH17jcQ=;
 b=g9ImlWqlcEugciRfx8ALZVJCrZdOVgXbBtl1XgquYupk4sNeHxmOIGPSilJ1Xukdp6
 5w1jvuY9czmFVhm9Wjs4B4Heird7jvkmWByyi3vb3MZejV60xLzU1ddGaTVfAdPV7cGI
 za9GLphl+r60S943IAd7hUmRIcGnLrNf2X+iSghCDUbPNVf5bKGoET9Cd2o4LVCUzjNp
 jP9R7Wv4sjKINGzgAlBFSBslTV40+C9Jl0FembTKB9CJPAqpRj8ubXlo21D8STYE+v7j
 4h3bKw0Wl96mO7yhZWHQ9zl3aW8tkvQ65m18BxJNt7OxcgPobx/jVw7Fs5csUNoIRwr/
 vrmQ==
X-Gm-Message-State: AOAM530AKV7llwmGlxRY5HfXtyRnxCtXLeIu1o06NxyTC6YU436yaiOU
 2gv7yrNWTsI15/hS6spnHhw5YuoaxDpD5knIFkg2GG9fIMd81AY/GJY6PFie+y0xgHMNvzxT3jW
 FqTZ1x7wxdMzvObs=
X-Received: by 2002:a05:600c:2116:: with SMTP id
 u22mr2800799wml.82.1592816376909; 
 Mon, 22 Jun 2020 01:59:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7WqmCn/TcNsxJLqH9r/tXI0Jrlfuhao6DNAu2/nOnJ5smd3fGDHQsGycSA4Zj24vc/SV0Zg==
X-Received: by 2002:a05:600c:2116:: with SMTP id
 u22mr2800785wml.82.1592816376727; 
 Mon, 22 Jun 2020 01:59:36 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d9sm16856594wre.28.2020.06.22.01.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 01:59:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Acceptance testing patches for 2020-06-22
Date: Mon, 22 Jun 2020 10:59:26 +0200
Message-Id: <20200622085934.16441-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 06c4cc3660b366278bdc7bc8b6677032d7b1118c:

  qht: Fix threshold rate calculation (2020-06-19 18:29:11 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/acceptance-testing-20200622

for you to fetch changes up to b52d7e216c663ae89c65d656faf3a80b1c05737e:

  tests/acceptance: record/replay tests with advcal images (2020-06-21 13:58:=
52 +0200)

----------------------------------------------------------------
Acceptance tests patches

- List acceptance test reviewers in MAINTAINERS
- Record/Replay tests from Pavel Dovgalyuk

Travis-CI:
https://travis-ci.org/github/philmd/qemu/jobs/700787719
----------------------------------------------------------------

Pavel Dovgaluk (7):
  tests/acceptance: add base class record/replay kernel tests
  tests/acceptance: add kernel record/replay test for x86_64
  tests/acceptance: add record/replay test for aarch64
  tests/acceptance: add record/replay test for arm
  tests/acceptance: add record/replay test for ppc64
  tests/acceptance: add record/replay test for m68k
  tests/acceptance: record/replay tests with advcal images

Philippe Mathieu-Daud=C3=A9 (1):
  MAINTAINERS: Add an entry to review Avocado based acceptance tests

 MAINTAINERS                       |   9 +
 tests/acceptance/replay_kernel.py | 300 ++++++++++++++++++++++++++++++
 2 files changed, 309 insertions(+)
 create mode 100644 tests/acceptance/replay_kernel.py

--=20
2.21.3


