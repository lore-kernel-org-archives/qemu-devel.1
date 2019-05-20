Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EEBC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCEF120815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEF120815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38288 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlEq-0007En-Jy
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:34:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkxG-0000FU-CF
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkxF-0003oF-CO
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:16:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSkx9-0003hw-3f; Mon, 20 May 2019 12:15:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23F7A30832C6;
	Mon, 20 May 2019 16:15:45 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BC5378386;
	Mon, 20 May 2019 16:15:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 20 May 2019 18:14:49 +0200
Message-Id: <20190520161453.30723-21-kwolf@redhat.com>
In-Reply-To: <20190520161453.30723-1-kwolf@redhat.com>
References: <20190520161453.30723-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Mon, 20 May 2019 16:15:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 20/24] qemu-img.texi: Describe human-readable
 info output
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Ideally, it should be self-explanatory.  However, keys like "disk size"
arguably really are not self-explanatory.  In any case, there is no harm
in going into a some more detail here.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.texi | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/qemu-img.texi b/qemu-img.texi
index 39562317ee..e8bc0fd7a2 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -428,6 +428,47 @@ The command can output in the format @var{ofmt} whic=
h is either @code{human} or
 @code{json}.  The JSON output is an object of QAPI type @code{ImageInfo}=
; with
 @code{--backing-chain}, it is an array of @code{ImageInfo} objects.
=20
+@code{--output=3Dhuman} reports the following information (for every ima=
ge in the
+chain):
+@table @var
+@item image
+The image file name
+
+@item file format
+The image format
+
+@item virtual size
+The size of the guest disk
+
+@item disk size
+How much space the image file occupies on the host file system (may be s=
hown as
+0 if this information is unavailable, e.g. because there is no file syst=
em)
+
+@item cluster_size
+Cluster size of the image format, if applicable
+
+@item encrypted
+Whether the image is encrypted (only present if so)
+
+@item cleanly shut down
+This is shown as @code{no} if the image is dirty and will have to be
+auto-repaired the next time it is opened in qemu.
+
+@item backing file
+The backing file name, if present
+
+@item backing file format
+The format of the backing file, if the image enforces it
+
+@item Snapshot list
+A list of all internal snapshots
+
+@item Format specific information
+Further information whose structure depends on the image format.  This s=
ection
+is a textual representation of the respective @code{ImageInfoSpecific*} =
QAPI
+object (e.g. @code{ImageInfoSpecificQCow2} for qcow2 images).
+@end table
+
 @item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--ou=
tput=3D@var{ofmt}] [-U] @var{filename}
=20
 Dump the metadata of image @var{filename} and its backing file chain.
--=20
2.20.1


