Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646E9C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3073621775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpC3DT2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3073621775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnmV-0004zn-Bi
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTnlO-0003Ad-Ng
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTnlN-0004gK-FG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:32:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31854
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTnlM-0004ex-Re
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588170755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JaFQ6WZvDQfiENlhBwIvfRFwKxDGg4xG2sIaKau2ctM=;
 b=UpC3DT2XOLWjWZ11zy1aLakLJ4oCq5hdOBxz/l+oOdrbnEmS1EvPAJxXoG9zEO7JAeasUb
 bamBHunD68ov1DDsbq7Lwu9XzK5idxF4araGeM4K+of1/meDkEUzuywX42oSBZhRVl87+M
 aljCPeL/Pe0CWRlDZxzBwoYRp61bBXI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-JHhW6TdKO5yJbT2uMQGb0g-1; Wed, 29 Apr 2020 10:32:30 -0400
X-MC-Unique: JHhW6TdKO5yJbT2uMQGb0g-1
Received: by mail-qv1-f72.google.com with SMTP id et5so2800289qvb.5
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rxQ+xJ0mTQYyd9uHIlRYGTeaDP2kASMzRQkje/xMWXw=;
 b=Jjl7ezDATvoBkQXnBZcThdRul0PLqKEJuGZbCbEQ0iNpRPmykSrLBETRem1EpGCxXd
 GS869cO12PnBJo6ImNKnI4pz5iN8hL2KIHkfTc3GWpQZV6/ods4k2pehasScHVhP/lSg
 slyOCb2zyf57LcPJZ1iSDIpYRS4FE44apUkKjh3OYaofRfJ94fquovE+VtXl9M3h/rPU
 jnZL97R0OlnFqlZI4HNEmecE4gijC660g5dqjoN/vMOv8uRcc5EP2sNNDRw8hdD9ydf0
 I9gRXJye729H6KaG61fUd+ft2ZuLy9YQcTreLx/i3oYsdfZYOxTJThfj2yLZQM9szmOs
 jtUg==
X-Gm-Message-State: AGi0PuaFD8WdR0OP3EX9V9RUmMpvk2MuMN92ZnteQ9ZpRUd85F9o8tvI
 xlkSc/YpRkYgDluXM67os4HFXnw8wS4KbFkq7w6b06D9n1uTroPzZ9JNmFopfMdcDGJzAumtn4B
 tcYd1Drx/smkCwNM=
X-Received: by 2002:ac8:47cb:: with SMTP id d11mr33648616qtr.136.1588170749772; 
 Wed, 29 Apr 2020 07:32:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJtlC+DewkUaxIQ/dWv2eDmptaFpmlfwPVjxw+y2M3G55Hz4n5juuzFGTQLzYT9IYwAheboyw==
X-Received: by 2002:ac8:47cb:: with SMTP id d11mr33648566qtr.136.1588170749242; 
 Wed, 29 Apr 2020 07:32:29 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id p2sm15796756qkm.65.2020.04.29.07.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 07:32:28 -0700 (PDT)
Date: Wed, 29 Apr 2020 10:32:27 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 0/4] vl: Sync dirty bitmap when system resets
Message-ID: <20200429143227.GC4280@xz-x1>
References: <20200428194219.10963-1-peterx@redhat.com>
 <20200429132607.GJ2834@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200429132607.GJ2834@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Wed, Apr 29, 2020 at 02:26:07PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > This RFC series starts from the fact that we will sync dirty bitmap whe=
n
> > removing a memslot for KVM.  IIUC that was majorly to maintain the dirt=
y bitmap
> > even across a system reboot.
> >=20
> > This series wants to move that sync from kvm memslot removal to system =
reset.
> >=20
> > (I still don't know why the reset system will still need to keep the RA=
M status
> >  before the reset.  I thought things like kdump might use this to retri=
eve info
> >  from previous kernel panic, however IIUC that's not what kdump is doin=
g now.
> >  Anyway, I'd be more than glad if anyone knows the real scenario behind
> >  this...)
>=20
> Aren't there pages written by the BIOS that are read by the system as it
> comes up through reset - so you need those pages intact?
> (But I don't think that slot gets removed? Or does it - the bios has
> some weird aliasing)

