Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E078BCA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 09:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59682087F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 09:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59682087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPkgR-0005KB-Qw
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 05:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iPkfU-0004H9-65
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iPkfQ-0006rM-6v
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:53:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35674)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iPkfP-0006p7-UW
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:53:28 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0284181F2F
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 09:53:26 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id c6so1050735wrp.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 02:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v0iam7SbGeY1R8rhTPq10FW8xdJx0jgBJ5JXrMKbxmo=;
 b=Y5XcL/S2CZrkMhw4ceqKK5EMmS5ZdymX1+2RrTBoP6YJPROHO1cTcD+c8fUPthJbJR
 7zKv0FpuLuGfnzPAsnqcYxY/Hn5zVyALVMwwSl/XSB2k9My2rCc38Wbe7v9VYzA2LuZ/
 aWsDp9D32lSCFn6BA9q+jMw18zRL+fgPnLo8PIqpHg1jvcl7sbeTnFFtlCDyGSXINOl9
 ojRGC/Bcdnhyn0gkjimbTaP3E3DcUP7oQXR7F6XMyiTH6rT9+5vfq96Jfc6FHS2ckEdC
 DJEGQTQlZPzaVSBFNiB1oMQfZEH2Qig6MiWM1RPjhZmUVUOMEvvpBR92bV5jKHKfuQ2p
 WpCg==
X-Gm-Message-State: APjAAAW1lMHx4aI5/TqPPsAfGbbP0eJrXByaToAhFt23adifmOA5fTta
 EHj8GLcAHZdrTrayle308DZBU1+QWODh8QJu4B5bgLD53zJqyReqfyNryTljl3VkZK1m+dtD0dG
 Z8wt/ZcTzPh8Ag5c=
X-Received: by 2002:a5d:5446:: with SMTP id w6mr23347473wrv.350.1572429204730; 
 Wed, 30 Oct 2019 02:53:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyzADxugFtw0xBFozFCQHrwOZq/dsoHhjnXnV0xa8s1M9ujfTkOxiOTurri4DqkODo4noNKWQ==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr23347440wrv.350.1572429204368; 
 Wed, 30 Oct 2019 02:53:24 -0700 (PDT)
Received: from [172.20.51.145] ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id g184sm2001307wma.8.2019.10.30.02.53.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2019 02:53:23 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191026180143.7369-1-philmd@redhat.com>
 <CAL1e-=jW0Jmk=Y9o_UpdeOo6vfTm-qXyPVtk4O+RLOUN_5Y_cw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a635330c-0ef0-b4e1-53ff-b5bca3d2ffa0@redhat.com>
