Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D32C4741C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5155C20726
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmEiNZpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5155C20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50455 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vu0-0005DY-CK
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpR-0004WT-F7
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpO-0006rD-BH
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45028
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpO-0006qi-5O
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIOCGKSD5czZANtlyuxDIL7h3GoI4a3RyaVmBZlR3VI=;
 b=UmEiNZpVgN1+dwQfSYRLJwFButMOskcWHV390jJjltXUV1MY1kz40lIILxKp0MzM8Fg9+o
 TCUblwEoBJqoHuSbrlrcWPDmphaCkpV5AGnGSBiMeMFchCDYwGyjviw0zOn+qoziz23mcU
 D3f94CFRCSn2YgA54dr57Elrpl8SOa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-dunse9B6OoixF2nHW2qPlA-1; Sat, 15 Feb 2020 06:41:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A849107ACC9;
 Sat, 15 Feb 2020 11:41:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA7A726FB6;
 Sat, 15 Feb 2020 11:41:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F3EC1136365; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/18] qapi: Use explicit bulleted lists
Date: Sat, 15 Feb 2020 12:41:30 +0100
Message-Id: <20200215114133.15097-16-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dunse9B6OoixF2nHW2qPlA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

A JSON block comment like this:
     Returns: nothing on success
              If @node is not a valid block device, DeviceNotFound
              If @name is not found, GenericError with an explanation

renders like this:

     Returns: nothing on success If node is not a valid block device,
     DeviceNotFound If name is not found, GenericError with an explanation

because whitespace is not significant.

Use an actual bulleted list, so that the formatting is correct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200213175647.17628-14-peter.maydell@linaro.org>
Message-Id: <20200213175647.17628-15-peter.maydell@linaro.org>
Message-Id: <20200213175647.17628-16-peter.maydell@linaro.org>
[Three commits squashed into one]
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 108 +++++++++++++++++++++----------------------
 qapi/block.json      |  33 ++++++-------
 qapi/misc.json       |  36 +++++++--------
 qapi/tpm.json        |   4 +-
 qapi/ui.json         |  63 +++++++++++++------------
 5 files changed, 119 insertions(+), 125 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 31f7a1281c..082aca3f69 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1326,8 +1326,8 @@
 #
 # @size:  new image size in bytes
 #
-# Returns: nothing on success
-#          If @device is not a valid block device, DeviceNotFound
+# Returns: - nothing on success
+#          - If @device is not a valid block device, DeviceNotFound
 #
 # Since: 0.14.0
 #
@@ -1510,8 +1510,8 @@
 #
 # For the arguments, see the documentation of BlockdevSnapshotSync.
 #
-# Returns: nothing on success
-#          If @device is not a valid block device, DeviceNotFound
+# Returns: - nothing on success
+#          - If @device is not a valid block device, DeviceNotFound
 #
 # Since: 0.14.0
 #
@@ -1586,9 +1586,8 @@
 #                when specifying the string or the image chain may
 #                not be able to be reopened again.
 #
-# Returns: Nothing on success
-#
-#          If "device" does not exist or cannot be determined, DeviceNotFo=
und
+# Returns: - Nothing on success
+#          - If "device" does not exist or cannot be determined, DeviceNot=
Found
 #
 # Since: 2.1
 ##
@@ -1674,9 +1673,9 @@
 #                list without user intervention.
 #                Defaults to true. (Since 3.1)
 #
-# Returns: Nothing on success
-#          If @device does not exist, DeviceNotFound
-#          Any other error returns a GenericError.
+# Returns: - Nothing on success
+#          - If @device does not exist, DeviceNotFound
+#          - Any other error returns a GenericError.
 #
 # Since: 1.3
 #
@@ -1704,8 +1703,8 @@
 # The operation can be stopped before it has completed using the
 # block-job-cancel command.
 #
-# Returns: nothing on success
-#          If @device is not a valid block device, GenericError
+# Returns: - nothing on success
+#          - If @device is not a valid block device, GenericError
 #
 # Since: 1.6
 #
@@ -1730,8 +1729,8 @@
 # The operation can be stopped before it has completed using the
 # block-job-cancel command.
 #
-# Returns: nothing on success
-#          If @device is not a valid block device, DeviceNotFound
+# Returns: - nothing on success
+#          - If @device is not a valid block device, DeviceNotFound
 #
 # Since: 2.3
 #
