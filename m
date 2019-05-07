Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A8C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C26A20578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C26A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48207 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1dC-0005yE-Gz
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:03:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO1bS-0004qj-Ki
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO1bR-0002Pa-H5
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hO1bR-0002PE-BW
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:01:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D3132D7E4
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 15:01:56 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B8F55B0A5
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 15:01:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:01:48 -0500
Message-Id: <20190507150153.26859-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 07 May 2019 15:01:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/5] NBD patches for 2019-05-07
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 19eb2d4e736dc895f31fbd6b520e514f10cc08=
e0:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' in=
to staging (2019-05-07 10:43:32 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-05-07

for you to fetch changes up to 8fabb8be37775ebb32b0d78bc7be815a29b8a107:

  iotests: Make 182 do without device_add (2019-05-07 09:43:42 -0500)

----------------------------------------------------------------
nbd patches for 2019-05-07

- iotest improvements

----------------------------------------------------------------
Eric Blake (1):
      iotests: Tweak 221 sizing for different hole granularities

Max Reitz (3):
      qemu-nbd: Look up flag names in array
      iotests: Fix 233 for ports other than 10809
      iotests: Make 182 do without device_add

Thomas Huth (1):
      tests/qemu-iotests: Fix more reference output files due to recent q=
emu-io change

 include/block/nbd.h        | 38 ++++++++++++++++++--------
 qemu-nbd.c                 | 46 ++++++++++++-------------------
 tests/qemu-iotests/059.out |  8 +++---
 tests/qemu-iotests/083.out | 68 +++++++++++++++++++++++-----------------=
------
 tests/qemu-iotests/092.out | 24 ++++++++--------
 tests/qemu-iotests/182     | 22 +++++++++++----
 tests/qemu-iotests/182.out |  1 +
 tests/qemu-iotests/221     | 10 +++----
 tests/qemu-iotests/221.out | 20 +++++++-------
 tests/qemu-iotests/233     |  6 ++--
 tests/qemu-iotests/233.out |  4 +--
 11 files changed, 132 insertions(+), 115 deletions(-)

--=20
2.20.1


