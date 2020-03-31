Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B4CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34C0206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T++pqjpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34C0206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJK81-00023j-0H
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jJK77-00016x-OH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jJK75-0002DW-Rb
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:51:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jJK73-0002Ai-Nu
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585673500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92xcFkbSOeKiZND8DVLt0LoMfNbGpH+qfhq4A4uQ9GA=;
 b=T++pqjpotPU7GtFTwPyWJLwkXGdFIFz7brop+XWciNGvuL6Sl0aLkCbx2I8nqFMsffVZn4
 SqiRtWnisnMLVCMl4pIRHiXlKrsXDmjZe0+hcSw30c1kr/bGGIwGKd1esc66oVH7/u87P9
 drAA9kHo87cM4YZvFDGTZoBPtwijZwI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-QGhNqXwGPjO_pHSXbNN8Uw-1; Tue, 31 Mar 2020 12:51:38 -0400
X-MC-Unique: QGhNqXwGPjO_pHSXbNN8Uw-1
Received: by mail-wm1-f70.google.com with SMTP id e16so698664wmh.5
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 09:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NP1m9XCO6KKa6bVIinTCba9cyrsRlgItIyK4mTXPstU=;
 b=SH87jcy6ziMawoXNJQrgPeOTnSZge2xVeD1iaB0aKWRNfCPQhXAzhK/lJkjEhVkYpG
 6Ks1YKBTuXwIq70s97K/xQAdWuAeLKyAdU8MrGtQ5b9XvV9F6Ac4GrrxCBdeEKwoMCoj
 Z4XaHPeZVRePbrvy/n6QruKtFJ4IjcLnYUlX3h2/HAjB0FU4j4S4klimx/6TL2wXRYn/
 +03fhS4KDNPfG05Ubf154S0fvw0ryM79tyrKluPnvJCHcoxuZXr7VgVIhNVJPj6IYzQz
 JKLMtahOMIKvts5snjSe/u5EqlnfsieovVX0QUcbEsquHO55o02mrOLbsTsJXxItSlUK
 mOew==
X-Gm-Message-State: ANhLgQ01weXHuw2AjXJLaAFgyG/zKTEcY8atDKF0GfAWOu3Cvjbj8nfa
 RWlyIWZiGSDkKEm7qDyA+nfZ3+NE55x99x/JdvYskIAh+DMyDaokG0opfdeSrX6WfKDRQWnEXzu
 ApCLv6b0tOehPshM=
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr4322160wmd.8.1585673497128; 
 Tue, 31 Mar 2020 09:51:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuxz7jsUPWWcjG+qE2ew93Mnh+ps4J9z3W4c2uNuxLLd8STNP77dm1inZFAMF7pP4SEAJ4EYg==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr4322143wmd.8.1585673496820; 
 Tue, 31 Mar 2020 09:51:36 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id v26sm28362127wra.7.2020.03.31.09.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 09:51:36 -0700 (PDT)
Date: Tue, 31 Mar 2020 12:51:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Question on dirty sync before kvm memslot removal
Message-ID: <20200331165133.GI522868@xz-x1>
References: <20200327150425.GJ422390@xz-x1>
 <c90a6ffd-0cab-186d-b9c8-8e379921783f@redhat.com>
 <20200331152314.GG522868@xz-x1>
 <62aa8314-954f-7397-8bf4-d81d926c4f0b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <62aa8314-954f-7397-8bf4-d81d926c4f0b@redhat.com>
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
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 05:34:43PM +0200, Paolo Bonzini wrote:
> On 31/03/20 17:23, Peter Xu wrote:
> >> Or KVM_MEM_READONLY.
> > Yeah, I used a new flag because I thought READONLY was a bit tricky to
> > be used directly here.  The thing is IIUC if guest writes to a
> > READONLY slot then KVM should either ignore the write or trigger an
> > error which I didn't check, however here what we want to do is to let
> > the write to fallback to the userspace so it's neither dropped (we
> > still want the written data to land gracefully on RAM), nor triggering
> > an error (because the slot is actually writable).
>=20
> No, writes fall back to userspace with KVM_MEM_READONLY.

I read that __kvm_write_guest_page() will return -EFAULT when writting
to the read-only memslot, and e.g. kvm_write_guest_virt_helper() will
return with X86EMUL_IO_NEEDED, which will be translated into a
EMULATION_OK in x86_emulate_insn().  Then in x86_emulate_instruction()
it seems to get a "1" returned (note that I think it does not set
either vcpu->arch.pio.count or vcpu->mmio_needed).  Does that mean
it'll retry the write forever instead of quit into the userspace?  I
may possibly have misread somewhere, though..

>=20
> >> The problem here is also that the GFN is not an unique identifier of t=
he
> >> QEMU ram_addr_t.  However you don't really need to kick all vCPUs out,
> >> do you?  You can protect the dirty ring with its own per-vCPU mutex an=
d
> >> harvest the pages from the main thread.
> > I'm not sure I get the point, but just to mention that currently the
> > dirty GFNs are collected in a standalone thread (in the QEMU series
> > it's called the reaper thread) rather than in the per vcpu thread
> > because the KVM_RESET_DIRTY_RINGS is per-vm after all.  One major
> > reason to kick the vcpus is to make sure the hardware cached dirty
> > GFNs (i.e. PML) are flushed synchronously.
>=20
> But you're referring to KVM kicking vCPUs not qemu_vcpu_kick.  Can you
> just do an iteration of reaping after setting KVM_MEM_READONLY?

Oh I think you're right, deleting & readding memslot is special here
that we can keep the data in PML untouched, as long as they can be
flushed again to the new bitmap we're going to create.

However... I think I might find another race with this:

          main thread                       vcpu thread
          -----------                       -----------
                                            dirty GFN1, cached in PML
                                            ...
          remove memslot1 of GFN1
            set slot READONLY (whatever, or INVALID)
            sync log (NOTE: no GFN1 yet)
                                            vmexit, flush PML with RCU
                                            (will flush to old bitmap) <---=
---- [1]
            delete memslot1 (old bitmap freed)                         <---=
---- [2]
          add memslot2 of GFN1 (memslot2 could be smaller)
            add memslot2

I'm not 100% sure, but I think GFN1's dirty bit will be lost though
it's correctly applied at [1] but quickly freed at [2].

>=20
> > I think the whole kick operation is indeed too heavy for this when
> > with the run_on_cpu() trick, because the thing we want to know (pml
> > flushing) is actually per-vcpu and no BQL interaction. Do we have/need
> > a lightweight way to kick one vcpu in synchronous way?  I was
> > wondering maybe something like responding a "sync kick" request in the
> > vcpu thread right after KVM_RUN ends (when we don't have BQL yet).
> > Would that make sense?
>=20
> Not synchronously, because anything synchronous is very susceptible to
> deadlocks.

Yeah it's easy to deadlock (I suffer from it...), but besides above
case (which I really think it's special) I still think unluckily we
need a synchronous way.  For example, the VGA code will need the
latest dirty bit information to decide whether to update the screen
(or it could stall), or the migration code where we need to calculate
downtime with the current dirty bit information, etc.

--=20
Peter Xu