@@ -1925,8 +1924,8 @@
 # format of the mirror image, default is to probe if mode=3D'existing',
 # else the format of the source.
 #
-# Returns: nothing on success
-#          If @device is not a valid block device, GenericError
+# Returns: - nothing on success
+#          - If @device is not a valid block device, GenericError
 #
 # Since: 1.3
 #
@@ -2097,9 +2096,9 @@
 #
 # Create a dirty bitmap with a name on the node, and start tracking the wr=
ites.
 #
-# Returns: nothing on success
-#          If @node is not a valid block device or node, DeviceNotFound
-#          If @name is already taken, GenericError with an explanation
+# Returns: - nothing on success
+#          - If @node is not a valid block device or node, DeviceNotFound
+#          - If @name is already taken, GenericError with an explanation
 #
 # Since: 2.4
 #
@@ -2120,10 +2119,10 @@
 # with block-dirty-bitmap-add. If the bitmap is persistent, remove it from=
 its
 # storage too.
 #
-# Returns: nothing on success
-#          If @node is not a valid block device or node, DeviceNotFound
-#          If @name is not found, GenericError with an explanation
-#          if @name is frozen by an operation, GenericError
+# Returns: - nothing on success
+#          - If @node is not a valid block device or node, DeviceNotFound
+#          - If @name is not found, GenericError with an explanation
+#          - if @name is frozen by an operation, GenericError
 #
 # Since: 2.4
 #
@@ -2144,9 +2143,9 @@
 # backup from this point in time forward will only backup clusters
 # modified after this clear operation.
 #
-# Returns: nothing on success
-#          If @node is not a valid block device, DeviceNotFound
-#          If @name is not found, GenericError with an explanation
+# Returns: - nothing on success
+#          - If @node is not a valid block device, DeviceNotFound
+#          - If @name is not found, GenericError with an explanation
 #
 # Since: 2.4
 #
@@ -2165,9 +2164,9 @@
 #
 # Enables a dirty bitmap so that it will begin tracking disk changes.
 #
-# Returns: nothing on success
-#          If @node is not a valid block device, DeviceNotFound
-#          If @name is not found, GenericError with an explanation
+# Returns: - nothing on success
+#          - If @node is not a valid block device, DeviceNotFound
+#          - If @name is not found, GenericError with an explanation
 #
 # Since: 4.0
 #
@@ -2186,9 +2185,9 @@
 #
 # Disables a dirty bitmap so that it will stop tracking disk changes.
 #
-# Returns: nothing on success
-#          If @node is not a valid block device, DeviceNotFound
-#          If @name is not found, GenericError with an explanation
+# Returns: - nothing on success
+#          - If @node is not a valid block device, DeviceNotFound
+#          - If @name is not found, GenericError with an explanation
 #
 # Since: 4.0
 #
@@ -2215,11 +2214,11 @@
 # of the source bitmaps. This can be used to achieve backup checkpoints, o=
r in
 # simpler usages, to copy bitmaps.
 #
-# Returns: nothing on success
-#          If @node is not a valid block device, DeviceNotFound
-#          If any bitmap in @bitmaps or @target is not found, GenericError
-#          If any of the bitmaps have different sizes or granularities,
-#              GenericError
+# Returns: - nothing on success
+#          - If @node is not a valid block device, DeviceNotFound
+#          - If any bitmap in @bitmaps or @target is not found, GenericErr=
or
+#          - If any of the bitmaps have different sizes or granularities,
+#            GenericError
 #
 # Since: 4.0
 #
@@ -2251,10 +2250,10 @@
 #
 # Get bitmap SHA256.
 #
-# Returns: BlockDirtyBitmapSha256 on success
-#          If @node is not a valid block device, DeviceNotFound
-#          If @name is not found or if hashing has failed, GenericError wi=
th an
-#          explanation
+# Returns: - BlockDirtyBitmapSha256 on success
+#          - If @node is not a valid block device, DeviceNotFound
+#          - If @name is not found or if hashing has failed, GenericError =
with an
+#            explanation
 #
 # Since: 2.10
 ##
@@ -2371,8 +2370,8 @@
 # the device will be removed from its group and the rest of its
 # members will not be affected. The 'group' parameter is ignored.
 #
-# Returns: Nothing on success
-#          If @device is not a valid block device, DeviceNotFound
+# Returns: - Nothing on success
+#          - If @device is not a valid block device, DeviceNotFound
 #
 # Since: 1.1
 #
