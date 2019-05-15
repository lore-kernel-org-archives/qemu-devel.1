Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7043AC04E87
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D5920843
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D5920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33097 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQoql-0006EX-GM
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 04:01:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQoow-00052o-Ie
	for qemu-devel@nongnu.org; Wed, 15 May 2019 03:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQoov-0004Wr-Du
	for qemu-devel@nongnu.org; Wed, 15 May 2019 03:59:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hQoos-0004MT-Tn; Wed, 15 May 2019 03:59:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 469C2307EA93;
	Wed, 15 May 2019 07:59:22 +0000 (UTC)
Received: from localhost (ovpn-204-29.brq.redhat.com [10.40.204.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D2D145D6A6;
	Wed, 15 May 2019 07:59:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 15 May 2019 09:59:16 +0200
Message-Id: <20190515075917.24980-2-mreitz@redhat.com>
In-Reply-To: <20190515075917.24980-1-mreitz@redhat.com>
References: <20190515075917.24980-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 15 May 2019 07:59:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] qemu-img.texi: Be specific about JSON
 object types
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

Just writing that --output=3Djson outputs JSON information does not reall=
y
help; we should also make a note of what QAPI type the result object
has.  (The map subcommand does not emit a QAPI-typed object, but its
section already describes the object structure well enough.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.texi | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/qemu-img.texi b/qemu-img.texi
index 724f244ba1..39562317ee 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -230,6 +230,7 @@ overridden with a pattern byte specified by @var{patt=
ern}.
=20
 Perform a consistency check on the disk image @var{filename}. The comman=
d can
 output in the format @var{ofmt} which is either @code{human} or @code{js=
on}.
+The JSON output is an object of QAPI type @code{ImageCheck}.
=20
 If @code{-r} is specified, qemu-img tries to repair any inconsistencies =
found
 during the check. @code{-r leaks} repairs only cluster leaks, whereas
@@ -406,8 +407,7 @@ The size syntax is similar to dd(1)'s size syntax.
 Give information about the disk image @var{filename}. Use it in
 particular to know the size reserved on disk which can be different
 from the displayed size. If VM snapshots are stored in the disk image,
-they are displayed too. The command can output in the format @var{ofmt}
-which is either @code{human} or @code{json}.
+they are displayed too.
=20
 If a disk image has a backing file chain, information about each disk im=
age in
 the chain can be recursively enumerated by using the option @code{--back=
ing-chain}.
@@ -424,6 +424,10 @@ To enumerate information about each disk image in th=
e above chain, starting from
 qemu-img info --backing-chain snap2.qcow2
 @end example
=20
+The command can output in the format @var{ofmt} which is either @code{hu=
man} or
+@code{json}.  The JSON output is an object of QAPI type @code{ImageInfo}=
; with
+@code{--backing-chain}, it is an array of @code{ImageInfo} objects.
+
 @item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--ou=
tput=3D@var{ofmt}] [-U] @var{filename}
=20
 Dump the metadata of image @var{filename} and its backing file chain.
@@ -485,7 +489,8 @@ Calculate the file size required for a new image.  Th=
is information can be used
 to size logical volumes or SAN LUNs appropriately for the image that wil=
l be
 placed in them.  The values reported are guaranteed to be large enough t=
o fit
 the image.  The command can output in the format @var{ofmt} which is eit=
her
-@code{human} or @code{json}.
+@code{human} or @code{json}.  The JSON output is an object of QAPI type
+@code{BlockMeasureInfo}.
=20
 If the size @var{N} is given then act as if creating a new empty image f=
ile
 using @command{qemu-img create}.  If @var{filename} is given then act as=
 if
--=20
2.21.0


