Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974BEC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC54B2076E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvSb8hUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC54B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQwZm-0000su-Qm
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQwYJ-00080R-AG
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQwYG-0007IF-SU
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602265891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QBwbGCF6dRWsU8TAcObm3soBcExKpet9UXNMCtywKFQ=;
 b=fvSb8hUc8IoSNPoogxPfg8JtYdP9ABVQTue82/FkDx8EWb6ed8Lje7gk5WdqK2dQCceYIl
 777d+baSKjRYkIshscEGaOoqywOh4wQHcGph0hVbeetf8zSHMX19yGXyIARsv9toV8xkKs
 nr+m9CeFXK6xRqCqR1P687PVPOWSoOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-zO6wQ_HVMzqnilq0uGzMGg-1; Fri, 09 Oct 2020 13:51:28 -0400
X-MC-Unique: zO6wQ_HVMzqnilq0uGzMGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A85E0801FDD
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 17:51:27 +0000 (UTC)
Received: from scv.redhat.com (ovpn-112-203.rdu2.redhat.com [10.10.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B21C67664F;
 Fri,  9 Oct 2020 17:51:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] python/qemu: strictly typed mypy conversion, pt3
Date: Fri,  9 Oct 2020 13:51:20 -0400
Message-Id: <20201009175123.249009-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is actually quite short; it's already fully typed. Attached are two=0D
fixes for settimeout and error handling. There are actually more fixes=0D
that need to be made here, because use of readline() in non-blocking=0D
mode is actually undefined behavior, so a more thorough re-work of the=0D
error classes used by this library must be put on hold pending a more=0D
aggressive re-write.=0D
=0D
That's a problem for later, so for now, call the initial conversion to=0D
the statically typed subset of python done so we can move on to adding=0D
the regression tests that will maintain this baseline for us.=0D
=0D
John Snow (3):=0D
  python: add mypy config=0D
  python/qemu/qmp.py: re-raise OSError when encountered=0D
  python/qemu/qmp.py: Fix settimeout operation=0D
=0D
 python/mypy.ini    |  4 ++++=0D
 python/qemu/qmp.py | 30 +++++++++++++++++++++---------=0D
 2 files changed, 25 insertions(+), 9 deletions(-)=0D
 create mode 100644 python/mypy.ini=0D
=0D
--=20=0D
2.26.2=0D
=0D


