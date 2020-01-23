Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C21FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087B921D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="JT8kMWH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087B921D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueBi-0001mw-W6
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iucCb-0002h2-3x
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iucCZ-0004m1-82
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:07:16 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:39989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iucCY-0004jm-NV
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=sAZNKaKJi3tOvw5qAVuxxNi5Pn6NBVaDhiiwpqHWOtY=; b=JT8kMWH92MIHv2PTo/Kw/MBkhm
 n1P0E301xR0s2XzCmaD6QWZLpMi3O9LHi/uQbKH4tKeG4Qh9ykMcoVuF05fIRO6s1wA9vTSDlS8Bt
 wCxoS/sX2wqFHFeiN4lYJRBCtVcAspxXeF26rrTR0fZTOGYpHHpgfnTSvQmy2lp/LG7c8F6wmvFCs
 6jpaUREXtgNgOEJTnHowPWaHcDQXH0tfkGLiTp8W0yg8tu60C8xj5HMKfpjTGipUr7TxxHtREgpC1
 o5yWysuTgg0Z6a9kDZ/rW+uJhY9u33EjV3bU4cpZwETdzfAi68Kr92PlLhg6srO/z/BPZ4hhBYuGb
 97tB39qBkxizcWoKEVnA/HrOxkLcUt6eWscwRg6X510DqfsLmnVM1xuQHRvEPR3Km8YsDU/NqktOb
 HPnLQLilpxGk19Unw/Ktk+swlac+aeKpM2bp/dXYsNmFgphSrMFTXW0I9XDPlqM2tAljVU+Yy+JZA
 DnbjyKYADW3lMW3tf6uAMxjWfQTVxUcrX5WO23P39zL0bTwTR6Pnjz1UYZA0Zc4dCZOYQ2vce6Ul4
 1Vg9ggraUcjKQCRxzjfVlYOTxabCi3OrCU+MRNFkEyQ+AKafAKUKNHRvlQkOHyTJ09vXp4nWGw8mq
 CDGBEJNN+fSno54IbjOIsbcXzvaKVTjy4dYJCCMws=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 06/11] tests/virtio-9p: added splitted readdir test
Date: Thu, 23 Jan 2020 14:07:06 +0100
Message-ID: <38533076.nkKmY2FMRI@silver>
In-Reply-To: <20200123113058.17e2c88d@bahia.lan>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <17952898.t909x8hp7r@silver> <20200123113058.17e2c88d@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

