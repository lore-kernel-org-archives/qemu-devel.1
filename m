Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8768DC3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7922341B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7922341B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3hkQ-000468-2F
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 10:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i3hgL-0001fT-85
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i3hgF-000122-2X
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:15:13 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:34258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i3hgE-0000N2-Pw
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:15:10 -0400
Received: from player734.ha.ovh.net (unknown [10.108.57.153])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id C894E117DC5
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 13:48:32 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id CB6319364678;
 Fri, 30 Aug 2019 11:48:28 +0000 (UTC)
Date: Fri, 30 Aug 2019 13:48:27 +0200
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Message-ID: <20190830134827.326dc87a@bahia.lan>
In-Reply-To: <5352483.8Ep87BTfyf@silver>
References: <cover.1562154272.git.qemu_oss@crudebyte.com>
 <ec68cd4c68726f09cb340348f682265060d914d4.1562154272.git.qemu_oss@crudebyte.com>
 <5352483.8Ep87BTfyf@silver>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 941252326133111104
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeigedggeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.49
Subject: Re: [Qemu-devel] [PATCH v5 3/5] 9p: Added virtfs option
 'remap_inodes'
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 06 Jul 2019 12:22:27 +0200
Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> wrote:

> On Mittwoch, 3. Juli 2019 13:13:26 CEST Christian Schoenebeck wrote:
> > To support multiple devices on the 9p share, and avoid
> > qid path collisions we take the device id as input
> [snip]
> >      - Fixed v9fs_do_readdir() having exposed info outside
> >        export root with '..' entry.
> [snip]
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 8cc65c2c67..39c6c2a894 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> [snip]
> > @@ -1940,6 +2041,19 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu,
> > V9fsFidState *fidp, int32_t count = 0;
> >      off_t saved_dir_pos;
> >      struct dirent *dent;
> > +    struct stat stbuf;
> > +    bool fidIsExportRoot;
> > +
> > +    /*
> > +     * determine if fidp is the export root, which is required for safe
> > +     * handling of ".." below
> > +     */
> > +    err = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
> > +    if (err < 0) {
> > +        return err;
> > +    }
> > +    fidIsExportRoot = pdu->s->dev_id == stbuf.st_dev &&
> > +                      pdu->s->root_ino == stbuf.st_ino;
> > 
> >      /* save the directory position */
> >      saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> > @@ -1964,16 +2078,51 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU
> > *pdu, V9fsFidState *fidp, v9fs_string_free(&name);
> >              return count;
> >          }
> > -        /*
> > -         * Fill up just the path field of qid because the client uses
> > -         * only that. To fill the entire qid structure we will have
> > -         * to stat each dirent found, which is expensive
> > -         */
> > -        size = MIN(sizeof(dent->d_ino), sizeof(qid.path));
> > -        memcpy(&qid.path, &dent->d_ino, size);
> > -        /* Fill the other fields with dummy values */
> > -        qid.type = 0;
> > -        qid.version = 0;
> > +
> > +        if (fidIsExportRoot && !strcmp("..", dent->d_name)) {
> > +            /*
> > +             * if "." is export root, then return qid of export root for
> > +             * ".." to avoid exposing anything outside the export
> > +             */
> > +            err = fid_to_qid(pdu, fidp, &qid);
> > +            if (err < 0) {
> > +                v9fs_readdir_unlock(&fidp->fs.dir);
> > +                v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> > +                v9fs_string_free(&name);
> > +                return err;
> > +            }
> 
> Hmm, I start to wonder whether I should postpone that particular bug fix and 
> not make it part of that QID fix patch series (not even as separate patch 
> there). Because that fix needs some more adjustments. E.g. I should adjust 
> dent->d_type here as well; but more notably it should also distinguish between 
> the case where the export root is mounted as / on guest or not and that's 
> where this fix could become ugly and grow in size.
> 
> To make the case clear:  calling on guest	
> 
> 	readdir(pathOfSome9pExportRootOnGuest);
> 
> currently always returns for its ".." result entry the inode number and d_type 
> of the export root's parent directory on host, so it exposes information of 
> host outside the 9p export.
> 
> I don't see that as security issue, since the information revealed is limited 
> to the inode number and d_type, but it is definitely incorrect behaviour.
> 

Definitely. This should be fixed independently of this series. Maybe follow
the same approach as commit 56f101ecce0e "9pfs: handle walk of ".." in the
root directory", ie. basically make /.. an alias of /.

> Best regards,
> Christian Schoenebeck
> 


