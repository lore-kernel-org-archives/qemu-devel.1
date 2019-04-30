Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC40C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D5120652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D5120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42382 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPSE-0003iz-W8
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 05:53:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLPRL-0003M8-Rp
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLPRK-00033y-PU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:52:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLPRI-0002xq-HO; Tue, 30 Apr 2019 05:52:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C901885360;
	Tue, 30 Apr 2019 09:52:37 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6314661548;
	Tue, 30 Apr 2019 09:52:36 +0000 (UTC)
Date: Tue, 30 Apr 2019 11:52:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Message-ID: <20190430095234.GA5607@linux.fritz.box>
References: <cover.1556562150.git.berto@igalia.com>
	<08ed89d9905a7143201743ec8003058a083c7b72.1556562150.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <08ed89d9905a7143201743ec8003058a083c7b72.1556562150.git.berto@igalia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 30 Apr 2019 09:52:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/5] vvfat: Replace bdrv_{read,
 write}() with bdrv_{pread, pwrite}()
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430095234.qgvRibITwiZLoZK5AhZXAvH3HnSTOYKFPUgsKIQU-Nw@z>

Am 29.04.2019 um 20:42 hat Alberto Garcia geschrieben:
> There's only a couple of bdrv_read() and bdrv_write() calls left in
> the vvfat code, and they can be trivially replaced with the byte-based
> bdrv_pread() and bdrv_pwrite().
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/vvfat.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 5f66787890..35c7e2761f 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1494,8 +1494,8 @@ static int vvfat_read(BlockDriverState *bs, int64_t sector_num,
>                  DLOG(fprintf(stderr, "sectors %" PRId64 "+%" PRId64
>                               " allocated\n", sector_num,
>                               n >> BDRV_SECTOR_BITS));
> -                if (bdrv_read(s->qcow, sector_num, buf + i * 0x200,
> -                              n >> BDRV_SECTOR_BITS)) {
> +                if (bdrv_pread(s->qcow, sector_num * BDRV_SECTOR_SIZE,
> +                               buf + i * 0x200, n)) {

bdrv_pread() returns a positive number of bytes in the success case, so
this error check is wrong. (No real reason why it couldn't return 0, but
we would have to check and possibly update all callers, so we never did
that.)

>                      return -1;
>                  }
>                  i += (n >> BDRV_SECTOR_BITS) - 1;
> @@ -1983,7 +1983,8 @@ static uint32_t get_cluster_count_for_direntry(BDRVVVFATState* s,
>                          if (res) {
>                              return -1;
>                          }
> -                        res = bdrv_write(s->qcow, offset, s->cluster_buffer, 1);
> +                        res = bdrv_pwrite(s->qcow, offset * BDRV_SECTOR_SIZE,
> +                                          s->cluster_buffer, BDRV_SECTOR_SIZE);
>                          if (res) {

Same here, this needs to be res < 0 now.

>                              return -2;
>                          }
> @@ -3050,7 +3051,8 @@ DLOG(checkpoint());
>       * Use qcow backend. Commit later.
>       */
>  DLOG(fprintf(stderr, "Write to qcow backend: %d + %d\n", (int)sector_num, nb_sectors));
> -    ret = bdrv_write(s->qcow, sector_num, buf, nb_sectors);
> +    ret = bdrv_pwrite(s->qcow, sector_num * BDRV_SECTOR_SIZE, buf,
> +                      nb_sectors * BDRV_SECTOR_SIZE);
>      if (ret < 0) {

This one is already correct.

>          fprintf(stderr, "Error writing to qcow backend\n");
>          return ret;

Kevin

