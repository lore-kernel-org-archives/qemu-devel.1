Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2C3C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB3C20872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RU6Vc08a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB3C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJKmF-00019h-5s
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJKkm-0000Gy-Cr
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJKkk-0002m4-Gs
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600452297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IDTa4LSC/EHTg5Z4A9WhBqpxbU3BxD/R33sML67IkCc=;
 b=RU6Vc08aLsvCnmrcbi9PYzIG23gu7pdKSD35WMyhsUhyXHDUNa9s1RszZh17peEGiXxa23
 Cw6KXm5JaZAqGZrHILUtRQ0YAyiZeELnxzVqubgh3jrJlODYpN7d8d90zCLk2o0ZzLffmw
 wu1JkojzU5iDargFik4LoYs8C7Um5kA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-H0KyYIiPOA61ZRsttBJQxA-1; Fri, 18 Sep 2020 14:04:53 -0400
X-MC-Unique: H0KyYIiPOA61ZRsttBJQxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95CD356C35;
 Fri, 18 Sep 2020 18:04:52 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E7581002D61;
 Fri, 18 Sep 2020 18:04:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PULL 0/2] Python queue, 2020-09-18
Date: Fri, 18 Sep 2020 14:04:49 -0400
Message-Id: <20200918180451.1121055-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Leftovers from pre-5.1.0 days.=0D
=0D
The following changes since commit 053a4177817db307ec854356e95b5b350800a216=
:=0D
=0D
  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-20200918'=
 into staging (2020-09-18 16:34:26 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/python-next-pull-request=0D
=0D
for you to fetch changes up to 14f9cec7132bc60f9839048b0a0f8ef7ae9ed64c:=0D
=0D
  analyze-migration.py: fix read_migration_debug_json() return type (2020-0=
9-18 14:00:32 -0400)=0D
=0D
----------------------------------------------------------------=0D
Python queue, 2020-09-18=0D
=0D
Alexey Kirillov (1):=0D
      analyze-migration.py: fix read_migration_debug_json() return type=0D
=0D
Andrey Shinkevich (1):=0D
      scripts/simplebench: compare write request performance=0D
=0D
----------------------------------------------------------------=0D
=0D
Alexey Kirillov (1):=0D
  analyze-migration.py: fix read_migration_debug_json() return type=0D
=0D
Andrey Shinkevich (1):=0D
  scripts/simplebench: compare write request performance=0D
=0D
 scripts/analyze-migration.py           |   3 +-=0D
 scripts/simplebench/bench_write_req.py | 170 +++++++++++++++++++++++++=0D
 2 files changed, 172 insertions(+), 1 deletion(-)=0D
 create mode 100755 scripts/simplebench/bench_write_req.py=0D
=0D
--=20=0D
2.26.2=0D
=0D


