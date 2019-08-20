Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962EDC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679E4214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679E4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzxZl-0006gL-Fk
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 02:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzxZ0-0005tf-51
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzxYy-0007TF-Ju
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42222)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzxYy-0007SN-C3
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:24:12 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 631216881A
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 06:24:10 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id t9so6529124wrx.9
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 23:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N06t3SdbxOINmcGXnI130yjPQmrl/Feq74/twoh6KW8=;
 b=fEM1l5EjbxI56qj/93WKaBGSphZQ7+OC43WP44vd8X8yUL6ryTC2Q7KKpkqaslREGd
 IYI16pax27r0913h0v+y78m9BIHto4pg4fndW8Nmxm4GzJv/uknOVLh16R6l5clFD0VU
 g0ILjXZCYsp6NN3HKV0c8gfVcnay6iOAe7G92IqWC6rtMbIJODjGzhnCcUp213/1NEKH
 sUwVC5sGOtJmtii+oFUounvZ2zSq7obopdLfJ3z4IAu+R4k6OmowaaiMEJ0eWH9WaAbb
 wvG7mV4L/d7tiQARdigN773e11tMF/e1Y7uym3tqSXiCadPSBM3dWyRwU7NgCUAR4tuN
 uIzQ==
X-Gm-Message-State: APjAAAUkCJVbqBqRyKeBp+z3ntrbe2zCiZOxxoabfU7sw4quiVVW4bUb
 qpNhYZQ7igFKJCGEFxKKPX3OXuM1VO8NSnfOd0dkNP+oWGB6oM3hDv7tY/zca4kCzLw/8Ut3bub
 SzM2XTOI6czGZgDs=
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr11981856wmj.58.1566282248897; 
 Mon, 19 Aug 2019 23:24:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxHei9a/gUR/lTezgHRhUUW2JOFMP5X9jB7J80/JNxuar5vFN09DywKoX4ZHxD3T6n0Wq2ifQ==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr11981807wmj.58.1566282248444; 
 Mon, 19 Aug 2019 23:24:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f?
 ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
 by smtp.gmail.com with ESMTPSA id b136sm37436063wme.18.2019.08.19.23.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 23:24:07 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190820051615.1210-1-peterx@redhat.com>
 <20190820051615.1210-3-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <800a4208-627f-9089-8291-c6f4329cd4d5@redhat.com>
Date: Tue, 20 Aug 2019 08:24:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820051615.1210-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] memory: Split zones when do
 coalesced_io_del()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/19 07:16, Peter Xu wrote:
> It is a workaround of current KVM's KVM_UNREGISTER_COALESCED_MMIO
> interface.  The kernel interface only allows to unregister an mmio
> device with exactly the zone size when registered, or any smaller zone
> that is included in the device mmio zone.  It does not support the
> userspace to specify a very large zone to remove all the small mmio
> devices within the zone covered.
> 
> Logically speaking it would be nicer to fix this from KVM side, though
> in all cases we still need to coop with old kernels so let's do this.
> 
> This patch has nothing to do with 3ac7d43a6fbb5d4a3 because this is
> probably broken from the very beginning when the
> KVM_UNREGISTER_COALESCED_MMIO interface is introduced in kernel.
> However to make the backport to stables easier, I'm still using the
> commit 3ac7d43a6fbb5d4a3 to track this problem because this will
> depend on that otherwise even additions of mmio devices won't work.
> 
> Fixes: 3ac7d43a6fbb5d4a3
> Signed-off-by: Peter Xu <peterx@redhat.com>

What about my comments to this patch? :)

Paolo

> ---
>  memory.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index c53dcfc092..7684b423f8 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -857,6 +857,9 @@ static void address_space_update_ioeventfds(AddressSpace *as)
>  
>  static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
>  {
> +    CoalescedMemoryRange *cmr;
> +    AddrRange tmp;
> +
>      if (!fr->has_coalesced_range) {
>          return;
>      }
> @@ -865,9 +868,30 @@ static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
>          return;
>      }
>  
> -    MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
> -                                  int128_get64(fr->addr.start),
> -                                  int128_get64(fr->addr.size));
> +    /*
> +     * We split the big region into smaller ones to satisfy KVM's
> +     * KVM_UNREGISTER_COALESCED_MMIO interface, where it does not
> +     * allow to specify a large region to unregister all the devices
> +     * under that zone instead it only accepts exact zones or even a
> +     * smaller zone of previously registered mmio device.  Logically
> +     * speaking we should better fix KVM to allow the userspace to
> +     * unregister multiple mmio devices within a large requested zone,
> +     * but in all cases we'll still need to live with old kernels.  So
> +     * let's simply break the zones into exactly the small pieces when
> +     * we do coalesced_io_add().
> +     */
> +    QTAILQ_FOREACH(cmr, &fr->mr->coalesced, link) {
> +        tmp = addrrange_shift(cmr->addr,
> +                              int128_sub(fr->addr.start,
> +                                         int128_make64(fr->offset_in_region)));
> +        if (!addrrange_intersects(tmp, fr->addr)) {
> +            continue;
> +        }
> +        tmp = addrrange_intersection(tmp, fr->addr);
> +        MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
> +                                      int128_get64(tmp.start),
> +                                      int128_get64(tmp.size));
> +    }
>  }
>  
>  static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
> 


