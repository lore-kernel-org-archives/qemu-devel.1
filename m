Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83F7C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 19:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63045208B6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 19:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvF9Z5ZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63045208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZfz6-0005FV-AH
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 14:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZfxS-0003Tz-At
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 14:57:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZfxQ-0002Jt-Hl
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 14:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604347055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y1ActQqn7IjOKhLyD+w0yqxWr9JKTHGT64ljnD9pteY=;
 b=VvF9Z5ZA10wd3JZRjwOwWbsLMS7EW4zBFfaUcWKJqAcBYK7nKclM3+9m34zB6sAODx9cfe
 yua6MrjuN/s4UoAhCNZqhH0yOFdrza8YRjOJSQV6BAfP3yCaPsGGvmo0gK1Sqws7Lxpmyc
 I1Nl0I+XMvbPWvd7KD5gb31bHvaX9dM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-KclJitKNMKChVjLnAufW6g-1; Mon, 02 Nov 2020 14:57:34 -0500
X-MC-Unique: KclJitKNMKChVjLnAufW6g-1
Received: by mail-qv1-f72.google.com with SMTP id dd7so8931319qvb.6
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 11:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=y1ActQqn7IjOKhLyD+w0yqxWr9JKTHGT64ljnD9pteY=;
 b=jlaa5N+AFGGRj89Y0ASQC5CycWOsBThCDx6dQLfGQ16hKBPb6JE73w0bWkdjAnpefc
 /faZJ1bTSTbll2e3gzytTFwfjrh9HC/5FCuYLTf+KbDVpfXp9gC/T8fTn5TpkqU+OdSL
 DykAjg6inYN5M6WSdRNGhC6Y7FcBX/Uh+trBqC4DMbhevrgcMLaFJo5tgGfuXxX5ghea
 ghDY5oJAsjwDREcrb6t5TLuu5xKvpJeVhxbf0az5/K+WtMaKe9WkdArNWXbTRRYw9wdL
 ieOiBABhGx0WyT2qF5QITFzqn3/8d1SLvqn0GypM3HrM9d6SmAzlZCklgmECEGEww2vX
 I35A==
X-Gm-Message-State: AOAM532BHMM+ea9FM3HBUt3nhl+1mLz8v1Ic4Wv0QiWy2jOAHBFkM5rq
 rQNyAisiqfv8IZD6LNTETwvTWtZ60T/pkFaKQGC7CRqzsS5r7fVwt3BRqkkd1Z5RAWvRf1tPJ+r
 tqpEPwG1Hd6rYlhk=
X-Received: by 2002:a37:664a:: with SMTP id a71mr10738882qkc.370.1604347053683; 
 Mon, 02 Nov 2020 11:57:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwM5aVmCFcwbkdF57s5MI38fA7eJFxEMkujvMgTWc8O4bgVTTZFRJa4XaU4QVEA+6Cql9zAoQ==
X-Received: by 2002:a37:664a:: with SMTP id a71mr10738867qkc.370.1604347053441; 
 Mon, 02 Nov 2020 11:57:33 -0800 (PST)
Received: from xz-x1
 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
 by smtp.gmail.com with ESMTPSA id c12sm1738172qtx.54.2020.11.02.11.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 11:57:32 -0800 (PST)
Date: Mon, 2 Nov 2020 14:57:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC] memory: pause all vCPUs for the duration of memory
 transactions
Message-ID: <20201102195729.GA20600@xz-x1>
References: <20201026084916.3103221-1-vkuznets@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026084916.3103221-1-vkuznets@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Vitaly,

On Mon, Oct 26, 2020 at 09:49:16AM +0100, Vitaly Kuznetsov wrote:
> Currently, KVM doesn't provide an API to make atomic updates to memmap when
> the change touches more than one memory slot, e.g. in case we'd like to
> punch a hole in an existing slot.
> 
> Reports are that multi-CPU Q35 VMs booted with OVMF sometimes print something
> like
> 
> !!!! X64 Exception Type - 0E(#PF - Page-Fault)  CPU Apic ID - 00000003 !!!!
> ExceptionData - 0000000000000010  I:1 R:0 U:0 W:0 P:0 PK:0 SS:0 SGX:0
> RIP  - 000000007E35FAB6, CS  - 0000000000000038, RFLAGS - 0000000000010006
> RAX  - 0000000000000000, RCX - 000000007E3598F2, RDX - 00000000078BFBFF
> ...
> 
> The problem seems to be that TSEG manipulations on one vCPU are not atomic
> from other vCPUs views. In particular, here's the strace:
> 
> Initial creation of the 'problematic' slot:
> 
> 10085 ioctl(13, KVM_SET_USER_MEMORY_REGION, {slot=6, flags=0, guest_phys_addr=0x100000,
>    memory_size=2146435072, userspace_addr=0x7fb89bf00000}) = 0
> 
> ... and then the update (caused by e.g. mch_update_smram()) later:
> 
> 10090 ioctl(13, KVM_SET_USER_MEMORY_REGION, {slot=6, flags=0, guest_phys_addr=0x100000,
>    memory_size=0, userspace_addr=0x7fb89bf00000}) = 0
> 10090 ioctl(13, KVM_SET_USER_MEMORY_REGION, {slot=6, flags=0, guest_phys_addr=0x100000,
>    memory_size=2129657856, userspace_addr=0x7fb89bf00000}) = 0
> 
> In case KVM has to handle any event on a different vCPU in between these
> two calls the #PF will get triggered.

A pure question: Why a #PF?  Is it injected into the guest?

My understanding (which could be wrong) is that all thing should start with a
vcpu page fault onto the removed range, then when kvm finds that the memory
accessed is not within a valid memslot (since we're adding it back but not
yet), it'll become an user exit back to QEMU assuming it's an MMIO access.  Or
am I wrong somewhere?

Thanks,

-- 
Peter Xu


