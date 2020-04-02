Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4F0C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C0B20719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d10PkBWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C0B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK6li-0002NJ-Em
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 16:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jK6l3-0001t3-HA
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jK6kx-0002JZ-Vw
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:48:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22675
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jK6kx-0002Ix-P0
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585860487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3hd7x5jI/pOnwL9+xYsdPfYCVLESBjMRWKQ9SQ8psJk=;
 b=d10PkBWcwF8uxEASW1Qp+Hy8BBCG0d4ArGkeGlfzt1zUuU9zBWhCrsFb5sXkifm33jwD2L
 raoUUZOh9zjr6/kIlzgYzb8OQomU2IcuYaqlUB6wVL2dxymLnZCwojk03fofiaJWFxTF3n
 /vKlXQW4IMGcBh0eJdeV/m0ZzKfbbWA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-EVs-bGFhOBmplFW2xlflDQ-1; Thu, 02 Apr 2020 16:48:05 -0400
X-MC-Unique: EVs-bGFhOBmplFW2xlflDQ-1
Received: by mail-wr1-f70.google.com with SMTP id r15so1965450wrm.22
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 13:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OvH3oNdkbUnKE+iOX27ntEzNW0rDN00MA3ddBirRW1E=;
 b=GzkAHEI8qmBT7NGE0yo7UCRUX0TeM1P8c52QWL4rj8LdAgtqJANBXC4GQojMvCrA8f
 vr1Qcob5H0oQN+Q0niMZbSOiXfvAR13ZCxEpAfkXH7zmzqxKYchm1GJIyuY89dkwR9qy
 AR8XGCxcpwsaggh0IuaK6sXvPUeXb3uO2sTRJ68kff/4BvlY9nTZFh7czhNvqfX6fy4h
 mY9ZGZG8mLR2EU58ICMxhkYBZExCQkDitZwAgrYksysf1r4jc9619kYC3q3N75N9/y7T
 i/QMsGJRwKGrS4eCcWmd7IJBag0buFC/px5WGtEUCkbe2JgtRIyebJjg5ZFr0X9Gjgrm
 1osA==
X-Gm-Message-State: AGi0PuaHiCceNx9MGlmsOS+BfmSsk8UwKateXlpcqs2MzGThpXWIQNmz
 gBhu/Ig2xfe8jDemSI+MXrS9+JDPWlX3R5HQIzxVPmq1j8pm0nq16c28zDScy96WHvqh90pRc8N
 3VD586pUed7sytVg=
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr5527665wrv.357.1585860484168; 
 Thu, 02 Apr 2020 13:48:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypL7b24JfuF0J3pgu2cXqDLQ/W+L03wGANq7OZkl4XCaFgqmQL8dondzWmgNCZKF9gBP8SqfLg==
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr5527631wrv.357.1585860483824; 
 Thu, 02 Apr 2020 13:48:03 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id p17sm8337738wmb.30.2020.04.02.13.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 13:48:03 -0700 (PDT)
Date: Thu, 2 Apr 2020 16:47:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Question on dirty sync before kvm memslot removal
Message-ID: <20200402204758.GF103677@xz-x1>
References: <20200327150425.GJ422390@xz-x1>
 <c90a6ffd-0cab-186d-b9c8-8e379921783f@redhat.com>
 <20200331152314.GG522868@xz-x1>
 <62aa8314-954f-7397-8bf4-d81d926c4f0b@redhat.com>
 <20200331165133.GI522868@xz-x1>
 <2eebbb76-0a12-87f4-812c-27d3e3f16a7c@redhat.com>
 <20200401230928.GG648829@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200401230928.GG648829@xz-x1>
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

On Wed, Apr 01, 2020 at 07:09:28PM -0400, Peter Xu wrote:
> On Wed, Apr 01, 2020 at 01:12:04AM +0200, Paolo Bonzini wrote:
> > On 31/03/20 18:51, Peter Xu wrote:
> > > On Tue, Mar 31, 2020 at 05:34:43PM +0200, Paolo Bonzini wrote:
> > >> On 31/03/20 17:23, Peter Xu wrote:
> > >>>> Or KVM_MEM_READONLY.
> > >>> Yeah, I used a new flag because I thought READONLY was a bit tricky=
 to
> > >>> be used directly here.  The thing is IIUC if guest writes to a
> > >>> READONLY slot then KVM should either ignore the write or trigger an
> > >>> error which I didn't check, however here what we want to do is to l=
et
> > >>> the write to fallback to the userspace so it's neither dropped (we
> > >>> still want the written data to land gracefully on RAM), nor trigger=
ing
> > >>> an error (because the slot is actually writable).
> > >>
> > >> No, writes fall back to userspace with KVM_MEM_READONLY.
> > >=20
> > > I read that __kvm_write_guest_page() will return -EFAULT when writtin=
g
> > > to the read-only memslot, and e.g. kvm_write_guest_virt_helper() will
> > > return with X86EMUL_IO_NEEDED, which will be translated into a
> > > EMULATION_OK in x86_emulate_insn().  Then in x86_emulate_instruction(=
)
> > > it seems to get a "1" returned (note that I think it does not set
> > > either vcpu->arch.pio.count or vcpu->mmio_needed).  Does that mean
> > > it'll retry the write forever instead of quit into the userspace?  I
> > > may possibly have misread somewhere, though..
> >=20
> > We are definitely relying on KVM_MEM_READONLY to exit to userspace, in
> > order to emulate flash memory.
> >=20
> > > However... I think I might find another race with this:
> > >=20
> > >           main thread                       vcpu thread
> > >           -----------                       -----------
> > >                                             dirty GFN1, cached in PML
> > >                                             ...
> > >           remove memslot1 of GFN1
> > >             set slot READONLY (whatever, or INVALID)
> > >             sync log (NOTE: no GFN1 yet)
> > >                                             vmexit, flush PML with RC=
U
> > >                                             (will flush to old bitmap=
) <------- [1]
> > >             delete memslot1 (old bitmap freed)                       =
  <------- [2]
