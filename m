Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3017C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 12:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C28D2072A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 12:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="rd4Ba57h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C28D2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipt8B-0006Av-Hr
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 07:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ipt7U-0005l5-GX
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:10:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ipt7T-0000bm-6i
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:10:28 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:52071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ipt7S-0000VO-Oy
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=wqB7tILbLgoaMMJBnr4IsbGkg5KXzzC8Vi4Zx4vGr4o=; b=rd4Ba57h+w5EoZfvVHTr3QL0KT
 07ua1Q2vaRZDsQC+UPPxvaEkSGStSbYPG8euQ4Ikug/TftLxwT5H4RADOuBYgqMAyfTra/4YLKJU2
 fdFAEJYTsT9cElrpn1ttORtUpUGc8RfelR+HtoOyB8Odjl6Jzc12p/omskue9RKBbikEbhwsm7rHX
 TPBwVyx38t/fwf/RlgvtZdGSZzxIaGyAsJ17EgcnlszshETww1OOdfoOT2/po4W8uMoecSGzAVW16
 ZfZlDhvlVwIPkCrqfqjC6fEKJUUCZfiS3NVVS8bTS52WCoe9ZbqdirF/9g7RjOeBG/s4mZSME9NLB
 Ks4B6oFSzWqcBUxvLxNO1HGNiu0EXqSnX10aJr9euZdA5J2wikQX8wcjg+tcygKygdSorHFueNomw
 8pMZ+C5rC50ZL9r4o5CzuOcl6xA+ilyAOeduWV//KFLtX8reCiBP5AMLSARhelbMe6zbIeOQ52Xtl
 Zqv/aJpbwrH2KUjw4NMshBZwZmp9diVAHGZ7lGCatVkSm/TEyqaxwjqlz9zJGh+rlYpwKvrArd8h6
 7SOW1O9MK9p/avuKbsafoeyJZlDWkz7DH/kNiCGvRqzTW1HpA+rFkajnYoX0Ms4APf484hhCde9WA
 RgVzZGuCtckXkj7FtjrGSWxpJ4o2X0+Q0s4JSQMG0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 4/9] tests/virtio-9p: added readdir test
Date: Fri, 10 Jan 2020 13:10:24 +0100
Message-ID: <13849642.UhcBSJl6WW@silver>
In-Reply-To: <20200109005545.5b24236b@bahia.lan>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
 <a8d6dab2625554d425bd44a4d54d84459f083b18.1576678644.git.qemu_oss@crudebyte.com>
 <20200109005545.5b24236b@bahia.lan>
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

On Donnerstag, 9. Januar 2020 00:55:45 CET Greg Kurz wrote:
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
> > +    v9fs_qid qid;
> > +    uint64_t offset;
> > +    uint8_t type;
> > +    char *name;
> > +    struct v9fs_dirent *next;
> > +};
> > +
> > +/* size[4] Rreaddir tag[2] count[4] data[count] */
> > +static void v9fs_rreaddir(P9Req *req, uint32_t *count, uint32_t
> > *nentries,
> > +                          struct v9fs_dirent **entries)
> > +{
> > +    uint32_t sz;
> 
> Even if this is a size indeed, the 9p spec uses the wording "count" and
> so does the function signature. Please rename this variable to local_count.
> Some other functions that return server originated data already use this
> naming scheme.

I know, I did that intentionally. But I don't care for such code style details 
enough to start argueing, so I'll change it.

> 
> > +    struct v9fs_dirent *e = NULL;
> > +    uint16_t slen;
> > +    uint32_t n = 0;
> > +
> > +    v9fs_req_recv(req, P9_RREADDIR);
> > +    v9fs_uint32_read(req, &sz);
> > +
> > +    if (count) {
> > +        *count = sz;
> > +    }
> > +
> > +    for (int32_t togo = (int32_t)sz;
> > +         togo >= 13 + 8 + 1 + 2;
> > +         togo -= 13 + 8 + 1 + 2 + slen, ++n)
> > +    {
> > +        if (!e) {
> > +            e = g_malloc(sizeof(struct v9fs_dirent));
> > +            if (entries)
> 
> ERROR: braces {} are necessary for all arms of this statement
> #98: FILE: tests/virtio-9p-test.c:407:
> +            if (entries)
> [...]

Right, sorry I missed that for some reason.

Best regards,
Christian Schoenebeck



