Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E82C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA69820665
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGnwJ34y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA69820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igsdA-0004xk-Rh
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:49:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igsbz-0003oZ-FA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igsby-0004rw-6i
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:48:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igsby-0004oo-1z
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576511321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2v/Ok6ZvcnVhGX+VExCC/zEjb9qtt3LYiq8Bn2igZas=;
 b=dGnwJ34yTaf3+NcBeuWYMEmKLW83Md2RHrMBPHNxjROTOyd2MG5xeLuc19HDqvmT5xVoXg
 K+cob0ZJLfSYmKddZ9fNKlQfD3aPRhFg4Q4zhfZ657ZYrdnNR+XjtXJEf9OBIHrfw5m/6J
 pa/U4tH/HZFAwxwQZ0xYH3Aj68tLuuY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-n3uNrwfDMmm-m4ILMgBsAg-1; Mon, 16 Dec 2019 10:48:39 -0500
Received: by mail-wr1-f70.google.com with SMTP id f15so3961546wrr.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 07:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NK24jcfG9UBuY8rN//ofB2n49byardjTFM1RJjyjWnM=;
 b=hslOdhPtUq3hnv1JJqdfLHfy4RdjWPnvKtqy6fXweX+5Hkn9CLT+cu7E4KZRIWLS98
 Mr8bejB6RZHlSsjPt987w0hvVM8dOjse6bBaqmncuuzxKQdN2umaYSTqN8n8Duiz9YLs
 GKrqINuwac/7kBRnaq6ICOgrEOF+KzVKwTaISnC8OPTnC0v4/y3EXcj/jakrrbGUBVMw
 eWLFYyOFLS4gGLLqYYcEy2u9lah2kN5LuKKQgKcOMzKMspf2R15OGcUCxqlp/2v/FSDU
 GbmOHKSV6ZOmCZjt8knSCrk47MwzBgWJkM/eVwX/kFefLXYh31Lpvmre9gjxmsyiyT/V
 +HiA==
X-Gm-Message-State: APjAAAXawCK3IdqN4E3fWM6HTGLAyN9JZX03v3TXr/eiUBpnBvSqoMOC
 dqIl4Bb4w0yBLVpbFxOo0a5sroOJingClZgOhyqSPCwpkvI5Vf6Dro5Ubz+j7fU8bzYyRjvSEaw
 JyXaNXIernCI5ixQ=
X-Received: by 2002:a05:600c:1003:: with SMTP id
 c3mr30651544wmc.120.1576511317837; 
 Mon, 16 Dec 2019 07:48:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqw91mpCMXRzNUnMlilO04dgXju+Jt835qTjzpZhengzNi+a5MHx1NtPbwEpwmIXe3771MmoCQ==
X-Received: by 2002:a05:600c:1003:: with SMTP id
 c3mr30651518wmc.120.1576511317615; 
 Mon, 16 Dec 2019 07:48:37 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id 4sm21037599wmg.22.2019.12.16.07.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 07:48:36 -0800 (PST)
Subject: Re: [PATCH 12/12] hw/i386/pc: Move PC-machine specific declarations
 to 'pc_internal.h'
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20191213161753.8051-1-philmd@redhat.com>
 <20191213161753.8051-13-philmd@redhat.com>
 <d9792ff4-bada-fbb9-301d-aeb19826235c@redhat.com>
 <20191215045812-mutt-send-email-mst@kernel.org>
 <0d15c735-73b4-7875-ec0f-8c181508f0d4@redhat.com>
 <90d54a3b-ae96-43ac-0f8e-268c1257f7d0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <76162c3a-1b66-dd49-901e-7435efc21873@redhat.com>
Date: Mon, 16 Dec 2019 16:48:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <90d54a3b-ae96-43ac-0f8e-268c1257f7d0@redhat.com>
Content-Language: en-US
X-MC-Unique: n3uNrwfDMmm-m4ILMgBsAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/16/19 4:41 PM, Paolo Bonzini wrote:
> On 16/12/19 16:37, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/15/19 10:58 AM, Michael S. Tsirkin wrote:
>>> On Fri, Dec 13, 2019 at 05:47:28PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
>>>> On 12/13/19 5:17 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> Historically, QEMU started with only one X86 machine: the PC.
>>>>> The 'hw/i386/pc.h' header was used to store all X86 and PC
>>>>> declarations. Since we have now multiple machines based on the
>>>>> X86 architecture, move the PC-specific declarations in a new
>>>>> header.
>>>>> We use 'internal' in the name to explicit this header is restricted
>>>>> to the X86 architecture. Other architecture can not access it.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>> ---
>>>>> Maybe name it 'pc_machine.h'?
>>>>
>>>> I forgot to describe here (and in the cover), what's follow after this
>>>> patch.
>>>>
>>>> Patch #13 moves PCMachineClass to
>>>>
>>>> If you ignore PCMachineState, "hw/i386/pc.h" now only contains 76
>>>> lines, and
>>>> it is easier to see what is PC machine specific, what is X86
>>>> specific, and
>>>> what is device generic (not X86 related at all):
>>>>
>>>> - GSI is common to X86 (Paolo sent [3], [6])
>>>> - IOAPIC is common to X86
>>>> - i8259 is multiarch (Paolo [2])
>>>> - PCI_HOST definitions and pc_pci_hole64_start() are X86
>>>> - pc_machine_is_smm_enabled() is X86 (Paolo sent [5])
>>>> - hpet
>>>> - tsc (Paolo sent [3])
>>>> - 3 more functions
>>>>
>>>> So we can move half of this file to "pc_internal.h" and the other to
>>>>
>>>> One problem is the Q35 MCH north bridge which directly sets the PCI
>>>> PCMachineState->bus in q35_host_realize(). This seems a QOM violation
>>>> and is
>>>> probably easily fixable.
>>>>
>>>> Maybe I can apply Paolo's patches instead of this #12, move X86-generi=
c
>>>> declarations to "hw/i386/x86.h", and directly git-move what's left of
>>>> "hw/i386/pc.h" to "pc_internal.h".
>>>
>>> Yea that sounds a bit better.
>>
>> OK, I'll wait for Paolo's next pull get in, then continue based on that,
>> including Paolo's "x86: allow building without PC machine types" series.
>>
>> (Thanks Paolo for picking most of this series!)
>=20
> FWIW I don't think kvm_i8259_init should be in sysemu/kvm.h, since it's
> x86-specific and that would be something like the same mistake already
> done with hw/i386/pc.h.

Hmm OK.
So to follow your reasoning,=20
kvm_pc_gsi_handler/kvm_pc_setup_irq_routing() are x86-specific and could=20
be moved out.
I'll figure that out when I rework the last patches.


