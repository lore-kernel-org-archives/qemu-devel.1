Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1D3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 21:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B0A20774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 21:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csR28ydy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B0A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5y3Z-0000nO-4i
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 17:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k5y30-0000OL-2d
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 17:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k5y2x-00040Y-6s
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 17:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597266749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FfjC4fMfF9wdoE2SNyQm6+S+qXsN0wbRc6QYYxZlhLk=;
 b=csR28ydyQKrzlAtjdhbVdVWoNQ3kUJ5ZZd0qO+LAUyAujMyoTvcLVppnk/UCMRg9gaXsFA
 rbME+AD9VbQ4nTjyQi4JN8zCOrhLZFGOK9PoeitZy8lT9C3ReeWuRPhQryn2xOw29ymZUY
 DCn9G5m2QApA/gSBEtibvHXWRNPw1yw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-N3KCPnmGMnyi-g7c0jSqjg-1; Wed, 12 Aug 2020 17:12:25 -0400
X-MC-Unique: N3KCPnmGMnyi-g7c0jSqjg-1
Received: by mail-qt1-f197.google.com with SMTP id z20so2823433qti.21
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 14:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FfjC4fMfF9wdoE2SNyQm6+S+qXsN0wbRc6QYYxZlhLk=;
 b=AhjynwWC1MbJbHCPz/bBgfmbfDWKiTL8t1zg7WHosxLNeopR3oDE/abiLRIKm073kU
 XK4nceI10yvVy1XmytsC9SGMi+2AIa1avaOv00YX4DOKa/i8I6R38fXrEVF1/gBEv97z
 BBhtetWVcrHmrFAi6ai8zKG6ZwZAmQ1ySdWnlPH+Oa5Ki5enZmEUOA7GPrvF3Hq2mMrw
 lsb/dj1DTqtVftlx9/y5wyxkFzB01/HtvpuYXL3YzXVIDKjr37tk8bH8f+VDx+Amf/lH
 d8B9DevPdSd1UaLaSfmdk1gntmDP3oysbtxctjbumFk2i00rWOSEOZ/sE2XeRVFFue8j
 mZxQ==
X-Gm-Message-State: AOAM531F+mi3+v7T83PTW8RGUMnz9UzqMnHOw0CVgs4vQu6Sg5dHtIqF
 Pq4sDOwANx5AYSjegxlTI0tnGvsxfUhCjkmy+Y5qnhxTfGheM9qEpHe0roUdQUgVdvDrukBJbHf
 JH2K/D/rOVfwThBM=
X-Received: by 2002:ae9:f807:: with SMTP id x7mr1820432qkh.148.1597266744548; 
 Wed, 12 Aug 2020 14:12:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsE9TdCsN6rrpFWplBUVM6IO8/wJKNbiaG+fzOiLaaROOuC+n39ZQlNarYxjxpxFF+seN2bw==
X-Received: by 2002:ae9:f807:: with SMTP id x7mr1820393qkh.148.1597266744233; 
 Wed, 12 Aug 2020 14:12:24 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id d203sm3414936qkc.10.2020.08.12.14.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 14:12:23 -0700 (PDT)
Date: Wed, 12 Aug 2020 17:12:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC v3 0/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200812211221.GG6353@xz-x1>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200811175533.7359-1-eperezma@redhat.com>
 <CAJaqyWf24F8ERAuvYj+0Xv=+cYj4v1MCmvCmQFTqcfLVYYCVuQ@mail.gmail.com>
 <20200811192757.GB6353@xz-x1>
 <CAJaqyWePxesYQqiG_ATPjwzw1c=xv3Uyw-x8tj5tVJJu__ChLQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWePxesYQqiG_ATPjwzw1c=xv3Uyw-x8tj5tVJJu__ChLQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 17:12:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Avi Kivity <avi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 04:33:24PM +0200, Eugenio Perez Martin wrote:
