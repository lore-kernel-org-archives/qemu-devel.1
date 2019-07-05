Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4055BC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C31E20828
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C31E20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjP3Y-0001wn-8n
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 10:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47914)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hjOzC-0007th-MR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hjOz8-0000pW-Jg
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:14:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hjOz4-0000QP-6b; Fri, 05 Jul 2019 10:14:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08746307D84F;
 Fri,  5 Jul 2019 14:14:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8A1E860E5;
 Fri,  5 Jul 2019 14:14:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6319A1132ABF; Fri,  5 Jul 2019 16:14:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-2-jsnow@redhat.com>
Date: Fri, 05 Jul 2019 16:14:32 +0200
In-Reply-To: <20190703215542.16123-2-jsnow@redhat.com> (John Snow's message of
 "Wed, 3 Jul 2019 17:55:25 -0400")
Message-ID: <87sgrkin5j.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 05 Jul 2019 14:14:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 01/18] qapi/block-core: Introduce
 BackupCommon
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> drive-backup and blockdev-backup have an awful lot of things in common
> that are the same. Let's fix that.
>
> I don't deduplicate 'target', because the semantics actually did change
> between each structure. Leave that one alone so it can be documented
> separately.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json | 103 ++++++++++++++-----------------------------
>  1 file changed, 33 insertions(+), 70 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c..7b23efcf13 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1315,32 +1315,23 @@
>    'data': { 'node': 'str', 'overlay': 'str' } }
>  
>  ##
> -# @DriveBackup:
> +# @BackupCommon:
>  #
>  # @job-id: identifier for the newly-created block job. If
>  #          omitted, the device name will be used. (Since 2.7)
>  #
>  # @device: the device name or node-name of a root node which should be copied.
>  #
> -# @target: the target of the new image. If the file exists, or if it
> -#          is a device, the existing file/device will be used as the new
> -#          destination.  If it does not exist, a new file will be created.
> -#
> -# @format: the format of the new destination, default is to
> -#          probe if @mode is 'existing', else the format of the source
> -#
>  # @sync: what parts of the disk image should be copied to the destination
>  #        (all the disk, only the sectors allocated in the topmost image, from a
>  #        dirty bitmap, or only new I/O).

This is DriveBackup's wording.  Blockdev lacks "from a dirty bitmap, ".
Is this a doc fix?

>  #
> -# @mode: whether and how QEMU should create a new image, default is
> -#        'absolute-paths'.
> -#
> -# @speed: the maximum speed, in bytes per second
> +# @speed: the maximum speed, in bytes per second. The default is 0,
> +#         for unlimited.

This is Blockdev's wording.  DriveBackup lacks "the default is 0, for
unlimited."  Is this a doc fix?

>  #
>  # @bitmap: the name of dirty bitmap if sync is "incremental".
>  #          Must be present if sync is "incremental", must NOT be present
> -#          otherwise. (Since 2.4)
> +#          otherwise. (Since 2.4 (Drive), 3.1 (Blockdev))

I second Max's request to say (drive-backup) and (blockdev-backup),
strongly.

>  #
>  # @compress: true to compress data, if the target format supports it.
>  #            (default: false) (since 2.8)
> @@ -1372,73 +1363,45 @@
>  #
>  # Since: 1.6

BackupCommon is actually since 4.2.

The type doesn't appear in the external interface (only its extensions
DriveBackup and BlockdevBackup do), so documenting "since" is actually
pointless.  However, we blindly document "since" for *everything*,
simply because we don't want to waste time on deciding whether we have
to.

>  ##
> +{ 'struct': 'BackupCommon',
> +  'data': { '*job-id': 'str', 'device': 'str',
> +            'sync': 'MirrorSyncMode', '*speed': 'int',
> +            '*bitmap': 'str', '*compress': 'bool',
> +            '*on-source-error': 'BlockdevOnError',
> +            '*on-target-error': 'BlockdevOnError',
> +            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
> +
> +##
> +# @DriveBackup:
> +#
> +# @target: the target of the new image. If the file exists, or if it
> +#          is a device, the existing file/device will be used as the new
> +#          destination.  If it does not exist, a new file will be created.
> +#
> +# @format: the format of the new destination, default is to
> +#          probe if @mode is 'existing', else the format of the source
> +#
> +# @mode: whether and how QEMU should create a new image, default is
> +#        'absolute-paths'.
> +#
> +# Since: 1.6
> +##
>  { 'struct': 'DriveBackup',
> -  'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
> -            '*format': 'str', 'sync': 'MirrorSyncMode',
> -            '*mode': 'NewImageMode', '*speed': 'int',
> -            '*bitmap': 'str', '*compress': 'bool',
> -            '*on-source-error': 'BlockdevOnError',
> -            '*on-target-error': 'BlockdevOnError',
> -            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
> +  'base': 'BackupCommon',
> +  'data': { 'target': 'str',
> +            '*format': 'str',
> +            '*mode': 'NewImageMode' } }
>  
>  ##
>  # @BlockdevBackup:
>  #
> -# @job-id: identifier for the newly-created block job. If
> -#          omitted, the device name will be used. (Since 2.7)
> -#
> -# @device: the device name or node-name of a root node which should be copied.
> -#
>  # @target: the device name or node-name of the backup target node.
>  #
> -# @sync: what parts of the disk image should be copied to the destination
> -#        (all the disk, only the sectors allocated in the topmost image, or
> -#        only new I/O).
> -#
> -# @speed: the maximum speed, in bytes per second. The default is 0,
> -#         for unlimited.
> -#
> -# @bitmap: the name of dirty bitmap if sync is "incremental".
> -#          Must be present if sync is "incremental", must NOT be present
> -#          otherwise. (Since 3.1)
> -#
> -# @compress: true to compress data, if the target format supports it.
> -#            (default: false) (since 2.8)
> -#
> -# @on-source-error: the action to take on an error on the source,
> -#                   default 'report'.  'stop' and 'enospc' can only be used
> -#                   if the block device supports io-status (see BlockInfo).
> -#
> -# @on-target-error: the action to take on an error on the target,
> -#                   default 'report' (no limitations, since this applies to
> -#                   a different block device than @device).
> -#
> -# @auto-finalize: When false, this job will wait in a PENDING state after it has
> -#                 finished its work, waiting for @block-job-finalize before
> -#                 making any block graph changes.
> -#                 When true, this job will automatically
> -#                 perform its abort or commit actions.
> -#                 Defaults to true. (Since 2.12)
> -#
> -# @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
> -#                has completely ceased all work, and awaits @block-job-dismiss.
> -#                When true, this job will automatically disappear from the query
> -#                list without user intervention.
> -#                Defaults to true. (Since 2.12)
> -#
> -# Note: @on-source-error and @on-target-error only affect background
> -# I/O.  If an error occurs during a guest write request, the device's
> -# rerror/werror actions will be used.
> -#
>  # Since: 2.3
>  ##
>  { 'struct': 'BlockdevBackup',
> -  'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
> -            'sync': 'MirrorSyncMode', '*speed': 'int',
> -            '*bitmap': 'str', '*compress': 'bool',
> -            '*on-source-error': 'BlockdevOnError',
> -            '*on-target-error': 'BlockdevOnError',
> -            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
> +  'base': 'BackupCommon',
> +  'data': { 'target': 'str' } }
>  
>  ##
>  # @blockdev-snapshot-sync:

