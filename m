Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182F9C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54AF2075A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="XTjdOyUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54AF2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUSt-000610-Uh
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ioU1a-0008EB-PD
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ioU1Y-0004iz-TP
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:10:34 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:49699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ioU1Y-0004i0-Bu
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=yb2suF/OENmaPwybHdvuGFCLAgQc3CdKMbNFMNk5UBM=; b=XTjdOyUPuGd2pq0rYfDCRPTn/U
 uFfGaWZCaqOctN4doLIicsDrL3n69YV9qbs5SraK0YTLLY24ID/Ep3KR434RDYaDYbJyjGFgTqvWq
 wm4pQ8KrBVe/pBw+8Qo6vJcp59+DTh91h3TwsYQFKhh3xq10yJJtJcwuNsMajz8gxzRGDwq1XdWUD
 AUR3JLcFSpy2fLTdFy2mhxgPISORJTCdkhU7qfgV6+yMEeJeAWz7oLr8RxaESPE1H4HBA8LdjupIG
 6eAOO4/Ccjdw1e3yd8kBGtR1V0/HwBTrYGe0vVIzCBiRkeqQ+cQX0KmxWPi6YPtITU2ETGOjYzm7f
 691U0FeAuIyqpsgUMsFfGnEycnb5MCRreIoDD8lacqZspH/F0DbmJnYG5QWTXvxH8/RkGqzfFXehH
 ZDYHe0ZOIoXGNhWda2NqHqLwfV14QSOlt5Te7fnDcFoYOpZxFDqXKHCvJL5K3zUKql0kxd/gpb21C
 ZS+YBFXUoDFUe+2Uxe6wn2DHI1Z5Vvu4ESg0ngfdNaqYDZjhh4in1pZgYAEuhYPU5xRpLVhmp6TeU
 4zjILgnWi8ZXCp5uMuKh6vIJvfSutfT+6BRl5A6IWNmhVJcOSgzf1ZDqruTKQNrzL3jYPdZ3JjNJb
 x3VBy+FQkExmzlRJtVFjD/jj+cB+FgVzlJ2ymOG30=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Stefano Stabellini <sstabellini@kernel.org>, anthony.perard@citrix.com,
 Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 2/9] 9pfs: validate count sent by client with T_readdir
Date: Mon, 06 Jan 2020 16:10:28 +0100
Message-ID: <6289486.8nMSniMWIK@silver>
In-Reply-To: <20200106133024.2ce31324@bahia.lan>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
 <4866c87cb19f3191b977fc7fbe2857abf1da80b6.1576678644.git.qemu_oss@crudebyte.com>
 <20200106133024.2ce31324@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 6. Januar 2020 13:30:24 CET Greg Kurz wrote:
> On Wed, 18 Dec 2019 14:17:59 +0100
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > A good 9p client sends T_readdir with "count" parameter that's
> > sufficiently smaller than client's initially negotiated msize
> > (maximum message size). We perform a check for that though to
> > avoid the server to be interrupted with a "Failed to encode
> > VirtFS reply type 41" error message by bad clients.
> 
> Hmm... doesn't v9fs_do_readdir() already take care of that ?

No, unfortunately it doesn't. It just looks at the "count" parameter 
transmitted with client's T_readdir request, but not at session's msize.
So a bad client could send a T_readdir request with a "count" parameter that's 
substantially higher than session's msize, which would lead to that mentioned 
transport error ATM. Hence I suggested this patch here to address it.

You can easily reproduce this issue:

1. Omit this patch 2 (since it would fix it).

2. Apply patch 3 and patch 4 of this patch set, which assemble a T_readdir
   test case combined, then stop patches here (i.e. don't apply subsequent 
   patches of this patch set, since e.g. patch 6 would increase test client's 
   msize).

3. Set QTEST_V9FS_SYNTH_READDIR_NFILES in hw/9pfs/9p-synth.h to a high number
   (e.g. several thousands).

4. Run the T_readdir test case:

   cd build
   make && make tests/qos-test
   export QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
   tests/qos-test -p $(tests/qos-test -l | grep readdir/basic)

