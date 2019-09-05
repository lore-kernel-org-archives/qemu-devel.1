Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E072DC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864AD2070C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864AD2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5s8m-0006C2-Mr
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 09:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i5s4s-0004IL-ND
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i5s4r-00055T-2q
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:45:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i5s4q-000548-To
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:45:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 70109315C009;
 Thu,  5 Sep 2019 13:45:31 +0000 (UTC)
Received: from dhcp-17-64.lcy.redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DBEA5C258;
 Thu,  5 Sep 2019 13:45:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  5 Sep 2019 14:45:22 +0100
Message-Id: <20190905134526.32146-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 05 Sep 2019 13:45:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/4] Docs patches
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 500efcfcf0fe2e0dae1d25637a13435ce7b6e4=
21:

  Merge remote-tracking branch 'remotes/rth/tags/pull-or1k-20190904' into=
 staging (2019-09-05 09:33:01 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/docs-pull-request

for you to fetch changes up to 9f8efa74d3f1cb9ceeee957ee382c2b4feb2ae30:

  docs: split the CODING_STYLE doc into distinct groups (2019-09-05 14:41=
:00 +0100)

----------------------------------------------------------------

* Merges HACKING into CODING_STYLE
* Converts README and CODING_STYLE docs into RST syntax
* Documents use of auto cleanup functions

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (4):
  docs: convert README, CODING_STYLE and HACKING to RST syntax
  docs: merge HACKING.rst contents into CODING_STYLE.rst
  docs: document use of automatic cleanup functions in glib
  docs: split the CODING_STYLE doc into distinct groups

 CODING_STYLE          | 216 --------------
 CODING_STYLE.rst      | 641 ++++++++++++++++++++++++++++++++++++++++++
 HACKING               | 257 -----------------
 README =3D> README.rst  |  47 ++--
 scripts/checkpatch.pl |   2 +-
 5 files changed, 671 insertions(+), 492 deletions(-)
 delete mode 100644 CODING_STYLE
 create mode 100644 CODING_STYLE.rst
 delete mode 100644 HACKING
 rename README =3D> README.rst (84%)

--=20
2.21.0


