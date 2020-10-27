Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686E7C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A3E20878
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjWqXtYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A3E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOth-0001oj-Mo
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kXOsa-0000xT-CO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kXOsX-0005iT-Rc
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603804747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iFZIHFvyfpHba7UYLsx6BpLUE1vBAVzv/SOr3L1DwmE=;
 b=CjWqXtYGeNkdojh9MZ3fHdsyDm5JNoKV5/RifYv19r7MOWAKDe4Q2rfoywwRuKl5JX3pgp
 nV9Uu21m3J8DavNq/zUUMZd1vLrqDxoBPADGMD0pTga2uLJbg2bNSGEAfbbrFOefMgJGgD
 jsFPZ+MMDwIJT/xvH/JWAksMxGxvM5A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-sgTao5rNPhy5_kzdnl339g-1; Tue, 27 Oct 2020 09:19:05 -0400
X-MC-Unique: sgTao5rNPhy5_kzdnl339g-1
Received: by mail-ej1-f70.google.com with SMTP id d13so881765ejz.6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=iFZIHFvyfpHba7UYLsx6BpLUE1vBAVzv/SOr3L1DwmE=;
 b=SqFou0UwmPR4te3brzllv5o1jhPf8O92o+BZwMfB9SE+h67Do246q3QHIGgmjMOtsZ
 8DwKrqOGkC3ZM+3gFD2kWQYbk+VE1WUzA4GRFaDQDrUCanw5URy5VUukxwyknds1EJ7h
 AZMvpheiFFx+0RPhdJ1bDs9cgzUarzotVPh9ZHMmQTJZBcUtnLDnYdVvaeKpNN/Kop9v
 JIbO1y5ZSAKEmG5ItFS4E/bhfh9nywm/L7mNIPt5kxNPu6xpFiEd1KNoeEVpA0AhNrOt
 v6Qf7kH+h40ybjjVEG/bn1E5DfRJJBsCZgUJKBAXpfzqrDgy0HoXB+wtqvab+zLeYbOS
 k/0w==
X-Gm-Message-State: AOAM533w8Cvs33DXK77+ODjIGoT4Ec6iq/w4mQ+X4nx0bEeU+sO0P3UK
 5wM1SSz1eOGzpjYMOVX9C59yBfVIhTJXX90wNsFU8EalsMXEUgUXQGn9t/dGIZHVtdytN0iqMmK
 uTaNImMaBxTJWa+M=
X-Received: by 2002:aa7:ccc8:: with SMTP id y8mr2263425edt.325.1603804744339; 
 Tue, 27 Oct 2020 06:19:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx14q0Qhhx1eLEbWQ2Rd35ZZxgjNgRfJITxhjNriX9FRvGYfgzMx97lpl6aY9BvKuEFddiTog==
X-Received: by 2002:aa7:ccc8:: with SMTP id y8mr2263401edt.325.1603804744121; 
 Tue, 27 Oct 2020 06:19:04 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id 11sm1024084ejy.19.2020.10.27.06.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:19:02 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] memory: pause all vCPUs for the duration of memory
 transactions
In-Reply-To: <e1d85d86-fb2f-d2a8-77ea-1e0d48c8fb67@redhat.com>
References: <20201026084916.3103221-1-vkuznets@redhat.com>
 <294a987d-b0ef-1b58-98ac-0d4d43075d6e@redhat.com>
 <d7a20a33-0317-467e-6fc6-6528b3b46062@redhat.com>
 <87imav26d8.fsf@vitty.brq.redhat.com>
 <cb74d717-cfc1-a78b-cf80-eb8ebf1075fd@redhat.com>
 <87a6w72565.fsf@vitty.brq.redhat.com>
 <e1d85d86-fb2f-d2a8-77ea-1e0d48c8fb67@redhat.com>
Date: Tue, 27 Oct 2020 14:19:01 +0100
Message-ID: <875z6v24e2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
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
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> On 27.10.20 14:02, Vitaly Kuznetsov wrote:
>> 
>> Sorry for not being clear: your patch looks good to me, what I tried to
>> say is that with the current KVM API the only way to guarantee atomicity
>> of the update is to make vCPUs stop (one way or another), kicking them
>> out and preventing new IOCTLs from being dispatched is one way
>> (temporary pausing them inside KVM would be another, for example -- but
>> that would require *new* API supplying the whole transaction and not one
>> memslot update).
>
> Ah, got it.
>
> Yes - and I briefly looked into resizing slots inside KVM atomically and 
> it already turned out to be a major pain. All that metadata that's 
> allocated for a memory slot based on the size is problematic.
>

Yep, exactly and personally I'd rather refrain from doing more tricks
within KVM to keep the code simple. Generally, memslot updates should't
happen very often so pausing and resuming vCPUs should be acceptable
(that was one of the questions for this RFC).

Overall, I think we're in violent agreement here)

> Same applies to all other kinds of operations (splitting, punching out, 
> ...) as you also mentioned.

One question from a QEMU newbie though: why do you put
kvm_ioctl_inhibit_begin()/kvm_ioctl_inhibit_end() to kvm_region_resize()
only and not taking it all the way up to
memory_region_transaction_begin()/memory_region_transaction_end() to
support atomicity for all kinds of updates right away?

The second question is whether you plan to sumbit this any time soon)

Thanks!

-- 
Vitaly


