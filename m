Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6641BC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B3820757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMuGyGuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B3820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK8PO-0003o3-C7
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 18:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jK8Ob-0003Lm-SG
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jK8OZ-0000pj-Rm
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:33:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29623
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jK8OZ-0000p8-Il
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585866786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jgw1wziQTJ/Y5YKkrx5Zwlk1XyKN+xqUoQqSyHolRAk=;
 b=eMuGyGucaG6fgj9hOg9eaEW/5xQUIiaeCpLR6uGBibKN2y46oE2qG506jGbROePy5C8wn0
 02KGrniju9X8/jvhKLfW+qh+T76X+nOTsX+XLTJql58nqUk0eyAKIYan86BIMq58Fws1xw
 Pacn9G2TKpxxhYCvuePsK2SZseQ4Zok=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-3fSL2oyXNh-xvk9C2KzHbw-1; Thu, 02 Apr 2020 18:33:05 -0400
X-MC-Unique: 3fSL2oyXNh-xvk9C2KzHbw-1
Received: by mail-wm1-f71.google.com with SMTP id l13so1959650wme.7
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 15:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Qyhkos/nJeNiiUzpQUyRUl3fVbYSAc4+dJAO/XC0RuA=;
 b=ksjzF0HT+auNlp4s8vKPd+/ABxXaU6Vg2H6MeUAqluboDXSSW5P2taCeSOxFWMIVHM
 1cKfaWnIDL54qidC2+vg/0V4FI7UlB8O+Rz6YC8h0HUt6mx4PFOcJd5HLkeB4u8ZoOkO
 /84fv2ZHtCLBzQVEw5oDraKXwFBbfAikDSfKQikR7mf97yKCVJPh5A6ND3xacVis2XAn
 JYNpRpLccy87Ely1M4R8FgbvM7SkqAxZlLnrehV5kmxQmImGzCQVz8ePT7tQZAJFLRXi
 /TgPxtEcfVOWRRumlFOzolAnec1VYfQgQ5ZbLj+Ffy9k/tLUSsT2HNKZOMgp8r14WGVk
 dWOA==
X-Gm-Message-State: AGi0PuakZtbawbgz7NOC652HEwopNfxi+yqnHDcCOwh9Ntz7SU/6oQQO
 eIOgmrlrwG2iYs4c1wHAx+SLU/6q3rO+BLpM47T9e7vtGUTvHNSQMg6Ca33xP2hrC8H5eTWoGsB
 bYOBm8yaoNmTrL8g=
X-Received: by 2002:adf:e948:: with SMTP id m8mr5568364wrn.193.1585866783879; 
 Thu, 02 Apr 2020 15:33:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypIyF9k6dETrmkh+pAh6M5xrrKnoLjwl1KassPiSEtS1Mz3o90Fc4kZU+RTWEDJXeZJrX+WLIw==
X-Received: by 2002:adf:e948:: with SMTP id m8mr5567344wrn.193.1585866765118; 
 Thu, 02 Apr 2020 15:32:45 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id h132sm9555668wmf.18.2020.04.02.15.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 15:32:44 -0700 (PDT)
Date: Thu, 2 Apr 2020 18:32:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Question on dirty sync before kvm memslot removal
Message-ID: <20200402223240.GG103677@xz-x1>
References: <20200327150425.GJ422390@xz-x1>
 <c90a6ffd-0cab-186d-b9c8-8e379921783f@redhat.com>
 <20200331152314.GG522868@xz-x1>
 <62aa8314-954f-7397-8bf4-d81d926c4f0b@redhat.com>
 <20200331165133.GI522868@xz-x1>
 <2eebbb76-0a12-87f4-812c-27d3e3f16a7c@redhat.com>
 <20200401230928.GG648829@xz-x1> <20200402204758.GF103677@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200402204758.GF103677@xz-x1>
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

