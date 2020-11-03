Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34604C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685F120756
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OV++vaQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685F120756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZw2u-0004a7-1L
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 08:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kZw21-0003vO-EP
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:07:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kZw1u-0008Qy-UT
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604408834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SbmKyhr8EbSE9HdMzkHDuoJH6boMqArz2Ah+lM4rvsY=;
 b=OV++vaQweuXdBWmFaLSvddXXkhIFZWQh6N5QSv7jrpGBCJSZEBYbKW7+i+h3WL/MWt+N5j
 6fwOwEqx4xv/hDLz0EnXAIDR2gFgUheioji3sGReq3AqFdWXFQKh0FqF/iwPtLSGsmwfrC
 fcewJPPdF2ijPnQknuqILbPJ4jxy3TY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-gfXGWFJ6PbiwDlth4XjrLQ-1; Tue, 03 Nov 2020 08:07:12 -0500
X-MC-Unique: gfXGWFJ6PbiwDlth4XjrLQ-1
Received: by mail-wr1-f69.google.com with SMTP id u1so5554740wri.6
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 05:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=SbmKyhr8EbSE9HdMzkHDuoJH6boMqArz2Ah+lM4rvsY=;
 b=Eg2863LvgWdRORJk1GVSGfA2BHeNp5ntZxLKDZPwKlMynMwBO/DERB00lb49rwOBFY
 LbyzGwFYUO5YqQMPcV9tRsZmp8kiq7OrecrYi6jwjOgJTjRj8F/THlYQEH7G4LKdHhPx
 uPN/ZiJqJgGXmA6E4ugSW2f/u9f6k4D0M9loiX0adbc2jeMvNUDwv3YJas1DvOmjYUxk
 p2z5dYqSU034OYM4oY24qncq1mAhThGxwChS5szhFaDLcm9YXysBGQHe4N7225lEJacl
 1EocoTydZ4rPRTtWiXo3RIzFWlTNy1gByrGv6PNdAyMLO0/qnDzIXyx+/EKmS3KLGoiJ
 TWXA==
X-Gm-Message-State: AOAM532svZCu7qpS5BrjB6AktAZvI68j58N8HxWRbf0CDodPerO9Y5tI
 c+2rWrBRIYflc/9DQ3xlG+oSIFfYTHfK4RJCEydDJP6B1yMaHjhUWGYbFx9XB0ovhC8+iS5d9pM
 OzDrqooJHzyz6j/U=
X-Received: by 2002:adf:f1c8:: with SMTP id z8mr28137363wro.371.1604408831055; 
 Tue, 03 Nov 2020 05:07:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpr1D7V/cKaTTGbgsBFb7aWjKRsfLu2Raq1WhS1dpStHDMYv2RQSoZ6gkMBpJSRSDM+Qm2iQ==
X-Received: by 2002:adf:f1c8:: with SMTP id z8mr28137336wro.371.1604408830850; 
 Tue, 03 Nov 2020 05:07:10 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id u16sm10224672wrn.55.2020.11.03.05.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 05:07:10 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC] memory: pause all vCPUs for the duration of memory
 transactions
In-Reply-To: <20201102195729.GA20600@xz-x1>
References: <20201026084916.3103221-1-vkuznets@redhat.com>
 <20201102195729.GA20600@xz-x1>
Date: Tue, 03 Nov 2020 14:07:09 +0100
Message-ID: <87v9emy4g2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Xu <peterx@redhat.com> writes:

> Vitaly,
>
> On Mon, Oct 26, 2020 at 09:49:16AM +0100, Vitaly Kuznetsov wrote:
>> Currently, KVM doesn't provide an API to make atomic updates to memmap when
>> the change touches more than one memory slot, e.g. in case we'd like to
>> punch a hole in an existing slot.
>> 
>> Reports are that multi-CPU Q35 VMs booted with OVMF sometimes print something
>> like
>> 
>> !!!! X64 Exception Type - 0E(#PF - Page-Fault)  CPU Apic ID - 00000003 !!!!
>> ExceptionData - 0000000000000010  I:1 R:0 U:0 W:0 P:0 PK:0 SS:0 SGX:0
>> RIP  - 000000007E35FAB6, CS  - 0000000000000038, RFLAGS - 0000000000010006
>> RAX  - 0000000000000000, RCX - 000000007E3598F2, RDX - 00000000078BFBFF
>> ...
>> 
>> The problem seems to be that TSEG manipulations on one vCPU are not atomic
>> from other vCPUs views. In particular, here's the strace:
>> 
>> Initial creation of the 'problematic' slot:
>> 
>> 10085 ioctl(13, KVM_SET_USER_MEMORY_REGION, {slot=6, flags=0, guest_phys_addr=0x100000,
>>    memory_size=2146435072, userspace_addr=0x7fb89bf00000}) = 0
>> 
>> ... and then the update (caused by e.g. mch_update_smram()) later:
>> 
>> 10090 ioctl(13, KVM_SET_USER_MEMORY_REGION, {slot=6, flags=0, guest_phys_addr=0x100000,
>>    memory_size=0, userspace_addr=0x7fb89bf00000}) = 0
>> 10090 ioctl(13, KVM_SET_USER_MEMORY_REGION, {slot=6, flags=0, guest_phys_addr=0x100000,
>>    memory_size=2129657856, userspace_addr=0x7fb89bf00000}) = 0
>> 
>> In case KVM has to handle any event on a different vCPU in between these
>> two calls the #PF will get triggered.
>
> A pure question: Why a #PF?  Is it injected into the guest?
>

Yes, we see a #PF injected in the guest during OVMF boot.

> My understanding (which could be wrong) is that all thing should start with a
> vcpu page fault onto the removed range, then when kvm finds that the memory
> accessed is not within a valid memslot (since we're adding it back but not
> yet), it'll become an user exit back to QEMU assuming it's an MMIO access.  Or
> am I wrong somewhere?

In case it is a normal access from the guest, yes, but AFAIR here
guest's CR3 is pointing to non existent memory and when KVM detects that
it injects #PF by itself without a loop through userspace.

-- 
Vitaly


