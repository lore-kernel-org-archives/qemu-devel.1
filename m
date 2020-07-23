Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25072C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57692086A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0IEria6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57692086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyaM9-0000tl-8i
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jyaKc-0007Rx-HD
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:28:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51152
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jyaKa-0003Ks-V9
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595507291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=7bAl/k/Tjh+juBipVsB/Zta8W0heNbnDknIaAXLxoe0=;
 b=Y0IEria66+AicB+NoCVHUdN0w8c2DisG/ElOaBP0CJfv5Wv3TmrkymOmR4/yRlp9BH+jMw
 BvpaarWOj7LOVBW1yKuRmQiAptWAs/291LrgVi6/5j3JcZZnfjpYgSAZvQ6nXh6eu+kcS0
 R8wEuBdvNy6e9iUGG6mWYroSI9gH0RQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-oKgBJBxgNY6faIz-P4HOlA-1; Thu, 23 Jul 2020 08:28:10 -0400
X-MC-Unique: oKgBJBxgNY6faIz-P4HOlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 278378005B0;
 Thu, 23 Jul 2020 12:28:08 +0000 (UTC)
Received: from thuth.com (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96AD574F58;
 Thu, 23 Jul 2020 12:28:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/4] Test more in less time in the Gitlab-CI
Date: Thu, 23 Jul 2020 14:27:56 +0200
Message-Id: <20200723122800.723-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds two new "build-system" pipelines to the Gitlab-CI,
one based on Debian and one on CentOS. We then use these build pipelines
to test the targets that were missing so far (e.g. the two new targets
rx-softmmu and avr-softmmu), and move some of the targets from the other
build-system pipelines here, too, so that the total testing time gets
shorter (at least 5 minutes from what I've seen so far).

Thomas Huth (4):
  tests/docker: Add python3-venv and netcat to the debian-amd64
    container
  iotests: Select a default machine for the rx and avr targets
  tests/acceptance: Disable the rx sash and arm cubieboard replay test
    on Gitlab
  gitlab-ci.yml: Add build-system-debian and build-system-centos jobs

 .gitlab-ci.yml                               | 88 ++++++++++++++++----
 tests/acceptance/machine_rx_gdbsim.py        |  4 +
 tests/acceptance/replay_kernel.py            |  1 +
 tests/docker/dockerfiles/debian-amd64.docker |  4 +-
 tests/qemu-iotests/check                     | 14 ++--
 5 files changed, 90 insertions(+), 21 deletions(-)

-- 
2.18.1


