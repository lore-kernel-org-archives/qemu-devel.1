Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5961C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0977214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0977214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxxLV-0003kI-Pc
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 13:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hxxKH-0002hd-8x
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hxxKG-000058-48
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:44:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hxxKF-0008Uz-HV
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:44:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 353EF3E53F;
 Wed, 14 Aug 2019 17:44:42 +0000 (UTC)
Received: from work-vm (ovpn-117-212.ams2.redhat.com [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42FA88BE3B;
 Wed, 14 Aug 2019 17:44:32 +0000 (UTC)
Date: Wed, 14 Aug 2019 18:44:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190814174430.GT2920@work-vm>
References: <20190813102936.32195-1-dgilbert@redhat.com>
 <20190813102936.32195-2-dgilbert@redhat.com>
 <f87ef58d-a549-54cf-4a3a-8e4712c699e1@redhat.com>
 <20190814172545.GS2920@work-vm>
 <64416580-ee29-8d75-4ad6-c1453d70afd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <64416580-ee29-8d75-4ad6-c1453d70afd6@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 14 Aug 2019 17:44:42 +0000 (UTC)
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
> On 8/14/19 7:25 PM, Dr. David Alan Gilbert wrote:
> > * Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> >> Hi David,
> >>
> >> On 8/13/19 12:29 PM, Dr. David Alan Gilbert (git) wrote:
> >>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>>
> >>> MemoryRegionSection includes an Int128 'size' field;
> >>> on some platforms the compiler causes an alignment of this to
> >>> a 128bit boundary, leaving 8 bytes of dead space.
> >>> This deadspace can be filled with junk.
> >>>
> >>> Move the size field to the top avoiding unnecsssary alignment
> >>
> >> "unnecessary"
> >=20
> > Oops thanks.
> >=20
> >> This is enough change to be in its own commit.
> >>
> >> ---
> >>
> >>> and provide an 'eq' routine to safely compare MRS's.
> >>
> >> This is another change, and should be squashed in the next patch IMO=
.
> >=20
> > OK, what I'll do is I'll split this one into two ; I feel better
> > having the extra function here separate from the next commit.
>=20
> Thanks, feel free to add to both:
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Thanks!

> >> Doesn't Clang warn about unused 'static inline' btw?
> >=20
> > I was using gcc; but we seem to have loads of static inline's - what
> > would make this one different?
>=20
> I guess I was confused with 'static (no-inline)' :)
>=20
> >>>
> >>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >>> ---
> >>>  include/exec/memory.h | 14 +++++++++++++-
> >>>  1 file changed, 13 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/exec/memory.h b/include/exec/memory.h
> >>> index 606250172a..ce62e847bd 100644
> >>> --- a/include/exec/memory.h
> >>> +++ b/include/exec/memory.h
> >>> @@ -487,15 +487,27 @@ static inline FlatView *address_space_to_flat=
view(AddressSpace *as)
> >>>   * @nonvolatile: this section is non-volatile
> >>>   */
> >>>  struct MemoryRegionSection {
> >>> +    Int128 size;
> >>>      MemoryRegion *mr;
> >>>      FlatView *fv;
> >>>      hwaddr offset_within_region;
> >>> -    Int128 size;
> >>>      hwaddr offset_within_address_space;
> >>>      bool readonly;
> >>>      bool nonvolatile;
> >>>  };
> >>> =20
> >>> +static inline bool MemoryRegionSection_eq(MemoryRegionSection *a,
> >>> +                                          MemoryRegionSection *b)
> >>> +{
> >>> +    return a->mr =3D=3D b->mr &&
> >>> +           a->fv =3D=3D b->fv &&
> >>> +           a->offset_within_region =3D=3D b->offset_within_region =
&&
> >>> +           a->offset_within_address_space =3D=3D b->offset_within_=
address_space &&
> >>> +           int128_eq(a->size, b->size) &&
> >>> +           a->readonly =3D=3D b->readonly &&
> >>> +           a->nonvolatile =3D=3D b->nonvolatile;
> >>> +}
> >>> +
> >>>  /**
> >>>   * memory_region_init: Initialize a memory region
> >>>   *
> >>>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

