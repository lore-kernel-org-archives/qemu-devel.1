Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BC0C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 15:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0A621744
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 15:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0A621744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4oOQ-00042m-0O
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 11:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i4oLs-0001tQ-Hp
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 11:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i4oLq-0003ZM-Eg
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 11:34:44 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:34724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i4oLq-0003Vq-6J
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 11:34:42 -0400
Received: from player778.ha.ovh.net (unknown [10.109.160.253])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 51D5F24BD04
 for <qemu-devel@nongnu.org>; Mon,  2 Sep 2019 17:34:39 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 50A7994A2265;
 Mon,  2 Sep 2019 15:34:33 +0000 (UTC)
Date: Mon, 2 Sep 2019 17:34:32 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190902173432.20f2637b@bahia.lan>
In-Reply-To: <21182000.2zn5IIMESL@silver>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <156651233307.28865.18175668587519528989@5dec9699b7de>
 <20190829190234.41c8d988@bahia.lan> <21182000.2zn5IIMESL@silver>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3931079528154437952
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejtddgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.182.191
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
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
Cc: stefanha@gmail.com, berrange@redhat.com, qemu-devel@nongnu.org,
 antonios.motakis@huawei.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 01 Sep 2019 21:28:45 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Donnerstag, 29. August 2019 19:02:34 CEST Greg Kurz wrote:
> > On Thu, 22 Aug 2019 15:18:54 -0700 (PDT)
> > 
> > no-reply@patchew.org wrote:
> > > Patchew URL:
> > > https://patchew.org/QEMU/cover.1566503584.git.qemu_oss@crudebyte.com/
> > > 
> > > 
> > > 
> > > Hi,
> > > 
> > > This series seems to have some coding style problems. See output below for
> > > more information:
> [snip]
> > > 
> > > === OUTPUT BEGIN ===
> > > 1/4 Checking commit bb69de63f788 (9p: Treat multiple devices on one export
> > > as an error) ERROR: Author email address is mangled by the mailing list
> > > #2:
> > > Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
> > 
> > This is problematic since it ends up in the Author: field in git. Please
> > find a way to fix that.
> 
> Like in which way do you imagine that? And where is the actual practical 
> problem? I mean every patch still has my signed-off-by tag with the correct 
> email address ending up in git history.
> 

Yes, this only breaks Author: if the patch is applied from the list.

> The cause for this issue is that the domain is configured to require DKIM 
> signatures for all outgoing emails. That's why mailman replaces my address by
> "Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>" placeholder 
> since it could not provide a valid signature.
> 
> There were good reasons for enabling DKIM and it is a good thing for all 
> domains in general, since that ensures that (i.e. foreign) email addresses 
> cannot be used as sender address if the actual sender is not authorized for 
> sending emails with that address.
> 

Don't know much about DKIM but google seems to confirm what you say. So,
this means that patchew will complain each time you post if we can't find
a proper way to address that... :-\

> What I changed in the meantime though is that you should get all my patches 
> directly to your personal address, not only from the list. Or did you receive 
> v6 again just from the list?
> 

I've received the patches in my mailbox but I prefer to use the patchwork's
pwclient CLI to apply patches... and patchwork captures the patches from
the list, so I end up having to patch the authorship manually anyway.

How are you sending patches ? With git send-email ? If so, maybe you can pass
something like --from='"Christian Schoenebeck" <qemu_oss@crudebyte.com>'.
Since this is a different string, git will assume you're sending someone else's
patch : it will automatically add an extra From: made out of the commit Author
as recorded in the git tree.

> > Other warnings/errors should also be fixed but they look trivial.
> 
> Yeah, they are trivial. *But* there is one thing ...
> 
> > > Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
> > > 
> > > ERROR: space prohibited after that open parenthesis '('
> > > #92: FILE: hw/9pfs/9p.c:586:
> > > +    return ((uint64_t)mirror8bit( value        & 0xff) << 56) |
> > > 
> > > ERROR: space prohibited before that close parenthesis ')'
> > > #98: FILE: hw/9pfs/9p.c:592:
> > > +           ((uint64_t)mirror8bit((value >> 48) & 0xff) << 8 ) |
> > > 
> > > ERROR: space prohibited before that close parenthesis ')'
> > > #99: FILE: hw/9pfs/9p.c:593:
> > > +           ((uint64_t)mirror8bit((value >> 56) & 0xff)      ) ;
> 
> ... I would like to ignore this specific bot whining, because that particular 
> function looks much more readable the way it is (in that patch) right now.

Prettier certainly but...

/* Same as mirror8bit() just for a 64 bit data type instead for a byte. */
static inline uint64_t mirror64bit(uint64_t value)
{
    return ((uint64_t)mirror8bit(value         & 0xff) << 56) |
           ((uint64_t)mirror8bit((value >> 8)  & 0xff) << 48) |
           ((uint64_t)mirror8bit((value >> 16) & 0xff) << 40) |
           ((uint64_t)mirror8bit((value >> 24) & 0xff) << 32) |
           ((uint64_t)mirror8bit((value >> 32) & 0xff) << 24) |
           ((uint64_t)mirror8bit((value >> 40) & 0xff) << 16) |
           ((uint64_t)mirror8bit((value >> 48) & 0xff) <<  8) |
           ((uint64_t)mirror8bit((value >> 56) & 0xff));
}

... is readable enough IMHO and makes checkpatch happy :)

> 
> > > WARNING: Block comments use a leading /* on a separate line
> > > #102: FILE: hw/9pfs/9p.c:596:
> > > +/** @brief Parameter k for the Exponential Golomb algorihm to be used.
> > > 
> > > WARNING: Block comments use a leading /* on a separate line
> > > #121: FILE: hw/9pfs/9p.c:615:
> > > +/** @brief Exponential Golomb algorithm for arbitrary k (including k=0).
> > > 
> > > WARNING: Block comments use a leading /* on a separate line
> > > #148: FILE: hw/9pfs/9p.c:642:
> > > +/** @brief Converts a suffix into a prefix, or a prefix into a suffix.


