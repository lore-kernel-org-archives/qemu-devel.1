Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91497C54E8E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5976120722
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsAhXWps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5976120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYSEq-0008C6-CB
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 06:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYSDN-0006IV-54
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:32:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42431
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYSDM-0007Sd-CM
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589279563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D3s9LSGcZEYro7u0ScBs6UfFzzI5QWTXiQteI6q/kVs=;
 b=EsAhXWpsze/ypPCspL9/dCdqWo/3o2fMcX/3iYvSaaUYf76252Nuo/4txUArxK4Ffp78in
 a73jpK9rbyjaZlEhSF7AvBwpgzTZEJUVd4+ZHEmRHdyaxG7fwgxveYpTQ4TvOnwpu6zyVy
 6b5wM4y8ECddCTqPUbkfjh+5FiTitmI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-DioBRlIoNuqMfsN3hvRVJA-1; Tue, 12 May 2020 06:32:41 -0400
X-MC-Unique: DioBRlIoNuqMfsN3hvRVJA-1
Received: by mail-wr1-f69.google.com with SMTP id z10so2723869wrs.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 03:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D3s9LSGcZEYro7u0ScBs6UfFzzI5QWTXiQteI6q/kVs=;
 b=nxCkS5btspXAl8/YCBWNLvxl0A/bhWoraKMN5IUo8Kw8Fk3gP37gGRuunE77GoVUOu
 eZpA9rUM+Via+q9wMvc2d4Vs1gIXnE7i3PF79PPdYkPFmgRqgD99LZM+5U++44F+aPQn
 oLazn4QtUXO3SiRMuWfGjQ3qYO9SFiH4wBf2vTZiW/iy8WEANE4/BLEgpIwW3GXtriSZ
 U+j0UzrVrXWs5vaWTEtqgnHsBXqjXviMGRLVX227HfnseENtDzqdrOb/fVRnM4A4GByL
 exeXnpvgBVpG3P6DYwAxQTofx25TPrh857ZpD4goLe0VhIXGw+6kQ22MCvJiA6hn5l3H
 7/pg==
X-Gm-Message-State: AGi0PuYYXT7LwFm3IdTaON/ii+r2pHFisjHCDogeypW7QCwUUbXyf0WT
 1rmGTpQtF0YLRXQ/EhQtqaM73iwfyPZspQE/ueQnxNs0MrjXAt2Fr+Vc90KAsN893uTON4v0S1j
 F1LQdmlLV3nDWoew=
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr20748016wmk.3.1589279560456; 
 Tue, 12 May 2020 03:32:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypI7UX/2eCYXEuygt24GZ0cIrBaT7G/B+iwW2cYEEuIZJysOnDbHZJBLcIIaLOSrWhvw7mpSHA==
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr20747977wmk.3.1589279560089; 
 Tue, 12 May 2020 03:32:40 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id x5sm23249077wro.12.2020.05.12.03.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 03:32:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/6] scripts: More Python fixes
Date: Tue, 12 May 2020 12:32:32 +0200
Message-Id: <20200512103238.7078-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, kvm@vger.kernel.org, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial Python3 fixes, again...

Since v3:
- Fixed missing scripts/qemugdb/timers.py (kwolf)
- Cover more scripts
- Check for __main__ in few scripts

Since v2:
- Remove patch updating MAINTAINERS

Since v1:
- Added Alex Bennée A-b tags
- Addressed John Snow review comments
  - Use /usr/bin/env
  - Do not modify os.path (dropped last patch)

Philippe Mathieu-Daudé (6):
  scripts/qemugdb: Remove shebang header
  scripts/qemu-gdb: Use Python 3 interpreter
  scripts/qmp: Use Python 3 interpreter
  scripts/kvm/vmxcap: Use Python 3 interpreter and add pseudo-main()
  scripts/modules/module_block: Use Python 3 interpreter & add
    pseudo-main
  tests/migration/guestperf: Use Python 3 interpreter

 scripts/kvm/vmxcap                 |  7 ++++---
 scripts/modules/module_block.py    | 31 +++++++++++++++---------------
 scripts/qemu-gdb.py                |  4 ++--
 scripts/qemugdb/__init__.py        |  3 +--
 scripts/qemugdb/aio.py             |  3 +--
 scripts/qemugdb/coroutine.py       |  3 +--
 scripts/qemugdb/mtree.py           |  4 +---
 scripts/qemugdb/tcg.py             |  1 -
 scripts/qemugdb/timers.py          |  1 -
 scripts/qmp/qom-get                |  2 +-
 scripts/qmp/qom-list               |  2 +-
 scripts/qmp/qom-set                |  2 +-
 scripts/qmp/qom-tree               |  2 +-
 tests/migration/guestperf-batch.py |  2 +-
 tests/migration/guestperf-plot.py  |  2 +-
 tests/migration/guestperf.py       |  2 +-
 16 files changed, 33 insertions(+), 38 deletions(-)

-- 
2.21.3


