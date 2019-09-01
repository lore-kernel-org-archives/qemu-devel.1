Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E9EC3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 17:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C802173E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 17:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="WNeIYbyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C802173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4TpH-000160-4G
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 13:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i4ToA-0000af-GF
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 13:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i4To9-0006Yb-EY
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 13:38:34 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:40457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1i4To8-0006T8-VW
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 13:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f+p0E6yYT+91k9zU0ES4ZVHcoeiinKaivMaOvsI63LU=; b=WNeIYbyHPhr7tqBuIxCtvP5Arb
 7Zex1GW8coVnLSTIa4L8WFH9iu7Hhk9kfCub3gNyoTQgFdkZTRQTJZ2FxJ384chuSX1v/pbPFnV4f
 gYe6VWK3hjfly993sD4izjh8Bvd8F3FWi/eQL7dm+ndtWQUEdSLGlLUC7fUOzlQyqUDoMG0F6xkgq
 gfGTmRSdlbSjuUFJ4/+2KNbcbTPcIKdNmaGtgzgC9F1MzS7SN9WSCsyxnH0Wu2+pNeGFvfRX+MLgL
 VuTm5k/3tpP2go+V2Rw4c3c4C/3E1uWe+pYEqMkg8GC8RLjU7s1chAM14VxGBJ4ugHn4OcQQ/ADkK
 sMdltpYbGrI2PmQZENbl32/HPVn9T0dsORMMVadJwhP66dsjyyjHJlQFRu5ZqMvbjdP6VD/P0H8VT
 8JjCY4roxyX8kIrTgXMqnU4toSPuiZu66JbzD4FISy9WsFRLwKDaIdPlhRT12hg0XpcPAf3S2jPeH
 oz8WTBgaVOq+0WbqckDfs8ucR7x0+sbDXP0xLM/KXOxyqcmGy21wEwZ5smWAeZgAloH0SEza9rS9S
 283Q9WOx7a6PYKavwam3jPeBp0BtdZtYiGAb++oBg8aD9f7ycPHSljFOVcAGwbsdzGLxjGJNPvcjo
 y49dUKzE2ts8sC47E8e3tiAebZuSHWQ1krO7M8yiA=;
To: qemu-devel@nongnu.org
Date: Sun, 01 Sep 2019 19:38:28 +0200
Message-ID: <4884116.45koar3ZxJ@silver>
In-Reply-To: <20190829182730.1e1d69b2@bahia.lan>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <5415baa3955c354d9f1e6aab39270ab2abca662a.1566503584.git.qemu_oss@crudebyte.com>
 <20190829182730.1e1d69b2@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [PATCH v6 1/4] 9p: Treat multiple devices on one
 export as an error
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

On Donnerstag, 29. August 2019 18:27:30 CEST Greg Kurz wrote:
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 586a6dccba..8cc65c2c67 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -572,10 +572,18 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
> > 
> >                                  P9_STAT_MODE_SOCKET)
> >  
> >  /* This is the algorithm from ufs in spfs */
> > 
> > -static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
> > +static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID
> > *qidp)> 
> >  {
> >  
> >      size_t size;
> > 
> > +    if (pdu->s->dev_id != stbuf->st_dev) {
> > +        error_report_once(
> > +            "9p: Multiple devices detected in same VirtFS export. "
> > +            "You must use a separate export for each device."
> > +        );
> > +        return -ENODEV;
> 
> As explained in the v5 review, we don't necessarily want to break existing
> cross-device setups that just happen to work. Moreover, the next patch
> re-allows them since remap_inodes=ignore is the default. I would thus
> only do:
> 
>         warn_report_once(
>                     "9p: Multiple devices detected in same VirtFS export, "
>                     "which might lead to file ID collisions and severe "
>                     "misbehaviours on guest! You should use a separate "
>                     "export for each device shared from host."
>         );
> 
> So I've just changed that and applied to 9p-next since it is
> a valuable improvement. Note that I've kept the signature change
> of stat_to_qid() for simplicity even if it isn't needed before
> the next patch.

I'm fine with your changes.

Dropping "return -ENODEV" in this patch was beyond my default level for 
details since this is really just a very detailed sort of git history 
tweaking. :) Like you already pointed out, not aborting (as default behaviour) 
would have been addressed with the subsequent patch anyway.

