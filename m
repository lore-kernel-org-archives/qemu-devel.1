Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B71C10F0E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A7220874
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A7220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51677 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE233-0001bF-JB
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 21:29:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hE1yf-0007bG-LC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hE1yd-0002gh-N8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:24:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hE1yP-0001sd-9E; Tue, 09 Apr 2019 21:24:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A10481235;
	Wed, 10 Apr 2019 01:24:20 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-206.bos.redhat.com [10.18.17.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A97061001E92;
	Wed, 10 Apr 2019 01:24:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  9 Apr 2019 21:24:13 -0400
Message-Id: <20190410012413.31569-4-jsnow@redhat.com>
In-Reply-To: <20190410012413.31569-1-jsnow@redhat.com>
References: <20190410012413.31569-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 10 Apr 2019 01:24:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC 3/3] qemu-img.texi: use macros for command
 summaries
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
Message-ID: <20190410012413.lCrE3HkG4QRLXn28hoLuG0NBD0JZY7nJvQhAblGcc-U@z>

Use a macro to recall this text instead of re-entering it manually.

Modify the pxtool script to create macros for each subcommand, then
alter the qemu-img.texi file to recall these macros.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qemu-img.texi     | 28 ++++++++++++++--------------
 scripts/pxtool.py |  4 ++++
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/qemu-img.texi b/qemu-img.texi
index 724f244ba1..c21a97e934 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -197,12 +197,12 @@ Command description:
 
 @table @option
 
-@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
+@qemuimgcmdamend
 
 Amends the image format specific @var{options} for the image file
 @var{filename}. Not all file formats support this operation.
 
-@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] [-U] @var{filename}
+@qemuimgcmdbench
 
 Run a simple sequential I/O benchmark on the specified image. If @code{-w} is
 specified, a write test is performed, otherwise a read test is performed.
@@ -226,7 +226,7 @@ specified as well.
 For write tests, by default a buffer filled with zeros is written. This can be
 overridden with a pattern byte specified by @var{pattern}.
 
-@item check [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] [-U] @var{filename}
+@qemuimgcmdcheck
 
 Perform a consistency check on the disk image @var{filename}. The command can
 output in the format @var{ofmt} which is either @code{human} or @code{json}.
@@ -262,7 +262,7 @@ If @code{-r} is specified, exit codes representing the image state refer to the
 state after (the attempt at) repairing it. That is, a successful @code{-r all}
 will yield the exit code 0, independently of the image state before.
 
-@item commit [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [-t @var{cache}] [-b @var{base}] [-d] [-p] @var{filename}
+@qemuimgcmdcommit
 
 Commit the changes recorded in @var{filename} in its base image or backing file.
 If the backing file is smaller than the snapshot, then the backing file will be
@@ -284,7 +284,7 @@ all images between @var{base} and the top image will be invalid and may return
 garbage data when read. For this reason, @code{-b} implies @code{-d} (so that
 the top image stays valid).
 
-@item compare [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-F @var{fmt}] [-T @var{src_cache}] [-p] [-q] [-s] [-U] @var{filename1} @var{filename2}
+@qemuimgcmdcompare
 
 Check if two images have the same content. You can compare images with
 different format or settings.
@@ -325,7 +325,7 @@ Error on reading data
 
 @end table
 
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@qemuimgcmdconvert
 
 Convert the disk image @var{filename} or a snapshot @var{snapshot_param}
 to disk image @var{output_filename} using format @var{output_fmt}. It can be optionally compressed (@code{-c}
@@ -366,7 +366,7 @@ creating compressed images.
 @var{num_coroutines} specifies how many coroutines work in parallel during
 the convert process (defaults to 8).
 
-@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
+@qemuimgcmdcreate
 
 Create the new disk image @var{filename} of size @var{size} and format
 @var{fmt}. Depending on the file format, you can add one or more @var{options}
@@ -390,7 +390,7 @@ way.
 The size can also be specified using the @var{size} option with @code{-o},
 it doesn't need to be specified separately in this case.
 
-@item dd [--image-opts] [-U] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
+@qemuimgcmddd
 
 Dd copies from @var{input} file to @var{output} file converting it from
 @var{fmt} format to @var{output_fmt} format.
@@ -401,7 +401,7 @@ dd will stop reading input after reading @var{blocks} input blocks.
 
 The size syntax is similar to dd(1)'s size syntax.
 
-@item info [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [--backing-chain] [-U] @var{filename}
+@qemuimgcmdinfo
 
 Give information about the disk image @var{filename}. Use it in
 particular to know the size reserved on disk which can be different
@@ -424,7 +424,7 @@ To enumerate information about each disk image in the above chain, starting from
 qemu-img info --backing-chain snap2.qcow2
 @end example
 
-@item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [-U] @var{filename}
+@qemuimgcmdmap
 
 Dump the metadata of image @var{filename} and its backing file chain.
 In particular, this commands dumps the allocation state of every sector
@@ -479,7 +479,7 @@ preallocated.
 For more information, consult @file{include/block/block.h} in QEMU's
 source code.
 
-@item measure [--output=@var{ofmt}] [-O @var{output_fmt}] [-o @var{options}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-l @var{snapshot_param}] @var{filename}]
+@qemuimgcmdmeasure
 
 Calculate the file size required for a new image.  This information can be used
 to size logical volumes or SAN LUNs appropriately for the image that will be
@@ -509,11 +509,11 @@ been written to all sectors.  This is the maximum size that the image file can
 occupy with the exception of internal snapshots, dirty bitmaps, vmstate data,
 and other advanced image format features.
 
-@item snapshot [--object @var{objectdef}] [--image-opts] [-U] [-q] [-l | -a @var{snapshot} | -c @var{snapshot} | -d @var{snapshot}] @var{filename}
+@qemuimgcmdsnapshot
 
 List, apply, create or delete snapshots in image @var{filename}.
 
-@item rebase [--object @var{objectdef}] [--image-opts] [-U] [-q] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-p] [-u] -b @var{backing_file} [-F @var{backing_fmt}] @var{filename}
+@qemuimgcmdrebase
 
 Changes the backing file of an image. Only the formats @code{qcow2} and
 @code{qed} support changing the backing file.
@@ -573,7 +573,7 @@ qemu-img rebase -b base.img diff.qcow2
 At this point, @code{modified.img} can be discarded, since
 @code{base.img + diff.qcow2} contains the same information.
 
-@item resize [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--preallocation=@var{prealloc}] [-q] [--shrink] @var{filename} [+ | -]@var{size}
+@qemuimgcmdresize
 
 Change the disk image as if it had been created with @var{size}.
 
diff --git a/scripts/pxtool.py b/scripts/pxtool.py
index 008fea839e..7ed5550b29 100755
--- a/scripts/pxtool.py
+++ b/scripts/pxtool.py
@@ -30,7 +30,11 @@ def generate_texi(conf):
     print("@table @option")
     for command, usage_strs in conf.items():
         usage = " ".join(usage_strs)
+        macro = "qemuimgcmd{}".format(command)
+        print("@macro {}".format(macro))
         print("@item {} {}".format(command, usage))
+        print("@end macro")
+        print("@{}".format(macro))
     print("@end table")
 
 if __name__ == '__main__':
-- 
2.17.2


