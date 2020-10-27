Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C9BC55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCA821707
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dodq91ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCA821707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPLI-0002l3-5m
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kXPJt-00011u-M7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kXPJr-0002yR-7U
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603806440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XfL4NYKjn0zvlyXug2SSgfn8pO1wrKL+CVH5RQcW9Tw=;
 b=Dodq91ZKoUdEIRZUjir9OxPbifSxUYw4yhPpaI61T4Tzcvpjyyyx9G6zO04+t1Nd6QwMfI
 93fwKWgDdD+feTfvMnqVHtciitQxlj0N/a4Xqcic/WOnZiuPjYDb40JCftiNNeKNAVpjN7
 RVO300B/mi5dnFzkReKcBVsrL8zauIc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-lXetS2PNOCmk33Fi9tA6EA-1; Tue, 27 Oct 2020 09:47:17 -0400
X-MC-Unique: lXetS2PNOCmk33Fi9tA6EA-1
Received: by mail-ej1-f72.google.com with SMTP id d13so913466ejz.6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=XfL4NYKjn0zvlyXug2SSgfn8pO1wrKL+CVH5RQcW9Tw=;
 b=klc4ph6fb8k+f1jyHiqYhXd5zvD/DEkj5bjT38S1auGHrWVrNW+GhbtDj+048tIxIy
 es2WiR7kBZdD+3gOs7/Xi2OHqs9G3nzs6Mr/42p/xgx1iJ4KrL+kwGkx2t6XtGPrlDai
 C2D7ubB7CPAZtjlOnHk8igdfx0MyTQ4yJdBDWBDpHciqFmSJzMknnLQjx2ZronvYAD3w
 EBvLwWlMjUgp8BcEf8XBRLDI9j3sdK9ddLc5DYdDJY068Vbn3lt1IjPt74qRbpi2SkX4
 ejGRLrIh7v/yajXxmxS6XC8jfNHvCQHQMtSN7Mj7+Vc/LOFPItu0vM/0qs3aNPiSFFAJ
 dGOg==
X-Gm-Message-State: AOAM532qsdWgUAUr/qNQGgUgPmys+SeHzjhFkLomVbX+r0UON+bGX6Tq
 AgNH21RxJzzWc97MhAzWvPMVk4/CBTDhNkYIDpy8VZtfK/ZtYQqUd1an5u8mUNkFl0qbYLqP7tU
 uc8v237jZ81BYmQA=
X-Received: by 2002:aa7:c608:: with SMTP id h8mr2282565edq.16.1603806436674;
 Tue, 27 Oct 2020 06:47:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPqRV36i/C9/ckpLJVzFMdJKt4cg5Xr50tcLBZrlxrX6hBeoaw1136OZBK8A4vlBQbJeaC9w==
X-Received: by 2002:aa7:c608:: with SMTP id h8mr2282550edq.16.1603806436447;
 Tue, 27 Oct 2020 06:47:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id v18sm1139194ejj.10.2020.10.27.06.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:47:15 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] memory: pause all vCPUs for the duration of memory
 transactions
In-Reply-To: <219ac264-dcd4-70f0-244f-1bee601aded7@redhat.com>
References: <20201026084916.3103221-1-vkuznets@redhat.com>
 <294a987d-b0ef-1b58-98ac-0d4d43075d6e@redhat.com>
 <d7a20a33-0317-467e-6fc6-6528b3b46062@redhat.com>
 <87imav26d8.fsf@vitty.brq.redhat.com>
 <cb74d717-cfc1-a78b-cf80-eb8ebf1075fd@redhat.com>
 <87a6w72565.fsf@vitty.brq.redhat.com>
 <e1d85d86-fb2f-d2a8-77ea-1e0d48c8fb67@redhat.com>
 <875z6v24e2.fsf@vitty.brq.redhat.com>
 <219ac264-dcd4-70f0-244f-1bee601aded7@redhat.com>
Date: Tue, 27 Oct 2020 14:47:14 +0100
Message-ID: <87wnzbzspp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

>>> Same applies to all other kinds of operations (splitting, punching out,
>>> ...) as you also mentioned.
>> 
>> One question from a QEMU newbie though: why do you put
>> kvm_ioctl_inhibit_begin()/kvm_ioctl_inhibit_end() to kvm_region_resize()
>> only and not taking it all the way up to
>> memory_region_transaction_begin()/memory_region_transaction_end() to
>> support atomicity for all kinds of updates right away?
>
> The clean way to implement it for 
> memory_region_transaction_begin()/memory_region_transaction_end() is by 
> implementing
> ->begin()
> ->commit()
> callbacks for the KVM MemoryListener, and doing it in there, in KVM code.
>
>
> Now, I wasn't sure how this might affect real-time workloads, where you 
> really don't want to kick CPUs out of KVM. You can make a lot of 
> operations without requiring this handling like
>
> 1. Adding regions (memory hotplug)
> 2. Removing regions (memory hotunplug)
> 3. Enabling/disabling dirty logging
>
> Resize/split(/move/...) are the problematic operations where we would 
> need that handling. Modifying the size/location of existing slots.
>
> One way to tackle it would be to "sense" upfront if such "modifying" 
> operations will be required, communicating that via "->begin()", and 
> letting the KVM notifier decide based on that information whether to get 
> everything out of KVM. Sounds feasible.
>

I don't actually know if we have such use-cases but thinking about
e.g. punching a hole in a middle of an existing slot requires:
1) Resizing the existing slot to its first half
2) Creating the hole
3) Creating a new slot for the second half of the slot.
In case we'd like to make this atomic, we need to cover the whole
transaction. But again, I don't know if we have a use-case for it or
not.

>> 
>> The second question is whether you plan to sumbit this any time soon)
>
> Once we have an agreement on how to proceed, either I can try to 
> dedicate some time, or if you have some time, you can pickup my work and 
> make it also handle the other problematic cases (as discussed e.g., ^).

Ok, I plan to test your patch in the nearby future and if it works we
can start with just the 'resize' case as it seems to be causing real
issues. The infrastructure you create with kvm_ioctl_inhibit_begin()/
kvm_ioctl_inhibit_end() can be re-used later for other ops.

-- 
Vitaly


