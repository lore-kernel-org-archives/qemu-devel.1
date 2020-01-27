Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9247C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45B1208CD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAmCPEsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45B1208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw293-0000Mi-Mk
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw27E-0007Hu-CY
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw27B-0001Gh-V0
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:59:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw27B-0001GI-Rz
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580122773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ie9fkpG4v/gcQbHZbleauYkbPlpwvxo3vJqIIqT/WGw=;
 b=gAmCPEsjBkxMNtiYiPnOF5yK8GuA8ojaLg48IG9n5fmT4XdlT/8IMAytX7Vx1i2EKjLd4y
 kAPQwazsn/8gKHc+CKDPg6VymGkKQv52xK17lotDbHkLOzuQ6gx0ZIDkCz5fT3CMc+wG7E
 oaqy9L2jWXcNr8KxyEMxhddPwvh32z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-QarHaZkAOkqyGXW59Zx5vQ-1; Mon, 27 Jan 2020 05:59:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8885A184BBA4;
 Mon, 27 Jan 2020 10:59:28 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28BDA60BF1;
 Mon, 27 Jan 2020 10:59:23 +0000 (UTC)
Message-ID: <d5eb3c52984afca9c9afb1436313ccc1cd305e04.camel@redhat.com>
Subject: Re: [PATCH v3 00/13] RFC: [for 5.0]: HMP monitor handlers cleanups
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 27 Jan 2020 12:59:23 +0200
In-Reply-To: <158012255772.23531.2251214730955729844@f6d1ed32ca6b>
References: <158012255772.23531.2251214730955729844@f6d1ed32ca6b>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QarHaZkAOkqyGXW59Zx5vQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com, kraxel@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-01-27 at 02:55 -0800, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200127103647.17761-1-mlevitsk@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:

All of these errors are either from code that I moved, and I wanted to
move it as is and from update of iotests, which shows that some of our
error messages end with space, which is stripped by iotest filter,
but once you update the iotest output, it appears again. I'll fix that
in later version of that WIP patch.

Best regards,
	Maxim Levitsky

