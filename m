Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3B0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 06:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293AD20770
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 06:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293AD20770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGcQR-0001V0-W3
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 02:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGcPi-0000vl-M4; Fri, 11 Sep 2020 02:20:02 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:42451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGcPg-0001Ao-Jr; Fri, 11 Sep 2020 02:20:02 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.68])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 600A159DBB2D;
 Fri, 11 Sep 2020 08:19:34 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 11 Sep
 2020 08:19:33 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001b79c65f0-0046-4da6-a893-3f4a7bb6957f,
 864FBEA0465FE1F0C66A9C6AC37977A76827B8ED) smtp.auth=groug@kaod.org
Date: Fri, 11 Sep 2020 08:19:32 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 07/14] block/blklogwrites: drop error propagation
Message-ID: <20200911081932.666d246f@bahia.lan>
In-Reply-To: <87r1r8g9s2.fsf@dusky.pond.sub.org>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-8-vsementsov@virtuozzo.com>
 <20200910192440.695b8e81@bahia.lan>
 <878sdghoox.fsf@dusky.pond.sub.org>
 <87r1r8g9s2.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: f0e476a5-7b7a-4b4d-9de4-c94beaa364d3
X-Ovh-Tracer-Id: 1654509914147887608
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehkedguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheprghrihesthhugigvrhgrrdgtohhm
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 02:19:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 berto@igalia.com, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Sep 2020 07:30:37 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Greg Kurz <groug@kaod.org> writes:
> >
> >> On Wed,  9 Sep 2020 21:59:23 +0300
> >> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> >>
> >>> It's simple to avoid error propagation in blk_log_writes_open(), we
> >>> just need to refactor blk_log_writes_find_cur_log_sector() a bit.
> >>> 
> >>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>> ---
> >>>  block/blklogwrites.c | 23 +++++++++++------------
> >>>  1 file changed, 11 insertions(+), 12 deletions(-)
> >>> 
> >>> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
> >>> index 7ef046cee9..c7da507b2d 100644
> >>> --- a/block/blklogwrites.c
> >>> +++ b/block/blklogwrites.c
> >>> @@ -96,10 +96,10 @@ static inline bool blk_log_writes_sector_size_valid(uint32_t sector_size)
> >>>          sector_size < (1ull << 24);
> >>>  }
> >>>  
> >>> -static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
> >>> -                                                   uint32_t sector_size,
> >>> -                                                   uint64_t nr_entries,
> >>> -                                                   Error **errp)
> >>> +static int64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
> >>> +                                                  uint32_t sector_size,
> >>> +                                                  uint64_t nr_entries,
> >>> +                                                  Error **errp)
> >>>  {
> >>>      uint64_t cur_sector = 1;
> >>>      uint64_t cur_idx = 0;
> >>> @@ -112,13 +112,13 @@ static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
> >>>          if (read_ret < 0) {
> >>>              error_setg_errno(errp, -read_ret,
> >>>                               "Failed to read log entry %"PRIu64, cur_idx);
> >>> -            return (uint64_t)-1ull;
> >>> +            return read_ret;
> >>
> >> This changes the error status of blk_log_writes_open() from -EINVAL to
> >> whatever is returned by bdrv_pread(). I guess this is an improvement
> >> worth to be mentioned in the changelog.
> >>
> >>>          }
> >>>  
> >>>          if (cur_entry.flags & ~cpu_to_le64(LOG_FLAG_MASK)) {
> >>>              error_setg(errp, "Invalid flags 0x%"PRIx64" in log entry %"PRIu64,
> >>>                         le64_to_cpu(cur_entry.flags), cur_idx);
> >>> -            return (uint64_t)-1ull;
> >>> +            return -EINVAL;
> >>>          }
> >>>  
> >>>          /* Account for the sector of the entry itself */
> >>> @@ -143,7 +143,6 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
> >>>  {
> >>>      BDRVBlkLogWritesState *s = bs->opaque;
> >>>      QemuOpts *opts;
> >>> -    Error *local_err = NULL;
> >>>      int ret;
> >>>      uint64_t log_sector_size;
> >>>      bool log_append;
> >>> @@ -215,15 +214,15 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
> >>>          s->nr_entries = 0;
> >>>  
> >>>          if (blk_log_writes_sector_size_valid(log_sector_size)) {
> >>> -            s->cur_log_sector =
> >>> +            int64_t cur_log_sector =
> >>>                  blk_log_writes_find_cur_log_sector(s->log_file, log_sector_size,
> >>> -                                    le64_to_cpu(log_sb.nr_entries), &local_err);
> >>> -            if (local_err) {
> >>> -                ret = -EINVAL;
> >>> -                error_propagate(errp, local_err);
> >>> +                                    le64_to_cpu(log_sb.nr_entries), errp);
> >>> +            if (cur_log_sector < 0) {
> >>> +                ret = cur_log_sector;
> >>
> >> This is converting int64_t to int, which is usually not recommended.
> >> In practice this is probably okay because cur_log_sector is supposed
> >> to be a negative errno (ie. an int) in this case.
> >
> > It isn't: blk_log_writes_find_cur_log_sector() returns (uint64_t)-1ull
> > on error.
> >
> > Aside: returning uint64_t is awkward.  We commonly use a signed integer
> > for non-negative offset or negative error.
> >
> >> Maybe make this clear with a an assert(cur_log_sector >= INT_MIN) ?
> >
> > Unless we change blk_log_writes_find_cur_log_sector() to return a
> > negative errno code,
> 
> Which the patch does.  I shouldn't review patches before breakfast.
> 

:)

> > negative errno code, we need to ret = -EINVAL here.  Let's keep this
> > series simple.
> 
> No, the patch is okay as is.
> 
> Dumbing it down to keep it simple would also be okay.
> 

What about Ari's proposal to add ERRP_GUARD() and check errors
with "if (*errp)" like we do for void functions ?

> Regarding the proposed assertion: do we protect similar conversions from
> over-wide negative errno int elsewhere?
> 

We do protect int64_t->int conversions in a few places, eg.
qcow2_write_snapshots() or qemu_spice_create_host_primary(),
but I couldn't find one about a negarive errno.

> >>>                  goto fail_log;
> >>>              }
> >>>  
> >>> +            s->cur_log_sector = cur_log_sector;
> >>>              s->nr_entries = le64_to_cpu(log_sb.nr_entries);
> >>>          }
> >>>      } else {
> 


