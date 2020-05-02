Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B19C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 21:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6507F20757
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 21:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dILO8mIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6507F20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUzJv-0002LX-Jd
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 17:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jUzJK-0001wM-Pn
 for qemu-devel@nongnu.org; Sat, 02 May 2020 17:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jUzJJ-0006BV-5A
 for qemu-devel@nongnu.org; Sat, 02 May 2020 17:04:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23858
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jUzJI-0006Ah-IN
 for qemu-devel@nongnu.org; Sat, 02 May 2020 17:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588453470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSiMT6OBpieCOiijxlOehRA/z7SOk14fKm1lMERSPaY=;
 b=dILO8mIzbIxeK5S2rTQW+dNo8OkWAUfYWo9YaOLyiEVBTdfBZQVHQEqwb1y8uIxpmdvdst
 f0aa6g2FdWSVS7vgLxTanjXN6PHmEivKmPm2wo28uyJmhHTKkv/9ACa9++xxpcM+YD3Pg/
 ET7gn3dzQFGCgzu0/6fNrRVx9ER3+ag=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-vmP5otttN56hPXRQhD7KrQ-1; Sat, 02 May 2020 17:04:26 -0400
X-MC-Unique: vmP5otttN56hPXRQhD7KrQ-1
Received: by mail-qv1-f70.google.com with SMTP id c5so13884197qvi.10
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 14:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p2E2om7DnCuQzFyagvAxGkPQjOEuhE0GvUMdpooshyE=;
 b=NClHSpaxQqI/laNUF1OwfK4gz65j1MZkkfI6Ve29T0nfL7ndF7mAPiQaxJpR36/Gsv
 zlsN4jl6xxw2DJQUkrSScpVKn3yqUziJrVYx8+NA5wBF3RZ6KAq90CHcr0ZCOps+A7d8
 6+r6tOKr3L6JpQzkhKtRz4sg3J+jHMOknCX5LfeyH2FPAKcOOpNCniEjybpvXpcTaax3
 qQdAhdeInkYwGfjK/IEdQrdxvfRXouKwkv3i8imrC2MHw2vTRF1I8Cxr/lTPkUytjUvX
 CA5dhKixUUM/ZSJ3IydCvd+h4fZKlJPBQ+TIbqtG3cCGRsofrSPHIE7BAJ8ibGB320Ww
 IFmw==
X-Gm-Message-State: AGi0PubKcfyNh/pcGVUNH7b1Ij+uBn59EhAThseiHqLkWBLEvWDS1cNM
 xjLZVGtCWFYqpda98lJm9O1BI9g9tCo34TVxb4B6mfSGPArvPkSIUPB2qHGYJcYn3ZziLhPaL01
 ZdIEwxt7qTR5ZOz4=
X-Received: by 2002:ac8:5645:: with SMTP id 5mr10000135qtt.151.1588453466155; 
 Sat, 02 May 2020 14:04:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypLS0y4Kl73Frod9aRa1TclU8vhBO+hcUrnfWBPFuo0nEgAKMvz+L3ooborvlksgR8ivUvTlAw==
X-Received: by 2002:ac8:5645:: with SMTP id 5mr10000110qtt.151.1588453465706; 
 Sat, 02 May 2020 14:04:25 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id u27sm6268738qtc.73.2020.05.02.14.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 14:04:24 -0700 (PDT)
Date: Sat, 2 May 2020 17:04:23 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 0/4] vl: Sync dirty bitmap when system resets
Message-ID: <20200502210423.GB6299@xz-x1>
References: <20200428194219.10963-1-peterx@redhat.com>
 <20200429132607.GJ2834@work-vm> <20200429143227.GC4280@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200429143227.GC4280@xz-x1>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 16:36:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tian Kevin <kevin.tian@intel.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 10:32:27AM -0400, Peter Xu wrote:
> On Wed, Apr 29, 2020 at 02:26:07PM +0100, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > This RFC series starts from the fact that we will sync dirty bitmap w=
hen
> > > removing a memslot for KVM.  IIUC that was majorly to maintain the di=
rty bitmap
> > > even across a system reboot.
> > >=20
> > > This series wants to move that sync from kvm memslot removal to syste=
m reset.
> > >=20
> > > (I still don't know why the reset system will still need to keep the =
RAM status
> > >  before the reset.  I thought things like kdump might use this to ret=
rieve info
> > >  from previous kernel panic, however IIUC that's not what kdump is do=
ing now.
> > >  Anyway, I'd be more than glad if anyone knows the real scenario behi=
nd
> > >  this...)
> >=20
> > Aren't there pages written by the BIOS that are read by the system as i=
t
> > comes up through reset - so you need those pages intact?
> > (But I don't think that slot gets removed? Or does it - the bios has
> > some weird aliasing)
>=20
> Do you know which section it writes to?  I can trace a bit to see...
>=20
> My previous understanding is that if the RAM starts to be written then it
> shouldn't change layout anymore, but I could be wrong.
>=20
> >=20
> > > The current solution (sync at kvm memslot removal) works in most case=
s, but:
> > >=20
> > >   - it will be merely impossible to work for dirty ring, and,
> >=20
> > Why doesn't that work with dirty ring?
>=20
> Because strict sync is hard imho... I shouldn't say it's impossible, but =
it
> should depend on the fixes for existing kvm get dirty log, so it's even h=
arder
> (please see below).
>=20
> I'll start with normal get dirty log.  Currently, qemu's KVM syncs dirty =
with:
>=20
>   - remove memslot
>     - KVM_GET_DIRTY_LOG on memslot
>     - KVM_SET_USER_MEMORY_REGION to remove
>=20
> But it's racy because writes can happen between the two steps.  One corre=
ct way
> to do that is:
>=20
>   - remove memslot
>     - KVM_SET_USER_MEMORY_REGION to set it READONLY [a]
>       - kick all vcpu out synchronously to make sure dirty bits are flush=
ed to
>         KVM per-memslot dirty bitmaps [b]
>     - KVM_GET_DIRTY_LOG on memslot
>     - KVM_SET_USER_MEMORY_REGION to remove
>=20
> The fix should both contain a QEMU fix at [a] to first mark it as READONL=
Y so
> no continuous write could happen before get dirty log, and another fix in
> kernel [b] to do synchronously flush each vcpu to make sure PML is flushe=
d
> (which could be very awkward; I proposed an idea [1] but I didn't get any
> positive feedback yet).
>=20
> [1] https://lore.kernel.org/qemu-devel/20200402223240.GG103677@xz-x1/
>=20
> So I think it's not easy to make it fully right even for get dirty log.
>=20
> For dirty ring, the sync will look like:
>=20
>   - remove memslot
>     - KVM_SET_USER_MEMORY_REGION to set it READONLY [a]
>       - kick all vcpu out synchronously to make sure dirty bits are flush=
ed to
>         KVM per-memslot dirty bitmaps [b]
>     - collect dirty ring [c]
>=20
> So it will depend on us fixing [a,b] first, then because dirty ring is pe=
r-vcpu
> not per-slot, [c] needs to collect all data for all vcpus (across all slo=
ts).
> So it will try to take all slots_lock even if we're removing a single sma=
ll
> memslot with one slots_lock taken already.  I think we can still do it, b=
ut as
> you see, it's awkward and harder than the legacy get dirty log process.
>=20
> I was always wondering why this is that useful and in what cases we're us=
ing
> this.  If system reset is the only place then it'll be very clean to move=
 it
> there because that's a very high point of the stack where we only have a =
BQL,
> at the same time we paused all the vcpus anyway so most nasty things are =
gone.
> We just do a simple sync like in this series and it'll nicely work for bo=
th
> dirty log and dirty ring (then we don't need to fix [a] and [b] either).

Paolo,

Do you have any opinion on this series?  Or more generally comments on what=
's
your preference to fix the known dirty sync issue with memslot removal woul=
d be
welcomed too.  For my own opinion, I prefer the approach with this series s=
o we
won't need to touch the kernel at all, and it also paves the way for dirty
ring.  In all cases, I do think collecting dirty bit of a removing slot is
slightly awkward already.

Dave has valid conerns about other cases besides reboot where we might stil=
l
want to keep the dirty bits, on either (1) during BIOS/... boots, or (2) gu=
est
unmaps of device mmio regions that were backed up by RAM.  I can continue t=
o
look into theses, however before that I'd appreciate to know whether the
direction is correct and acceptable.

IMHO the worst case of a series like this could be that we got regression o=
n
dirty bit loss, but then we can simply revert the last patch to verify or f=
ix
it (or we can fix the missing case instead).

Thanks,

>=20
> >=20
> > >   - it has an existing flaw on race condition. [1]
> > >=20
> > > So if system reset is the only thing we care here, I'm thinking wheth=
er we can
> > > move this sync explicitly to system reset so we do a global sync ther=
e instead
> > > of sync every time when memory layout changed and caused memory remov=
als.  I
> > > think it can be more explict to sync during system reset, and also wi=
th that
> > > context it will be far easier for kvm dirty ring to provide the same =
logic.
> > >=20
> > > This is totally RFC because I'm still trying to find whether there wi=
ll be
> > > other cases besides system reset that we want to keep the dirty bits =
for a
> > > to-be-removed memslot (real memory removals like unplugging memory sh=
ouldn't
> > > matter, because we won't care about the dirty bits if it's never goin=
g to be
> > > there anymore, not to mention we won't allow such things during a mig=
ration).
> > > So far I don't see any.
> >=20
> > I'm still unusure when slot removal happens for real; but if it's
> > happening for RAM on PCI devices, then that would make sense as
> > something you might want to keep.
>=20
> Yeah indeed.  Though I'm also curious on a real user of that either that =
will
> frequently map/unmap a MMIO region of device ram.  Also there's a workaro=
und of
> this issue too by marking the region as dirty when unmap the MMIO region,=
 but I
> haven't checked whether that's easy to do in qemu, assuming not that much=
...
>=20
> Thanks,
>=20
> --=20
> Peter Xu

--=20
Peter Xu