> 
> Type: series
> Message-id: 20200127103647.17761-1-mlevitsk@redhat.com
> Subject: [PATCH v3 00/13] RFC: [for 5.0]: HMP monitor handlers cleanups
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  - [tag update]      patchew/1579779525-20065-1-git-send-email-imammedo@redhat.com -> patchew/1579779525-20065-1-git-send-email-imammedo@redhat.com
>  - [tag update]      patchew/20200124100159.736209-1-stefanha@redhat.com -> patchew/20200124100159.736209-1-stefanha@redhat.com
>  - [tag update]      patchew/20200124162606.8787-1-peter.maydell@linaro.org -> patchew/20200124162606.8787-1-peter.maydell@linaro.org
>  - [tag update]      patchew/20200124172954.28481-1-peter.maydell@linaro.org -> patchew/20200124172954.28481-1-peter.maydell@linaro.org
>  * [new tag]         patchew/20200127103647.17761-1-mlevitsk@redhat.com -> patchew/20200127103647.17761-1-mlevitsk@redhat.com
> Switched to a new branch 'test'
> 9d7e4e6 monitor/hmp: Prefer to use hmp_handle_error for error reporting in block hmp commands
> a549971 add 'error' prefix to vreport
> 7c7da3a monitor: Move hmp_drive_add_node to block-hmp-cmds.c
> a2a0265 monitor/hmp: move hmp_info_block* to block-hmp-cmds.c
> d7f13de monitor/hmp: move remaining hmp_block* functions to block-hmp-cmds.c
> c067499 monitor/hmp: move hmp_nbd_server* to block-hmp-cmds.c
> f5fab94 monitor/hmp: move hmp_snapshot_* to block-hmp-cmds.c
> 4cb26f9 monitor/hmp: move hmp_block_job* to block-hmp-cmds.c
> 97953d5 monitor/hmp: move hmp_drive_mirror and hmp_drive_backup to block-hmp-cmds.c
> 00dc3e8 monitor/hmp: move hmp_drive_del and hmp_commit to block-hmp-cmds.c
> a4aa184 monitor/hmp: rename device-hotplug.c to block/monitor/block-hmp-cmds.c
> d76374a monitor/hmp: uninline add_init_drive
> 13decc9 usb/dev-storage: remove unused include
> 
> === OUTPUT BEGIN ===
> 1/13 Checking commit 13decc9a539d (usb/dev-storage: remove unused include)
> 2/13 Checking commit d76374a8829d (monitor/hmp: uninline add_init_drive)
> 3/13 Checking commit a4aa1842d39b (monitor/hmp: rename device-hotplug.c to block/monitor/block-hmp-cmds.c)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #58: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 83 lines checked
> 
> Patch 3/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 4/13 Checking commit 00dc3e8c0cc5 (monitor/hmp: move hmp_drive_del and hmp_commit to block-hmp-cmds.c)
> WARNING: Block comments use a leading /* on a separate line
> #81: FILE: block/monitor/block-hmp-cmds.c:119:
> +    /* If this BlockBackend has a device attached to it, its refcount will be
> 
> total: 0 errors, 1 warnings, 234 lines checked
> 
> Patch 4/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 5/13 Checking commit 97953d583c25 (monitor/hmp: move hmp_drive_mirror and hmp_drive_backup to block-hmp-cmds.c)
> 6/13 Checking commit 4cb26f9c9af1 (monitor/hmp: move hmp_block_job* to block-hmp-cmds.c)
> 7/13 Checking commit f5fab9454aca (monitor/hmp: move hmp_snapshot_* to block-hmp-cmds.c)
> WARNING: Block comments use a leading /* on a separate line
> #29: FILE: block/monitor/block-hmp-cmds.c:294:
> +        /* In the future, if 'snapshot-file' is not specified, the snapshot
> 
> WARNING: Block comments use * on subsequent lines
> #30: FILE: block/monitor/block-hmp-cmds.c:295:
> +        /* In the future, if 'snapshot-file' is not specified, the snapshot
> +           will be taken internally. Today it's actually required. */
> 
> WARNING: Block comments use a trailing */ on a separate line
> #30: FILE: block/monitor/block-hmp-cmds.c:295:
> +           will be taken internally. Today it's actually required. */
> 
> total: 0 errors, 3 warnings, 120 lines checked
> 
> Patch 7/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 8/13 Checking commit c06749935535 (monitor/hmp: move hmp_nbd_server* to block-hmp-cmds.c)
> WARNING: Block comments use a leading /* on a separate line
> #60: FILE: block/monitor/block-hmp-cmds.c:363:
> +    /* Then try adding all block devices.  If one fails, close all and
> 
> total: 0 errors, 1 warnings, 217 lines checked
> 
> Patch 8/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 9/13 Checking commit d7f13ded16b4 (monitor/hmp: move remaining hmp_block* functions to block-hmp-cmds.c)
> WARNING: Block comments use a leading /* on a separate line
> #75: FILE: block/monitor/block-hmp-cmds.c:468:
> +    /* qmp_block_set_io_throttle has separate parameters for the
> 
> WARNING: Block comments use a trailing */ on a separate line
> #77: FILE: block/monitor/block-hmp-cmds.c:470:
> +     * version has only one, so we must decide which one to pass. */
> 
> ERROR: "foo* bar" should be "foo *bar"
> #105: FILE: block/monitor/block-hmp-cmds.c:498:
> +    const char* device = qdict_get_str(qdict, "device");
> 
> ERROR: "foo* bar" should be "foo *bar"
> #106: FILE: block/monitor/block-hmp-cmds.c:499:
> +    const char* command = qdict_get_str(qdict, "command");
> 
> total: 2 errors, 2 warnings, 359 lines checked
> 
> Patch 9/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 10/13 Checking commit a2a0265c0910 (monitor/hmp: move hmp_info_block* to block-hmp-cmds.c)
> WARNING: line over 80 characters
> #67: FILE: block/monitor/block-hmp-cmds.c:593:
> +        if (info->has_io_status && info->io_status != BLOCK_DEVICE_IO_STATUS_OK) {
> 
> WARNING: Block comments use a leading /* on a separate line
> #381: FILE: block/monitor/block-hmp-cmds.c:907:
> +            /* The ID is not guaranteed to be the same on all images, so
> 
> total: 0 errors, 2 warnings, 845 lines checked
> 
> Patch 10/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 11/13 Checking commit 7c7da3a311a3 (monitor: Move hmp_drive_add_node to block-hmp-cmds.c)
> 12/13 Checking commit a549971b349f (add 'error' prefix to vreport)
> ERROR: trailing whitespace
> #51: FILE: tests/qemu-iotests/026.out:6:
> +Event: l1_update; errno: 5; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #62: FILE: tests/qemu-iotests/026.out:16:
> +Event: l1_update; errno: 5; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #79: FILE: tests/qemu-iotests/026.out:30:
> +Event: l1_update; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #90: FILE: tests/qemu-iotests/026.out:40:
> +Event: l1_update; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #107: FILE: tests/qemu-iotests/026.out:54:
> +Event: l2_load; errno: 5; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #116: FILE: tests/qemu-iotests/026.out:70:
> +Event: l2_load; errno: 5; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #125: FILE: tests/qemu-iotests/026.out:86:
> +Event: l2_load; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #134: FILE: tests/qemu-iotests/026.out:102:
> +Event: l2_load; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #143: FILE: tests/qemu-iotests/026.out:118:
> +Event: l2_update; errno: 5; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #154: FILE: tests/qemu-iotests/026.out:128:
> +Event: l2_update; errno: 5; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #171: FILE: tests/qemu-iotests/026.out:142:
> +Event: l2_update; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #182: FILE: tests/qemu-iotests/026.out:152:
> +Event: l2_update; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #199: FILE: tests/qemu-iotests/026.out:166:
> +Event: l2_alloc_write; errno: 5; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #210: FILE: tests/qemu-iotests/026.out:176:
> +Event: l2_alloc_write; errno: 5; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #227: FILE: tests/qemu-iotests/026.out:190:
> +Event: l2_alloc_write; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #238: FILE: tests/qemu-iotests/026.out:200:
> +Event: l2_alloc_write; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #255: FILE: tests/qemu-iotests/026.out:214:
> +Event: write_aio; errno: 5; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #266: FILE: tests/qemu-iotests/026.out:224:
> +Event: write_aio; errno: 5; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #283: FILE: tests/qemu-iotests/026.out:238:
> +Event: write_aio; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #294: FILE: tests/qemu-iotests/026.out:248:
> +Event: write_aio; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #311: FILE: tests/qemu-iotests/026.out:262:
> +Event: refblock_load; errno: 5; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #322: FILE: tests/qemu-iotests/026.out:272:
> +Event: refblock_load; errno: 5; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #339: FILE: tests/qemu-iotests/026.out:286:
> +Event: refblock_load; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #350: FILE: tests/qemu-iotests/026.out:296:
> +Event: refblock_load; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #367: FILE: tests/qemu-iotests/026.out:310:
> +Event: refblock_update_part; errno: 5; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #378: FILE: tests/qemu-iotests/026.out:320:
> +Event: refblock_update_part; errno: 5; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #395: FILE: tests/qemu-iotests/026.out:334:
> +Event: refblock_update_part; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #406: FILE: tests/qemu-iotests/026.out:344:
> +Event: refblock_update_part; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #423: FILE: tests/qemu-iotests/026.out:358:
> +Event: refblock_alloc; errno: 5; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #434: FILE: tests/qemu-iotests/026.out:368:
> +Event: refblock_alloc; errno: 5; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #451: FILE: tests/qemu-iotests/026.out:382:
> +Event: refblock_alloc; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #462: FILE: tests/qemu-iotests/026.out:392:
> +Event: refblock_alloc; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #479: FILE: tests/qemu-iotests/026.out:406:
> +Event: cluster_alloc; errno: 5; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #488: FILE: tests/qemu-iotests/026.out:416:
> +Event: cluster_alloc; errno: 5; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #497: FILE: tests/qemu-iotests/026.out:426:
> +Event: cluster_alloc; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #506: FILE: tests/qemu-iotests/026.out:436:
> +Event: cluster_alloc; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #515: FILE: tests/qemu-iotests/026.out:449:
> +Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #526: FILE: tests/qemu-iotests/026.out:459:
> +Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #543: FILE: tests/qemu-iotests/026.out:473:
> +Event: refblock_alloc_write; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #554: FILE: tests/qemu-iotests/026.out:483:
> +Event: refblock_alloc_write; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #571: FILE: tests/qemu-iotests/026.out:497:
> +Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #582: FILE: tests/qemu-iotests/026.out:507:
> +Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #599: FILE: tests/qemu-iotests/026.out:521:
> +Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #610: FILE: tests/qemu-iotests/026.out:531:
> +Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #627: FILE: tests/qemu-iotests/026.out:545:
> +Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write $
> 
> ERROR: trailing whitespace
> #638: FILE: tests/qemu-iotests/026.out:555:
> +Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write $
> 
> ERROR: trailing whitespace
> #781: FILE: tests/qemu-iotests/049.out:107:
> +qemu-img: error: Invalid image size specified! You may use k, M, G, T, P or E suffixes for $
> 
> ERROR: trailing whitespace
> #793: FILE: tests/qemu-iotests/049.out:116:
> +qemu-img: error: Invalid image size specified! You may use k, M, G, T, P or E suffixes for $
> 
> total: 48 errors, 0 warnings, 3053 lines checked
> 
> Patch 12/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 13/13 Checking commit 9d7e4e6ebe5d (monitor/hmp: Prefer to use hmp_handle_error for error reporting in block hmp commands)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20200127103647.17761-1-mlevitsk@redhat.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com



