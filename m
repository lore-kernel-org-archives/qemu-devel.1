Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E581C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECDF206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fO7X1Duc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECDF206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTeB-0000FH-IY
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jCTdH-0005aY-BF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jCTdF-0007kG-SC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:36:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35002
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jCTdF-0007jk-Oc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584041796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SvS7mG9VoTZ0ILTDjOWZzFzXTbYBHpAXxDBP5Q5DdXM=;
 b=fO7X1DuclgnNf4or9jN/ljyqapFMbVN7fXUayX2Xf1eop/WQ5txlnwkU5Ufy2Q3QyHnU/s
 NVM9NTj6HY112caQmTxFjYGUjwO7o20gNbcRTkrsKZcieUqP8GroRNLobkLHeGfF+jNt90
 X5DLYydaLM3dbQINVCXQj/9HdWpIHrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-p4GPEt3aPu2TBGWdCqp0YA-1; Thu, 12 Mar 2020 15:36:33 -0400
X-MC-Unique: p4GPEt3aPu2TBGWdCqp0YA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB6901005509;
 Thu, 12 Mar 2020 19:36:31 +0000 (UTC)
Received: from dhcp-17-173.bos.redhat.com (dhcp-17-173.bos.redhat.com
 [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EFDB5C1D4;
 Thu, 12 Mar 2020 19:36:17 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH 0/5] QEMU Gating CI
Date: Thu, 12 Mar 2020 15:36:11 -0400
Message-Id: <20200312193616.438922-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The idea about a public facing Gating CI for QEMU was lastly
summarized in an RFC[1].  Since then, it was decided that a
simpler version should be attempted first.

Changes from the RFC patches[2] accompanying the RFC document:

- Moved gating job definitions to .gitlab-ci-gating.yml
- Added info on "--disable-libssh" build option requirement
  (https://bugs.launchpad.net/qemu/+bug/1838763) to Ubuntu 18.04 jobs
- Added info on "--disable-glusterfs" build option requirement
  (there's no static version of those libs in distro supplied
  packages) to one
- Dropped ubuntu-18.04.3-x86_64-notools job definition, because it
  doesn't fall into the general scope of gating job described by PMM
  (and it did not run any test)
- Added w32 and w64 cross builds based on Fedora 30
- Added a FreeBSD based job that builds all targets and runs `make
  check`
- Added "-j`nproc`" and "-j`sysctl -n hw.ncpu`" options to make as a
  simple but effective way of speeding up the builds and tests by
  using a number of make jobs matching the number of CPUs
- Because the Ansible playbooks reference the content on Dockerfiles,
  some fixes to some Dockerfiles caught in the process were included
- New patch with script to check or wait on a pipeline execution

[1] - https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg00231.html
[2] - https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00154.html

Cleber Rosa (5):
  tests/docker: add CentOS 8 Dockerfile
  tests/docker: make "buildah bud" output similar to "docker build"
  GitLab CI: avoid calling before_scripts on unintended jobs
  GitLab Gating CI: introduce pipeline-status contrib script
  GitLab Gating CI: initial set of jobs, documentation and scripts

 .gitlab-ci-gating.yml                         | 111 ++++++++++
 .gitlab-ci.yml                                |  32 ++-
 contrib/ci/orgs/qemu/build-environment.yml    | 208 ++++++++++++++++++
 contrib/ci/orgs/qemu/gitlab-runner.yml        |  65 ++++++
 contrib/ci/orgs/qemu/inventory                |   2 +
 contrib/ci/orgs/qemu/vars.yml                 |  13 ++
 contrib/ci/scripts/gitlab-pipeline-status     | 148 +++++++++++++
 docs/devel/testing.rst                        | 142 ++++++++++++
 tests/docker/dockerfiles/centos8.docker       |  32 +++
 .../dockerfiles/debian-win32-cross.docker     |   2 +-
 10 files changed, 751 insertions(+), 4 deletions(-)
 create mode 100644 .gitlab-ci-gating.yml
 create mode 100644 contrib/ci/orgs/qemu/build-environment.yml
 create mode 100644 contrib/ci/orgs/qemu/gitlab-runner.yml
 create mode 100644 contrib/ci/orgs/qemu/inventory
 create mode 100644 contrib/ci/orgs/qemu/vars.yml
 create mode 100755 contrib/ci/scripts/gitlab-pipeline-status
 create mode 100644 tests/docker/dockerfiles/centos8.docker

--=20
2.24.1


