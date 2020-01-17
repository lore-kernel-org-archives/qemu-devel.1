Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE658C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AE52064C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="AGglFYfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AE52064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUku-00043U-Hv
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1isUjh-0003Wg-J1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1isUjf-0002Xx-WE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:44:41 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:49327)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1isUjf-0002X7-Nh
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=wUX2jeNOUTgeYGzKNgp7wPB1qcAEO3PsPi0irFyaIYc=; b=AGglFYfb8WYs46aVS+LixthWvv
 2CHZ57Bi2Ktzam9BaiWxyHh5JnyfT5G8cz+BZQUR6Wx8eZYJwrzYZ/2xS6m/aaEDaLdJ6dHUYAEr7
 tjf+q1kWHAuGTelLOUgv0qUUsABOHGDoAHXvMKxgVbplmc3S58hklfq7sPswlBr/ywccWyVv8Jr8E
 Hc4jLhlbm5J0LQG8Se+wwNS4miBg1gx7v9GG3uxADAasTgP9bCql0MaJX6XTd+FLds/y8dUuO6eBm
 M87Hk1K1yBCY7diToctK0jOE6cq+Ns8BePfogef/GiqW2oRFORFpY4RyZZaDD3FRWTyZCIj04e4S3
 rX2ZaN4A44GIr43b1izGpYaloYtz2yXPO4L4epOwFShorWlEP8+5m3eDYpjMbqV11UZVYWzeqIP17
 pA7cQBB5Gv+3t1FGrMs6jiwWz8vQztJst/Ozioubx4WHtBDjdqxQ+q620tQRCX7MuaZ6uJi+d21Pt
 6ym/KB8ANbd2DE8CJ5I3QHGvjcNy/dE6jOVc/ibWe8i4uAVW9rkqJ4vBSSQ09EefV21OU42NHYmJt
 y/m31YOWA4asLkj50NvBgZlT6NLGsxXar17DDmDrdp6L2vE7mCl9tZRzsw1o/XTegt+VSeUbmZNnW
 OXTQWlQZV3nWxSyBtmg3b3jJmo2u0sFHppEWDkDPA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 05/11] tests/virtio-9p: added readdir test
Date: Fri, 17 Jan 2020 17:44:33 +0100
Message-ID: <3128954.or4cCn8GAH@silver>
In-Reply-To: <20200117165129.064fbb30@bahia.lan>
References: <cover.1578957500.git.qemu_oss@crudebyte.com>
 <d48e21f83d8a8c766368190e872c7b72a5f7e881.1578957500.git.qemu_oss@crudebyte.com>
 <20200117165129.064fbb30@bahia.lan>
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

On Freitag, 17. Januar 2020 16:51:29 CET Greg Kurz wrote:
> On Tue, 14 Jan 2020 00:08:51 +0100
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > The first readdir test simply checks the amount of directory
> > entries returned by 9pfs server, according to the created amount
> > of virtual files on 9pfs synth driver side. Then the subsequent
> > readdir test also checks whether all directory entries have the
> > expected file names (as created on 9pfs synth driver side),
> > ignoring their precise order in result list though.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> 
> LGTM but I'm afraid this needs rebasing because virtio-9p-test.c got moved
> to tests/qtest/ by this commit (merged earlier this week):
> 
> commit 1e8a1fae7464ef79c9e50aa0f807d2c511be3c8e
> Author: Thomas Huth <thuth@redhat.com>
> Date:   Mon Sep 9 12:04:01 2019 +0200
> 
>     test: Move qtests to a separate directory
> 
>     The tests directory itself is pretty overcrowded, and it's hard to
>     see which test belongs to which test subsystem (unit, qtest, ...).
>     Let's move the qtests to a separate folder for more clarity.
> 
>     Message-Id: <20191218103059.11729-6-thuth@redhat.com>
>     Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>     Signed-off-by: Thomas Huth <thuth@redhat.com>

Sure, I'll take care of that, and like previously discussed ...

