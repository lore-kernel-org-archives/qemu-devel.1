Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63247C73C65
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9E220651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9E220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl1Zd-0005s3-41
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 21:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hl1Xa-0005Es-Sn
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hl1XV-0007Mb-0L
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:37:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hl1X0-00070J-Kr; Tue, 09 Jul 2019 21:36:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB5D4C05091A;
 Wed, 10 Jul 2019 01:36:24 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D734F1001B16;
 Wed, 10 Jul 2019 01:36:20 +0000 (UTC)
To: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20190709232550.10724-1-jsnow@redhat.com>
 <20190709232550.10724-2-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fdd0230c-2524-7a15-d356-c37f2944cf6b@redhat.com>
Date: Tue, 9 Jul 2019 21:36:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709232550.10724-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 10 Jul 2019 01:36:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 01/18] qapi/block-core: Introduce
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
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/9/19 7:25 PM, John Snow wrote:
> drive-backup and blockdev-backup have an awful lot of things in common
> that are the same. Let's fix that.
> 
> I don't deduplicate 'target', because the semantics actually did change
> between each structure. Leave that one alone so it can be documented
> separately.

Sorry Markus, I forgot to adjust this. Pretend I wrote:

Where documentation was not identical, use the most up-to-date version.
For "speed", use Blockdev-Backup's version. For "sync", use
Drive-Backup's version.

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 103 ++++++++++++++-----------------------------
>  1 file changed, 33 insertions(+), 70 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c..0af3866015 100644
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
>  #
> -# @mode: whether and how QEMU should create a new image, default is
> -#        'absolute-paths'.
> -#
> -# @speed: the maximum speed, in bytes per second
> +# @speed: the maximum speed, in bytes per second. The default is 0,
> +#         for unlimited.
>  #
>  # @bitmap: the name of dirty bitmap if sync is "incremental".
>  #          Must be present if sync is "incremental", must NOT be present
> -#          otherwise. (Since 2.4)
> +#          otherwise. (Since 2.4 (drive-backup), 3.1 (blockdev-backup))
>  #
>  # @compress: true to compress data, if the target format supports it.
>  #            (default: false) (since 2.8)
> @@ -1370,75 +1361,47 @@
>  # I/O.  If an error occurs during a guest write request, the device's
>  # rerror/werror actions will be used.
>  #
> +# Since: 4.2
> +##
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
>  # Since: 1.6
>  ##
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
> 

