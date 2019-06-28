Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AA1C5B57A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F392133F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F392133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqic-00088I-NQ
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39997)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hgqCy-0004jk-5Y
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hgqCw-00083J-Fl
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:42:28 -0400
Received: from 18.mo6.mail-out.ovh.net ([46.105.73.110]:46417)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hgqCw-00081a-7Q
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:42:26 -0400
Received: from player731.ha.ovh.net (unknown [10.108.57.95])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 846A01D4358
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 14:06:31 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 2EBB173FBAEB;
 Fri, 28 Jun 2019 12:06:26 +0000 (UTC)
Date: Fri, 28 Jun 2019 14:06:24 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190628140624.1408c08c@bahia.lan>
In-Reply-To: <3608455.qB9dszzTOH@silver>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <9e026ca5f087d6ef741e0d82a0067ed7cdaf129f.1561575449.git.qemu_oss@crudebyte.com>
 <20190627181203.59c956d9@bahia.lan> <3608455.qB9dszzTOH@silver>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 199847235213695296
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddtgdehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.73.110
Subject: Re: [Qemu-devel] [PATCH v4 1/5] 9p: unsigned type for type, version,
 path
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
 qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Jun 2019 13:42:43 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Donnerstag, 27. Juni 2019 18:12:03 CEST Greg Kurz wrote:
> > On Wed, 26 Jun 2019 20:25:55 +0200
> > Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> wrote:
> > > There is no need for signedness on these QID fields for 9p.
> > > 
> > > Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
> > 
> > You should mention here the changes you made on top of Antonios
> > original patch. Something like:
> > 
> > [CS: - also convert path
> >      - adapted trace-events and donttouch_stat()]
> 
> Haven't seen that comment style in the git logs. Any example hash for that?
> 

$ git log | egrep '^[[:space:]]*\[' | head -15
    [Commit message tweaked]
    [Superfluous #include dropped]
    [Comment reformatted to make checkpatch.pl happy, #include <dirent.h>
    [monitor_is_qmp() tidied up to make checkpatch.pl happy,
    [Header guard symbol tidied up, superfluous #include dropped, FIXME in
    [sortcmdlist() cleaned up to make checkpatch.pl happy]
    [Superfluous variable in monitor_data_destroy() eliminated, whitespace
    [Superfluous variable in monitor_data_destroy() eliminated]
    [Zero initialization of Monitor moved from monitor_data_init() to
        [ ... ]
        [ ... ]
    [mreitz: Dropped superfluous printf from _filter_offsets, as suggested
    [mreitz: Adjusted commit message as per John's proposal]
    [mreitz: Moved from 250 to 256]
    [AJB: fix conflicts with tests/vm: Port basevm to Python 3]

This is something you should do when re-posting someone else's patch
with modifications.

> > > diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
> > > index c0a0a4ab5d..6964756922 100644
> > > --- a/hw/9pfs/trace-events
> > > +++ b/hw/9pfs/trace-events
> > > @@ -6,7 +6,7 @@ v9fs_rerror(uint16_t tag, uint8_t id, int err) "tag %d id
> > > %d err %d"> 
> > >  v9fs_version(uint16_t tag, uint8_t id, int32_t msize, char* version) "tag
> > >  %d id %d msize %d version %s" v9fs_version_return(uint16_t tag, uint8_t
> > >  id, int32_t msize, char* version) "tag %d id %d msize %d version %s"
> > >  v9fs_attach(uint16_t tag, uint8_t id, int32_t fid, int32_t afid, char*
> > >  uname, char* aname) "tag %u id %u fid %d afid %d uname %s aname %s"> 
> > > -v9fs_attach_return(uint16_t tag, uint8_t id, int8_t type, int32_t
> > > version, int64_t path) "tag %d id %d type %d version %d path %"PRId64
> > > +v9fs_attach_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t
> > > version, uint64_t path) "tag %d id %d type %d version %d path %"PRId64
> > I was expecting to see PRIu64 for an uint64_t but I now realize that %d
> > seems to be used all over the place for unsigned types... :-\
> > 
> > At least, please fix the masks of the lines you're changing in this
> > patch so that unsigned are passed to "u" or PRIu64. The rest of the
> > mess can be fixed later in a followup.
> 
> If you don't mind I will restrict it to your latter suggestion for now, that 
> is adjusting it using the short format specifiers e.g. "u", the rest would IMO 
> be out of the scope of this patch series.
> 

Sure.

> Too bad that no format specifier warnings are thrown on these.
> 

Yeah :-\

> Best regards,
> Christian Schoenebeck


