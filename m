Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F54C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 23:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232A120658
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 23:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcfdUPBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232A120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJQ4i-0003wf-8E
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 19:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jJQ3I-0003PA-Mo
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 19:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jJQ3G-0008Cw-6o
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 19:12:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23255
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jJQ3G-00089O-2B
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 19:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585696329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVso95ykEzjfJGpoXRVv7wepLFJDWD2WqTldj+FTquQ=;
 b=EcfdUPByg9dEndkv/8r44dkdXrn/wi3MUAcgEVp6Eg4PQxjfARQKfoNYK9pI4OIL3gy2JJ
 p9Q4DFikNB9t5r3yA1Tc3A1VIAAvyumEx4F0F1WAs+GJBL/ey2kB4ugE4cFQCdelych4ug
 hDpV3priGGHP2TbJZ4DExOcvE5pP3Zw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-aFR-4XAlN966VUgWAnTBLw-1; Tue, 31 Mar 2020 19:12:07 -0400
X-MC-Unique: aFR-4XAlN966VUgWAnTBLw-1
Received: by mail-wr1-f71.google.com with SMTP id y1so12531811wrp.5
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 16:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KVso95ykEzjfJGpoXRVv7wepLFJDWD2WqTldj+FTquQ=;
 b=f+rD57k1v2Eu1HiOSrA7Tly05HDlpQpq2PzC00XthZUSak9rwfZsLrKAy3crpvdRVY
 6aAo2+Y+RuknTN4c+Fvnd/TtsGxaLDIPFzH+RpAJj1XdcAu+7kAd2JTelGUu+wpzsp7S
 LrBJwgq5C19X46GVyNWv5tYWaudRYtPd3Wk9y67RzM1+lav4LSRQbQsAhHkIqPxqRMfJ
 eqIP8zKIP+n7E5XKr0+DGK6hGahSaOv92lc2enhukDwhqrIDEC55uhH+nl6Di958PdKo
 p4OdxuzRMgGL/5OS989ArbtakSi97Q7dA1drZ7VelRkREY4l3dXIMM6J7kbtI2/FgHDo
 FhBw==
X-Gm-Message-State: AGi0PuagD9K/Om8GN/gS4T9yqB7PQ7tQhTdrhbR/1E188Jghe88VxNV8
 HNl9n7Tj36RiZcRu3z3bwFU+OncZtiY2q6ix1LqOd2lrrfaA/DxQ2uYaUs0/JThzTq6QAhbAdWD
 AuYWF90JQg5I6Miw=
X-Received: by 2002:a7b:c010:: with SMTP id c16mr1230980wmb.73.1585696326596; 
 Tue, 31 Mar 2020 16:12:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypKVE5zOXOHhslENfgsk1MzjTZIfHL4TXqB4VTxeEZDUtvYdfJyn0DqJvMiD9RmLwWt3pEeTxA==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr1230970wmb.73.1585696326313; 
 Tue, 31 Mar 2020 16:12:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea?
 ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
 by smtp.gmail.com with ESMTPSA id c7sm333938wrn.49.2020.03.31.16.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 16:12:05 -0700 (PDT)
Subject: Re: Question on dirty sync before kvm memslot removal
To: Peter Xu <peterx@redhat.com>
References: <20200327150425.GJ422390@xz-x1>
 <c90a6ffd-0cab-186d-b9c8-8e379921783f@redhat.com>
 <20200331152314.GG522868@xz-x1>
 <62aa8314-954f-7397-8bf4-d81d926c4f0b@redhat.com>
 <20200331165133.GI522868@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2eebbb76-0a12-87f4-812c-27d3e3f16a7c@redhat.com>
Date: Wed, 1 Apr 2020 01:12:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331165133.GI522868@xz-x1>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 31/03/20 18:51, Peter Xu wrote:
> On Tue, Mar 31, 2020 at 05:34:43PM +0200, Paolo Bonzini wrote:
>> On 31/03/20 17:23, Peter Xu wrote:
>>>> Or KVM_MEM_READONLY.
>>> Yeah, I used a new flag because I thought READONLY was a bit tricky to
>>> be used directly here.  The thing is IIUC if guest writes to a
>>> READONLY slot then KVM should either ignore the write or trigger an
>>> error which I didn't check, however here what we want to do is to let
>>> the write to fallback to the userspace so it's neither dropped (we
>>> still want the written data to land gracefully on RAM), nor triggering
>>> an error (because the slot is actually writable).
>>
>> No, writes fall back to userspace with KVM_MEM_READONLY.
> 
> I read that __kvm_write_guest_page() will return -EFAULT when writting
> to the read-only memslot, and e.g. kvm_write_guest_virt_helper() will
> return with X86EMUL_IO_NEEDED, which will be translated into a
> EMULATION_OK in x86_emulate_insn().  Then in x86_emulate_instruction()
> it seems to get a "1" returned (note that I think it does not set
> either vcpu->arch.pio.count or vcpu->mmio_needed).  Does that mean
> it'll retry the write forever instead of quit into the userspace?  I
> may possibly have misread somewhere, though..

We are definitely relying on KVM_MEM_READONLY to exit to userspace, in
order to emulate flash memory.

> However... I think I might find another race with this:
> 
>           main thread                       vcpu thread
>           -----------                       -----------
>                                             dirty GFN1, cached in PML
>                                             ...
>           remove memslot1 of GFN1
>             set slot READONLY (whatever, or INVALID)
>             sync log (NOTE: no GFN1 yet)
>                                             vmexit, flush PML with RCU
>                                             (will flush to old bitmap) <------- [1]
>             delete memslot1 (old bitmap freed)                         <------- [2]
>           add memslot2 of GFN1 (memslot2 could be smaller)
>             add memslot2
> 
> I'm not 100% sure, but I think GFN1's dirty bit will be lost though
> it's correctly applied at [1] but quickly freed at [2].

Yes, we probably need to do a mass vCPU kick when a slot is made
READONLY, before KVM_SET_USER_MEMORY_REGION returns (and after releasing
slots_lock).  It makes sense to guarantee that you can't get any more
dirtying after KVM_SET_USER_MEMORY_REGION returns.

Paolo

>>> I think the whole kick operation is indeed too heavy for this when
>>> with the run_on_cpu() trick, because the thing we want to know (pml
>>> flushing) is actually per-vcpu and no BQL interaction. Do we have/need
>>> a lightweight way to kick one vcpu in synchronous way?  I was
>>> wondering maybe something like responding a "sync kick" request in the
>>> vcpu thread right after KVM_RUN ends (when we don't have BQL yet).
>>> Would that make sense?
>>
>> Not synchronously, because anything synchronous is very susceptible to
>> deadlocks.
> 
> Yeah it's easy to deadlock (I suffer from it...), but besides above
> case (which I really think it's special) I still think unluckily we
> need a synchronous way.  For example, the VGA code will need the
> latest dirty bit information to decide whether to update the screen
> (or it could stall), or the migration code where we need to calculate
> downtime with the current dirty bit information, etc.
> 


