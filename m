Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E3FC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984A5214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984A5214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAW8t-0006Of-8q
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iAW6m-0005UF-9Y
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iAW6l-0004EY-6d
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:18:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48548)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iAW6k-0004Cd-Sp
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:18:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 18889356C9;
 Wed, 18 Sep 2019 09:18:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-230.ams2.redhat.com
 [10.36.116.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 640331001DC0;
 Wed, 18 Sep 2019 09:18:33 +0000 (UTC)
Date: Wed, 18 Sep 2019 11:18:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Message-ID: <20190918091831.GD5207@localhost.localdomain>
References: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
 <156872148244.1757.2888672921697745021.stgit@pasha-Precision-3630-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156872148244.1757.2888672921697745021.stgit@pasha-Precision-3630-Tower>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 18 Sep 2019 09:18:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [for-4.2 PATCH 3/6] replay: update docs for
 record/replay with block devices
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
Cc: peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com,
 quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 crosthwaite.peter@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com,
 alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, mreitz@redhat.com, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.09.2019 um 13:58 hat Pavel Dovgalyuk geschrieben:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> This patch updates the description of the command lines for using
> record/replay with attached block devices.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  docs/replay.txt |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/replay.txt b/docs/replay.txt
> index ee6aee9861..ce97c3f72f 100644
> --- a/docs/replay.txt
> +++ b/docs/replay.txt
> @@ -27,7 +27,7 @@ Usage of the record/replay:
>   * First, record the execution with the following command line:
>      qemu-system-i386 \
>       -icount shift=7,rr=record,rrfile=replay.bin \
> -     -drive file=disk.qcow2,if=none,id=img-direct \
> +     -drive file=disk.qcow2,if=none,snapshot,id=img-direct \
>       -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
>       -device ide-hd,drive=img-blkreplay \
>       -netdev user,id=net1 -device rtl8139,netdev=net1 \
> @@ -35,7 +35,7 @@ Usage of the record/replay:
>   * After recording, you can replay it by using another command line:
>      qemu-system-i386 \
>       -icount shift=7,rr=replay,rrfile=replay.bin \
> -     -drive file=disk.qcow2,if=none,id=img-direct \
> +     -drive file=disk.qcow2,if=none,snapshot,id=img-direct \
>       -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
>       -device ide-hd,drive=img-blkreplay \
>       -netdev user,id=net1 -device rtl8139,netdev=net1 \
> @@ -223,7 +223,7 @@ Block devices record/replay module intercepts calls of
>  bdrv coroutine functions at the top of block drivers stack.
>  To record and replay block operations the drive must be configured
>  as following:
> - -drive file=disk.qcow2,if=none,id=img-direct
> + -drive file=disk.qcow2,if=none,snapshot,id=img-direct
>   -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay
>   -device ide-hd,drive=img-blkreplay
>  
> @@ -252,6 +252,12 @@ This snapshot is created at start of recording and restored at start
>  of replaying. It also can be loaded while replaying to roll back
>  the execution.
>  
> +'snapshot' flag of the disk image must be removed to save the snapshots
> +in the overlay (or original image) instead of using the temporary overlay.
> + -drive file=disk.ovl,if=none,id=img-direct
> + -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay
> + -device ide-hd,drive=img-blkreplay

Wait, didn't patch 2 just make -snapshot unconditionally incompatible
with replay? So isn't saving the snapshot in the original image the only
supported mode now?

Kevin

