Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F5EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B557720848
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kw6ZmUn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B557720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIwF-0002OY-RX
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jJIuh-00087D-O3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jJIue-0005aq-D2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:34:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58843
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jJIue-0005aZ-2f
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585668887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJMPo2RR+d09zCL+XQzPUuOVB89wta0KpqgaGUehU08=;
 b=Kw6ZmUn0DBWi+65gelLclSttOpcFOOt3UZrq5vVrx1Z7y4n8Tpp7Y4AItst7rTrnNJCq0A
 WOi3wrd5fb9guOBYidYh280Wq3qNsFj8dgmu2TKpfJ3BBAJY+Fe8takR7APfyK1eCDIdqV
 26ITs/+7OuKrMjEDUuJOeLyKGc2H7LI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-p0_h2NWxPDGgSOLXr6zKNw-1; Tue, 31 Mar 2020 11:34:46 -0400
X-MC-Unique: p0_h2NWxPDGgSOLXr6zKNw-1
Received: by mail-wr1-f70.google.com with SMTP id r15so5314978wrm.22
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 08:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PJMPo2RR+d09zCL+XQzPUuOVB89wta0KpqgaGUehU08=;
 b=clIa/czzGga25y1qd1bVJVhh0PHaW5xwO0V2ZQWBYHhGfCyoQmFc8LRQ6dtZcemoam
 AumW+e5d3h/TFfbYdqBiaWNCSlwQuTxK9OebdHAoanryQLFoVRvleRIlWkCqdclW0Fy9
 9XtvpYDdUUgWSRlch/tCYnSzsTIn9xjLaIuuzpOjjcmk6Ce3v4bfGdRzju7Hd6Un2n/O
 BghqCEsNZ+xWc5M4PIdEttK2U4XqETVe4hOU4udtmcfLSQHh3eX1CatoCaqTmaQqfKdA
 L0/+LP3aF7d9f/S0FqU+hlyi+mNL9iO1Lwb+9L7OXPVsNOnD4AizvFCRPA/hgvsKi/hp
 jrhQ==
X-Gm-Message-State: ANhLgQ2RZQutOmZr964J5WN9RGrIgj+II6XLe2JPKPivo46YpNQjvt9O
 HjWC3jDTK4MMFnGNkPLyDlZAch3MBSu9FqIIUTIl+3/hY41d7hhafMudovHNRB43O1cp24UMhHO
 PKxpGZCsu3ySV4UE=
X-Received: by 2002:a5d:6a43:: with SMTP id t3mr20204205wrw.87.1585668884680; 
 Tue, 31 Mar 2020 08:34:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv5kdZZJrWRrRT79xy9+KvBt1AzA90+vzIndEHzMi1ByVTea7eFBt/P1nwCsKNLK9ZCGsAIzw==
X-Received: by 2002:a5d:6a43:: with SMTP id t3mr20204183wrw.87.1585668884461; 
 Tue, 31 Mar 2020 08:34:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea?
 ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
 by smtp.gmail.com with ESMTPSA id x11sm21218674wru.62.2020.03.31.08.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 08:34:43 -0700 (PDT)
Subject: Re: Question on dirty sync before kvm memslot removal
To: Peter Xu <peterx@redhat.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
References: <20200327150425.GJ422390@xz-x1>
 <c90a6ffd-0cab-186d-b9c8-8e379921783f@redhat.com>
 <20200331152314.GG522868@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62aa8314-954f-7397-8bf4-d81d926c4f0b@redhat.com>
Date: Tue, 31 Mar 2020 17:34:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331152314.GG522868@xz-x1>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 31/03/20 17:23, Peter Xu wrote:
>> Or KVM_MEM_READONLY.
> Yeah, I used a new flag because I thought READONLY was a bit tricky to
> be used directly here.  The thing is IIUC if guest writes to a
> READONLY slot then KVM should either ignore the write or trigger an
> error which I didn't check, however here what we want to do is to let
> the write to fallback to the userspace so it's neither dropped (we
> still want the written data to land gracefully on RAM), nor triggering
> an error (because the slot is actually writable).

No, writes fall back to userspace with KVM_MEM_READONLY.

>> The problem here is also that the GFN is not an unique identifier of the
>> QEMU ram_addr_t.  However you don't really need to kick all vCPUs out,
>> do you?  You can protect the dirty ring with its own per-vCPU mutex and
>> harvest the pages from the main thread.
> I'm not sure I get the point, but just to mention that currently the
> dirty GFNs are collected in a standalone thread (in the QEMU series
> it's called the reaper thread) rather than in the per vcpu thread
> because the KVM_RESET_DIRTY_RINGS is per-vm after all.  One major
> reason to kick the vcpus is to make sure the hardware cached dirty
> GFNs (i.e. PML) are flushed synchronously.

But you're referring to KVM kicking vCPUs not qemu_vcpu_kick.  Can you
just do an iteration of reaping after setting KVM_MEM_READONLY?

> I think the whole kick operation is indeed too heavy for this when
> with the run_on_cpu() trick, because the thing we want to know (pml
> flushing) is actually per-vcpu and no BQL interaction. Do we have/need
> a lightweight way to kick one vcpu in synchronous way?  I was
> wondering maybe something like responding a "sync kick" request in the
> vcpu thread right after KVM_RUN ends (when we don't have BQL yet).
> Would that make sense?

Not synchronously, because anything synchronous is very susceptible to
deadlocks.

Thanks,

Paolo


