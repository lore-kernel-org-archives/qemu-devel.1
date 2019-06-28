Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF65C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B079D205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B079D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgnTx-000117-WF
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 05:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49646)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hgnSS-0008Qm-Vj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hgnSQ-0003Z6-U5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:46:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hgnSE-0003Ne-U9; Fri, 28 Jun 2019 05:46:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24B56C049E23;
 Fri, 28 Jun 2019 09:45:57 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AD785D71C;
 Fri, 28 Jun 2019 09:45:55 +0000 (UTC)
Date: Fri, 28 Jun 2019 11:45:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190628094554.GC5179@dhcp-200-226.str.redhat.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-2-dplotnikov@virtuozzo.com>
 <507334f0-c680-c975-5001-159087dd0670@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <507334f0-c680-c975-5001-159087dd0670@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 28 Jun 2019 09:45:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v0 1/3] qcow2: introduce compression type
 feature
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 29.05.2019 um 13:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 28.05.2019 17:37, Denis Plotnikov wrote:
> > The patch adds some preparation parts for incompatible compression type
> > feature to QCOW2 header that indicates that *all* compressed clusters
> > must be (de)compressed using a certain compression type.
> > 
> > It is implied that the compression type is set on the image creation and
> > can be changed only later by image conversion, thus compression type
> > defines the only compression algorithm used for the image.
> > 
> > The goal of the feature is to add support of other compression algorithms
> > to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
> > It works roughly x2 faster than ZLIB providing a comparable compression ratio
> > and therefore provide a performance advantage in backup scenarios.
> > 
> > The default compression is ZLIB. Images created with ZLIB compression type
> > is backward compatible with older qemu versions.
> > 
> > Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > ---
> 
> [...]
> 
> > diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> > index af5711e533..cebcbc4f2f 100644
> > --- a/docs/interop/qcow2.txt
> > +++ b/docs/interop/qcow2.txt
> > @@ -109,7 +109,14 @@ in the description of a field.
> >                                   An External Data File Name header extension may
> >                                   be present if this bit is set.
> >   
> > -                    Bits 3-63:  Reserved (set to 0)
> > +                    Bit 3:      Compression type. If the bit is set, then the
> > +                                type of compression the image uses is set in the
> > +                                header extension. When the bit is set the
> > +                                compression type extension header must be present.
> > +                                When the bit is not set the compression type
> > +                                header must absent.
> > +
> > +                    Bits 4-63:  Reserved (set to 0)
> >   
> >            80 -  87:  compatible_features
> >                       Bitmask of compatible features. An implementation can
> > @@ -175,6 +182,7 @@ be stored. Each extension has a structure like the following:
> >                           0x23852875 - Bitmaps extension
> >                           0x0537be77 - Full disk encryption header pointer
> >                           0x44415441 - External data file name string
> > +                        0x434D5052 - Compression type extension
> >                           other      - Unknown header extension, can be safely
> >                                        ignored
> >   
> > @@ -771,3 +779,30 @@ In the image file the 'enabled' state is reflected by the 'auto' flag. If this
> >   flag is set, the software must consider the bitmap as 'enabled' and start
> >   tracking virtual disk changes to this bitmap from the first write to the
> >   virtual disk. If this flag is not set then the bitmap is disabled.
> > +
> > +
> > +== Compression type extension ==
> > +
> > +The compression type extension is an optional header extension. It stores the
> > +compression type used for disk clusters (de)compression.
> > +A single compression type is applied to all compressed disk clusters,
> > +with no way to change compression types per cluster. Two clusters of the image
> > +couldn't be compressed with different compression types.
> > +
> > +The compression type is set on image creation. The only way to change
> > +the compression type is to convert the image explicitly.
> > +
> > +The compression type extension is present if and only if the incompatible
> > +compression type bit is set. When the bit is not set the compression type
> > +header must be absent.
> 
> Hmm, not the first time we introduce incompatible bit to make incompatible
> header extension, as all header extensions are compatible by default, as for
> unknown header extension we have:
> 
>                          other      - Unknown header extension, can be safely
>                                       ignored
> 
> Hm. Should we instead define one incompatible bit for all such future cases,
> i.e. add incompatible bit HEADER_EXTENSION_FLAGS, add flag field to header
> extension declaration, and define one flag in it: COMPATIBLE, which will mean,
> that this extension may be safely ignored (old default behavior).

Would this actually make the implementation simpler, though?

I mean, the original idea was anyway that we'd just add new fields to
the header instead of using header extensions. Header extensions were
only meant for dynamically sized things like strings. That we would add
new fields to the header is why the header_length field even exists.

So in this case, we could consider using bytes 104-107 of the header for
compression_type instead of adding a new header extension.

Kevin

