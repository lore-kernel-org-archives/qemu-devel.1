Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C648C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 10:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EADB24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 10:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EADB24125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuZmL-0003iT-82
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 05:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iuZlg-0003JA-OE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iuZlf-0000Xq-8l
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:31:20 -0500
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:60390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iuZle-0000KS-TL
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:31:19 -0500
Received: from player763.ha.ovh.net (unknown [10.108.16.182])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 3D97C214FB9
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:31:07 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player763.ha.ovh.net (Postfix) with ESMTPSA id 2CE83E88957E;
 Thu, 23 Jan 2020 10:31:04 +0000 (UTC)
Date: Thu, 23 Jan 2020 11:30:58 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v4 06/11] tests/virtio-9p: added splitted readdir test
Message-ID: <20200123113058.17e2c88d@bahia.lan>
In-Reply-To: <17952898.t909x8hp7r@silver>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <f6394833fa66bf6a73d204db34302732a5f6b98a.1579567020.git.qemu_oss@crudebyte.com>
 <20200122221905.055f9f93@bahia.lan> <17952898.t909x8hp7r@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8496322174974335296
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvddvgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejieefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.179.66
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

On Wed, 22 Jan 2020 23:36:22 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 22. Januar 2020 22:19:05 CET Greg Kurz wrote:
> > On Tue, 21 Jan 2020 01:16:21 +0100
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > The previous, already existing readdir test simply used a 'count'
> > > parameter big enough to retrieve all directory entries with a
> > > single Treaddir request.
> > > 
> > > In this new 'splitted' readdir test, directory entries are
> > > retrieved, splitted over several Treaddir requests by picking small
> > > 'count' parameters which force the server to truncate the response.
> > > So the test client sends as many Treaddir requests as necessary to
> > > get all directory entries. Currently this test covers actually two
> > > tests: a sequence of Treaddir requests with count=512 and then a
> > > subsequent test with a sequence of Treaddir requests with count=256.
> > > 
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > ---
> > 
> > Not sure it is really needed to check with multiple values for 'count',
> > but it doesn't eat too many cycles so I guess it doesn't hurt.
> 
> Yes, it is a cheap test, nobody will feel the difference. One could argue 
> about the precise 'count' values being used ...
> 
> > 
> > Applied as well.
> > 
> > >  tests/qtest/virtio-9p-test.c | 91 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 91 insertions(+)
> > > 
> > > diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> > > index 2167322985..8b0d94546e 100644
> > > --- a/tests/qtest/virtio-9p-test.c
> > > +++ b/tests/qtest/virtio-9p-test.c
> > > @@ -578,6 +578,7 @@ static bool fs_dirents_contain_name(struct V9fsDirent
> > > *e, const char* name)> 
> > >      return false;
> > >  
> > >  }
> > > 
> > > +/* basic readdir test where reply fits into a single response message */
> > > 
> > >  static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
> > >  {
> > >  
> > >      QVirtio9P *v9p = obj;
> > > 
> > > @@ -631,6 +632,95 @@ static void fs_readdir(void *obj, void *data,
> > > QGuestAllocator *t_alloc)> 
> > >      g_free(wnames[0]);
> > >  
> > >  }
> > > 
> > > +/* readdir test where overall request is splitted over several messages
> > > */
> > > +static void fs_readdir_split(void *obj, void *data, QGuestAllocator
> > > *t_alloc) +{
> > > +    QVirtio9P *v9p = obj;
> > > +    alloc = t_alloc;
> > > +    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DIR) };
> > > +    uint16_t nqid;
> > > +    v9fs_qid qid;
> > > +    uint32_t count, nentries, npartialentries;
> > > +    struct V9fsDirent *entries, *tail, *partialentries;
> > > +    P9Req *req;
> > > +    int subtest;
> > > +    int fid;
> > > +    uint64_t offset;
> > > +    /* the Treaddir 'count' parameter values to be tested */
> > > +    const uint32_t vcount[] = { 512, 256 };
> 
> ... here. But IMO it does make sense preserving the function's overall 
> structure to allow testing with different 'count' values if necessary. Because 
> that way this test could e.g. guard potential bugs when server's Treaddir 
> handler is rolling back (or not) the dir offset for instance, which server has 
> to do (or not) according to this 'count' value and the precise file name 
> length of the individual directory entries.
> 

I still agree it is useful to be able to check different values but I
now realize that it shouldn't be done like this because adding new
values to vcount[] doesn't scale well with the MAX_REQ limitation I
mentioned in another mail. More values, especially small ones, are
likely to trigger "Failed to decode VirtFS request type 40" at some
point. 

I now think that fs_readdir_split() should rather get count as
an argument and only do one run. By default we would only call
this with an appropriate value, ideally derived from the test
environment (number of files, size of filenames... etc...).
If someone needs to test a specific value, it is easy as adding
a new qos_add_test() line.

This would ensure at least that each run starts with the same
fixed number of possible requests, ie. MAX_REQ minus the cost of
fs_attach().

So I'll revert this patch for now.

> Whatever precise 'count' tests are desired, it would only mean a one line 
> change here.
> 
> Best regards,
> Christian Schoenebeck
> 
> 


