Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95488C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE1D20665
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE1D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxx2f-0006Xm-N3
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 13:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hxx24-00067e-NC
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hxx23-0004N0-Cq
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hxx23-0004Lj-7B
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:25:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89724309BDA0;
 Wed, 14 Aug 2019 17:25:54 +0000 (UTC)
Received: from work-vm (ovpn-117-212.ams2.redhat.com [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB2DC909F8;
 Wed, 14 Aug 2019 17:25:48 +0000 (UTC)
Date: Wed, 14 Aug 2019 18:25:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190814172545.GS2920@work-vm>
References: <20190813102936.32195-1-dgilbert@redhat.com>
 <20190813102936.32195-2-dgilbert@redhat.com>
 <f87ef58d-a549-54cf-4a3a-8e4712c699e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f87ef58d-a549-54cf-4a3a-8e4712c699e1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 14 Aug 2019 17:25:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] memory: Align and add helper for
 comparing MemoryRegionSections
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> Hi David,
>=20
> On 8/13/19 12:29 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > MemoryRegionSection includes an Int128 'size' field;
> > on some platforms the compiler causes an alignment of this to
> > a 128bit boundary, leaving 8 bytes of dead space.
> > This deadspace can be filled with junk.
> >=20
> > Move the size field to the top avoiding unnecsssary alignment
>=20
> "unnecessary"

Oops thanks.

> This is enough change to be in its own commit.
>=20
> ---
>=20
> > and provide an 'eq' routine to safely compare MRS's.
>=20
> This is another change, and should be squashed in the next patch IMO.

OK, what I'll do is I'll split this one into two ; I feel better
having the extra function here separate from the next commit.

> Doesn't Clang warn about unused 'static inline' btw?

I was using gcc; but we seem to have loads of static inline's - what
would make this one different?

Dave

> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  include/exec/memory.h | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 606250172a..ce62e847bd 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -487,15 +487,27 @@ static inline FlatView *address_space_to_flatvi=
ew(AddressSpace *as)
> >   * @nonvolatile: this section is non-volatile
> >   */
> >  struct MemoryRegionSection {
> > +    Int128 size;
> >      MemoryRegion *mr;
> >      FlatView *fv;
> >      hwaddr offset_within_region;
> > -    Int128 size;
> >      hwaddr offset_within_address_space;
> >      bool readonly;
> >      bool nonvolatile;
> >  };
> > =20
> > +static inline bool MemoryRegionSection_eq(MemoryRegionSection *a,
> > +                                          MemoryRegionSection *b)
> > +{
> > +    return a->mr =3D=3D b->mr &&
> > +           a->fv =3D=3D b->fv &&
> > +           a->offset_within_region =3D=3D b->offset_within_region &&
> > +           a->offset_within_address_space =3D=3D b->offset_within_ad=
dress_space &&
> > +           int128_eq(a->size, b->size) &&
> > +           a->readonly =3D=3D b->readonly &&
> > +           a->nonvolatile =3D=3D b->nonvolatile;
> > +}
> > +
> >  /**
> >   * memory_region_init: Initialize a memory region
> >   *
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

