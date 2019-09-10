Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54643C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20AF62081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dMCW4csP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AF62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dEg-0004Dt-PG
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i7dAs-0001pP-Qr
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i7dAr-0005Lx-PA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:15:02 -0400
Received: from mout.web.de ([217.72.192.78]:48455)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i7dAr-0005Kt-D8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568110472;
 bh=B6vK/wb54ShVskmPEM0whV2vUYdLV0tePfc8emFT37g=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=dMCW4csPXICtvl2g7dcbi5Ld2Vl3m5QTeE27XLVmAWJKYoCU3el3GFds2oMAwCJ9l
 iNijxBFMSAhdyD7tl9G2HBmtXzEXsRowkWF9me3bJxqNYVHTcoTu578J4GbDTapq2Q
 dO/sS9yJOoRvP02a7icgAPqmDhY4Lj/+ABE69AmA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.217]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LrJse-1iHZJc1BiW-0132oN; Tue, 10
 Sep 2019 12:14:32 +0200
Date: Tue, 10 Sep 2019 12:14:29 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <cover.1568110100.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dFN37VIRNm4/7+dtnNHg9VjYU8CGUvJxdf29WtOEn8wE43PKvLa
 ABIadc+S+okURfoqfEyuj9YCCiYR2/a/D5XOAovpR540mhtx2x4uOFaEsici2hhaRwwUf3J
 nmFv5+IfjNIMhuoDdCovD7DgM68S2nCz2eOqL3XfxTwzXSXusidGXlOlNI5vfdLGuK8Az7Y
 ucm5E8fuKu1v01bvwwI3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tZO3Y76WeMc=:R3TkzY9FqXrLS2BmmZQSuH
 2aa/Wdhk28O0+LFU4HTI+86Ga5fd5cDcUK4yNnL261fHh1EPNUdOxZszJfHdeGoesSYYDauc2
 Ar5rnCMHdPCXRdS/zgPxS7H1NddAaiVjYR0g5o36i3WjD0KNDho+TEv7jHZQtGpzzH8yAgZXv
 MASHO9qErXjzCoks2Yf+o3JOnhaYzDxuSGEtfIyYya5N5CQi81acT94brOTKR8H0GSK1ADQPj
 2vTpLwCr5USkxx9V262GzxFQAMnwObw9CEu7YDlLMfWimrYlhJWjPRY73D5OrkgpEi1csrojQ
 xIfXy/zahZJls6axc3TVTUogXE4+tEwRt5/kphcjNh55oBtSMRzOthVL3RzL1n/F+flRQsSEs
 /CWmgdQxnikXUqTCXjeX83NW7qOimGBw9/z43ZFwKXw2xK4tFXF/ljsfC+tC7/D8BsUcOYShE
 XmqJutPpGw8ZcJ+tbespwNvhHVsIjo9tHTXtzofX8jD28L3O0BPWQVXKrr/ZUEj2D8Ucszh2w
 zoEc9AHMnDEOwle2AN4t+XwAHO+qdATgGwsnCcYOMsvBX5wArbCIv2VOQa+pYw/IdkDAvP3MD
 lSan+LZlorL7Iw2ClTwOpPAykHF/C9XELqVr5M9A96dbknYUu0N56SJ/F+hNbRKM7QM47517p
 qIbSNaicJ2DlIPtB2eGXX/K4nJsD08LQEu3ACZlJkBA8xgvD5WU9hduN3Mqcz3hh/dN7rCVh/
 4un88piuWihnDTP3nuvbRb+diDxvfL6VGoXc9H38yjC5VANAJQK6AjlSQaRQJkUToAMKUgb/p
 HuJDY3WUj5B6Ip01mBnU3nnM34Psi+sLBsBjs9O+xOzwd7dH5wvsXNxe7eveb4oJ+GF3vylpX
 ju5qsOFVD7hH2Xpg1TGeI9CL4AdjswmIK4UoA4CGM1aInkUNhIPjFQS1Te8aBJKbVy7BWNqTE
 1+H6/gLIly6imS/pnvrUILbyBznAN3BLeFFEvdZk5nCVmJ/RNRiENXbfXEiDJEQ99MsPJfoHq
 i0Q+l4wJF51gU82LWzZY9Js9l7elf9f+dW9SkotMa1+8Ha2/YjDZ/lKS+OxvI7KisoFmhoWKC
 W9naWqYEvXv0DQRdf3RumUU5SBJERTz685Mxmz3HWn9KKGTAmrtBoCKrHLJgX/vnakDIrJUU5
 KQchOUniN5OyrqHCUHztkBUDflf+coPfP09Kp+q7enjn5Nb6+8ovT3A+0rzlQmefDaRYyg2Xo
 78d++6ksL/IoqCe/b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.78
Subject: [Qemu-devel] [PATCH v4 0/4] colo: Add support for continious
 replication
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
Cc: kwolf@redhat.com, Wen Congyang <wencongyang2@huawei.com>,
 Jason Wang <jasowang@redhat.com>, mreitz@redhat.com,
 Zhang Chen <chen.zhang@intel.com>, Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Everyone,
These Patches add support for continious replication to colo. This means
that after the Primary fails and the Secondary did a failover, the Seconda=
ry
can then become Primary and resume replication to a new Secondary.

On a side note, I wrote a Pacemaker Resource Agent for colo which I will
post when its ready.
I have to say it's quite fun to randomly kill a Node, wait for resync
and repeat and see how the VM stays alive all the time. :)

Regards,
Lukas Straub

v4:
 - fix checkpatch.pl warnings

v3:
 - add test for replication changes
 - check if the filter to be inserted before/behind belongs to the same in=
terface
 - fix the error message for the position=3D parameter
 - rename term "after" -> "behind" and variable "insert_before" -> "insert=
_before_flag"
 - document the quorum node on the secondary side
 - simplify quorum parameters in documentation
 - remove trailing spaces in documentation
 - clarify the testing procedure in documentation

v2:
 - fix email formating
 - fix checkpatch.pl warnings
 - fix patchew error
 - clearer commit messages

Lukas Straub (4):
  block/replication.c: Ignore requests after failover
  tests/test-replication.c: Add test for ignoring requests after
    failover
  net/filter.c: Add Options to insert filters anywhere in the filter
    list
  colo: Update Documentation for continious replication

 block/replication.c        |  38 ++++++-
 docs/COLO-FT.txt           | 212 +++++++++++++++++++++++++++----------
 docs/block-replication.txt |  26 +++--
 include/net/filter.h       |   2 +
 net/filter.c               |  78 +++++++++++++-
 qemu-options.hx            |  10 +-
 tests/test-replication.c   |  52 +++++++++
 7 files changed, 343 insertions(+), 75 deletions(-)

=2D-
2.20.1

