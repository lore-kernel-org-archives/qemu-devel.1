Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30F4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE148217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="nKyRpG1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE148217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGye-000552-L7
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iuGxW-0003ka-Tg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iuGxV-0001dJ-NL
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:26:18 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:54381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iuGxV-0001Zx-6i
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=o3fpBiCs+ILBZnbU9Cda+t7v8Q0Y9XmKKPCJRGHxbAI=; b=nKyRpG1MrIRSH+Lx5+VzkyK7QR
 heW9VIxOhrC/bQTFkB1saDLhJ4k3dokG58C4S/S4s+lSLk3CP7dMe8hHtPhSpuYr+xcHWaUIiJDru
 a5ccAN4QmpuoP7UoV/S1Lxq6H0GV/HuxMyzriKMRXTAhlHsnJ3gNA6Am/Ul8I1woxKt6Su3Hfpp4U
 KlhPu4C2i5xH70NdihcHcVhz51Nt+Rlf2oQejIbt4Z3dD5Bao9DwDZGymYa/djKH6KWX7Jc675ARQ
 ippg53H85KYYz+R8k+Gg0Qxstg8gKqN2jQcqvAV2Xuu1uEZImnFug6hVumWvt07BGlb1s2Ogu0Jym
 Z2jVqszMqP0eRK3zUZRwbzB7VHQghFG2OT2g6awVoJLgRDZqW3yyeJVZHMdxbTAT7+0XtvAoQHKSe
 +JtH4YcY25dt/kuBkXZ/U+QlGmNbd373lf/ZlGvGzCZisIBJmWkoAh12QqqhvqDh464RsUHzrSGYL
 UOROG28/xC90O93ywgrDXPNtFLabmZ79dmBxjEyO5AmB1VSbrDsvqplp1ALVVwfSNLv2vrwk9hQOy
 wvVyP0+sI2yDNKOS7f3lnq2sVC+wr4upW0hArB01CSmFIda1ZrQGsoCL9Y0slWlg7dB2y5H2I3jJF
 qqpObMt0I3CzfQIAWUPouc/pHk1gMOuE9Ih/WZiZ0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 03/11] 9pfs: validate count sent by client with
 T_readdir
Date: Wed, 22 Jan 2020 15:26:13 +0100
Message-ID: <11790174.e6hFKklOfu@silver>
In-Reply-To: <20200122151107.7b8e5b10@bahia.lan>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <3990d3891e8ae2074709b56449e96ab4b4b93b7d.1579567020.git.qemu_oss@crudebyte.com>
 <20200122151107.7b8e5b10@bahia.lan>
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

On Mittwoch, 22. Januar 2020 15:11:07 CET Greg Kurz wrote:
> On Tue, 21 Jan 2020 00:50:33 +0100
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > A good 9p client sends T_readdir with "count" parameter that's
> > sufficiently
> > smaller than client's initially negotiated msize (maximum message size).
> > We perform a check for that though to avoid the server to be interrupted
> > with a "Failed to encode VirtFS reply type 41" transport error message by
> > bad clients. This count value constraint uses msize - 11, because 11 is
> > the
> > header size of R_readdir.
> 
> This would be worth a comment...
> 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  hw/9pfs/9p.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index a5fbe821d4..18370183c4 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -2426,6 +2426,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
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
> > @@ -2434,6 +2435,13 @@ static void coroutine_fn v9fs_readdir(void *opaque)
> > 
> >      }
> >      trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset,
> >      max_count);
> 
> ... here. Something like:
> 
>     /* Enough space for a R_readdir header: size[4] Rreaddir tag[2] count[4]
> */
> 
> I can fix this in my tree, and actually done so since I've
> applied patches 1 to 3.

Fine with me, thanks Greg!

> Reviewed-by: Greg Kurz <groug@kaod.org>

Best regards,
Christian Schoenebeck



