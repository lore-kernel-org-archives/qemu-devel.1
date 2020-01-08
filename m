Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93642C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D9420643
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D9420643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipC1f-0005P0-Hs
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ipC0k-0004mw-4q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ipC0i-0000uZ-SD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:08:37 -0500
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:35704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ipC0i-0000rH-LK
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:08:36 -0500
Received: from player794.ha.ovh.net (unknown [10.108.57.72])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 4A3692660A0
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 15:08:34 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player794.ha.ovh.net (Postfix) with ESMTPSA id 62352AFBC6D5;
 Wed,  8 Jan 2020 14:08:30 +0000 (UTC)
Date: Wed, 8 Jan 2020 15:08:29 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v1 45/59] 9pfs/9p.c: remove unneeded labels
Message-ID: <20200108150829.6664f450@bahia.lan>
In-Reply-To: <13045963.Gd4jlxRJ09@silver>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-46-danielhb413@gmail.com>
 <13045963.Gd4jlxRJ09@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16312319329440340288
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehkedgheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.45.10
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 07 Jan 2020 13:14:20 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Montag, 6. Januar 2020 19:24:11 CET Daniel Henrique Barboza wrote:
> > 'out' label in v9fs_xattr_write() and 'out_nofid' label in
> > v9fs_complete_rename() can be replaced by appropriate return
> > calls.
> > 
> > CC: Greg Kurz <groug@kaod.org>
> > Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> > ---
> >  hw/9pfs/9p.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 520177f40c..be2beba4cd 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -2464,8 +2464,7 @@ static int v9fs_xattr_write(V9fsState *s, V9fsPDU
> > *pdu, V9fsFidState *fidp,
> > 
> > 
> >      if (fidp->fs.xattr.len < off) {
> > -        err = -ENOSPC;
> > -        goto out;
> > +        return -ENOSPC;
> >      }
> >      write_count = fidp->fs.xattr.len - off;
> >      if (write_count > count) {
> > @@ -2491,7 +2490,7 @@ static int v9fs_xattr_write(V9fsState *s, V9fsPDU
> > *pdu, V9fsFidState *fidp, off += to_copy;
> >          write_count -= to_copy;
> >      }
> > -out:
> > +
> >      return err;
> >  }
> > 
> > @@ -3056,8 +3055,7 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU
> > *pdu, V9fsFidState *fidp, if (newdirfid != -1) {
> >          dirfidp = get_fid(pdu, newdirfid);
> >          if (dirfidp == NULL) {
> > -            err = -ENOENT;
> > -            goto out_nofid;
> > +            return -ENOENT;
> >          }
> >          if (fidp->fid_type != P9_FID_NONE) {
> >              err = -EINVAL;
> > @@ -3100,7 +3098,6 @@ out:
> >          put_fid(pdu, dirfidp);
> >      }
> >      v9fs_path_free(&new_path);
> > -out_nofid:
> >      return err;
> >  }
> 
> Same as with patch 44: IMO not any improvement, but also not any behaviour 
> change at least. So it's up to you Greg.
> 

I don't really care either but as you say it doesn't change behaviour, and
and the diffstat is nice :)

Acked-by: Greg Kurz <groug@kaod.org>

> Best regards,
> Christian Schoenebeck
> 
> 


