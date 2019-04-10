Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28239C10F0E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58792133D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58792133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE20b-0000Mv-79
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 21:26:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hE1yR-0007QV-Kl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hE1yQ-00020a-HP
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:24:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hE1yN-0001l2-1c; Tue, 09 Apr 2019 21:24:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 634CFE3DEC;
	Wed, 10 Apr 2019 01:24:18 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-206.bos.redhat.com [10.18.17.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F1781084201;
	Wed, 10 Apr 2019 01:24:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  9 Apr 2019 21:24:11 -0400
Message-Id: <20190410012413.31569-2-jsnow@redhat.com>
In-Reply-To: <20190410012413.31569-1-jsnow@redhat.com>
References: <20190410012413.31569-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 10 Apr 2019 01:24:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC 1/3] qemu-img: fix .hx and .texi disparity
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	John Snow <jsnow@redhat.com>, armbru@redhat.com,
	Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410012411.aEKOyXCFrc9UuA_GOn2nqbK653er7pruNL88qMlmLkw@z>

It turns out that having options listed in three places continues to be
a bad idea. I'm still toying with the idea of an improved infrastructure
here, but in the meantime, another bandaid.

There are three locations:
(1) .hx file, formatted as texi
(2) .hx file, formatted as human readable.
(3) .texi file, as section headers, formatted as texi.

You can compare the two summaries within the .hx file like so:

Human-readable command summaries:
`./qemu-img --help | grep 'Command syntax' -A14`
Detokenized texi command summaries:
`grep "@item" qemu-img-cmds.hx | sed -E 's|@var\{([^\}]*?)\}|\1|g'`

You can compare the two separate texi summaries like so:

Texi command summaries:
`grep "@item" qemu-img-cmds.hx"`
Texi command headers:
grep -E "@item.*@var" qemu-img.texi | tail -14

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qemu-img.texi    | 4 ++--
 qemu-img-cmds.hx | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-img.texi b/qemu-img.texi
index 3b6710a580..724f244ba1 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -197,7 +197,7 @@ Command description:
 
 @table @option
 
-@item amend [--object @var{objectdef}] [--image-opts] [-p] [-p] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
+@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
 
 Amends the image format specific @var{options} for the image file
 @var{filename}. Not all file formats support this operation.
@@ -424,7 +424,7 @@ To enumerate information about each disk image in the above chain, starting from
 qemu-img info --backing-chain snap2.qcow2
 @end example
 
-@item map [-f @var{fmt}] [--output=@var{ofmt}] @var{filename}
+@item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [-U] @var{filename}
 
 Dump the metadata of image @var{filename} and its backing file chain.
 In particular, this commands dumps the allocation state of every sector
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1526f327a5..4b47f7495d 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -46,7 +46,7 @@ ETEXI
 DEF("convert", img_convert,
     "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("create", img_create,
-- 
2.17.2