@@ -2622,7 +2621,8 @@
 #                list without user intervention.
 #                Defaults to true. (Since 3.1)
 #
-# Returns: Nothing on success. If @device does not exist, DeviceNotFound.
+# Returns: - Nothing on success.
+#          - If @device does not exist, DeviceNotFound.
 #
 # Since: 1.1
 #
@@ -2656,8 +2656,8 @@
 # @speed: the maximum speed, in bytes per second, or 0 for unlimited.
 #         Defaults to 0.
 #
-# Returns: Nothing on success
-#          If no background operation is active on this device, DeviceNotA=
ctive
+# Returns: - Nothing on success
+#          - If no background operation is active on this device, DeviceNo=
tActive
 #
 # Since: 1.1
 ##
@@ -2696,8 +2696,8 @@
 #         abandon the job immediately (even if it is paused) instead of wa=
iting
 #         for the destination to complete its final synchronization (since=
 1.3)
 #
-# Returns: Nothing on success
-#          If no background operation is active on this device, DeviceNotA=
ctive
+# Returns: - Nothing on success
+#          - If no background operation is active on this device, DeviceNo=
tActive
 #
 # Since: 1.1
 ##
@@ -2720,8 +2720,8 @@
 #          the name of the parameter), but since QEMU 2.7 it can have
 #          other values.
 #
-# Returns: Nothing on success
-#          If no background operation is active on this device, DeviceNotA=
ctive
+# Returns: - Nothing on success
+#          - If no background operation is active on this device, DeviceNo=
tActive
 #
 # Since: 1.3
 ##
@@ -2742,8 +2742,8 @@
 #          the name of the parameter), but since QEMU 2.7 it can have
 #          other values.
 #
-# Returns: Nothing on success
-#          If no background operation is active on this device, DeviceNotA=
ctive
+# Returns: - Nothing on success
+#          - If no background operation is active on this device, DeviceNo=
tActive
 #
 # Since: 1.3
 ##
@@ -2770,8 +2770,8 @@
 #          the name of the parameter), but since QEMU 2.7 it can have
 #          other values.
 #
-# Returns: Nothing on success
-#          If no background operation is active on this device, DeviceNotA=
ctive
+# Returns: - Nothing on success
+#          - If no background operation is active on this device, DeviceNo=
tActive
 #
 # Since: 1.3
 ##
diff --git a/qapi/block.json b/qapi/block.json
index 65eaacf31a..da19834db4 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -115,15 +115,12 @@
 #
 # For the arguments, see the documentation of BlockdevSnapshotInternal.
 #
-# Returns: nothing on success
-#
-#          If @device is not a valid block device, GenericError
-#
-#          If any snapshot matching @name exists, or @name is empty,
-#          GenericError
-#
-#          If the format of the image used does not support it,
-#          BlockFormatFeatureNotSupported
+# Returns: - nothing on success
+#          - If @device is not a valid block device, GenericError
+#          - If any snapshot matching @name exists, or @name is empty,
+#            GenericError
+#          - If the format of the image used does not support it,
+#            BlockFormatFeatureNotSupported
 #
 # Since: 1.7
 #
@@ -154,12 +151,12 @@
 #
 # @name: optional the snapshot's name to be deleted
 #
-# Returns: SnapshotInfo on success
-#          If @device is not a valid block device, GenericError
-#          If snapshot not found, GenericError
-#          If the format of the image used does not support it,
-#          BlockFormatFeatureNotSupported
-#          If @id and @name are both not specified, GenericError
+# Returns: - SnapshotInfo on success
+#          - If @device is not a valid block device, GenericError
+#          - If snapshot not found, GenericError
+#          - If the format of the image used does not support it,
+#            BlockFormatFeatureNotSupported
+#          - If @id and @name are both not specified, GenericError
 #
 # Since: 1.7
 #
@@ -197,10 +194,8 @@
 # @force: If true, eject regardless of whether the drive is locked.
 #         If not specified, the default value is false.
 #
-# Returns:  Nothing on success
-#
-#           If @device is not a valid block device, DeviceNotFound
-#
+# Returns: - Nothing on success
+#          - If @device is not a valid block device, DeviceNotFound
 # Notes:    Ejecting a device with no media results in success
 #
 # Since: 0.14.0
diff --git a/qapi/misc.json b/qapi/misc.json
index 46e0abdfe7..af00279e7b 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -430,12 +430,10 @@
 #
 # Return information about the balloon device.
 #
