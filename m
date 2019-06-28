Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D44C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF1E20644
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ew6DgG4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF1E20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgq9W-0007wT-T9
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 08:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37445)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hgq7e-00067H-MD
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hgq7b-0005We-3d
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:36:56 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:50737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1hgq7V-0005Pi-Fc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DGhPttdw73qL6OGRySEE0zOgjLIhXsWykFugGyy63kY=; b=ew6DgG4tZltP73Dd3CEY6hqO8h
 Gza5IToGMwDWsYeOqZ4ggDohN8mMk7NpbaEmbVO1B0jZo3d/AUKNRK5tqF2ffcpIiDSGUpL+KLVXd
 Gp+g9o0biZY6CMmOqQl1MdXkIy5Uo3RUG42LNyu+eSY4QnVnfdjNIhqe99kCOrgxoPOipqukAUODU
 pcE8YNhQUAmfG2zbMgw/SkXC1VvX6mduFsSPim1CV4oUVLsyZHmN0/6C0hQwfPIcv8vHGdTiI1BNm
 hfuZb/XSQGZa92vnZf73yZ4yylewSCGcVNNAlQsTp/pDrXfVrsmp0G/VW+W8aPjgKpw/6ZMQDg4US
 XIgun8CTnzPvuZZYjKu/tjD8GaNy0/kaUIHCZZjjUKflS6uZ7z0ipyqBaCTu3tC9se43DHNE1ldHP
 taoYL2xktYGP5LG+k2eq6zbXqzFbYY+OjSeENZK+ExpXIbM0qjvSdkcTp4STojG/gtOGohzYD8vw/
 ZUADXPUmTr6JnUxdxO/xPshpXbrPlojhhU7ddHceIsXMbKsmxliaJ1DVBjqYytaGl5TrMR1njeU7i
 vtZLmDsP9Imtl0WbvtIea3LNSWkPuuAzvpWorfgcqKQ9YoKzj11chy5CgJD+MnZ3cT036Sc1ehwh5
 zdUunrDDBp5P4I1/c21LW4rRF7IEyfbR6SoIM+BzA=;
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 13:42:43 +0200
Message-ID: <3608455.qB9dszzTOH@silver>
In-Reply-To: <20190627181203.59c956d9@bahia.lan>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <9e026ca5f087d6ef741e0d82a0067ed7cdaf129f.1561575449.git.qemu_oss@crudebyte.com>
 <20190627181203.59c956d9@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [PATCH v4 1/5] 9p: unsigned type for type, version,
 path
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 27. Juni 2019 18:12:03 CEST Greg Kurz wrote:
> On Wed, 26 Jun 2019 20:25:55 +0200
> Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> wrote:
> > There is no need for signedness on these QID fields for 9p.
> > 
> > Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
> 
> You should mention here the changes you made on top of Antonios
> original patch. Something like:
> 
> [CS: - also convert path
>      - adapted trace-events and donttouch_stat()]

Haven't seen that comment style in the git logs. Any example hash for that?

> > diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
> > index c0a0a4ab5d..6964756922 100644
> > --- a/hw/9pfs/trace-events
> > +++ b/hw/9pfs/trace-events
> > @@ -6,7 +6,7 @@ v9fs_rerror(uint16_t tag, uint8_t id, int err) "tag %d id
> > %d err %d"> 
> >  v9fs_version(uint16_t tag, uint8_t id, int32_t msize, char* version) "tag
> >  %d id %d msize %d version %s" v9fs_version_return(uint16_t tag, uint8_t
> >  id, int32_t msize, char* version) "tag %d id %d msize %d version %s"
> >  v9fs_attach(uint16_t tag, uint8_t id, int32_t fid, int32_t afid, char*
> >  uname, char* aname) "tag %u id %u fid %d afid %d uname %s aname %s"> 
> > -v9fs_attach_return(uint16_t tag, uint8_t id, int8_t type, int32_t
> > version, int64_t path) "tag %d id %d type %d version %d path %"PRId64
> > +v9fs_attach_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t
> > version, uint64_t path) "tag %d id %d type %d version %d path %"PRId64
> I was expecting to see PRIu64 for an uint64_t but I now realize that %d
> seems to be used all over the place for unsigned types... :-\
> 
> At least, please fix the masks of the lines you're changing in this
> patch so that unsigned are passed to "u" or PRIu64. The rest of the
> mess can be fixed later in a followup.

If you don't mind I will restrict it to your latter suggestion for now, that 
is adjusting it using the short format specifiers e.g. "u", the rest would IMO 
be out of the scope of this patch series.

Too bad that no format specifier warnings are thrown on these.

Best regards,
Christian Schoenebeck

