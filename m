Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22A6C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4F12075A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="d1kfI7/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4F12075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooOg-0003OZ-HZ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ionvj-00018w-5N
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ionvh-0000WB-PR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:25:50 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:36753)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ionvh-0000V1-Cu
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=dUHd+9G2AYjgCyzQ49UQCRBnmcpm08/n661jKXFbrMo=; b=d1kfI7/7UautXD0hhWyEpGLPRp
 bzPHDJdPQP6Jt66wCf997O/VHKA3sNn+uvlFALEStSqDcDOA0j35tBJI1jrH3DWq5/n5O0ncLecg7
 wh6u0a3NW840uPt+bENbPs+fWELA5ms4VlTTX55HiJgJsAmxTvdyeH9HnxP+Q8+5r6SfXwZtp48aB
 igdWvAaMKoKrp5vcM+4IAiHv1ApRIvws5OvQdWbaxxfpSTcaUGUXhNL2Z0Qy4OenQHA5ttiAEw/hq
 9b02nIYEEls8Ksls9pJdG2bwQ8CDu+uw2OQy2YaccC/qvevcdWXFtRWhpDsTp+d6I7Yb9lNoH8Rqf
 tV4sKzU54xT1xFar71q4L1+zK+5aazRUDvEYwQwef9FooYlxt8igjy1dLvidHPp/JAoo2RsJ+Rizm
 4CvbZhJTUaJ4lbraE3ls59nvIEPwa5I0evzzI1uIxBg5Q1uKfZVQFypv+vhW2kTv4wUFp0vYEr00B
 bpY8YIXtptz6EwgMAoR2eItIRhRM+LEqwi+26FCwnHLpkxuaih5SJugVWNmrt4WF+oq0os1TDy5Xn
 FCPIUp/F1bPyr0tvwEisJnuJ+XqNjkKGopVqyUP3Y8XUGDWmT2Bbn+yRkln9thYoXPiKl7E8SFX8f
 41eBFJMqZ0Udv1Us4zEVh1gHJUCI1wxEkTHOLY7eo=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 4/9] tests/virtio-9p: added readdir test
Date: Tue, 07 Jan 2020 13:25:46 +0100
Message-ID: <10962452.xo9bJ14PLm@silver>
In-Reply-To: <20200106182252.58dd6712@bahia.lan>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
 <a8d6dab2625554d425bd44a4d54d84459f083b18.1576678644.git.qemu_oss@crudebyte.com>
 <20200106182252.58dd6712@bahia.lan>
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

On Montag, 6. Januar 2020 18:22:52 CET Greg Kurz wrote:
> > diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
> > index 06263edb53..48c0eca292 100644
> > --- a/tests/virtio-9p-test.c
> > +++ b/tests/virtio-9p-test.c
> > @@ -68,6 +68,11 @@ static void v9fs_memread(P9Req *req, void *addr, size_t
> > len)> 
> >      req->r_off += len;
> >  
> >  }
> > 
> > +static void v9fs_uint8_read(P9Req *req, uint8_t *val)
> > +{
> > +    v9fs_memread(req, val, 1);
> > +}
> > +
> > 
> >  static void v9fs_uint16_write(P9Req *req, uint16_t val)
> >  {
> >  
> >      uint16_t le_val = cpu_to_le16(val);
> > 
> > @@ -101,6 +106,12 @@ static void v9fs_uint32_read(P9Req *req, uint32_t
> > *val)> 
> >      le32_to_cpus(val);
> >  
> >  }
> > 
> > +static void v9fs_uint64_read(P9Req *req, uint64_t *val)
> > +{
> > +    v9fs_memread(req, val, 8);
> > +    le64_to_cpus(val);
> > +}
> > +
> > 
> >  /* len[2] string[len] */
> >  static uint16_t v9fs_string_size(const char *string)
> >  {
> > 
> > @@ -191,6 +202,7 @@ static const char *rmessage_name(uint8_t id)
> > 
> >          id == P9_RLOPEN ? "RLOPEN" :
> >          id == P9_RWRITE ? "RWRITE" :
> > 
> >          id == P9_RFLUSH ? "RFLUSH" :
> > +        id == P9_RREADDIR ? "READDIR" :
> >          "<unknown>";
> >  
> >  }
> > 
> > @@ -348,6 +360,79 @@ static void v9fs_rwalk(P9Req *req, uint16_t *nwqid,
> > v9fs_qid **wqid)> 
> >      v9fs_req_free(req);
> >  
> >  }
> > 
> > +/* size[4] Treaddir tag[2] fid[4] offset[8] count[4] */
> > +static P9Req *v9fs_treaddir(QVirtio9P *v9p, uint32_t fid, uint64_t
> > offset,
> > +                            uint32_t count, uint16_t tag)
> > +{
> > +    P9Req *req;
> > +
> > +    req = v9fs_req_init(v9p, 4 + 8 + 4, P9_TREADDIR, tag);
> > +    v9fs_uint32_write(req, fid);
> > +    v9fs_uint64_write(req, offset);
> > +    v9fs_uint32_write(req, count);
> > +    v9fs_req_send(req);
> > +    return req;
> > +}
> > +
> > +struct v9fs_dirent {
> 
> The QEMU coding style calls for a CamelCase typedef,
> 
> ie.
> 
> typedef struct V9fsDirent V9fsDirent;

np

> > +    v9fs_qid qid;
> 
> Yeah... I should have done the same when I introduced this type ;-)

So I'll probably address your sin with a separate patch then.

> > +static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
> > +{
> > +    QVirtio9P *v9p = obj;
> > +    alloc = t_alloc;
> > +    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DIR) };
> > +    uint16_t nqid;
> > +    v9fs_qid qid;
> > +    uint32_t count, nentries;
> > +    struct v9fs_dirent *entries = NULL;
> > +    P9Req *req;
> > +
> > +    fs_attach(v9p, NULL, t_alloc);
> > +    req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
> > +    v9fs_req_wait_for_reply(req, NULL);
> > +    v9fs_rwalk(req, &nqid, NULL);
> > +    g_assert_cmpint(nqid, ==, 1);
> > +
> > +    req = v9fs_tlopen(v9p, 1, O_DIRECTORY, 0);
> > +    v9fs_req_wait_for_reply(req, NULL);
> > +    v9fs_rlopen(req, &qid, NULL);
> > +
> > +    req = v9fs_treaddir(v9p, 1, 0, P9_MAX_SIZE - P9_IOHDRSZ, 0);
> > +    v9fs_req_wait_for_reply(req, NULL);
> > +    v9fs_rreaddir(req, &count, &nentries, &entries);
> > +
> > +    /*
> > +     * Assuming msize (P9_MAX_SIZE) is large enough so we can retrieve
> > all
> > +     * dir entries with only one readdir request.
> > +     */
> > +    g_assert_cmpint(
> > +        nentries, ==,
> > +        QTEST_V9FS_SYNTH_READDIR_NFILES + 2 /* "." and ".." */
> > +    );
> 
> What about coming up with a version of this test that loops until
> it could read all the entries instead of this assumption ?

Yes, I had this planned a bit later though. And not as a replacement for this 
one, but rather as a subsequent advanced readdir test. Because it makes sense 
to cover both cases: readdir a large amount of entries with a single request, 
but also splitted down by several readdir requests as subsequent, separate 
test.

Best regards,
Christian Schoenebeck