-# Returns: @BalloonInfo on success
-#
-#          If the balloon driver is enabled but not functional because the=
 KVM
-#          kernel module cannot support it, KvmMissingCap
-#
-#          If no balloon device is present, DeviceNotActive
+# Returns: - @BalloonInfo on success
+#          - If the balloon driver is enabled but not functional because t=
he KVM
+#            kernel module cannot support it, KvmMissingCap
+#          - If no balloon device is present, DeviceNotActive
 #
 # Since: 0.14.0
 #
@@ -492,8 +490,8 @@
 #
 # @bar: the index of the Base Address Register for this region
 #
-# @type: 'io' if the region is a PIO region
-#        'memory' if the region is a MMIO region
+# @type: - 'io' if the region is a PIO region
+#        - 'memory' if the region is a MMIO region
 #
 # @size: memory size
 #
@@ -1004,10 +1002,10 @@
 #
 # @value: the target size of the balloon in bytes
 #
-# Returns: Nothing on success
-#          If the balloon driver is enabled but not functional because the=
 KVM
+# Returns: - Nothing on success
+#          - If the balloon driver is enabled but not functional because t=
he KVM
 #            kernel module cannot support it, KvmMissingCap
-#          If no balloon device is present, DeviceNotActive
+#          - If no balloon device is present, DeviceNotActive
 #
 # Notes: This command just issues a request to the guest.  When it returns=
,
 #        the balloon size may not have changed.  A guest can change the ba=
lloon
@@ -1086,8 +1084,8 @@
 #       If @device is 'vnc' and @target is 'password', this is the new VNC
 #       password to set.  See change-vnc-password for additional notes.
 #
-# Returns: Nothing on success.
-#          If @device is not a valid block device, DeviceNotFound
+# Returns: - Nothing on success.
+#          - If @device is not a valid block device, DeviceNotFound
 #
 # Notes: This interface is deprecated, and it is strongly recommended that=
 you
 #        avoid using it.  For changing block devices, use
@@ -1237,11 +1235,9 @@
 #
 # @opaque: A free-form string that can be used to describe the fd.
 #
-# Returns: @AddfdInfo on success
-#
-#          If file descriptor was not received, FdNotSupplied
-#
-#          If @fdset-id is a negative value, InvalidParameterValue
+# Returns: - @AddfdInfo on success
+#          - If file descriptor was not received, FdNotSupplied
+#          - If @fdset-id is a negative value, InvalidParameterValue
 #
 # Notes: The list of fd sets is shared by all monitor connections.
 #
@@ -1269,8 +1265,8 @@
 #
 # @fd: The file descriptor that is to be removed.
 #
-# Returns: Nothing on success
-#          If @fdset-id or @fd is not found, FdNotFound
+# Returns: - Nothing on success
+#          - If @fdset-id or @fd is not found, FdNotFound
 #
 # Since: 1.2.0
 #
diff --git a/qapi/tpm.json b/qapi/tpm.json
index 63878aa0f4..dc1f081739 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -96,8 +96,8 @@
 #
 # A union referencing different TPM backend types' configuration options
 #
-# @type: 'passthrough' The configuration options for the TPM passthrough t=
ype
-#        'emulator' The configuration options for TPM emulator backend typ=
e
+# @type: - 'passthrough' The configuration options for the TPM passthrough=
 type
+#        - 'emulator' The configuration options for TPM emulator backend t=
ype
 #
 # Since: 1.5
 ##
diff --git a/qapi/ui.json b/qapi/ui.json
index 088a8680ef..e4bd3d8ea7 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -12,8 +12,8 @@
 #
 # Sets the password of a remote display session.
 #
-# @protocol: 'vnc' to modify the VNC server password
-#            'spice' to modify the Spice server password
+# @protocol: - 'vnc' to modify the VNC server password
+#            - 'spice' to modify the Spice server password
 #
 # @password: the new password
 #
@@ -23,8 +23,8 @@
 #             'disconnect' to disconnect existing clients
 #             'keep' to maintain existing clients
 #
-# Returns: Nothing on success
-#          If Spice is not enabled, DeviceNotFound
+# Returns: - Nothing on success
+#          - If Spice is not enabled, DeviceNotFound
 #
 # Since: 0.14.0
 #
@@ -46,13 +46,14 @@
 # @protocol: the name of the remote display protocol 'vnc' or 'spice'
 #
 # @time: when to expire the password.
