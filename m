Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD01C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5EB92084A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EB92084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33093 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQoqi-00065C-1i
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 04:01:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQoou-00051h-BU
	for qemu-devel@nongnu.org; Wed, 15 May 2019 03:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQoot-0004RH-Fa
	for qemu-devel@nongnu.org; Wed, 15 May 2019 03:59:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hQoor-0004Iu-G4; Wed, 15 May 2019 03:59:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E43D1307EA93;
	Wed, 15 May 2019 07:59:19 +0000 (UTC)
Received: from localhost (ovpn-204-29.brq.redhat.com [10.40.204.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CB535D9C2;
	Wed, 15 May 2019 07:59:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 15 May 2019 09:59:15 +0200
Message-Id: <20190515075917.24980-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 15 May 2019 07:59:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] =?utf-8?q?=5BPATCH_0/2=5D_qemu-img=2Etexi=3A_Provide?=
 =?utf-8?q?_more_info_on_some_commands=E2=80=99_output?=
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most qemu-img subcommands that have (optional) JSON output don=E2=80=99t
describe the structure of their JSON output -- but having a fixed,
well-known output structure kind of is the point of having JSON output
at all.  Therefore, patch 1 in this series makes every such command note
which QAPI type their JSON output has in the qemu-img man page.  (The
exception to this is the map subcommand, which does not emit a
QAPI-typed object.  It already has a description of the structure of its
output object, though.)

That should be enough to thoroughly explain the machine-readable output.
But we can also do better for the human-readable output: qemu-img info
emits quite a bit of information, and not all of it is self-explanatory.
In patch 2, I=E2=80=99ve tried to provide some potentially missing explan=
ation.


Max Reitz (2):
  qemu-img.texi: Be specific about JSON object types
  qemu-img.texi: Describe human-readable info output

 qemu-img.texi | 52 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

--=20
2.21.0


