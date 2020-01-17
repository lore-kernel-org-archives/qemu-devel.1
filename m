Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B1C33CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F9120730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9XPVhlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F9120730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPV5-0007pd-JS
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1isPU3-0006dZ-ID
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1isPU0-0003i6-1j
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:08:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25735
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1isPTz-0003hd-Uy
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579259287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EwW85shZBDFu8te/4jdwgBFzFv7RBdJkoBQPunQhVVg=;
 b=H9XPVhlP79ZMecJ4Vr49F+H8jVk+MXMcjoRrGMlDwo6ij827SajutDUmKJznRuckrubVPh
 r6JeffQt8FJUeaPnZMk9HLCYu/C3lu61+tOgcKdgxdQWktQ1KvDfmrW3DFdBffB9L2dccm
 vKrWBUys+WTnWq8IrJVFW3Gq5ntdCg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-uzm9jq8tPAWggqX53jMiTw-1; Fri, 17 Jan 2020 06:08:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A086100550E;
 Fri, 17 Jan 2020 11:08:02 +0000 (UTC)
Received: from thuth.com (ovpn-116-212.ams2.redhat.com [10.36.116.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D60860F82;
 Fri, 17 Jan 2020 11:08:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/4] qtests and gitlab-CI
Date: Fri, 17 Jan 2020 12:07:54 +0100
Message-Id: <20200117110758.1995-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uzm9jq8tPAWggqX53jMiTw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit fee0ec1fd11a6fb960517e18201ed8a686a0d7e8=
:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' i=
nto staging (2020-01-14 14:11:34 +0000)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-01-17

for you to fetch changes up to c82b95489f8c33318101d18e643f7b50259d8e4e:

  gitlab-ci.yml: Run tcg test with tci (2020-01-16 17:01:39 +0100)

----------------------------------------------------------------
* Various fixes for qtests
* Enable TCG tests with TCI in the gitlab CI
----------------------------------------------------------------

Laurent Vivier (1):
      migration-test: ppc64: fix FORTH test program

Shameer Kolothum (1):
      tests: acpi: update path in rebuild-expected-aml

Thomas Huth (2):
      tests/qtest/vhost-user-test: Fix memory leaks
      gitlab-ci.yml: Run tcg test with tci

 .gitlab-ci.yml                          |  1 +
 tests/data/acpi/rebuild-expected-aml.sh |  6 +++---
 tests/qtest/migration-test.c            |  4 ++--
 tests/qtest/vhost-user-test.c           | 11 ++++++++---
 4 files changed, 14 insertions(+), 8 deletions(-)


