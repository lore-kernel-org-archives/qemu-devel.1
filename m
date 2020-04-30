Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEA5C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383E22082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383E22082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9W7-0004lL-90
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jU9Kn-000861-5X
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jU9HE-0004lh-AN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:34:36 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:45947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jU9HD-0004kp-Q9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:30:55 -0400
Received: from player758.ha.ovh.net (unknown [10.110.171.131])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 9DA901653C8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 15:30:52 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player758.ha.ovh.net (Postfix) with ESMTPSA id F2BDB11F18A11;
 Thu, 30 Apr 2020 13:30:50 +0000 (UTC)
Date: Thu, 30 Apr 2020 15:30:49 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v6 3/5] 9pfs: add new function v9fs_co_readdir_many()
Message-ID: <20200430153049.12488a1d@bahia.lan>
In-Reply-To: <5059845.6LZZmIoT5M@silver>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <fdb0e29a86d1df6005021a08078d7e69ed0de1a2.1587309014.git.qemu_oss@crudebyte.com>
 <20200430134235.524df46e@bahia.lan> <5059845.6LZZmIoT5M@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15207530042828626240
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrieehgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.79.203; envelope-from=groug@kaod.org;
 helo=10.mo68.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:30:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 46.105.79.203
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 14:50:31 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Donnerstag, 30. April 2020 13:42:35 CEST Greg Kurz wrote:
> > > +/*
> > > + * This is solely executed on a background IO thread.
> > > + *
> > > + * See v9fs_co_readdir_many() (as its only user) below for details.
> > > + */
> > > +static int do_readdir_many(V9fsPDU *pdu, V9fsFidState *fidp,
> > > +                             struct V9fsDirEnt **entries,
> > > +                             int32_t maxsize, bool dostat)
> > > +{
> > > +    V9fsState *s = pdu->s;
> > > +    V9fsString name;
> > > +    int len, err = 0;
> > > +    int32_t size = 0;
> > > +    off_t saved_dir_pos;
> > > +    struct dirent *dent;
> > > +    struct V9fsDirEnt *e = NULL;
> > > +    V9fsPath path;
> > > +    struct stat stbuf;
> > > 
> > > -            errno = 0;
> > > -            entry = s->ops->readdir(&s->ctx, &fidp->fs);
> > > -            if (!entry && errno) {
> > > +    *entries = NULL;
> > > +    v9fs_path_init(&path);
> > > +
> > > +    /*
> > > +     * TODO: Here should be a warn_report_once() if lock failed.
> > > +     *
> > > +     * With a good 9p client we should not get into concurrency here,
> > > +     * because a good client would not use the same fid for concurrent
> > > +     * requests. We do the lock here for safety reasons though. However
> > > +     * the client would then suffer performance issues, so better log
> > > that
> > > +     * issue here.
> > > +     */
> > > +    v9fs_readdir_lock(&fidp->fs.dir);
> > 
> > I agree that a client that issues concurrent readdir requests on the
> > same fid is probably asking for troubles, but this permitted by the
> > spec. Whether we should detect such conditions and warn or even fail
> > is discussion for another thread.
> > 
> > The locking is only needed to avoid concurrent accesses to the dirent
> > structure returned by readdir(), otherwise we could return partially
> > overwritten file names to the client. It must be done for each individual
> > call to readdir(), but certainly not for multiple calls.
> 
> Yeah, that would resolve this issue more appropriately for 9p2000.L, since 
> Treaddir specifies an offset, but for 9p2000.u the result of a concurrent read 
> on a directory (9p2000.u) would still be undefined.
> 

The bad client behavior you want to tackle has nothing to do with
the locking itself. Since all the code in 9p.c runs serialized in
the context of the QEMU main loop, concurrent readdir requests could
easily be detected up-front with a simple flag in the fid structure.

> > As discussed privately, I'm working on a patch to better address the
> > locking and I'd really prefer to merge this before your series. Sorry
> > for the delay again. I'll try to post ASAP.
> > 
> > Anyway, I have some more remarks.
> > 
> > > +
> > > +    /* save the directory position */
> > > +    saved_dir_pos = s->ops->telldir(&s->ctx, &fidp->fs);
> > > +    if (saved_dir_pos < 0) {
> > > +        err = saved_dir_pos;
> > > +        goto out;
> > > +    }
> > > +
> > > +    while (true) {
> > > +        /* get directory entry from fs driver */
> > > +        err = do_readdir(pdu, fidp, &dent);
> > > +        if (err || !dent) {
> > > +            break;
> > > +        }
> > > +
> > > +        /*
> > > +         * stop this loop as soon as it would exceed the allowed maximum
> > > +         * response message size for the directory entries collected so
> > > far, +         * because anything beyond that size would need to be
> > > discarded by +         * 9p controller (main thread / top half) anyway
> > > +         */
> > > +        v9fs_string_init(&name);
> > > +        v9fs_string_sprintf(&name, "%s", dent->d_name);
> > > +        len = v9fs_readdir_response_size(&name);
> > > +        v9fs_string_free(&name);
> > > +        if (size + len > maxsize) {
> > > +            /* this is not an error case actually */
> > > +            break;
> > > +        }
> > > +
> > > +        /* append next node to result chain */
> > > +        if (!e) {
> > > +            *entries = e = g_malloc0(sizeof(V9fsDirEnt));
> > > +        } else {
> > > +            e = e->next = g_malloc0(sizeof(V9fsDirEnt));
> > > +        }
> > > +        e->dent = g_malloc0(sizeof(struct dirent));
> > 
> > So we're allocating a bunch of stuff here...
> > 
> > > +        memcpy(e->dent, dent, sizeof(struct dirent));
> > > +
> > > +        /* perform a full stat() for directory entry if requested by
> > > caller */ +        if (dostat) {
> > > +            err = s->ops->name_to_path(
> > > +                &s->ctx, &fidp->path, dent->d_name, &path
> > > +            );
> > > +            if (err < 0) {
> > > 
> > >                  err = -errno;
> > > 
> > > -            } else {
> > > -                *dent = entry;
> > > -                err = 0;
> > > +                break;
> > 
> > ... but we're erroring out there and it seems that we're leaking
> > all the entries that have been allocated so far.
> 
> No, they are not leaking actually.
> 
> You are right that they are not deallocated in do_readdir_many(), but that's 
> intentional: in the new implementation of v9fs_do_readdir() you see that 
> v9fs_free_dirents(entries) is *always* called at the very end of the function, 
> no matter if success or any error. That's one of the measures to simplify 
> overall code as much as possible.
> 

Hmm... I still don't quite like the idea of having an erroring function
asking for extra cleanup. I suggest you come up with an idem-potent version
of v9fs_free_dirents(), move it to codir.c (I also prefer locality of calls
to g_malloc and g_free in the same unit), make it extern and call it
both on the error path of v9fs_co_readdir_many() and in v9fs_do_readdir().

> As you might have noticed, the previous/current v9fs_do_readdir() 
> implementation had quite a bunch of individual error pathes, which is quite 
> error prone or at least makes it difficult to maintain. So I think it makes 
> sense to strip unnecessary branches as much as possible.
> 
> > Also I have the impression that all the if (dostat) { } block could
> > be done before chaining a new entry.
> 
> Yes, you could move it forward, but what would you buy from that?
> 

It just seems a better practice to do the things that can fail up front.

> I think you mean the case when there's an error inside the if (dostat) {} 
> block: The comments on struct V9fsDirEnt already suggest that the "st" member 
> is optional and may be NULL. So if there's an error inside if (dostat) {}
> then caller still has a valid "dent" field at least and it's up to caller 
> whether or not it's a problem for its purpose that "st" is empty. For that 
> reason I would not move the block forward.
> 

Hrm... the comment is:

    /*
     * optional (may be NULL): A full stat of each directory entry is just
     * done if explicitly told to fs driver.
     */

I don't read that it is optional for the fs driver to populate "st"
if this was required by the caller. Also, looking at the next patch
I see that the condition for calling stat() is V9FS_REMAP_INODES and
the code explicitly requires "st" to be available in this case.

> Best regards,
> Christian Schoenebeck
> 
> 

Cheers,

--
Greg

