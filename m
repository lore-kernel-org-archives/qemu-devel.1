Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24760C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FCA2147A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FCA2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGYW-0006TC-5U
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40119)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hdFIA-0004BH-8h
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hdFI3-0001iM-Ea
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:40:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hdFHz-0001Ot-3D
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:40:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE8FA75721;
 Tue, 18 Jun 2019 14:40:18 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CCD87BE64;
 Tue, 18 Jun 2019 14:40:14 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Date: Tue, 18 Jun 2019 11:40:11 -0300
Message-Id: <20190618144013.6537-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 18 Jun 2019 14:40:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/2] Python queue, 2019-06-18
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit cdfaa2720f4a09e5254868bd1f6e33f3e9eae7=
6f:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2019-06-=
17-v2' into staging (2019-06-18 10:47:00 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to c21f30ebc779cd4210b488dd702b3f8653aee82b:

  Travis: print acceptance tests logs in case of job failure (2019-06-18 =
11:15:08 -0300)

----------------------------------------------------------------
Python queue, 2019-06-18

Use a different method to dump avocado job log, to work around
timing-dependent issues in the arm test cases.

----------------------------------------------------------------

Cleber Rosa (1):
  Travis: print acceptance tests logs in case of job failure

Eduardo Habkost (1):
  Revert "travis: Make check-acceptance job more verbose"

 .travis.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--=20
2.18.0.rc1.1.g3f1ff2140