> On Tue, Aug 11, 2020 at 9:28 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Eugenio,
> >
> > On Tue, Aug 11, 2020 at 08:10:44PM +0200, Eugenio Perez Martin wrote:
> > > Using this patch as a reference, I'm having problems to understand:
> > >
> > > - I'm not sure that the flag name expresses clearly the notifier capability.
> >
> > The old code is kind of messed up for dev-iotlb invalidations, by always
> > sending UNMAP notifications for both iotlb and dev-iotlb invalidations.
> >
> > Now if we introduce the new DEV_IOTLB type, we can separate the two:
> >
> >   - We notify IOMMU_NOTIFIER_UNMAP for iotlb invalidations
> >
> >   - We notify IOMMU_NOTIFIER_DEV_IOTLB for dev-iotlb invalidations
> >
> > Vhost should always be with ats=on when vIOMMU enabled, so it will enable
> > device iotlb.  Then it does not need iotlb (UNMAP) invalidation any more
> > because they'll normally be duplicated (one is to invalidate vIOMMU cache, one
> > is to invalidate device cache).
> >
> > Also, we can drop UNMAP type for vhost if we introduce DEV_IOTLB.  It works
> > just like on the real hardwares - the device won't be able to receive iotlb
> > invalidation messages, but only device iotlb invalidation messages.  Here
> > vhost (or, virtio-pci) is the device.
> >
> > > - What would be the advantages of using another field (NotifierType?)
> > > in the notifier to express that it accepts arbitrary ranges for
> > > unmapping? (If I understood correctly Jason's proposal)
> >
> > (Please refer to above too..)
> >
> > > - Is it possible (or advisable) to skip all the page splitting in
> > > vtd_page_walk if the memory range notifier supports these arbitrary
> > > ranges? What would be the disadvantages? (Maybe in a future patch). It
> > > seems it is advisable to me, but I would like to double confirm.
> >
> > vtd_page_walk is not used for dev-iotlb, we don't need to change that.  We also
> > want to explicitly keep the page granularity of vtd_page_walk for the other
> > IOMMU notifiers, e.g. vfio.
> >
> 
> I'm not sure if I'm understanding it.
> 
> I have here a backtrace in a regular call (not [0,~0ULL]):
> #0  0x000055555597ca63 in memory_region_notify_one_iommu
> (notifier=0x7fffe4976f08, entry=0x7fffddff9d20)
>     at /home/qemu/softmmu/memory.c:1895
> #1  0x000055555597cc87 in memory_region_notify_iommu
> (iommu_mr=0x55555728f2e0, iommu_idx=0, entry=...) at
> /home/qemu/softmmu/memory.c:1938
> #2  0x000055555594b95a in vtd_sync_shadow_page_hook
> (entry=0x7fffddff9e70, private=0x55555728f2e0) at
> /home/qemu/hw/i386/intel_iommu.c:1436
> #3  0x000055555594af7b in vtd_page_walk_one (entry=0x7fffddff9e70,
> info=0x7fffddffa140) at /home/qemu/hw/i386/intel_iommu.c:1173
> #4  0x000055555594b2b3 in vtd_page_walk_level
>     (addr=10531758080, start=4292870144, end=4294967296, level=1,
> read=true, write=true, info=0x7fffddffa140)
>     at /home/qemu/hw/i386/intel_iommu.c:1254
> #5  0x000055555594b225 in vtd_page_walk_level
>     (addr=10530922496, start=3221225472, end=4294967296, level=2,
> read=true, write=true, info=0x7fffddffa140)
>     at /home/qemu/hw/i386/intel_iommu.c:1236
> #6  0x000055555594b225 in vtd_page_walk_level
>     (addr=10529021952, start=0, end=549755813888, level=3, read=true,
> write=true, info=0x7fffddffa140)
>     at /home/qemu/hw/i386/intel_iommu.c:1236
> #7  0x000055555594b3f8 in vtd_page_walk (s=0x555557565210,
> ce=0x7fffddffa1a0, start=0, end=549755813888, info=0x7fffddffa140)
>     at /home/qemu/hw/i386/intel_iommu.c:1293
> #8  0x000055555594ba77 in vtd_sync_shadow_page_table_range
> (vtd_as=0x55555728f270, ce=0x7fffddffa1a0, addr=0,
> size=18446744073709551615)
>     at /home/qemu/hw/i386/intel_iommu.c:1467
> #9  0x000055555594bb50 in vtd_sync_shadow_page_table
> (vtd_as=0x55555728f270) at /home/qemu/hw/i386/intel_iommu.c:1498
> #10 0x000055555594cc5f in vtd_iotlb_domain_invalidate
> (s=0x555557565210, domain_id=3) at
> /home/qemu/hw/i386/intel_iommu.c:1965
> #11 0x000055555594dbae in vtd_process_iotlb_desc (s=0x555557565210,
> inv_desc=0x7fffddffa2b0) at /home/qemu/hw/i386/intel_iommu.c:2371
> #12 0x000055555594dfd3 in vtd_process_inv_desc (s=0x555557565210) at
> /home/qemu/hw/i386/intel_iommu.c:2499
> #13 0x000055555594e1e9 in vtd_fetch_inv_desc (s=0x555557565210) at
> /home/qemu/hw/i386/intel_iommu.c:2568
> #14 0x000055555594e330 in vtd_handle_iqt_write (s=0x555557565210) at
> /home/qemu/hw/i386/intel_iommu.c:2595
> #15 0x000055555594ed90 in vtd_mem_write (opaque=0x555557565210,
> addr=136, val=1888, size=4) at /home/qemu/hw/i386/intel_iommu.c:2842
> #16 0x00005555559787b9 in memory_region_write_accessor
>     (mr=0x555557565540, addr=136, value=0x7fffddffa478, size=4,
> shift=0, mask=4294967295, attrs=...) at
> /home/qemu/softmmu/memory.c:483
> #17 0x00005555559789d7 in access_with_adjusted_size
>     (addr=136, value=0x7fffddffa478, size=4, access_size_min=4,
> access_size_max=8, access_fn=
>     0x5555559786da <memory_region_write_accessor>, mr=0x555557565540,
> attrs=...) at /home/qemu/softmmu/memory.c:544
> #18 0x000055555597b8a5 in memory_region_dispatch_write
> (mr=0x555557565540, addr=136, data=1888, op=MO_32, attrs=...)
>     at /home/qemu/softmmu/memory.c:1465
> #19 0x000055555582b1bf in flatview_write_continue
>     (fv=0x7fffc447c470, addr=4275634312, attrs=...,
> ptr=0x7ffff7dfd028, len=4, addr1=136, l=4, mr=0x555557565540) at
> /home/qemu/exec.c:3176
> #20 0x000055555582b304 in flatview_write (fv=0x7fffc447c470,
> addr=4275634312, attrs=..., buf=0x7ffff7dfd028, len=4)
>     at /home/qemu/exec.c:3216
> #21 0x000055555582b659 in address_space_write
>     (as=0x5555567a9380 <address_space_memory>, addr=4275634312,
> attrs=..., buf=0x7ffff7dfd028, len=4) at /home/qemu/exec.c:3307
> #22 0x000055555582b6c6 in address_space_rw
>     (as=0x5555567a9380 <address_space_memory>, addr=4275634312,
> attrs=..., buf=0x7ffff7dfd028, len=4, is_write=true)
>     at /home/qemu/exec.c:3317
> #23 0x000055555588e3b8 in kvm_cpu_exec (cpu=0x555556bfe9f0) at
> /home/qemu/accel/kvm/kvm-all.c:2518
> #24 0x0000555555972bcf in qemu_kvm_cpu_thread_fn (arg=0x555556bfe9f0)
> at /home/qemu/softmmu/cpus.c:1188
> #25 0x0000555555e08fbd in qemu_thread_start (args=0x555556c24c60) at
> util/qemu-thread-posix.c:521
> #26 0x00007ffff55a714a in start_thread () at /lib64/libpthread.so.0
> #27 0x00007ffff52d8f23 in clone () at /lib64/libc.so.6
> 
> with entry = {target_as = 0x5555567a9380, iova = 0xfff0b000,
> translated_addr = 0x0, addr_mask = 0xfff, perm = 0x0}
> 
> Here we got 3 levels of vtd_page_walk (frames #4-#6). The #6 parameters are:
> 
> (addr=10529021952, start=0, end=549755813888, level=3, read=true, write=true,
>     info=0x7fffddffa140)
> 
> If I understand correctly, the while (iova < end) {} loop in
> vtd_page_walk will break the big range in small pages (4K because of
> level=1, and (end - iova) / subpage_size = 245 pages or iterations).
> That could be a lot of write(2) in vhost_kernel_send_device_iotlb_msg
> in the worst case, or a lot of useless returns in
> memory_region_notify_one_iommu because of (notifier->start > entry_end
> || notifier->end < entry->iova) in the best.
> 
> Am I right with this? I understand that others notifiers (you mention
> vfio) need the granularity, but would a check in some vtd_* function
> for the help with the performance? (not suggesting to introduce it in
> this patch series).

Yeah, I think you're right we need to touch vtd_page_walk(), since
vtd_page_walk() should only notify MAP/UNMAP events, but not DEV_IOTLB.
However we don't need to touch more for the vtd_page_walk() internal logic, so
that the page granularities will be the same as before.

Thanks,

-- 
Peter Xu


