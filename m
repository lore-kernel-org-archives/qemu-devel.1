Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4812C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698272053B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P58wNBRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698272053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQTW-0000Zc-IW
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDQSa-0008Fy-6V
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDQSW-00009L-U9
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:53:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59861
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDQSW-00008o-OW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569491592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=WJu3Xlg6mD43ewleZZDOMWHBhDtR9cRG9ZeMoaYTa4o=;
 b=P58wNBRwuQgfr7VwIaC9XBgeyuWlT+UfrM9cZt10glzhDB0ZROQaWjl7YWv6DEpDklPOqr
 m9QvO7FuiIhinFNRQGyN1k64xKoMXwwzHVQnkSlmI7mz1P1oLsXfTg4GXLXiKEOBfmeeOq
 pr7PfPiLR1XPWmoKdWoyTZ0RBck2vKA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-dFzGABATN8S6R0zposR_ZQ-1; Thu, 26 Sep 2019 05:53:09 -0400
Received: by mail-wm1-f72.google.com with SMTP id 190so912210wme.4
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 02:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OQlwNvezBDdC6HCpQEUcONxZs5A19EVGk9nqw+nTF5o=;
 b=Wuqat+0UNoHQOzsl4OnAPDo/UDxXP+ZDB8vtLDkR2UTd+tTv1wN4lirPe5JUIoy61h
 QfOa4mbOvjaXxj7feOLj1TtbzNPc3rdNTS3e7mw6cquTTILTfAXLiEePFbi00KUkOYp/
 I8/Ux1gQ/RXLZvZlt1dMdLuAT+liToFIlwoYlpE6XlfIu6tH8WcBiRcpIEgA5PgVFyiV
 0qIZhqZdiZCbQ3U1/BabF6nLFqqc1uE89DzBgPCnsIYJ/iJEQZWmPbKu/AIIPGID9zCe
 PR2Kt6KKfGaorlDgFPAJxzqMBmrsl04Tt2h9U3YN4b7XE2yNEgNDYvy337XBUsDF5KYe
 WSnA==
X-Gm-Message-State: APjAAAU6OEO9x3kQdMvAtkidunau8ljk5Y0uvhjH4vXyzBB07uTjQY+T
 ueTLrsnor53rWaOfqQgqptOJVeusSNAxOPfURpwa6BcRd3MJZFQ7VwYp6rdVocAwNE3tlA7Ac5e
 rq120SjyMbdxOVb8=
X-Received: by 2002:adf:de03:: with SMTP id b3mr2119943wrm.14.1569491587512;
 Thu, 26 Sep 2019 02:53:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyrGdMAjaKx15CpTgGMUBi7eXZduW+YVWStuRRot76gKVmSfm3ZM4HI+uniZRghvULKJrnQxw==
X-Received: by 2002:adf:de03:: with SMTP id b3mr2119931wrm.14.1569491587202;
 Thu, 26 Sep 2019 02:53:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id y12sm1727816wrn.74.2019.09.26.02.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 02:53:06 -0700 (PDT)
Subject: Re: Questions about the real mode in kvm/qemu
To: Li Qiang <liq3ea@gmail.com>
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <b24f9938-d0a7-2680-0078-c02e1abebc59@redhat.com>
 <CAKXe6SJaNju-O8mECU18n-3W3OnYnjnOUCKfAmTK32LAXj0nng@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a7687447-5df8-bb08-b78b-bef0321b40a9@redhat.com>
Date: Thu, 26 Sep 2019 11:53:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJaNju-O8mECU18n-3W3OnYnjnOUCKfAmTK32LAXj0nng@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: dFzGABATN8S6R0zposR_ZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/09/19 11:35, Li Qiang wrote:
> So without unrestrict guest the mainline is this: KVM set guest's
> rflag bit X86_EFLAGS_VM, so when the guest enter guest mode, it is in
> vm86 mode. In this mode, the CPU will access the address like in
> real mode(seg*4+offset), this address is linear address. And in fact,
> the vm86 is still in protected, so the linear address will be
> translated to gpa by the identity mapping table. Then goes to EPT
> table?

Yes.

>     ... as soon as the guest tries to enter protected mode, it will get i=
nto
>     a situation which is not real mode but doesn't have the segment
>     registers properly loaded with selectors.=C2=A0=C2=A0
>=20
>     Therefore, it will either
>     hack things together (enter_pmode) or emulate instructions until the
>     state is accepted even without unrestricted guest support.
>=20
> Could you please explain this situation more detailed? Why this happen?

Protected mode entry looks like this:

        mov %cr0, %eax
        or $1, %al
        mov %eax, %cr0
=09# [1] now in 16-bit protected mode
        lgdtl gdt32
        ljmpl $8, 2f
=09# [2] now in 32-bit protected mode
2:
        .code32
        mov $16, %ax
        mov %ax, %ds
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        mov %ax, %ss
=09# [3] now everything is okay

Between [1] and [3] the vmentry could fail if not in unrestricted mode.
 For example (see checks on guest segment registers in the SDM):

- "CS. Type must be 9, 11, 13, or 15 (accessed code segment)."  CS in
real-mode is a RW data segment, not a code segment.  This applies
between [1] and [2].

- "SS. If the guest will not be virtual-8086 and the =E2=80=9Cunrestricted
guest=E2=80=9D VM-execution control is 0, the RPL (bits 1:0) must equal the=
 RPL
of the selector field for CS."  This may not be the case if the segment
register still holds real-mode values (which are not selectors, just
base >> 4).  This applies between [1] and [3].

- "DS, ES, FS, GS. The DPL cannot be less than the RPL in the selector
field"   Again, the real-mode DPL is zero but the RPL makes no sense if
the segment registers hold a real-mode value.

You can find more about these checks in guest_state_valid(); look at the
"else" branch of that function, the "then" branch is for pmode->rmode
transitions.  When any of the checks fail, KVM emulates instructions
instead of using VMX non-root mode (usually it's just a handful of them,
as in the case above).

Paolo


