Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52D6C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 21:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9E920870
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 21:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="pWQj7j/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9E920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4tZU-0005Cb-E7
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 17:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i4tYP-0004DJ-TH
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 17:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i4tYO-0008SZ-NA
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 17:08:01 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:39953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1i4tYO-0008OH-8E
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 17:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OFlSds/3MdxxS/bz5jymkCG6A9jZ86PoUx3RM6pO1h8=; b=pWQj7j/xTTNOwjW2SpKgicHPAg
 Ut2HPBA009OrTddZvb0dMskuAkU7+9AlRdxl/504Z9hhq3ZodMMeN8tQzI7dbU6gRyuZEKdyZ9OfQ
 PX76mAa9Bkd+nbmSTBfKMRQO5UHizNpaekBR7nkZwiLrJgwxyh/dXjLl46R2dUllEo/OZPL7LFpht
 t5A7vVIl3vkCXaezmZz2h6Tm0It5noI74V1RL6zGewNFgbWAF2cb5K2lwkCf0Z6zYbF1Li3wISSS8
 +yz1AOm0LcJt2THKtciwI5tELc1k2A94hMpMmMBloLg9yanOpkFYrHm27XYvd9Ihx03zXUfVPW2Uy
 VLpTSJMmV4xbt37p2m8+O5t39ExThhiHL6diQZXXqJ/PWABecT9Uvs3w4l4m06i/kciGDqjNLf5/e
 CjFtKb54CkH7OMVHcaoozTpSZEbRDsWjDGnp/tZjVXpBPROJwjy2rJHCmimhbLdhxAHlqdJPlboWS
 2hea0otyNyx+BleWX095vjEOaxkZoqX0rR2Jd6cPcvuZVl4oZeVgdBa4LJ6F1ja7c+jxEnuKKLB//
 BocU5eTPbbQwCozCtik4ko/vvNl/FvtsxPboU81TaHydh2iIG634c8ZLu3PYCh+jjumlFyWvXY7fS
 kvGEwgQJcuWlurv9C16TKNqF6yQo0sCl3YTNVGTGg=;
To: qemu-devel@nongnu.org
Date: Mon, 02 Sep 2019 23:07:53 +0200
Message-ID: <2619584.Ul88uybPbv@silver>
In-Reply-To: <20190902121626.4973d0a0@bahia.lan>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <2018575.EFrLczUYWK@silver> <20190902121626.4973d0a0@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [PATCH v6 2/4] 9p: Added virtfs option
 'multidevs=remap|forbid|warn'
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 2. September 2019 12:16:26 CEST Greg Kurz wrote:
> > > > @@ -571,22 +572,109 @@ static void coroutine_fn virtfs_reset(V9fsPDU
> > > > *pdu)
> > > > 
> > > >                                  P9_STAT_MODE_NAMED_PIPE |   \
> > > >                                  P9_STAT_MODE_SOCKET)
> > > > 
> > > > -/* This is the algorithm from ufs in spfs */
> > > > +
> > > > +/* creative abuse of tb_hash_func7, which is based on xxhash */
> > > > +static uint32_t qpp_hash(QppEntry e)
> > > > +{
> > > > +    return qemu_xxhash7(e.ino_prefix, e.dev, 0, 0, 0);
> > > > +}
> > > > +
> > > > +static bool qpp_lookup_func(const void *obj, const void *userp)
> > > > +{
> > > > +    const QppEntry *e1 = obj, *e2 = userp;
> > > > +    return e1->dev == e2->dev && e1->ino_prefix == e2->ino_prefix;
> > > > +}
> > > > +
> > > > +static void qpp_table_remove(void *p, uint32_t h, void *up)
> > > > +{
> > > > +    g_free(p);
> > > > +}
> > > > +
> > > > +static void qpp_table_destroy(struct qht *ht)
> > > > +{
> > > > +    qht_iter(ht, qpp_table_remove, NULL);
> > > > +    qht_destroy(ht);
> > > > +}
> > > 
> > > Ok to have a function for this instead of open-coding but I'd
> > > like to see qpp_table_init() for consistency.
> > 
> > Well, these are just qht_init() one-liners, but if you really want to have
> > dedicated, local init functions for them, okay.
> 
> Yeah, even if it's a one-liner, I prefer consistency. Alternatively, with
> an idempotent v9fs_device_unrealize_common() like in [1], you'd have
> only one user for qpp_table_destroy() and you can open-code it. This
> would address my consistency concern even better :)
> 
> [1]
> https://github.com/gkurz/qemu/commit/7fc4c49e910df2e155b36bf0a05de9209bd92d

I'll rather add qpp_table_init() then, because grouping the two calls 
qht_iter() and qht_destroy() together to a dedicated function 
qpp_table_destroy() still makes sense semantically IMO.