> > >           add memslot2 of GFN1 (memslot2 could be smaller)
> > >             add memslot2
> > >=20
> > > I'm not 100% sure, but I think GFN1's dirty bit will be lost though
> > > it's correctly applied at [1] but quickly freed at [2].
> >=20
> > Yes, we probably need to do a mass vCPU kick when a slot is made
> > READONLY, before KVM_SET_USER_MEMORY_REGION returns (and after releasin=
g
> > slots_lock).  It makes sense to guarantee that you can't get any more
> > dirtying after KVM_SET_USER_MEMORY_REGION returns.
>=20
> Sounds doable.  Though we still need a synchronous way to kick vcpus
> in KVM to make sure the PML is flushed before KVM_SET_MEMORY_REGION
> returns, am I right?  Is there an existing good way to do this?

Paolo,

I'm not sure whether it's anything close to acceptable, but this is
something I was thinking about below (pesudo code).  Do you think it
makes any sense?  Thanks,

8<-------------------------------------------
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1b6d9ac9533c..437d669dde42 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8161,6 +8161,22 @@ void __kvm_request_immediate_exit(struct kvm_vcpu *v=
cpu)
 }
 EXPORT_SYMBOL_GPL(__kvm_request_immediate_exit);

+void kvm_vcpu_sync(struct kvm_vcpu *vcpu)
+{
+       DECLARE_WAITQUEUE(wait, current);
+
+       add_wait_queue(&vcpu->sync_wq, &wait);
+       set_current_state(TASK_UNINTERRUPTIBLE);
+       kvm_make_request(KVM_REQ_SYNC_VCPU, vcpu);
+       schedule();
+       remove_wait_queue(&vcpu->sync_wq, &wait);
+}
+
+void kvm_vcpu_sync_ack(struct kvm_vcpu *vcpu)
+{
+       wake_up(&vcpu->sync_wq);
+}
+
 /*
  * Returns 1 to let vcpu_run() continue the guest execution loop without
  * exiting to the userspace.  Otherwise, the value will be returned to the
@@ -8274,6 +8290,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
                        kvm_hv_process_stimers(vcpu);
                if (kvm_check_request(KVM_REQ_APICV_UPDATE, vcpu))
                        kvm_vcpu_update_apicv(vcpu);
+               if (kvm_check_request(KVM_REQ_SYNC_VCPU, vcpu))
+                       kvm_vcpu_sync_ack(vcpu);
        }

        if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f6a1905da9bf..e825d2e0a221 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -146,6 +146,7 @@ static inline bool is_error_page(struct page *page)
 #define KVM_REQ_MMU_RELOAD        (1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_W=
AKEUP)
 #define KVM_REQ_PENDING_TIMER     2
 #define KVM_REQ_UNHALT            3
+#define KVM_REQ_SYNC_VCPU         4
 #define KVM_REQUEST_ARCH_BASE     8

 #define KVM_ARCH_REQ_FLAGS(nr, flags) ({ \
@@ -278,6 +279,7 @@ struct kvm_vcpu {
        struct kvm_run *run;

        struct swait_queue_head wq;
+       struct wait_queue_head sync_wq;
        struct pid __rcu *pid;
        int sigset_active;
        sigset_t sigset;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f744bc603c53..35216aeb0365 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -342,6 +342,7 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct=
 kvm *kvm, unsigned id)
        vcpu->vcpu_id =3D id;
        vcpu->pid =3D NULL;
        init_swait_queue_head(&vcpu->wq);
+       init_wait_queue_head(&vcpu->sync_wq);
        kvm_async_pf_vcpu_init(vcpu);

        vcpu->pre_pcpu =3D -1;
@@ -1316,9 +1317,20 @@ int kvm_set_memory_region(struct kvm *kvm,
                          const struct kvm_userspace_memory_region *mem)
 {
        int r;
+       unsigned int i;
+       struct kvm_vcpu *vcpu;

        mutex_lock(&kvm->slots_lock);
+
        r =3D __kvm_set_memory_region(kvm, mem);
+
+       /* TBD: use arch-specific hooks; this won't compile on non-x86 */
+       if ((mem->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
+           (mem->flags & KVM_MEM_READONLY)) {
+               kvm_for_each_vcpu(i, vcpu, kvm)
+                   kvm_vcpu_sync(vcpu);
+       }
+
        mutex_unlock(&kvm->slots_lock);
        return r;
 }
@@ -2658,6 +2670,8 @@ static int kvm_vcpu_check_block(struct kvm_vcpu *vcpu=
)
                goto out;
        if (signal_pending(current))
                goto out;
+       if (kvm_check_request(KVM_REQ_SYNC_VCPU, vcpu))
+               goto out;

        ret =3D 0;
 out:
8<-------------------------------------------

--=20
Peter Xu


