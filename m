Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC893C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6198D20BED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0WDJwQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6198D20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKPzq-0003ee-7I
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKPql-0001Ps-9j
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKPqj-0000SO-Hr
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600710216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=yQI49b5LN7qhGwj3PD3df4ITi/yxuq8O1WjK9ROGQkU=;
 b=O0WDJwQu83w9kI2/nf8id5QJra41rJxUpRCPjisg7n50eAXnf6HFh2eSIfWuVBrDykuz9y
 EvwLbypnsRsu2uQvM+WldsPdL1/m+QMh6fnd7ZVYdki8EYJDBgZadYjxLqFEO43suK8cAK
 Cnk+ITU6J/eKAgKjnWNXbDvVk1iRDZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-k7vHoF-SMt6YtEM8wx6Fgw-1; Mon, 21 Sep 2020 13:43:34 -0400
X-MC-Unique: k7vHoF-SMt6YtEM8wx6Fgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64EC818BA280;
 Mon, 21 Sep 2020 17:43:33 +0000 (UTC)
Received: from thuth.com (ovpn-112-14.ams2.redhat.com [10.36.112.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 021335D9CD;
 Mon, 21 Sep 2020 17:43:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/7] Do not support Debian 9 and Python 3.5 anymore
Date: Mon, 21 Sep 2020 19:43:13 +0200
Message-Id: <20200921174320.46062-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Debian 9 is EOL now, and according to our support policy, we do not
support it anymore. Let's switch the corresponding CI builds to
either Fedora (for a more recent version of the MinGW compilers) or
Debian 10 instead.

Together with the Travis patch series that I recently posted ("Update
Travis from Xenial to Bionic and Focal"), our CI should now be free of
distros that we do not support anymore. And all supported build systems
now use at least Python 3.6, so we can drop the support for Python 3.5.

Based-on: <20200918103430.297167-1-thuth@redhat.com>

Thomas Huth (7):
  tests/docker: Use Fedora containers for MinGW cross-builds in the
    gitlab-CI
  gitlab-ci: Remove the Debian9-based containers and containers-layer3
  tests/docker: Update the tricore container to debian 10
  shippable.yml: Remove the Debian9-based MinGW cross-compiler tests
  tests/docker: Remove old Debian 9 containers
  gitlab-ci: Increase the timeout for the cross-compiler builds
  configure: Bump the minimum required Python version to 3.6

 .gitlab-ci.d/containers.yml                   | 38 +++++-----------
 .gitlab-ci.d/crossbuilds.yml                  |  5 ++-
 .gitlab-ci.yml                                |  1 -
 .shippable.yml                                |  4 --
 configure                                     |  4 +-
 tests/docker/Makefile.include                 |  2 +-
 .../dockerfiles/debian-tricore-cross.docker   |  2 +-
 .../dockerfiles/debian-win32-cross.docker     | 38 ----------------
 .../dockerfiles/debian-win64-cross.docker     | 45 -------------------
 tests/docker/dockerfiles/debian9-mxe.docker   | 21 ---------
 tests/docker/dockerfiles/debian9.docker       | 32 -------------
 .../dockerfiles/fedora-win32-cross.docker     | 42 +++++++++++++++++
 .../dockerfiles/fedora-win64-cross.docker     | 38 ++++++++++++++++
 13 files changed, 98 insertions(+), 174 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-win32-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-win64-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian9-mxe.docker
 delete mode 100644 tests/docker/dockerfiles/debian9.docker
 create mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker
 create mode 100644 tests/docker/dockerfiles/fedora-win64-cross.docker

-- 
2.18.2


