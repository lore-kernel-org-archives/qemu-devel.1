Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C11C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A94C2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2EMnle8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A94C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYzEn-0005Ms-C7
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 17:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYz8P-00076F-Ai
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:41:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYz8N-0005d0-CV
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589406106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oSlb2jaEmHwuQ9ohjRY7zhBH5rgwjx/81mClC66MFYU=;
 b=P2EMnle8sQX0X1XYyR8QszB7KKyNRNGCCXrbfF+JHnxXRgtrxlote3v56bMarCrSWXmqHH
 SMOlARZXN04RPLMpQ+y57YeXIdCYKV0Hw7fPGGZiUV/qDdO5yJv54AxQp7tIi/qeNGgvML
 AcrUld1cOaaGbD1iGjNRYJ6O7xOXCl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-GMYZdX0KPCm7mLI56QxXMQ-1; Wed, 13 May 2020 17:41:33 -0400
X-MC-Unique: GMYZdX0KPCm7mLI56QxXMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08C6B8015CF;
 Wed, 13 May 2020 21:41:32 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-80.rdu2.redhat.com [10.10.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E45B41C94D;
 Wed, 13 May 2020 21:41:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC WIP 0/6] iotests: delinting work-in-progress
Date: Wed, 13 May 2020 17:41:24 -0400
Message-Id: <20200513214130.15375-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I ran out of time, but I was briefly entertaining the idea of hitting
everything else in the iotests folder with the pylint and mypy beam.

This is just a draft of what I had at the time, in case someone gets
around to it before I do.

I forced all of the python scripts in this directory to Python3 and pass
the formatter check imposed by the pylintrc that we make iotests.py
adhere to, but there's no guarantee these scripts actually work. I was a
little rough around the edges.

qed.py and qcow2.py in particular abuse some python features that pylint
really doesn't like to see at all, and forcing these to pass a pylint
check was clearly fighting against the idioms in-use in those files,
with more than a few unsatisfactory hacks employed just to make pylint
shut up. They are not necessarily improvements to those scripts.

I created a Makefile check to hit the iotests themselves with the pylint
checker so we can identify when refactors to the testing infrastructure
invalidate tests we don't get to run that often; but didn't get around
to improving the quality of the tests themselves.

(Whether or not this is even worth our time is debatable, it depends on
how much effort it would take to bring them up to par. Maybe it's a lot,
I don't know.)

--js

John Snow (6):
  iotests: type hint wip
  Makefile: add delint WIP
  nbd-fault-injector: delint
  qed.py: delint
  qcow2.py: delint
  WIP: delint test files

 tests/qemu-iotests/Makefile              |   6 +
 tests/qemu-iotests/iotests.py            |  28 ++--
 tests/qemu-iotests/nbd-fault-injector.py |  34 +++--
 tests/qemu-iotests/pylintrc              |   1 +
 tests/qemu-iotests/qcow2.py              | 156 +++++++++++++++--------
 tests/qemu-iotests/qed.py                |  46 ++++---
 6 files changed, 173 insertions(+), 98 deletions(-)

-- 
2.21.1