> >  tests/virtio-9p-test.c | 149 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 149 insertions(+)
> > 
> > diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
> > index 06263edb53..721f13c1fb 100644
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
> > @@ -348,6 +360,82 @@ static void v9fs_rwalk(P9Req *req, uint16_t *nwqid,
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
> > +struct V9fsDirent {
> > +    v9fs_qid qid;
> > +    uint64_t offset;
> > +    uint8_t type;
> > +    char *name;
> > +    struct V9fsDirent *next;
> > +};
> > +
> > +/* size[4] Rreaddir tag[2] count[4] data[count] */
> > +static void v9fs_rreaddir(P9Req *req, uint32_t *count, uint32_t
> > *nentries,
> > +                          struct V9fsDirent **entries)
> > +{
> > +    uint32_t local_count;
> > +    struct V9fsDirent *e = NULL;
> > +    uint16_t slen;
> > +    uint32_t n = 0;
> > +
> > +    v9fs_req_recv(req, P9_RREADDIR);
> > +    v9fs_uint32_read(req, &local_count);
> > +
> > +    if (count) {
> > +        *count = local_count;
> > +    }
> > +
> > +    for (int32_t togo = (int32_t)local_count;
> > +         togo >= 13 + 8 + 1 + 2;
> > +         togo -= 13 + 8 + 1 + 2 + slen, ++n)
> > +    {
> > +        if (!e) {
> > +            e = g_malloc(sizeof(struct V9fsDirent));
> > +            if (entries) {
> > +                *entries = e;
> > +            }
> > +        } else {
> > +            e = e->next = g_malloc(sizeof(struct V9fsDirent));
> > +        }
> > +        e->next = NULL;
> > +        /* qid[13] offset[8] type[1] name[s] */
> > +        v9fs_memread(req, &e->qid, 13);
> > +        v9fs_uint64_read(req, &e->offset);
> > +        v9fs_uint8_read(req, &e->type);
> > +        v9fs_string_read(req, &slen, &e->name);
> > +    }
> > +
> > +    if (nentries) {
> > +        *nentries = n;
> > +    }
> > +
> > +    v9fs_req_free(req);
> > +}
> > +
> > +static void v9fs_free_dirents(struct V9fsDirent *e)
> > +{
> > +    struct V9fsDirent *next = NULL;
> > +
> > +    for (; e; e = next) {
> > +        next = e->next;
> > +        g_free(e->name);
> > +        g_free(e);
> > +    }
> > +}
> > +
> > 
> >  /* size[4] Tlopen tag[2] fid[4] flags[4] */
> >  static P9Req *v9fs_tlopen(QVirtio9P *v9p, uint32_t fid, uint32_t flags,
> >  
> >                            uint16_t tag)
> > 
> > @@ -480,6 +568,66 @@ static void fs_walk(void *obj, void *data,
> > QGuestAllocator *t_alloc)> 
> >      g_free(wqid);
> >  
> >  }
> > 
> > +static bool fs_dirents_contain_name(struct V9fsDirent *e, const char*
> > name) +{
> > +    for (; e; e = e->next) {
> > +        if (!strcmp(e->name, name)) {
> > +            return true;
> > +        }
> > +    }
> > +    return false;
> > +}
> > +
> > +static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
> > +{
> > +    QVirtio9P *v9p = obj;
> > +    alloc = t_alloc;
> > +    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DIR) };
> > +    uint16_t nqid;
> > +    v9fs_qid qid;
> > +    uint32_t count, nentries;
> > +    struct V9fsDirent *entries = NULL;
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

... I'll have to change that to:

	req = v9fs_treaddir(v9p, 1, 0, P9_MAX_SIZE - 11, 0);


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
> > +
> > +    /*
> > +     * Check all file names exist in returned entries, ignore their order
> > +     * though.
> > +     */
> > +    g_assert_cmpint(fs_dirents_contain_name(entries, "."), ==, true);
> > +    g_assert_cmpint(fs_dirents_contain_name(entries, ".."), ==, true);
> > +    for (int i = 0; i < QTEST_V9FS_SYNTH_READDIR_NFILES; ++i) {
> > +        char *name = g_strdup_printf(QTEST_V9FS_SYNTH_READDIR_FILE, i);
> > +        g_assert_cmpint(fs_dirents_contain_name(entries, name), ==,
> > true);
> > +        g_free(name);
> > +    }
> > +
> > +    v9fs_free_dirents(entries);
> > +    g_free(wnames[0]);
> > +}
> > +
> > 
> >  static void fs_walk_no_slash(void *obj, void *data, QGuestAllocator
> >  *t_alloc) {
> >  
> >      QVirtio9P *v9p = obj;
> > 
> > @@ -658,6 +806,7 @@ static void register_virtio_9p_test(void)
> > 
> >                   NULL);
> >      
> >      qos_add_test("fs/flush/ignored", "virtio-9p", fs_flush_ignored,
> >      
> >                   NULL);
> > 
> > +    qos_add_test("fs/readdir/basic", "virtio-9p", fs_readdir, NULL);
> > 
> >  }
> >  
> >  libqos_init(register_virtio_9p_test);

Best regards,
Christian Schoenebeck



