Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B68C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31B120733
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPVRJjBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31B120733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYP10-0005ZV-T9
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYP03-0004F8-TG; Tue, 12 May 2020 03:06:47 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:35537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYP03-000849-6j; Tue, 12 May 2020 03:06:47 -0400
Received: by mail-ed1-x52b.google.com with SMTP id h15so7913598edv.2;
 Tue, 12 May 2020 00:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O53LT9XpVwSPMFK4w2PFhzkO8rIO707i+mYTAM8vrqo=;
 b=BPVRJjBgnA3w4caDu0x8u3D5q+AUBj1TVz0lPYgJb8UxOFuhF2tJ3r67D3ENujcqpc
 EJS6Pm1drXWnJ11Lt3hE4x0iLX+l9Xd9WjA5oFpIuR81Md+/hKGXXJggOOgUlKT1yUxh
 Jchd4mUSmWBOCuP5veW3EDWVoPZUWuMZ5GmmhA6ZZlBT3nzH30wf9HdH4xmJ1Q1pM45k
 mIVGX3gUhFPHHGm/o4jzqqsq9mpZIaQVbIrkJKZ290Z7XCp+SH6GJM1aiEYd56XFag+y
 4ozxDu+A/6LHlhge1iIUCDMl4go6/9aVoTGlvgjFzmjT+8DI44JMnr4Ap/cjx5oPuPQY
 5B3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=O53LT9XpVwSPMFK4w2PFhzkO8rIO707i+mYTAM8vrqo=;
 b=ssb8/Ti2DfSTon+wcH6LyuAaHnjtV8Gs62s2HLYdpibybe1PbtCAGIn3zIaW2TIfth
 ORGkZllxfOMBnC5IkJ5P4evo4HugH99DCrGZ9XdvKuU0SLubniZ6Ocf9rguY4t/j0gWA
 cVcndUxvdNmRgj2jYihdpT66vCpWUFvSAXGQNehYnz2wmUVAywsdjtgWrsWykY4UsYdl
 fBG0/FcAwVJZPcpS0g0lL8zJaruW3qdFo6hPhReqR0pjyHbYLEdhyY2I7polTzgbveou
 PJe6Dq4K1fe2dDBBCB4jOvHk78r/pIh5aJsm7FjjMGzewB78oR9fgNNPOUoy8WIysoQM
 XynA==
X-Gm-Message-State: AGi0PuYZopJtQQLpRq3+m8MufZys4eqpMhgOmPsVchAA3Wsy9NgIU+Ou
 oGKFXgYkNPF37tb9Y+F1WNfgPRXjhg0=
X-Google-Smtp-Source: APiQypJvyhzrJAdrXVvj8uIBesdmGSBX+wtQSS7k/BZ4yTivh6nzaZyVch8mdkCY5Gs/R6bubf1xHg==
X-Received: by 2002:a50:c047:: with SMTP id u7mr9273128edd.208.1589267204824; 
 Tue, 12 May 2020 00:06:44 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id ch8sm247345ejb.53.2020.05.12.00.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 00:06:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] scripts: More Python fixes
Date: Tue, 12 May 2020 09:06:40 +0200
Message-Id: <20200512070642.23986-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial Python3 fixes, again...

Since v2:
- Remove patch updating MAINTAINERS

Since v1:
- Added Alex Bennée A-b tags
- Addressed John Snow review comments
  - Use /usr/bin/env
  - Do not modify os.path (dropped last patch)

Philippe Mathieu-Daudé (2):
  scripts/qemugdb: Remove shebang header
  scripts/qmp: Use Python 3 interpreter

 scripts/qemugdb/__init__.py  | 3 +--
 scripts/qemugdb/aio.py       | 3 +--
 scripts/qemugdb/coroutine.py | 3 +--
 scripts/qemugdb/mtree.py     | 4 +---
 scripts/qemugdb/tcg.py       | 1 -
 scripts/qmp/qom-get          | 2 +-
 scripts/qmp/qom-list         | 2 +-
 scripts/qmp/qom-set          | 2 +-
 scripts/qmp/qom-tree         | 2 +-
 9 files changed, 8 insertions(+), 14 deletions(-)

-- 
2.21.3


