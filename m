Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EB0C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D940221F7
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQuXCza6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D940221F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXXd6-0005Ow-6Q
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 18:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXXbq-0004DU-LO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 18:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXXbn-0006Mc-8J
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 18:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603838305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vHDGPNSRmUevHK/EGRRXiI683Rq8K6v92WRwcrkLB6s=;
 b=NQuXCza6X7fkN7V6Z02NBSGyLbIAKidwy6NJn+8SFpAWb8tXzyzASxIMM/umczY8YBMW39
 0kr3azg2ovRQmGxAXQB8eux/W4/ckduf4FfXmdh0aox2XP1SvhERFE3vjOccoHA29qO8k7
 RWEQR70D45eQoDk8eLOmk62lGYECMCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-2qwxmxGROBiv-OeP9Em-7w-1; Tue, 27 Oct 2020 18:38:21 -0400
X-MC-Unique: 2qwxmxGROBiv-OeP9Em-7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58E46186DD33;
 Tue, 27 Oct 2020 22:38:20 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCEC55B4B2;
 Tue, 27 Oct 2020 22:38:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] python: add linters to gitlab CI
Date: Tue, 27 Oct 2020 18:38:10 -0400
Message-Id: <20201027223815.159802-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

based-on: <20201020193555.1493936-1-jsnow@redhat.com>=0D
          [PATCH v3 00/15] python: create installable package=0D
=0D
This series serves as an addendum to the python package series; it adds=0D
easy invocations for running the linters with the correct options for=0D
the purposes of preventing regressions in our python libraries and=0D
tools.=0D
=0D
It adds (to ./python):=0D
=0D
- make venv: Use pipenv to recreate a venv as laid out precisely by=0D
  Pipfile.lock; this requires *precisely* Python 3.6.=0D
=0D
- make check: Run linters using pytest framework using user's current=0D
  environment (Which may well be their own venv, their OS environment,=0D
  whatever.) It only requires *a* python; at the moment, 3.6, 3.7, and=0D
  3.8 are supported. There are some known problems with 3.9 as of yet.=0D
=0D
- make venv-check: Run the linters using the venv laid out by=0D
  Pipfile.lock specifically.=0D
=0D
Then, it adds a very simple gitlab test to run this on top of the=0D
Fedora32 build. I chose Fedora as the host for this test only because=0D
Fedora's package ecosystem makes it very easy to install multiple=0D
versions of Python, which allows us to test against our minimum required=0D
version explicitly to detect against any accidental breakages that slip=0D
in from developers coding against 3.7, 3.8, 3.9, etc.=0D
=0D
This is the simplest thing I could come up with that fulfilled a few=0D
design goals I had in mind:=0D
=0D
1. It can be run locally with an arbitrary environment=0D
=0D
2. It can be run locally with a precise environment, matching how it=0D
will be executed in the CI environment=0D
=0D
3. It can be invoked from the python directory in a standalone manner.=0D
=0D
4. It runs on our CI infrastructure, preventing regressions in the=0D
python code.=0D
=0D
John Snow (5):=0D
  python: add pytest and tests=0D
  python: add excluded dirs to flake8 config=0D
  python: add Makefile for some common tasks=0D
  python: add .gitignore=0D
  gitlab: add python linters to CI=0D
=0D
 .gitlab-ci.yml                         | 10 ++++=0D
 python/.gitignore                      |  9 ++++=0D
 python/Makefile                        | 35 +++++++++++++=0D
 python/Pipfile.lock                    | 71 ++++++++++++++++++++++++--=0D
 python/setup.cfg                       |  7 +++=0D
 python/tests/test_lint.py              | 28 ++++++++++=0D
 tests/docker/dockerfiles/fedora.docker |  2 +=0D
 7 files changed, 157 insertions(+), 5 deletions(-)=0D
 create mode 100644 python/.gitignore=0D
 create mode 100644 python/Makefile=0D
 create mode 100644 python/tests/test_lint.py=0D
=0D
--=20=0D
2.26.2=0D
=0D