Do you know which section it writes to?  I can trace a bit to see...

My previous understanding is that if the RAM starts to be written then it
shouldn't change layout anymore, but I could be wrong.

>=20
> > The current solution (sync at kvm memslot removal) works in most cases,=
 but:
> >=20
> >   - it will be merely impossible to work for dirty ring, and,
>=20
> Why doesn't that work with dirty ring?

Because strict sync is hard imho... I shouldn't say it's impossible, but it
should depend on the fixes for existing kvm get dirty log, so it's even har=
der
(please see below).

I'll start with normal get dirty log.  Currently, qemu's KVM syncs dirty wi=
th:

  - remove memslot
    - KVM_GET_DIRTY_LOG on memslot
    - KVM_SET_USER_MEMORY_REGION to remove

But it's racy because writes can happen between the two steps.  One correct=
 way
to do that is:

  - remove memslot
    - KVM_SET_USER_MEMORY_REGION to set it READONLY [a]
      - kick all vcpu out synchronously to make sure dirty bits are flushed=
 to
        KVM per-memslot dirty bitmaps [b]
    - KVM_GET_DIRTY_LOG on memslot
    - KVM_SET_USER_MEMORY_REGION to remove

The fix should both contain a QEMU fix at [a] to first mark it as READONLY =
so
no continuous write could happen before get dirty log, and another fix in
kernel [b] to do synchronously flush each vcpu to make sure PML is flushed
(which could be very awkward; I proposed an idea [1] but I didn't get any
positive feedback yet).

[1] https://lore.kernel.org/qemu-devel/20200402223240.GG103677@xz-x1/

So I think it's not easy to make it fully right even for get dirty log.

For dirty ring, the sync will look like:

  - remove memslot
    - KVM_SET_USER_MEMORY_REGION to set it READONLY [a]
      - kick all vcpu out synchronously to make sure dirty bits are flushed=
 to
        KVM per-memslot dirty bitmaps [b]
    - collect dirty ring [c]

So it will depend on us fixing [a,b] first, then because dirty ring is per-=
vcpu
not per-slot, [c] needs to collect all data for all vcpus (across all slots=
).
So it will try to take all slots_lock even if we're removing a single small
memslot with one slots_lock taken already.  I think we can still do it, but=
 as
you see, it's awkward and harder than the legacy get dirty log process.

I was always wondering why this is that useful and in what cases we're usin=
g
this.  If system reset is the only place then it'll be very clean to move i=
t
there because that's a very high point of the stack where we only have a BQ=
L,
at the same time we paused all the vcpus anyway so most nasty things are go=
ne.
We just do a simple sync like in this series and it'll nicely work for both
dirty log and dirty ring (then we don't need to fix [a] and [b] either).

>=20
> >   - it has an existing flaw on race condition. [1]
> >=20
> > So if system reset is the only thing we care here, I'm thinking whether=
 we can
> > move this sync explicitly to system reset so we do a global sync there =
instead
> > of sync every time when memory layout changed and caused memory removal=
s.  I
> > think it can be more explict to sync during system reset, and also with=
 that
> > context it will be far easier for kvm dirty ring to provide the same lo=
gic.
> >=20
> > This is totally RFC because I'm still trying to find whether there will=
 be
> > other cases besides system reset that we want to keep the dirty bits fo=
r a
> > to-be-removed memslot (real memory removals like unplugging memory shou=
ldn't
> > matter, because we won't care about the dirty bits if it's never going =
to be
> > there anymore, not to mention we won't allow such things during a migra=
tion).
> > So far I don't see any.
>=20
> I'm still unusure when slot removal happens for real; but if it's
> happening for RAM on PCI devices, then that would make sense as
> something you might want to keep.

Yeah indeed.  Though I'm also curious on a real user of that either that wi=
ll
frequently map/unmap a MMIO region of device ram.  Also there's a workaroun=
d of
this issue too by marking the region as dirty when unmap the MMIO region, b=
ut I
haven't checked whether that's easy to do in qemu, assuming not that much..=
.

Thanks,

--=20
Peter Xu


