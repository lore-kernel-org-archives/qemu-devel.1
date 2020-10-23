Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C96C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F5E20936
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7xYeyyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F5E20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVrbo-00011H-9T
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 03:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVraQ-00080K-8O
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVraO-0003VL-QP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603438444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=F0g5Ej4jpuVTdYwq9ik3qIUoSjjMofVXl5UNallKAYA=;
 b=V7xYeyyc3Y0w9lngrhZJiu1nYroZOl3LGLVSDYQ6F/S69TIKCNjDjUHSjHeWO9PxF1aUCF
 c8ahURAXQSGNylsSbj3H9uR0DnXGDcH+76asnamFqU57QpJ4ItaKFZwQQjBJ0ad5bp2N3O
 wbo9tYUKGzBZ8PpnzcD+ViS3+/yQ1f0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449--ptCja7fPca_-WFWo2JB9g-1; Fri, 23 Oct 2020 03:34:02 -0400
X-MC-Unique: -ptCja7fPca_-WFWo2JB9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA2978030DD;
 Fri, 23 Oct 2020 07:34:00 +0000 (UTC)
Received: from thuth.com (ovpn-112-123.ams2.redhat.com [10.36.112.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64D8555775;
 Fri, 23 Oct 2020 07:33:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH 0/4] Test more "check-acceptance" tests in the gitlab-CI
Date: Fri, 23 Oct 2020 09:33:47 +0200
Message-Id: <20201023073351.251332-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These patches enable more "check-acceptance" tests in the gitlab-CI,
fixing a broken URL, setting AVOCADO_ALLOW_UNTRUSTED_CODE and adding
some missing packages to the containers.

Thomas Huth (4):
  tests/acceptance/ppc_prep_40p: Fix the URL to the NetBSD-4.0 archive
  test/acceptance: Remove the CONTINUOUS_INTEGRATION tags
  tests/acceptance: Enable AVOCADO_ALLOW_UNTRUSTED_CODE in the gitlab-CI
  test/docker/dockerfiles: Add missing packages for acceptance tests

 .gitlab-ci.yml                               | 1 +
 tests/acceptance/ppc_prep_40p.py             | 4 +---
 tests/docker/dockerfiles/centos8.docker      | 1 +
 tests/docker/dockerfiles/debian-amd64.docker | 3 +++
 tests/docker/dockerfiles/fedora.docker       | 1 +
 tests/docker/dockerfiles/ubuntu2004.docker   | 1 +
 6 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.18.2


