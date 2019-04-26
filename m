Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB88FC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 22:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4679D2084F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 22:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4679D2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK9Di-0001TO-Qp
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 18:21:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hK9Cx-0000uD-16
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 18:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hK9Cw-0005Qe-2r
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 18:20:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hK983-0000Sg-9S; Fri, 26 Apr 2019 18:15:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 753AC315D4B;
	Fri, 26 Apr 2019 22:15:32 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-206.bos.redhat.com [10.18.17.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2E6C3608AC;
	Fri, 26 Apr 2019 22:15:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 26 Apr 2019 18:15:26 -0400
Message-Id: <20190426221528.30293-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 26 Apr 2019 22:15:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/2] docs/interop/bitmaps: rewrite and
 modernize doc
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
Cc: Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, aliang@redhat.com,
	kchamart@redhat.com, armbru@redhat.com, qemu-stable@nongnu.org,
	nsoffer@redhat.com, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426221526.HpfSltPyWfSv_c5VboKJa4ZvIkU7Xoy_VgfApzmAlYI@z>

The documentation as written in the 4.0 release is not quite correct as
of the 4.0 release; though thanks to backwards compatibility it's not
quite wrong either. It is suitable for inclusion in 4.0.1, or any
downstream that packages 4.0.

This patch is an attempt at a nearly full rewrite that revitalizes this
document to address frequent questions I encounter when discussing the
API.

V3:
 - Added -W flag to patch 1/2
 - Addressed comments from Vladimir on patch 2/2.

V2:
  - Split off makefile change into its own little patch.

  - Addressed (almost) all comments from Vladimir.
    - Example styling was not reworked.
  - Renamed all filenames to be consistent throughout the document,
    fixing a few more file extensions in the process
  - Reflowed almost all paragraphs to 78 columns for consistency.
  - Changed a few bulleted lists to paragraphs instead
  - Changed the big ascii text diagram to a more compact version
    and clarified its language
  - While in general I prefer to use en_US spellings, I have
    replaced "canceled" with "cancelled" so it does not look
    out of place juxtaposed with BLOCK_JOB_CANCELLED...

Future work that remains to be done:

- Paying heed to blockdev-backup workflows
- Adding a small migration section explaining the options there
- Possibly reworking some of the sections that all make their own
  repeated attempts to clarify time interval discretization and adding
  a proper treatment of the idea start to finish; this may be neccessary
  to explain the two below items properly:
- Differential Backups
- Pull Backups and NBD

John Snow (2):
  Makefile: add nit-picky mode to sphinx-build
  docs/interop/bitmaps: rewrite and modernize doc

 docs/interop/bitmaps.rst | 1599 ++++++++++++++++++++++++++++++--------
 Makefile                 |    2 +-
 2 files changed, 1265 insertions(+), 336 deletions(-)

--=20
2.20.1


