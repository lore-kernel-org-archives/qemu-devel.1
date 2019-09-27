Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC60BC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9128D217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9128D217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDqUE-0003Oq-KU
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 09:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iDpvL-0005gQ-M0
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iDpvI-0004PS-NE
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:04:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64443)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iDpvH-0004P2-0F
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:04:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7FE4F8A2195
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:59:29 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1921608C2;
 Fri, 27 Sep 2019 09:59:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] Qcrypto next patches
Date: Fri, 27 Sep 2019 10:59:15 +0100
Message-Id: <20190927095926.22230-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 27 Sep 2019 09:59:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d4e536f336d3d26c9fafa2a2549aaa0b014f5b=
6b:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-09-24-v2=
' into staging (2019-09-26 10:13:39 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/qcrypto-next-pull-request

for you to fetch changes up to befdba9edd20a896f4082adf6dfb613939a24e0c:

  qcrypto-luks: more rigorous header checking (2019-09-26 16:34:02 +0100)

----------------------------------------------------------------
Refactoring of LUKS support to facilitate keyslot updates

No current functional change is expected with this series.

----------------------------------------------------------------

Maxim Levitsky (11):
  qcrypto-luks: rename some fields in QCryptoBlockLUKSHeader
  qcrypto-luks: don't overwrite cipher_mode in header
  qcrypto-luks: simplify masterkey and masterkey length
  qcrypto-luks: pass keyslot index rather that pointer to the keyslot
  qcrypto-luks: use the parsed encryption settings in QCryptoBlockLUKS
  qcrypto-luks: purge unused error codes from open callback
  qcrypto-luks: extract store and load header
  qcrypto-luks: extract check and parse header
  qcrypto-luks: extract store key function
  qcrypto-luks: simplify the math used for keyslot locations
  qcrypto-luks: more rigorous header checking

 crypto/block-luks.c | 1025 +++++++++++++++++++++++++------------------
 1 file changed, 592 insertions(+), 433 deletions(-)

--=20
2.21.0


