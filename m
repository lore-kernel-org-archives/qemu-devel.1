Received: from eggs.gnu.org ([2001:4830:134:3::10]:38831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTfMW-0006jm-TL
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 21:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTfMV-0004Rf-Tb
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 21:53:04 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue, 26 Dec 2017 10:52:46 +0800
Message-Id: <20171226025247.11082-2-famz@redhat.com>
In-Reply-To: <20171226025247.11082-1-famz@redhat.com>
References: <20171226025247.11082-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 1/2] qemu-img.texi: Clean up parameter list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>

Split options out of the "@table @var" section and create a "@table
@option", then use whitespaces and blank lines consistently.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.texi | 66 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/qemu-img.texi b/qemu-img.texi
index fdcf120f36..60a0e080c6 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -33,38 +33,14 @@ The following commands are supported:
 
 Command parameters:
 @table @var
+
 @item filename
- is a disk image filename
-
-@item --object @var{objectdef}
-
-is a QEMU user creatable object definition. See the @code{qemu(1)} manual
-page for a description of the object properties. The most common object
-type is a @code{secret}, which is used to supply passwords and/or encryption
-keys.
-
-@item --image-opts
-
-Indicates that the source @var{filename} parameter is to be interpreted as a
-full option string, not a plain filename. This parameter is mutually
-exclusive with the @var{-f} parameter.
-
-@item --target-image-opts
-
-Indicates that the @var{output_filename} parameter(s) are to be interpreted as
-a full option string, not a plain filename. This parameter is mutually
-exclusive with the @var{-O} parameters. It is currently required to also use
-the @var{-n} parameter to skip image creation. This restriction may be relaxed
-in a future release.
+is a disk image filename
 
 @item fmt
 is the disk image format. It is guessed automatically in most cases. See below
 for a description of the supported disk formats.
 
-@item --backing-chain
-will enumerate information about backing files in a disk image chain. Refer
-below for further description.
-
 @item size
 is the disk image size in bytes. Optional suffixes @code{k} or @code{K}
 (kilobyte, 1024) @code{M} (megabyte, 1024k) and @code{G} (gigabyte, 1024M)
@@ -74,42 +50,78 @@ and T (terabyte, 1024G) are supported.  @code{b} is ignored.
 is the destination disk image filename
 
 @item output_fmt
- is the destination format
+is the destination format
+
 @item options
 is a comma separated list of format specific options in a
 name=value format. Use @code{-o ?} for an overview of the options supported
 by the used format or see the format descriptions below for details.
+
 @item snapshot_param
 is param used for internal snapshot, format is
 'snapshot.id=[ID],snapshot.name=[NAME]' or '[ID_OR_NAME]'
+
 @item snapshot_id_or_name
 is deprecated, use snapshot_param instead
 
+@end table
+
+@table @option
+
+@item --object @var{objectdef}
+is a QEMU user creatable object definition. See the @code{qemu(1)} manual
+page for a description of the object properties. The most common object
+type is a @code{secret}, which is used to supply passwords and/or encryption
+keys.
+
+@item --image-opts
+Indicates that the source @var{filename} parameter is to be interpreted as a
+full option string, not a plain filename. This parameter is mutually
+exclusive with the @var{-f} parameter.
+
+@item --target-image-opts
+Indicates that the @var{output_filename} parameter(s) are to be interpreted as
+a full option string, not a plain filename. This parameter is mutually
+exclusive with the @var{-O} parameters. It is currently required to also use
+the @var{-n} parameter to skip image creation. This restriction may be relaxed
+in a future release.
+
+@item --backing-chain
+will enumerate information about backing files in a disk image chain. Refer
+below for further description.
+
 @item -c
 indicates that target image must be compressed (qcow format only)
+
 @item -h
 with or without a command shows help and lists the supported formats
+
 @item -p
 display progress bar (compare, convert and rebase commands only).
 If the @var{-p} option is not used for a command that supports it, the
 progress is reported when the process receives a @code{SIGUSR1} or
 @code{SIGINFO} signal.
+
 @item -q
 Quiet mode - do not print any output (except errors). There's no progress bar
 in case both @var{-q} and @var{-p} options are used.
+
 @item -S @var{size}
 indicates the consecutive number of bytes that must contain only zeros
 for qemu-img to create a sparse image during conversion. This value is rounded
 down to the nearest 512 bytes. You may use the common size suffixes like
 @code{k} for kilobytes.
+
 @item -t @var{cache}
 specifies the cache mode that should be used with the (destination) file. See
 the documentation of the emulator's @code{-drive cache=...} option for allowed
 values.
+
 @item -T @var{src_cache}
 specifies the cache mode that should be used with the source file(s). See
 the documentation of the emulator's @code{-drive cache=...} option for allowed
 values.
+
 @end table
 
 Parameters to snapshot subcommand:
-- 
2.14.3