-#        'now' to expire the password immediately
-#        'never' to cancel password expiration
-#        '+INT' where INT is the number of seconds from now (integer)
-#        'INT' where INT is the absolute time in seconds
 #
-# Returns: Nothing on success
-#          If @protocol is 'spice' and Spice is not active, DeviceNotFound
+#        - 'now' to expire the password immediately
+#        - 'never' to cancel password expiration
+#        - '+INT' where INT is the number of seconds from now (integer)
+#        - 'INT' where INT is the absolute time in seconds
+#
+# Returns: - Nothing on success
+#          - If @protocol is 'spice' and Spice is not active, DeviceNotFou=
nd
 #
 # Since: 0.14.0
 #
@@ -201,9 +202,10 @@
 # @tls-port: The SPICE server's TLS port number.
 #
 # @auth: the current authentication type used by the server
-#        'none'  if no authentication is being used
-#        'spice' uses SASL or direct TLS authentication, depending on comm=
and
-#                line options
+#
+#        - 'none'  if no authentication is being used
+#        - 'spice' uses SASL or direct TLS authentication, depending on co=
mmand
+#          line options
 #
 # @mouse-mode: The mode in which the mouse cursor is displayed currently. =
Can
 #              be determined by the client or the server, or unknown if sp=
ice
@@ -433,27 +435,28 @@
 # @host: The hostname the VNC server is bound to.  This depends on
 #        the name resolution on the host and may be an IP address.
 #
-# @family: 'ipv6' if the host is listening for IPv6 connections
-#                    'ipv4' if the host is listening for IPv4 connections
-#                    'unix' if the host is listening on a unix domain sock=
et
-#                    'unknown' otherwise
+# @family: - 'ipv6' if the host is listening for IPv6 connections
+#          - 'ipv4' if the host is listening for IPv4 connections
+#          - 'unix' if the host is listening on a unix domain socket
+#          - 'unknown' otherwise
 #
 # @service: The service name of the server's port.  This may depends
 #           on the host system's service database so symbolic names should=
 not
 #           be relied on.
 #
 # @auth: the current authentication type used by the server
-#        'none' if no authentication is being used
-#        'vnc' if VNC authentication is being used
-#        'vencrypt+plain' if VEncrypt is used with plain text authenticati=
on
-#        'vencrypt+tls+none' if VEncrypt is used with TLS and no authentic=
ation
-#        'vencrypt+tls+vnc' if VEncrypt is used with TLS and VNC authentic=
ation
-#        'vencrypt+tls+plain' if VEncrypt is used with TLS and plain text =
auth
-#        'vencrypt+x509+none' if VEncrypt is used with x509 and no auth
-#        'vencrypt+x509+vnc' if VEncrypt is used with x509 and VNC auth
-#        'vencrypt+x509+plain' if VEncrypt is used with x509 and plain tex=
t auth
-#        'vencrypt+tls+sasl' if VEncrypt is used with TLS and SASL auth
-#        'vencrypt+x509+sasl' if VEncrypt is used with x509 and SASL auth
+#
+#        - 'none' if no authentication is being used
+#        - 'vnc' if VNC authentication is being used
+#        - 'vencrypt+plain' if VEncrypt is used with plain text authentica=
tion
+#        - 'vencrypt+tls+none' if VEncrypt is used with TLS and no authent=
ication
+#        - 'vencrypt+tls+vnc' if VEncrypt is used with TLS and VNC authent=
ication
+#        - 'vencrypt+tls+plain' if VEncrypt is used with TLS and plain tex=
t auth
+#        - 'vencrypt+x509+none' if VEncrypt is used with x509 and no auth
+#        - 'vencrypt+x509+vnc' if VEncrypt is used with x509 and VNC auth
+#        - 'vencrypt+x509+plain' if VEncrypt is used with x509 and plain t=
ext auth
+#        - 'vencrypt+tls+sasl' if VEncrypt is used with TLS and SASL auth
+#        - 'vencrypt+x509+sasl' if VEncrypt is used with x509 and SASL aut=
h
 #
 # @clients: a list of @VncClientInfo of all currently connected clients
 #
@@ -840,8 +843,8 @@
 # @hold-time: time to delay key up events, milliseconds. Defaults
 #             to 100
 #
-# Returns: Nothing on success
-#          If key is unknown or redundant, InvalidParameter
+# Returns: - Nothing on success
+#          - If key is unknown or redundant, InvalidParameter
 #
 # Since: 1.3.0
 #
--=20
2.21.1