Date: Wed, 30 Oct 2019 10:53:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jW0Jmk=Y9o_UpdeOo6vfTm-qXyPVtk4O+RLOUN_5Y_cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 10/27/19 8:44 AM, Aleksandar Markovic wrote:
> On Saturday, October 26, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     Changes since v2 [0]:
>     - Use a #define
>     - Reword one description
>     - Added review tags (thanks all for reviewing!)
>=20
>     Changes since v1 [1]:
>     - Removed patch reintroducing DO_UPCAST() use (thuth)
>     - Took various patches out to reduce series (thuth)
>     - Added review tags (thanks all for reviewing!)
>=20
>     $ git backport-diff -u pc_split_i440fx_piix-v2
>     Key:
>     [----] : patches are identical
>     [####] : number of functional differences between
>     upstream/downstream patch
>     [down] : patch is downstream-only
>     The flags [FC] indicate (F)unctional and (C)ontextual differences,
>     respectively
>=20
>     001/20:[----] [--] 'MAINTAINERS: Keep PIIX4 South Bridge separate
>     from PC Chipsets'
>     002/20:[0004] [FC] 'piix4: Add the Reset Control Register'
>     003/20:[0002] [FC] 'piix4: Add an i8259 Interrupt Controller as
>     specified in datasheet'
>     004/20:[----] [--] 'Revert "irq: introduce qemu_irq_proxy()"'
>     005/20:[----] [--] 'piix4: Rename PIIX4 object to piix4-isa'
>     006/20:[----] [--] 'piix4: Add an i8257 DMA Controller as specified
>     in datasheet'
>     007/20:[----] [-C] 'piix4: Add an i8254 PIT Controller as specified
>     in datasheet'
>     008/20:[0004] [FC] 'piix4: Add a MC146818 RTC Controller as
>     specified in datasheet'
>     009/20:[----] [--] 'hw/mips/mips_malta: Create IDE hard drive array
>     dynamically'
>     010/20:[----] [--] 'hw/mips/mips_malta: Extract the PIIX4 creation
>     code as piix4_create()'
>     011/20:[----] [-C] 'hw/isa/piix4: Move piix4_create() to hw/isa/pii=
x4.c'
>     012/20:[----] [--] 'hw/i386: Remove obsolete
>     LoadStateHandler::load_state_old handlers'
>     013/20:[----] [--] 'hw/pci-host/piix: Extract piix3_create()'
>     014/20:[0002] [FC] 'hw/pci-host/piix: Move RCR_IOPORT register
>     definition'
>     015/20:[----] [--] 'hw/pci-host/piix: Define and use the PIIX IRQ
>     Route Control Registers'
>     016/20:[----] [-C] 'hw/pci-host/piix: Move i440FX declarations to
>     hw/pci-host/i440fx.h'
>     017/20:[----] [--] 'hw/pci-host/piix: Fix code style issues'
>     018/20:[----] [--] 'hw/pci-host/piix: Extract PIIX3 functions to
>     hw/isa/piix3.c'
>     019/20:[----] [--] 'hw/pci-host: Rename incorrectly named 'piix' as
>     'i440fx''
>     020/20:[0004] [FC] 'hw/pci-host/i440fx: Remove the last PIIX3 trace=
s'
>=20
>     Previous cover:
>=20
>     This series is a rework of "piix4: cleanup and improvements" [2]
>     from Herv=C3=A9, and my "remove i386/pc dependency: PIIX cleanup" [=
3].
>=20
>     Still trying to remove the strong X86/PC dependency 2 years later,
>     one step at a time.
>     Here we split the PIIX3 southbridge from i440FX northbridge.
>     The i440FX northbridge is only used by the PC machine, while the
>     PIIX southbridge is also used by the Malta MIPS machine.
>=20
>     This is also a step forward using KConfig with the Malta board.
>     Without this split, it was impossible to compile the Malta without
>     pulling various X86 pieces of code.
>=20
>     The overall design cleanup is not yet perfect, but enough to post
>     as a series.
>=20
>     Now that the PIIX3 code is extracted, the code duplication with the
>     PIIX4 chipset is obvious. Not worth improving for now because it
>     isn't broken.
>=20
>     Based-on: <1572097538-18898-1-git-send-email-pbonzini@redhat.com
>     <mailto:1572097538-18898-1-git-send-email-pbonzini@redhat.com>>
>     to include:
>     mc146818rtc: Allow call object_initialize(MC146818_RTC) instead of
>     rtc_init()
>     https://mid.mail-archive.com/20191018133547.10936-1-philmd@redhat.c=
om <https://mid.mail-archive.com/20191018133547.10936-1-philmd@redhat.com=
>
>=20
>     Since Aleksandar offered me to send the pull request [4] I plan to =
do
>     it once Paolo's pull [5] is merged.
>=20
>=20
> Philippe,
>=20
> I attempted the other day the integration of v2 of this series into MIP=
S=20
> pull request, but couldn't do it - since another series of yours was=20
> already merged, acting on the same code, making rebasing difficult. Now=
=20
> this, v3, series can't be applied since certain patches in some, on=20
> surface, unrelated series aren't megred, and v3 assumes they are merged=
.
>=20
> If you send a series, it should preferably be based on the latest=20
> (current) code base, not on some imagined future state.

I used the 'based-on' tag to refer other series, and patchew succeeded
at applying this series on top of it and build/test it.

Based-on: <1572097538-18898-1-git-send-email-pbonzini@redhat.com

> Why did you create this such mess with interdependencies of your own=20
> multiple series, and just right before softfreeze? :( You should have=20
> distributed submitting those series over longer time interval, and=20
> absolutely avoid, if possible, this hectic around-softfreeze period. Yo=
u=20
> did the opposite: waited for softfreeze to become close, and sent=20
> several interdependant series in matter of days - creating stress=20
> without any real technical reason.

This series touches multiple subsystems, so different maintainers had to=20
take the various parts, so I had to split.

Also Peter gave the recommendation on the list to not put more than 20=20
patches in a series, to make it digestible for review.

> In case you, for any reason, can't complete this by softfreeze, I advic=
e=20
> you not to rush, and postpone the integration to 5.0.

This series doesn't provide any useful feature, it is a simple cleanup,
posted and reviewed before soft freeze, so we still have 1 week (until
hard freeze) to have it merged, or postpone. No need to stress out for
a cleanup ;)

Regards,

Phil.