Result: Since the test client's msize is quite small at this point (4kB), test 
client would transmit a very large "count" parameter with T_readdir request to 
retrieve all QTEST_V9FS_SYNTH_READDIR_NFILES files, and you'll end up getting 
the quoted transport error message on server (see precise error message 
above).

> > Note: we should probably also check for a minimum size of
> > msize during T_version to avoid issues and/or too complicated
> > count/size checks later on in other requests of that client.
> > T_version should submit an msize that's at least as large as
> > the largest request's header size.
> 
> Do you mean that the server should expose such an msize in the
> R_version response ? The 9p spec only says that the server must
> return an msize <= to the one proposed by the client [1]. Not
> sure we can do more than to emit a warning and/or interrupt the
> server if the client sends a silly size.
> 
> [1] https://9fans.github.io/plan9port/man/man9/version.html

My idea was to "handle it as an error" immediately when server receives a 
T_version request with a "msize" argument transmitted by client that would be 
way too small for anything.

Because if client sends T_version with msize < P9_IOHDRSZ then it is obvious 
that this msize would be way too small for handling any subsequent 9p request 
at all.

> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  hw/9pfs/9p.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 520177f40c..30e33b6573 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -2414,6 +2414,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
> > 
> >      int32_t count;
> >      uint32_t max_count;
> >      V9fsPDU *pdu = opaque;
> > 
> > +    V9fsState *s = pdu->s;
> > 
> >      retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
> >      
> >                             &initial_offset, &max_count);
> > 
> > @@ -2422,6 +2423,13 @@ static void coroutine_fn v9fs_readdir(void *opaque)
> > 
> >      }
> >      trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset,
> >      max_count);
> > 
> > +    if (max_count > s->msize - P9_IOHDRSZ) {
> > +        max_count = s->msize - P9_IOHDRSZ;
> 
> What if s->msize < P9_IOHDRSZ ?

Exactly, that's why I added that comment to the commit log of this patch for 
now to make this circumstance clear as yet TODO.

This issue with T_version and msize needs to be addressed anyway, because it 
will popup again and again with various other request types and also with 
transport aspects like previously discussed on a transport buffer size issue 
(submitters of that transport patch on CC here for that reason):
https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04701.html

The required patch to address this overall minimum msize issue would be very 
small: just comparing client's transmitted "msize" parameter of client's 
T_version request and if that transmitted msize is smaller than a certain 
absolute minimum msize then raise an error immediately to prevent the session 
to start.

But there are some decisions to be made, that's why I haven't provided a patch 
for this min. msize issue in this patch series yet:

1. What is the minimum msize to be allowed with T_version?

   P9_IOHDRSZ would be IMO too small, because P9_IOHDRSZ is the size of the 
   common header portion of all IO requests. So it would rather make sense IMO
   reviewing the protocol and pick the largest header size among all possible 
   requests supported by 9pfs server ATM. The advantage of this approach would 
   be that overall code would be easier too maintain, since we don't have to 
   add minimum msize checks in any (or even all) individual request type 
   handlers. T_version handler of server would already enforce a minimum msize 
   and prevent the session if msize too small, and that's it.

2. How to handle that error with T_version exactly?

   As far as I can see it, it was originally not considered that T_version 
   might react with an error response at all. The specs are ambiguous about 
   this topic. All you can find is that if the transmitted protocol version
   is not supported by server, then server should respond with "unknown" with 
   its R_version response, but should not respond with R_error in that case.

   The specs do not prohibit R_error for T_version in general, but I could 
   imagine that some clients might not expect if we would send R_error. On the 
   other hand responding with R_version "unknown" would not be appropriate for 
   this msize error either, because that would mean to the client that the 
   protocol version was not supported, which is not the case. So it would 
   leave client uninformed about the actual reason/cause of the error.

3. Are there any undocumented special msizes, e.g. msize=0 for "don't care" ?

   Probably not, but you might have seen more client implementations than me.

Best regards,
Christian Schoenebeck