On Donnerstag, 23. Januar 2020 11:30:58 CET Greg Kurz wrote:
> On Wed, 22 Jan 2020 23:36:22 +0100
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Mittwoch, 22. Januar 2020 22:19:05 CET Greg Kurz wrote:
> > > On Tue, 21 Jan 2020 01:16:21 +0100
> > > 
> > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > > The previous, already existing readdir test simply used a 'count'
> > > > parameter big enough to retrieve all directory entries with a
> > > > single Treaddir request.
> > > > 
> > > > In this new 'splitted' readdir test, directory entries are
> > > > retrieved, splitted over several Treaddir requests by picking small
> > > > 'count' parameters which force the server to truncate the response.
> > > > So the test client sends as many Treaddir requests as necessary to
> > > > get all directory entries. Currently this test covers actually two
> > > > tests: a sequence of Treaddir requests with count=512 and then a
> > > > subsequent test with a sequence of Treaddir requests with count=256.
> > > > 
> > > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > > ---
> > > 
> > > Not sure it is really needed to check with multiple values for 'count',
> > > but it doesn't eat too many cycles so I guess it doesn't hurt.
> > 
> > Yes, it is a cheap test, nobody will feel the difference. One could argue
> > about the precise 'count' values being used ...
> > 
> > > Applied as well.
> > > 
> > > >  tests/qtest/virtio-9p-test.c | 91
> > > >  ++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 91 insertions(+)
> > > > 
> > > > diff --git a/tests/qtest/virtio-9p-test.c
> > > > b/tests/qtest/virtio-9p-test.c
> > > > index 2167322985..8b0d94546e 100644
> > > > --- a/tests/qtest/virtio-9p-test.c
> > > > +++ b/tests/qtest/virtio-9p-test.c
> > > > @@ -578,6 +578,7 @@ static bool fs_dirents_contain_name(struct
> > > > V9fsDirent
> > > > *e, const char* name)>
> > > > 
> > > >      return false;
> > > >  
> > > >  }
> > > > 
> > > > +/* basic readdir test where reply fits into a single response message
> > > > */
> > > > 
> > > >  static void fs_readdir(void *obj, void *data, QGuestAllocator
> > > >  *t_alloc)
> > > >  {
> > > >  
> > > >      QVirtio9P *v9p = obj;
> > > > 
> > > > @@ -631,6 +632,95 @@ static void fs_readdir(void *obj, void *data,
> > > > QGuestAllocator *t_alloc)>
> > > > 
> > > >      g_free(wnames[0]);
> > > >  
> > > >  }
> > > > 
> > > > +/* readdir test where overall request is splitted over several
> > > > messages
> > > > */
> > > > +static void fs_readdir_split(void *obj, void *data, QGuestAllocator
> > > > *t_alloc) +{
> > > > +    QVirtio9P *v9p = obj;
> > > > +    alloc = t_alloc;
> > > > +    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DIR)
> > > > };
> > > > +    uint16_t nqid;
> > > > +    v9fs_qid qid;
> > > > +    uint32_t count, nentries, npartialentries;
> > > > +    struct V9fsDirent *entries, *tail, *partialentries;
> > > > +    P9Req *req;
> > > > +    int subtest;
> > > > +    int fid;
> > > > +    uint64_t offset;
> > > > +    /* the Treaddir 'count' parameter values to be tested */
> > > > +    const uint32_t vcount[] = { 512, 256 };
> > 
> > ... here. But IMO it does make sense preserving the function's overall
> > structure to allow testing with different 'count' values if necessary.
> > Because that way this test could e.g. guard potential bugs when server's
> > Treaddir handler is rolling back (or not) the dir offset for instance,
> > which server has to do (or not) according to this 'count' value and the
> > precise file name length of the individual directory entries.
> 
> I still agree it is useful to be able to check different values but I
> now realize that it shouldn't be done like this because adding new
> values to vcount[] doesn't scale well with the MAX_REQ limitation I
> mentioned in another mail. More values, especially small ones, are
> likely to trigger "Failed to decode VirtFS request type 40" at some
> point.
> 
> I now think that fs_readdir_split() should rather get count as
> an argument and only do one run. By default we would only call
> this with an appropriate value, ideally derived from the test
> environment (number of files, size of filenames... etc...).
> If someone needs to test a specific value, it is easy as adding
> a new qos_add_test() line.

I actually had this variant in the exact same way as you're suggesting here as 
well before (not submitted to the list though), that is I had a version of 
this function with a count argument, and I had 3 separate qtest cases, but 
that variant failed in the exact same way.

Furthermore, I even get some strange "could not push stack" error messages 
from the qtest environment when I just add some empty noop tests to the 9pfs 
test suite. I am not sure if that's related to this ringbuffer issue here, but 
it was a show stopper for this 'separate test for each count' variant, so I 
reverted it to this suggested array solution for now.

So to avoid any misapprehension: it seems to me as if you were thinking that 
the ringbuffer is freed between every individual test. That's not what I am 
observing here. It rather seems as space in the ringbuffer is never freed 
(before the entire 9pfs test suite completed).

> This would ensure at least that each run starts with the same
> fixed number of possible requests, ie. MAX_REQ minus the cost of
> fs_attach().
> 
> So I'll revert this patch for now.
> 
> > Whatever precise 'count' tests are desired, it would only mean a one line
> > change here.
> > 
> > Best regards,
> > Christian Schoenebeck


Best regards,
Christian Schoenebeck



