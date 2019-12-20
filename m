Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E06C2D0D2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B426D20716
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fv4qTB5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B426D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59007 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLWh-00075R-MU
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iiLVL-0005g5-H2
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iiLVK-0005Re-FV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:51:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60907
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iiLVK-0005Qo-C9
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576860713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BIW2ofsh+9yupKvIEl6YUdx4NiYu0P/YW5UE9eORwrw=;
 b=Fv4qTB5enUQ/W3XzFl0P3CvuXetx1kxCoY66BUav/78ELpAYrgBXVEkqzjZxIGnDjxi7l3
 PA/nta/0knyOnuRnNaEV8737+fnxECQwSA7WWgRo3yyMVOFI6AEOLKKYkiFU9nDjtsU1Rw
 1ij5fcAKNIcy7qzao5ljyg8K1GaTbuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-U_vBHCgLPqqgO-O7kSeLiA-1; Fri, 20 Dec 2019 11:51:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1557B800D48;
 Fri, 20 Dec 2019 16:51:47 +0000 (UTC)
Received: from localhost (ovpn-116-10.gru2.redhat.com [10.97.116.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3D975F77C;
 Fri, 20 Dec 2019 16:51:43 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/2] Require Python >= 3.5 to build QEMU
Date: Fri, 20 Dec 2019 13:51:39 -0300
Message-Id: <20191220165141.2207058-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: U_vBHCgLPqqgO-O7kSeLiA-1
X-Mimecast-Spam-Score: 0
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Differences from the previous Python 3.5 pull request
that was rejected:

* Now tests/vm/netbsd was fixed
* .travis.yml is being updated to replace Python 3.4 job with 3.5

The following changes since commit f59b31e6d0c69792b5d817c5aa0a6ed64fba42e0=
:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-tesing-and-misc-1=
91219-1' into staging (2019-12-20 14:00:49 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to ddf90699631db53c981b6a5a63d31c08e0eaeec7:

  configure: Require Python >=3D 3.5 (2019-12-20 13:45:59 -0300)

----------------------------------------------------------------
Require Python >=3D 3.5 to build QEMU

Python 2 EOL is 11 days away, we will stop supporting
it in QEMU 5.0.

----------------------------------------------------------------

Eduardo Habkost (2):
  travis: Replace Python 3.4 build with 3.5
  configure: Require Python >=3D 3.5

 .travis.yml            |  2 +-
 configure              | 18 ++++--------------
 tests/Makefile.include |  5 -----
 3 files changed, 5 insertions(+), 20 deletions(-)

--=20
2.23.0


