Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6548C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBAD2078B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZ5AE9Sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBAD2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIkN-0003dR-KR
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jJIjd-0002ea-NJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jJIjb-0000Bh-OM
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59797
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jJIjb-0000B5-Ju
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585668202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6KkuFVggGh74cOrfYuyy0XgRvciTyofjvQ2oBTqC6U=;
 b=AZ5AE9SqknijNn3k9yA4SaVdRafAo/LJ5rtXes0QYabPwJBxSCv30orCw1m11OxDPJu2Gb
 Hh6VQPGzJD4WcH4/lQgr5fcrG1bRvwGhmVYawYeKBBK5574I3ByZBeHH9WlywLjxay/HAy
 ysONm4+PH62L8BwBlYY/BvmWYQELNiQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-yWgf-DFCPiarqUiriW7enQ-1; Tue, 31 Mar 2020 11:23:20 -0400
X-MC-Unique: yWgf-DFCPiarqUiriW7enQ-1
Received: by mail-wm1-f69.google.com with SMTP id s9so1211186wmh.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 08:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OiCytAjuCBhc9NoZl/3YB/55X8RSjEY27GT8Kdum3UA=;
 b=R+GV6iXLw3MMnktrCnKcSLwpyzxOfs4VjM0fgJ8SPW25i4L0T3E5zaz7Tte9KTFTP+
 Syj9d2KP33FVLrgnO6gEg2fD3UtOjczxilOO4I4hof+0xxjhvMGmCW6CiJCq1bEoChgG
 1D/nmo9TBeevmdKZyR4aMcGRwY8WTeYiVfk9xQfbfi6Pfgtsm6yB6H58T5CRVo5TjyK/
 5MdDp8vD4sZjifgwJtw9Jn4z4ZcgYbEFqrZOIJXpMqT0V0ZM2Z1Pv+hp0k259aEKjVoL
 DBVgjAe38lrIjD95rT77gFstIFnrTXOzX0E708PWyBqjG+XlBgiOy7d9W92x6aXEwBDQ
 vHeA==
X-Gm-Message-State: ANhLgQ0Dkzsvhgtz5A9dyF2xJ2FBgUydsIsiL2DF9LKRyxatyskFH6p6
 Pnp7fZyyGVrfGAznptpirkIs36dl+/pKo7x36DsZ8XwBcT04KohNudolmFZV8jRm0gfzUKs5WHU
 UJqPKAlsqDqS8Rck=
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr3965723wmd.8.1585668198609; 
 Tue, 31 Mar 2020 08:23:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvzhvYV+hH2q7XVwSkJf9WG9joF5Xx0v13KOlLprgtDPnUfXxzGJgF5hsXFf44L3ICvfupDwA==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr3965696wmd.8.1585668198291; 
 Tue, 31 Mar 2020 08:23:18 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id y4sm16075441wrl.40.2020.03.31.08.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 08:23:17 -0700 (PDT)
Date: Tue, 31 Mar 2020 11:23:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
Subject: Re: Question on dirty sync before kvm memslot removal
Message-ID: <20200331152314.GG522868@xz-x1>
References: <20200327150425.GJ422390@xz-x1>
 <c90a6ffd-0cab-186d-b9c8-8e379921783f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c90a6ffd-0cab-186d-b9c8-8e379921783f@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 03:11:53PM +0200, Paolo Bonzini wrote:
> On 27/03/20 16:04, Peter Xu wrote:
> > That makes perfect sense to me, however... What if the vcpu generates
> > dirty bits _after_ we do KVM_GET_DIRTY_LOG but _before_ we send
> > KVM_SET_USER_MEMORY_REGION to remove the memslot?  If the vcpu is in
> > the userspace I think it's fine because BQL is needed so it won't be
> > able to, however the vcpus running inside KVM should not be restricted
> > to that.  I think those dirty bits will still get lost, but it should
> > be extremely hard to trigger.
>=20
> Yes, you've found a bug.
>=20
> > I'm not sure whether I missed something above, but if I'm correct, I
> > think the solution should be a flag for KVM_SET_USER_MEMORY_REGION to
> > set the memslot as invalid (KVM_MEM_INVALID), then when removing the
> > memslot which has KVM_MEM_LOG_DIRTY_PAGES enabled, we should:
> >=20
> >   - send KVM_SET_USER_MEMORY_REGION with KVM_MEM_INVALID to invalidate
> >     the memslot, but keep the slot and bitmap in KVM
> >=20
> >   - send KVM_GET_DIRTY_LOG to fetch the bitmap for the slot
> >=20
> >   - send KVM_SET_USER_MEMORY_REGION with size=3D=3D0 to remove the slot
>=20
> Or KVM_MEM_READONLY.

Yeah, I used a new flag because I thought READONLY was a bit tricky to
be used directly here.  The thing is IIUC if guest writes to a
READONLY slot then KVM should either ignore the write or trigger an
error which I didn't check, however here what we want to do is to let
the write to fallback to the userspace so it's neither dropped (we
still want the written data to land gracefully on RAM), nor triggering
an error (because the slot is actually writable).

>=20
> > However I don't know whether that'll worth it.
>=20
> Yes, especially in the light of the dirty ring issue below.
>=20
> > (Side question which is irrelevant to this: for kvm dirty ring we now
> >  need to do similar thing to flush dirty bits before removing a
> >  memslot, however that's even trickier because flushing dirty ring
> >  needs to kick all vcpu out, currently the RFC series is using
> >  run_on_cpu() which will release the BQL and wait for all vcpus to
> >  quit into userspace, however that cannot be done inside
> >  kvm_set_phys_mem because it needs the BQL.  I'm still thinking about
> >  a good way to fix this, but any idea is greatly welcomed :)
>=20
> The problem here is also that the GFN is not an unique identifier of the
> QEMU ram_addr_t.  However you don't really need to kick all vCPUs out,
> do you?  You can protect the dirty ring with its own per-vCPU mutex and
> harvest the pages from the main thread.

I'm not sure I get the point, but just to mention that currently the
dirty GFNs are collected in a standalone thread (in the QEMU series
it's called the reaper thread) rather than in the per vcpu thread
because the KVM_RESET_DIRTY_RINGS is per-vm after all.  One major
reason to kick the vcpus is to make sure the hardware cached dirty
GFNs (i.e. PML) are flushed synchronously.

I think the whole kick operation is indeed too heavy for this when
with the run_on_cpu() trick, because the thing we want to know (pml
flushing) is actually per-vcpu and no BQL interaction. Do we have/need
a lightweight way to kick one vcpu in synchronous way?  I was
wondering maybe something like responding a "sync kick" request in the
vcpu thread right after KVM_RUN ends (when we don't have BQL yet).
Would that make sense?

Thanks,

--=20
Peter Xu


