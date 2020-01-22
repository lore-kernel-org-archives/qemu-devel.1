Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C00C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 22:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BB92253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 22:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="LxJO+42/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BB92253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuOdr-0007Al-08
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 17:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iuObr-0005bH-A1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iuObp-0005U9-Ii
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:36:27 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:41675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iuObp-0005Rq-1r
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=gemmDmfKumpHWgEDHzOtI+LFs8MmR2eh65fuVniXYUs=; b=LxJO+42/sY5VodAPT9nvIRkq6n
 PeKg+oyT7Ebv4p+bxpEokPdQEDr1isuNU95oeL3hU5uyEB+4EZNpmPCLe5SCfhn8tTo1RETX/8pg/
 vOxFHXipTBEEcKT3ssxiXZxDM//lHajlVAEkOAFtOdAvylOZgvyBMdaT2dvctJKck+1gztExhIp5B
 9UKRP3c8jSM/zu/1Lt7CAKoN/Pm8s6Z3aGOlpkRtbv70gtH+SB+f/gl+n2bcRqtzWGdY7DOgZtEe7
 4sxdeW8jgXN0drKyHtIcwrbhRlERop8pMLJ6FJ5KBrrAXV6nGjlwJDuETy0Lpy01wrz1AenNvQfI/
 oPTZRgiu9yxSc9993hxxU5IEZO65HJyPRPcPOrp4k0waANknaNdurIF8Z6J+t50jEuMfTiKO8agOH
 icbwv8fTwY1F1Uenujl28Z3GuMn2T0AHqMh+wzDTbCxfGDOA8KJH4CjtS71GZ3cI7FqHZEQvH26hW
 iKTp4Oe9hEi04S+wHphGzbJcy+zkbhSKq386lT9tnzBLpOJRIQ0HKNCfE3+M2xqgOGu+OMsUyrIR3
 gIlco3f95blTaUn2Vu5TLIcUZIW21+NRoi1gd3qTup8LsFkmA+WeB9j+DfcvSA66YIcrGjEdzS3Ww
 xUFwkG34iSXo2QDCCzdYtM4TWm1XCjNL3w8/je5Gg=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 06/11] tests/virtio-9p: added splitted readdir test
Date: Wed, 22 Jan 2020 23:36:22 +0100
Message-ID: <17952898.t909x8hp7r@silver>
In-Reply-To: <20200122221905.055f9f93@bahia.lan>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <f6394833fa66bf6a73d204db34302732a5f6b98a.1579567020.git.qemu_oss@crudebyte.com>
 <20200122221905.055f9f93@bahia.lan>
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

On Mittwoch, 22. Januar 2020 22:19:05 CET Greg Kurz wrote:
> On Tue, 21 Jan 2020 01:16:21 +0100
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > The previous, already existing readdir test simply used a 'count'
> > parameter big enough to retrieve all directory entries with a
> > single Treaddir request.
> > 
> > In this new 'splitted' readdir test, directory entries are
> > retrieved, splitted over several Treaddir requests by picking small
> > 'count' parameters which force the server to truncate the response.
> > So the test client sends as many Treaddir requests as necessary to
> > get all directory entries. Currently this test covers actually two
> > tests: a sequence of Treaddir requests with count=512 and then a
> > subsequent test with a sequence of Treaddir requests with count=256.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> 
> Not sure it is really needed to check with multiple values for 'count',
> but it doesn't eat too many cycles so I guess it doesn't hurt.

Yes, it is a cheap test, nobody will feel the difference. One could argue 
about the precise 'count' values being used ...

> 
> Applied as well.
> 
> >  tests/qtest/virtio-9p-test.c | 91 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> > 
> > diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> > index 2167322985..8b0d94546e 100644
> > --- a/tests/qtest/virtio-9p-test.c
> > +++ b/tests/qtest/virtio-9p-test.c
> > @@ -578,6 +578,7 @@ static bool fs_dirents_contain_name(struct V9fsDirent
> > *e, const char* name)> 
> >      return false;
> >  
> >  }
> > 
> > +/* basic readdir test where reply fits into a single response message */
> > 
> >  static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
> >  {
> >  
> >      QVirtio9P *v9p = obj;
> > 
> > @@ -631,6 +632,95 @@ static void fs_readdir(void *obj, void *data,
> > QGuestAllocator *t_alloc)> 
> >      g_free(wnames[0]);
> >  
> >  }
> > 
> > +/* readdir test where overall request is splitted over several messages
> > */
> > +static void fs_readdir_split(void *obj, void *data, QGuestAllocator
> > *t_alloc) +{
> > +    QVirtio9P *v9p = obj;
> > +    alloc = t_alloc;
> > +    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DIR) };
> > +    uint16_t nqid;
> > +    v9fs_qid qid;
> > +    uint32_t count, nentries, npartialentries;
> > +    struct V9fsDirent *entries, *tail, *partialentries;
> > +    P9Req *req;
> > +    int subtest;
> > +    int fid;
> > +    uint64_t offset;
> > +    /* the Treaddir 'count' parameter values to be tested */
> > +    const uint32_t vcount[] = { 512, 256 };

... here. But IMO it does make sense preserving the function's overall 
structure to allow testing with different 'count' values if necessary. Because 
that way this test could e.g. guard potential bugs when server's Treaddir 
handler is rolling back (or not) the dir offset for instance, which server has 
to do (or not) according to this 'count' value and the precise file name 
length of the individual directory entries.

Whatever precise 'count' tests are desired, it would only mean a one line 
change here.

Best regards,
Christian Schoenebeck