On Thu, Apr 02, 2020 at 04:47:58PM -0400, Peter Xu wrote:
> On Wed, Apr 01, 2020 at 07:09:28PM -0400, Peter Xu wrote:
> > On Wed, Apr 01, 2020 at 01:12:04AM +0200, Paolo Bonzini wrote:
> > > On 31/03/20 18:51, Peter Xu wrote:
> > > > On Tue, Mar 31, 2020 at 05:34:43PM +0200, Paolo Bonzini wrote:
> > > >> On 31/03/20 17:23, Peter Xu wrote:
> > > >>>> Or KVM_MEM_READONLY.
> > > >>> Yeah, I used a new flag because I thought READONLY was a bit tric=
ky to
> > > >>> be used directly here.  The thing is IIUC if guest writes to a
> > > >>> READONLY slot then KVM should either ignore the write or trigger =
an
> > > >>> error which I didn't check, however here what we want to do is to=
 let
> > > >>> the write to fallback to the userspace so it's neither dropped (w=
e
> > > >>> still want the written data to land gracefully on RAM), nor trigg=
ering
> > > >>> an error (because the slot is actually writable).
> > > >>
> > > >> No, writes fall back to userspace with KVM_MEM_READONLY.
> > > >=20
> > > > I read that __kvm_write_guest_page() will return -EFAULT when writt=
ing
> > > > to the read-only memslot, and e.g. kvm_write_guest_virt_helper() wi=
ll
> > > > return with X86EMUL_IO_NEEDED, which will be translated into a
> > > > EMULATION_OK in x86_emulate_insn().  Then in x86_emulate_instructio=
n()
> > > > it seems to get a "1" returned (note that I think it does not set
> > > > either vcpu->arch.pio.count or vcpu->mmio_needed).  Does that mean
> > > > it'll retry the write forever instead of quit into the userspace?  =
I
> > > > may possibly have misread somewhere, though..
> > >=20
> > > We are definitely relying on KVM_MEM_READONLY to exit to userspace, i=
n
> > > order to emulate flash memory.
> > >=20
> > > > However... I think I might find another race with this:
> > > >=20
> > > >           main thread                       vcpu thread
> > > >           -----------                       -----------
> > > >                                             dirty GFN1, cached in P=
ML
> > > >                                             ...
> > > >           remove memslot1 of GFN1
> > > >             set slot READONLY (whatever, or INVALID)
> > > >             sync log (NOTE: no GFN1 yet)
> > > >                                             vmexit, flush PML with =
RCU
> > > >                                             (will flush to old bitm=
ap) <------- [1]
> > > >             delete memslot1 (old bitmap freed)                     =
    <------- [2]
