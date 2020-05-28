Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608EEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298812075A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/tt97uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298812075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFVs-0000FY-7Q
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeFUz-0007Ps-Ug
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:10:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28430
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeFUy-0003ES-Nu
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590660650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vrEQrlBDkuvsrk/aZcDVHRyqaC3WrxYB9wnc09aHWKU=;
 b=I/tt97uZqBhMIpfoeZIKLH7A/9vBFvI91GS/qFn66QF+uMfNr6Q/T69yrFfCC4JtLOUPyV
 6o7iKPH5Qc/x7fz508VfKeG4D8mCXUXlH5D+fq5j/RskNaSQsegnvh/PqbRKz23h2U3qkO
 ypHxkC14qGRMVlzyi6XwtOfESmBl2gY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-PAbs0MxjMP-gr4WhRApwbA-1; Thu, 28 May 2020 06:10:48 -0400
X-MC-Unique: PAbs0MxjMP-gr4WhRApwbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5FA3107ACCD;
 Thu, 28 May 2020 10:10:47 +0000 (UTC)
Received: from thuth.com (ovpn-112-213.ams2.redhat.com [10.36.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4F505D9EF;
 Thu, 28 May 2020 10:10:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 0/7] Gitlab CI fixes and improvements
Date: Thu, 28 May 2020 12:10:32 +0200
Message-Id: <20200528101039.24600-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

 Hi Peter,
 
the following changes since commit 06539ebc76b8625587aa78d646a9d8d5fddf84f3:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/mips-hw-next-20200526' into staging (2020-05-26 20:25:06 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-05-28

for you to fetch changes up to 0016afa250d251a1b3fbc90c6d618e7f00e02f14:

  gitlab-ci: Determine the number of jobs dynamically (2020-05-28 11:01:38 +0200)

----------------------------------------------------------------
- Build with other images instead of the broken Debian containers
- Fix building with the latest version of Clang (at least wrt. to
  the gitlab-CI pipeline)
- Add Philippe, Alex and Wainer to the Gitlab-CI section in MAINTAINERS
----------------------------------------------------------------

Alex Bennée (1):
      linux-user: limit check to HOST_LONG_BITS < TARGET_ABI_BITS

Cleber Rosa (1):
      GitLab CI: avoid calling before_scripts on unintended jobs

Philippe Mathieu-Daudé (1):
      gitlab-ci: Remove flex/bison packages

Thomas Huth (4):
      MAINTAINERS: Add Philippe, Alex and Wainer to the Gitlab-CI section
      gitlab-ci: Move edk2 and opensbi YAML files to .gitlab-ci.d folder
      gitlab-ci: Do not use the standard container images from gitlab
      gitlab-ci: Determine the number of jobs dynamically

 .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml       |  0
 .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml |  0
 .gitlab-ci.yml                                     | 67 +++++++++++++++-------
 MAINTAINERS                                        |  5 +-
 linux-user/elfload.c                               |  2 +
 5 files changed, 51 insertions(+), 23 deletions(-)
 rename .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml (100%)
 rename .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml (100%)


