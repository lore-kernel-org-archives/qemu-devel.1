Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94E4C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 23:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5853206F8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 23:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/F5bY2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5853206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJmVD-0005fe-PI
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 19:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jJmUK-0005Do-SR
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 19:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jJmUI-0003qX-9J
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 19:09:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46907
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jJmUI-0003og-3d
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 19:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585782573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lOTA5YCA04fBrteRy12J4SE8MBtCmqBI583zyQMtQ9c=;
 b=Z/F5bY2NAC3ZWqRDv83qk4EiEwpptxvuVyGrZ4KkhTw0jOQdYzeKUG6ovdJycoqFkpYnvN
 cq28o4d2ObgduhrHdGB/MvZhSocMdUFiYSmzYeqyIZmbngGY6i0gYmUKgoXYuabzzWLDnW
 W2xjqF3tqgpOfMaoGEAcJP/oQ30UxCY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-bW1jfpDQOW2bEluBMRAk7g-1; Wed, 01 Apr 2020 19:09:31 -0400
X-MC-Unique: bW1jfpDQOW2bEluBMRAk7g-1
Received: by mail-qk1-f199.google.com with SMTP id p8so1397660qkp.4
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 16:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2EITPI/Pu9jBrD46I6G6eYU5tecjrUlIoLZmy2yUtCI=;
 b=Tz7RXMy48CaUVgmqMOxfzfetko0YeHBNFAsVoKTkfFTZScOPO+gI4kLdOPabEqDH9e
 khN44YjjJHAtwdawftNhxj60NyclU3VXf4OSqiW1oHs+OO6gdDEASNlE6lSwVCBhGUJO
 Suzl8g+Y32Vj/MOe3zoORTjVIxuXur4W16YkpJeeLnevE1JVMPa1j13yq3n86OtqmFgZ
 aKp1VQdSGDGoEKkZd5L/N8Uu2rvMV9FlwoSSUSpd85iY+hPKn7gmqlJwomb2xNLknSJd
 jiRAdiIgdge2OlrTZoADizYRbnKM07XWM7Hcm5DyNS8/b2JYoggiWNYwzarrHykHZCDu
 3z4g==
X-Gm-Message-State: AGi0Puaq06joHr3vu+m8ALJGYuP9+TCDFrwb0nyZlh47f8XRFHsoAyxH
 LJD2U85riSnwW37+Pr12N3IcYXGAcOR+93YtrHGcuqVcN1w1FxgihZuQrcwRldxMk9OG1xQfi2q
 5zn5lp1UbNn2lZ+k=
X-Received: by 2002:a05:6214:333:: with SMTP id
 j19mr506967qvu.83.1585782571177; 
 Wed, 01 Apr 2020 16:09:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypJitEsBW5FfUbhPh6xihD84I68eYQi2P44lzTM7XiReICc929BIsOq4D0RflS+NMd3v3jPaKQ==
X-Received: by 2002:a05:6214:333:: with SMTP id
 j19mr506947qvu.83.1585782570912; 
 Wed, 01 Apr 2020 16:09:30 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id u51sm2549570qth.46.2020.04.01.16.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 16:09:30 -0700 (PDT)
Date: Wed, 1 Apr 2020 19:09:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Question on dirty sync before kvm memslot removal
Message-ID: <20200401230928.GG648829@xz-x1>
References: <20200327150425.GJ422390@xz-x1>
 <c90a6ffd-0cab-186d-b9c8-8e379921783f@redhat.com>
 <20200331152314.GG522868@xz-x1>
 <62aa8314-954f-7397-8bf4-d81d926c4f0b@redhat.com>
 <20200331165133.GI522868@xz-x1>
 <2eebbb76-0a12-87f4-812c-27d3e3f16a7c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2eebbb76-0a12-87f4-812c-27d3e3f16a7c@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Wed, Apr 01, 2020 at 01:12:04AM +0200, Paolo Bonzini wrote:
> On 31/03/20 18:51, Peter Xu wrote:
> > On Tue, Mar 31, 2020 at 05:34:43PM +0200, Paolo Bonzini wrote:
> >> On 31/03/20 17:23, Peter Xu wrote:
> >>>> Or KVM_MEM_READONLY.
> >>> Yeah, I used a new flag because I thought READONLY was a bit tricky t=
o
> >>> be used directly here.  The thing is IIUC if guest writes to a
> >>> READONLY slot then KVM should either ignore the write or trigger an
> >>> error which I didn't check, however here what we want to do is to let
> >>> the write to fallback to the userspace so it's neither dropped (we
> >>> still want the written data to land gracefully on RAM), nor triggerin=
g
> >>> an error (because the slot is actually writable).
> >>
> >> No, writes fall back to userspace with KVM_MEM_READONLY.
> >=20
> > I read that __kvm_write_guest_page() will return -EFAULT when writting
> > to the read-only memslot, and e.g. kvm_write_guest_virt_helper() will
> > return with X86EMUL_IO_NEEDED, which will be translated into a
> > EMULATION_OK in x86_emulate_insn().  Then in x86_emulate_instruction()
> > it seems to get a "1" returned (note that I think it does not set
> > either vcpu->arch.pio.count or vcpu->mmio_needed).  Does that mean
> > it'll retry the write forever instead of quit into the userspace?  I
> > may possibly have misread somewhere, though..
>=20
> We are definitely relying on KVM_MEM_READONLY to exit to userspace, in
> order to emulate flash memory.
>=20
> > However... I think I might find another race with this:
> >=20
> >           main thread                       vcpu thread
> >           -----------                       -----------
> >                                             dirty GFN1, cached in PML
> >                                             ...
> >           remove memslot1 of GFN1
> >             set slot READONLY (whatever, or INVALID)
> >             sync log (NOTE: no GFN1 yet)
> >                                             vmexit, flush PML with RCU
> >                                             (will flush to old bitmap) =
<------- [1]
> >             delete memslot1 (old bitmap freed)                         =
<------- [2]
> >           add memslot2 of GFN1 (memslot2 could be smaller)
> >             add memslot2
> >=20
> > I'm not 100% sure, but I think GFN1's dirty bit will be lost though
> > it's correctly applied at [1] but quickly freed at [2].
>=20
> Yes, we probably need to do a mass vCPU kick when a slot is made
> READONLY, before KVM_SET_USER_MEMORY_REGION returns (and after releasing
> slots_lock).  It makes sense to guarantee that you can't get any more
> dirtying after KVM_SET_USER_MEMORY_REGION returns.

Sounds doable.  Though we still need a synchronous way to kick vcpus
in KVM to make sure the PML is flushed before KVM_SET_MEMORY_REGION
returns, am I right?  Is there an existing good way to do this?

Thanks,

--=20
Peter Xu


