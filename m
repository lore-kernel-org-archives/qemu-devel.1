Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6275C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D2B20665
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aY5986Cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D2B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igsVy-0006WX-El
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1igsV6-0005aj-KM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1igsV5-0005NE-Hc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:41:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26296
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1igsV5-0005LS-Da
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576510894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cu162pOTWU5yRvxVUJyOyppXqvklmFV84tiKSaDKRvg=;
 b=aY5986CqFe8rVaHQxT85AbjqS5rU8RixRoauc/D5ooV1EAdrlKmrfxcD1DdTUS55DoDSSl
 u42rPkC09UbGQipKpbKIEP5VeqZ5NBEZS0ndDw4lcD++EIwaM55eMELKZW2WEp8Fmr8Q2Z
 dMddsfv+7k9EWmspyGW1KGfzV85pqck=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-SIEmcVY3O2m1lJMNljGz2A-1; Mon, 16 Dec 2019 10:41:31 -0500
Received: by mail-wm1-f70.google.com with SMTP id t4so1199892wmf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 07:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oeIc59QSTUoM+WKt9UthuhNY2ejH+cHhDJxHGyG7QBo=;
 b=Sh2wQgWE/CqsiluOgS1AGs02O1cD26g/NjLPvHpb6j5AeXGKEz5aMmjsemr3Caf7RS
 xOQizvF46y0sE4nVSIExNhHgI1WhOIlAfEPJmU4Pu5dBrmsaPxW4sH6xx1uErIzEo++2
 NssfUWeyKWqrocYMQxtEngcJGyymV8OuDtIuFM74PyzoKtPP+0wWDj2upd1mFTWK5Pm8
 ga9XIQOl1D95zJ3OogcNGmFeW73VcOA510h7OY11e6v0qfQGzPXsPJGiWCsFzLzVAeGA
 aQ7kfXq8AASg6Ri0LNOucaPgJ56ycwqxaNm78eLZAM21KWKsGlOZhS4JfmXsmPkTRBDd
 HZyw==
X-Gm-Message-State: APjAAAXoryh+mY523uTuMgb36XFbQnnbxNLHyt2XAr10tcMd1zW33Syb
 ubXePMOKP3o2zhip51cGrlpIkQdIwZK0WNHUq9MG2c/R2qBnnKmXdf3HFIliEGxLxzgdZzDOOY6
 NfQ9/txOaVB3rzmc=
X-Received: by 2002:adf:ea42:: with SMTP id j2mr31125216wrn.270.1576510890028; 
 Mon, 16 Dec 2019 07:41:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqypDXszAwMOZCzf4Ez0io31KjZBaZhfECz0yOnY8MQ2T2JBsgh1CjxeGSVWMrX9dHTIjFOC2w==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr31125154wrn.270.1576510889523; 
 Mon, 16 Dec 2019 07:41:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:cde8:2463:95a9:1d81?
 ([2001:b07:6468:f312:cde8:2463:95a9:1d81])
 by smtp.gmail.com with ESMTPSA id d10sm21967922wrw.64.2019.12.16.07.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 07:41:28 -0800 (PST)
Subject: Re: [PATCH 12/12] hw/i386/pc: Move PC-machine specific declarations
 to 'pc_internal.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20191213161753.8051-1-philmd@redhat.com>
 <20191213161753.8051-13-philmd@redhat.com>
 <d9792ff4-bada-fbb9-301d-aeb19826235c@redhat.com>
 <20191215045812-mutt-send-email-mst@kernel.org>
 <0d15c735-73b4-7875-ec0f-8c181508f0d4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <90d54a3b-ae96-43ac-0f8e-268c1257f7d0@redhat.com>
Date: Mon, 16 Dec 2019 16:41:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <0d15c735-73b4-7875-ec0f-8c181508f0d4@redhat.com>
Content-Language: en-US
X-MC-Unique: SIEmcVY3O2m1lJMNljGz2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On 16/12/19 16:37, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/15/19 10:58 AM, Michael S. Tsirkin wrote:
>> On Fri, Dec 13, 2019 at 05:47:28PM +0100, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> On 12/13/19 5:17 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Historically, QEMU started with only one X86 machine: the PC.
>>>> The 'hw/i386/pc.h' header was used to store all X86 and PC
>>>> declarations. Since we have now multiple machines based on the
>>>> X86 architecture, move the PC-specific declarations in a new
>>>> header.
>>>> We use 'internal' in the name to explicit this header is restricted
>>>> to the X86 architecture. Other architecture can not access it.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>> Maybe name it 'pc_machine.h'?
>>>
>>> I forgot to describe here (and in the cover), what's follow after this
>>> patch.
>>>
>>> Patch #13 moves PCMachineClass to
>>>
>>> If you ignore PCMachineState, "hw/i386/pc.h" now only contains 76
>>> lines, and
>>> it is easier to see what is PC machine specific, what is X86
>>> specific, and
>>> what is device generic (not X86 related at all):
>>>
>>> - GSI is common to X86 (Paolo sent [3], [6])
>>> - IOAPIC is common to X86
>>> - i8259 is multiarch (Paolo [2])
>>> - PCI_HOST definitions and pc_pci_hole64_start() are X86
>>> - pc_machine_is_smm_enabled() is X86 (Paolo sent [5])
>>> - hpet
>>> - tsc (Paolo sent [3])
>>> - 3 more functions
>>>
>>> So we can move half of this file to "pc_internal.h" and the other to
>>>
>>> One problem is the Q35 MCH north bridge which directly sets the PCI
>>> PCMachineState->bus in q35_host_realize(). This seems a QOM violation
>>> and is
>>> probably easily fixable.
>>>
>>> Maybe I can apply Paolo's patches instead of this #12, move X86-generic
>>> declarations to "hw/i386/x86.h", and directly git-move what's left of
>>> "hw/i386/pc.h" to "pc_internal.h".
>>
>> Yea that sounds a bit better.
>=20
> OK, I'll wait for Paolo's next pull get in, then continue based on that,
> including Paolo's "x86: allow building without PC machine types" series.
>=20
> (Thanks Paolo for picking most of this series!)

FWIW I don't think kvm_i8259_init should be in sysemu/kvm.h, since it's
x86-specific and that would be something like the same mistake already
done with hw/i386/pc.h.

Paolo


