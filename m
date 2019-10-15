Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907F2C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B252083B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B252083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKJu8-0006gi-Hq
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iKJst-000664-5G
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iKJsr-0004m6-Vt
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:16:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iKJsr-0004ks-Nh
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:16:53 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFE5A7BDA1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 10:16:52 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id o12so11797506pll.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 03:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JogTkUe/uqDqFj5WXU+5NnAAKDNISgI/0ydjP8PND6o=;
 b=lzRTidSa+CuRKWOyxFr3lK+bgTNSG7NDjFpoNquhgNhRIYI6LbWPw7UWfN+6cVoaxP
 pf3qBYEXbD1Iii4xqk4Ads3swfDMH4gowRk10H9mTOW7ykSWZoLKj9hxjPUliQlbeYEn
 YV1SNkNT4Y2A58CLrFafutDYMY3vCzMXmopO//Uw0RyZXvwM8/bctk8SaHT6I7Tc2sk7
 Qo6qWbt/6Q6pweDQBGFbKTgJHu1jZJSdx16+9dCj2xaVHuvfYDij7iQU8yhnWb2wvlB0
 njiFU7PnbuM+SqPEunCugXSOCZMde6lw5/t1+Qcue4iU0gafPq+Temvhhk2mXnqqHm+Z
 y3sw==
X-Gm-Message-State: APjAAAVTyQDMb8esiQzMWPic1GCMoZ77U2KDfOr8EyTrJZZFTUA1XBt+
 uevofkd77Mqd6ZJKo+db27n4pt/SPqeKSXoQvyPt0i5qvmKa2Ok1Fu3PL9EOIYdx6+QvODuHT+I
 mTWpEVXmW4SQO3F0=
X-Received: by 2002:a62:1953:: with SMTP id 80mr38098734pfz.168.1571134612278; 
 Tue, 15 Oct 2019 03:16:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8d9a0nDK2rKKnohcTLBd46xDZAVjlzB60X6P/b3xBzDCR8YTolJZEU88FaFna8MHIK4AoaQ==
X-Received: by 2002:a62:1953:: with SMTP id 80mr38098712pfz.168.1571134611987; 
 Tue, 15 Oct 2019 03:16:51 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r21sm26765017pfc.27.2019.10.15.03.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 03:16:51 -0700 (PDT)
Date: Tue, 15 Oct 2019 18:16:41 +0800
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] apic: Use 32bit APIC ID for migration instance ID
Message-ID: <20191015101641.GD8666@xz-x1>
References: <20191015075444.10955-1-peterx@redhat.com>
 <20191015075444.10955-3-peterx@redhat.com>
 <20191015092218.GC3073@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191015092218.GC3073@work-vm>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 15, 2019 at 10:22:18AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Migration is silently broken now with x2apic config like this:
> > 
> >      -smp 200,maxcpus=288,sockets=2,cores=72,threads=2 \
> >      -device intel-iommu,intremap=on,eim=on
> > 
> > After migration, the guest kernel could hang at anything, due to
> > x2apic bit not migrated correctly in IA32_APIC_BASE on some vcpus, so
> > any operations related to x2apic could be broken then (e.g., RDMSR on
> > x2apic MSRs could fail because KVM would think that the vcpu hasn't
> > enabled x2apic at all).
> > 
> > The issue is that the x2apic bit was never applied correctly for vcpus
> > whose ID > 255 when migrate completes, and that's because when we
> > migrate APIC we use the APICCommonState.id as instance ID of the
> > migration stream, while that's too short for x2apic.
> > 
> > Let's use the newly introduced initial_apic_id for that.
> 
> I'd like to understand a few things:
>    a) Does this change the instance ID of existing APICs on the
> migration stream? 
>      a1) Ever for <256 CPUs?

No.

>      a2) For >=256 CPUs?

Yes.

> 
>     [Because changing the ID breaks migration]

But if we don't change it, the stream is broken too. :)

Then the destination VM will receive e.g. two apic_id==0 instances (I
think the apic_id==256 instance will wrongly overwrite the apic_id==0
one), while the vcpu with apic_id==256 will use the initial apic
values.

So IMHO we should still fix this, even if it changes the migration
stream.  At least we start to make it right.

> 
>   b) Is the instance ID constant - I can see it's a property on the
>      APIC, but I cna't see who sets it

For each vcpu, I think yes it should be a constant as long as the
topology is the same.  This is how I understand it to be set:

(1) In pc_cpus_init(), we init these:

    possible_cpus = mc->possible_cpu_arch_ids(ms);
    for (i = 0; i < ms->smp.cpus; i++) {
        pc_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
    }

(2) In x86_cpu_apic_create(), we apply the apic_id to "id" property:

    qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);

> 
>   c) In the case where it fails, did we end up registering two
>      devices with the same name and instance ID?  If so, is it worth
>      adding a check that would error if we tried?

Sounds doable.

Thanks,

-- 
Peter Xu

