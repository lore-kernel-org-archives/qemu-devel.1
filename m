Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C68CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC50206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7dorztg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC50206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc364-0006yi-Sl
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc34G-00056Y-R7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:02:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc34E-0004Z9-Ju
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604912545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=otUObEwrxLHTIbCIaqTfPldeg5eM1iMn0UZOGd82ogc=;
 b=h7dorztgraJyhZw/M16udcy2/mnyHkD3lxWSebAYXocJ4sdsgZ89RSqo8OeQ5JJypRmvHQ
 +sWEdgaflH+aGUowhBuqKvwe+RmrWaHRSmlmVl0yC+hQAo6wUUdkcgKU4OqbY3aX6yZRE2
 2QyfY0Q9zlVQj3Iq6g+OJShzDv8BdAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-xPn9X4PQMDeSnWJBiSWQQA-1; Mon, 09 Nov 2020 04:02:23 -0500
X-MC-Unique: xPn9X4PQMDeSnWJBiSWQQA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51D101868410;
 Mon,  9 Nov 2020 09:02:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 227851002C18;
 Mon,  9 Nov 2020 09:02:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B81B41132BD6; Mon,  9 Nov 2020 10:02:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] QAPI patches patches for 2020-11-09
Date: Mon,  9 Nov 2020 10:02:15 +0100
Message-Id: <20201109090220.825764-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3493c36f0371777c62d1d72b205b0eb6117e2156:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201106' into staging (2020-11-06 13:43:28 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-11-09

for you to fetch changes up to 143d51e1792ecf2c8e5b0fc3a8c6022676c723d4:

  block: Remove unused BlockDeviceMapEntry (2020-11-09 09:14:21 +0100)

----------------------------------------------------------------
QAPI patches patches for 2020-11-09

----------------------------------------------------------------
Markus Armbruster (4):
      docs/devel/qapi-code-gen: Fix up examples
      MAINTAINERS: Add QAPI schema modules to their subsystems
      qapi: Fix missing headers in QMP Reference Manual
      block: Remove unused BlockDeviceMapEntry

Max Reitz (1):
      qapi/block-core: Improve MapEntry documentation

 docs/devel/qapi-code-gen.txt |  6 ++++--
 qapi/audio.json              |  4 ++++
 qapi/authz.json              |  6 ++++--
 qapi/block-core.json         | 47 ++++++++++++--------------------------------
 MAINTAINERS                  |  6 ++++++
 5 files changed, 31 insertions(+), 38 deletions(-)

-- 
2.26.2


