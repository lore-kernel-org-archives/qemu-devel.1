Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2A3C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F985206C2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F985206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHPfk-0006Oa-Az
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 05:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHPek-0005O4-UA
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHPej-00009r-Ka
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:50:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iHPee-00006A-Qm; Mon, 07 Oct 2019 05:50:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B69963082E42;
 Mon,  7 Oct 2019 09:50:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCF0260C05;
 Mon,  7 Oct 2019 09:50:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 48F941138648; Mon,  7 Oct 2019 11:49:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 1/1] IDE: deprecate ide-drive
References: <20191006203150.13054-1-jsnow@redhat.com>
 <20191006203150.13054-2-jsnow@redhat.com>
Date: Mon, 07 Oct 2019 11:49:52 +0200
In-Reply-To: <20191006203150.13054-2-jsnow@redhat.com> (John Snow's message of
 "Sun, 6 Oct 2019 16:31:50 -0400")
Message-ID: <87pnj8holb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 07 Oct 2019 09:50:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> It's an old compatibility shim that just delegates to ide-cd or ide-hd.
> I'd like to refactor these some day, and getting rid of the super-object
> will make that easier.

Device "scsi-disk" is similar.  However, it's still used by the
scsi_bus_legacy_add_drive() magic.  Not sure that's fully deprecated,
yet.  If / once it is, we can deprecate "scsi-disk", too.  Anyway, not
your department.

> Either way, we don't need this.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qemu-deprecated.texi          | 5 +++++
>  hw/ide/qdev.c                 | 3 +++
>  tests/qemu-iotests/051.pc.out | 6 ++++--
>  3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 01245e0b1c4..f802d83983e 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -247,6 +247,11 @@ quite a bit. It will be removed without replacement unless some users speaks
>  up at the @email{qemu-devel@@nongnu.org} mailing list with information about
>  their usecases.
>  
> +@subsection ide-drive (since 4.2)
> +
> +The 'ide-drive' device is deprecated. Users should use 'ide-hd' or
> +'ide-cd' as appropriate to get an IDE hard disk or CDROM as needed.

CD-ROM

> +
>  @section System emulator machines
>  
>  @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index 6fba6b62b87..9ecee4da074 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -279,6 +279,9 @@ static void ide_drive_realize(IDEDevice *dev, Error **errp)
>  {
>      DriveInfo *dinfo = NULL;
>  
> +    warn_report("The 'ide-drive' device is deprecated. "
> +                "Use 'ide-hd' or 'ide-cd' instead");

Two sentences, where only the first one terminated with a period.

Let's say "is deprecated, please use", like we do in several other places.

> +
>      if (dev->conf.blk) {
>          dinfo = blk_legacy_dinfo(dev->conf.blk);
>      }
> diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
> index 000557c7c83..93b9a1f82ca 100644
> --- a/tests/qemu-iotests/051.pc.out
> +++ b/tests/qemu-iotests/051.pc.out
> @@ -158,7 +158,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  
>  Testing: -drive if=none,id=disk -device ide-drive,drive=disk
>  QEMU X.Y.Z monitor - type 'help' for more information
> -(qemu) QEMU_PROG: -device ide-drive,drive=disk: Device needs media, but drive is empty
> +(qemu) QEMU_PROG: -device ide-drive,drive=disk: warning: The 'ide-drive' device is deprecated. Use 'ide-hd' or 'ide-cd' instead
> +QEMU_PROG: -device ide-drive,drive=disk: Device needs media, but drive is empty
>  
>  Testing: -drive if=none,id=disk -device ide-hd,drive=disk
>  QEMU X.Y.Z monitor - type 'help' for more information
> @@ -228,7 +229,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  
>  Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-drive,drive=disk
>  QEMU X.Y.Z monitor - type 'help' for more information
> -(qemu) QEMU_PROG: -device ide-drive,drive=disk: Block node is read-only
> +(qemu) QEMU_PROG: -device ide-drive,drive=disk: warning: The 'ide-drive' device is deprecated. Use 'ide-hd' or 'ide-cd' instead
> +QEMU_PROG: -device ide-drive,drive=disk: Block node is read-only
>  
>  Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-hd,drive=disk
>  QEMU X.Y.Z monitor - type 'help' for more information

A few iotests still use ide-drive.  Should any of them be converted to
ide-hd or ide-cd now?

