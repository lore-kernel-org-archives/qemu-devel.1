Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39689C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D40207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEEKd3ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D40207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeQvs-0002UT-To
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jeQu9-0000LO-HK
 for qemu-devel@nongnu.org; Thu, 28 May 2020 18:21:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53104
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jeQu7-0004fy-Uo
 for qemu-devel@nongnu.org; Thu, 28 May 2020 18:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590704493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1dwXqei3FbPvf+eQsWAP8NdYrU9hcPq14hfaB/uQXMU=;
 b=KEEKd3exOVELs3OwMuSFDjBghqTbkhziZduCtsdQDKJKHM48Q2JhQhtOYUzAbXTzbvbMkB
 T4u+xn0t856WtxomH3uZyNbVI0q1tf03n0qG9mJt2/YinxrQq6mnK9lJjV2jD97dOqS2WC
 rZC9OS3Appyg8FgmkYxHcAycAl9+VEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-jIENEA-FP4SLm2A0NeagJw-1; Thu, 28 May 2020 18:21:32 -0400
X-MC-Unique: jIENEA-FP4SLm2A0NeagJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D301107ACCA
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 22:21:31 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E3B35D9CD;
 Thu, 28 May 2020 22:21:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] python: pylint and flake8 support
Date: Thu, 28 May 2020 18:21:25 -0400
Message-Id: <20200528222129.23826-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 17:57:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a quick series to delint the files under python/qemu, with one
extra fix outside of that domain.

This was split out from my longer series attempting to package
python/qemu. This part is a nice standalone chunk.

John Snow (4):
  scripts/qmp: Fix shebang and imports
  python/machine.py: remove bare except
  python/qemu: delint and add pylintrc
  python/qemu: delint; add flake8 config

 python/qemu/.flake8    |  2 ++
 python/qemu/accel.py   |  9 ++++---
 python/qemu/machine.py | 52 +++++++++++++++++++++++--------------
 python/qemu/pylintrc   | 58 ++++++++++++++++++++++++++++++++++++++++++
 python/qemu/qmp.py     |  4 +--
 python/qemu/qtest.py   | 42 +++++++++++++++++++-----------
 scripts/qmp/qmp        |  4 ++-
 scripts/qmp/qom-fuse   |  4 ++-
 scripts/qmp/qom-get    |  6 +++--
 scripts/qmp/qom-list   |  6 +++--
 scripts/qmp/qom-set    |  6 +++--
 scripts/qmp/qom-tree   |  6 +++--
 12 files changed, 150 insertions(+), 49 deletions(-)
 create mode 100644 python/qemu/.flake8
 create mode 100644 python/qemu/pylintrc

-- 
2.21.3