> > > >           add memslot2 of GFN1 (memslot2 could be smaller)
> > > >             add memslot2
> > > >=20
> > > > I'm not 100% sure, but I think GFN1's dirty bit will be lost though
> > > > it's correctly applied at [1] but quickly freed at [2].
> > >=20
> > > Yes, we probably need to do a mass vCPU kick when a slot is made
> > > READONLY, before KVM_SET_USER_MEMORY_REGION returns (and after releas=
ing
> > > slots_lock).  It makes sense to guarantee that you can't get any more
> > > dirtying after KVM_SET_USER_MEMORY_REGION returns.
> >=20
> > Sounds doable.  Though we still need a synchronous way to kick vcpus
> > in KVM to make sure the PML is flushed before KVM_SET_MEMORY_REGION
> > returns, am I right?  Is there an existing good way to do this?
>=20
> Paolo,
>=20
> I'm not sure whether it's anything close to acceptable, but this is
> something I was thinking about below (pesudo code).  Do you think it
> makes any sense?  Thanks,
>=20
> 8<-------------------------------------------
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1b6d9ac9533c..437d669dde42 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8161,6 +8161,22 @@ void __kvm_request_immediate_exit(struct kvm_vcpu =
*vcpu)
>  }
>  EXPORT_SYMBOL_GPL(__kvm_request_immediate_exit);
>=20
> +void kvm_vcpu_sync(struct kvm_vcpu *vcpu)
> +{
> +       DECLARE_WAITQUEUE(wait, current);
> +
> +       add_wait_queue(&vcpu->sync_wq, &wait);
> +       set_current_state(TASK_UNINTERRUPTIBLE);
> +       kvm_make_request(KVM_REQ_SYNC_VCPU, vcpu);
> +       schedule();
> +       remove_wait_queue(&vcpu->sync_wq, &wait);
> +}
> +
> +void kvm_vcpu_sync_ack(struct kvm_vcpu *vcpu)
> +{
> +       wake_up(&vcpu->sync_wq);
> +}
> +
>  /*
>   * Returns 1 to let vcpu_run() continue the guest execution loop without
>   * exiting to the userspace.  Otherwise, the value will be returned to t=
he
> @@ -8274,6 +8290,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>                         kvm_hv_process_stimers(vcpu);
>                 if (kvm_check_request(KVM_REQ_APICV_UPDATE, vcpu))
>                         kvm_vcpu_update_apicv(vcpu);
> +               if (kvm_check_request(KVM_REQ_SYNC_VCPU, vcpu))
> +                       kvm_vcpu_sync_ack(vcpu);
>         }
>=20
>         if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index f6a1905da9bf..e825d2e0a221 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -146,6 +146,7 @@ static inline bool is_error_page(struct page *page)
>  #define KVM_REQ_MMU_RELOAD        (1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO=
_WAKEUP)
>  #define KVM_REQ_PENDING_TIMER     2
>  #define KVM_REQ_UNHALT            3
> +#define KVM_REQ_SYNC_VCPU         4
>  #define KVM_REQUEST_ARCH_BASE     8
>=20
>  #define KVM_ARCH_REQ_FLAGS(nr, flags) ({ \
> @@ -278,6 +279,7 @@ struct kvm_vcpu {
>         struct kvm_run *run;
>=20
>         struct swait_queue_head wq;
> +       struct wait_queue_head sync_wq;
>         struct pid __rcu *pid;
>         int sigset_active;
>         sigset_t sigset;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f744bc603c53..35216aeb0365 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -342,6 +342,7 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, stru=
ct kvm *kvm, unsigned id)
>         vcpu->vcpu_id =3D id;
>         vcpu->pid =3D NULL;
>         init_swait_queue_head(&vcpu->wq);
> +       init_wait_queue_head(&vcpu->sync_wq);
>         kvm_async_pf_vcpu_init(vcpu);
>=20
>         vcpu->pre_pcpu =3D -1;
> @@ -1316,9 +1317,20 @@ int kvm_set_memory_region(struct kvm *kvm,
>                           const struct kvm_userspace_memory_region *mem)
>  {
>         int r;
> +       unsigned int i;
> +       struct kvm_vcpu *vcpu;
>=20
>         mutex_lock(&kvm->slots_lock);
> +
>         r =3D __kvm_set_memory_region(kvm, mem);
> +
> +       /* TBD: use arch-specific hooks; this won't compile on non-x86 */
> +       if ((mem->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
> +           (mem->flags & KVM_MEM_READONLY)) {
> +               kvm_for_each_vcpu(i, vcpu, kvm)
> +                   kvm_vcpu_sync(vcpu);
> +       }
> +

Oops, this block should definitely be after the unlock as you
suggested...

>         mutex_unlock(&kvm->slots_lock);
>         return r;
>  }
> @@ -2658,6 +2670,8 @@ static int kvm_vcpu_check_block(struct kvm_vcpu *vc=
pu)
>                 goto out;
>         if (signal_pending(current))
>                 goto out;
> +       if (kvm_check_request(KVM_REQ_SYNC_VCPU, vcpu))
> +               goto out;
>=20
>         ret =3D 0;
>  out:
> 8<-------------------------------------------
>=20
> --=20
> Peter Xu

--=20
Peter Xu


