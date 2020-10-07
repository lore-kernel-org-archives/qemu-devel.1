Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFCDC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5D9206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOIwYOI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5D9206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7Vq-0005Qh-7I
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prasadalok77@gmail.com>)
 id 1kQ7V3-0004cy-Vd
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:20:49 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:40199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <prasadalok77@gmail.com>)
 id 1kQ7V1-0005MT-WD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:20:49 -0400
Received: by mail-il1-x142.google.com with SMTP id u9so1894074ilj.7
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w9vP+baIbynxJ3cglaOxcq+DgxTxh5YrQZYtfrZpoCg=;
 b=DOIwYOI3RPOykUtCTzNtLWbaFeX+psvK+UCEyLloSb2tUwmJN+pDMhE0rcSOll1JIy
 q/MiWjXs9+7f4kuuEN07ATfznGXXoChTwXehELpcAVGrSabdNOGwufgBCwAm6opP7Rnj
 jz0O4UE+FF0G3DzYoJABiT8GpfedXzBO7epAi/AHJKwLHgV6fFmjHiErKauGY52jwFux
 bZdnPDqw6/IXvk4YCIo6FGUltAdjdOfea+k9TX5IcI3aJ3NGZWgkQv2XB31C6DGDAXT2
 cKIApse5sPVCPtxCNQuU3ICKKssyIRUQdijtb5zq2VNDV2LfXyni6RNc4H0gKmqpfLL9
 b7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w9vP+baIbynxJ3cglaOxcq+DgxTxh5YrQZYtfrZpoCg=;
 b=YAbG4CT3oImPlWaCI7oVyItrKCqOQ0jw3VAhL79eKm7qRKiYrZlBbaIj4QpGOqAsyu
 FolTecYma0YphHV0ZeFIy46M7noSAs05rwEkNqrxWMIhAFiUVNOsN2Aa8t9LerWDislr
 P4rDW2982UWE+F6+0sk+FI7SBtHHbN/sVXcvoscNwidFlx2s9tDysXzNRTKBiqVwPQM0
 9cD+UIXhpt6+OqcPCTFQJSSIR8GYZLNEZoJ7Xyixwd9gfhkSEJjl+1JAJyMWOvUkLngp
 iDP+OIUSBchuThZw4dGFMQcKIqWTRTOIMPn6J7AMuJO4C3gbsbv5PqT2qH2QmuwUtROn
 2n1g==
X-Gm-Message-State: AOAM533VDrRTsgg1QRf/0Z4bbw5UR+N0knqXJqsv+/ZznUhqT0l2I9kX
 /uManf0mQTiAcfRDLVHCiLtTN4NtiIFrY/zAenM=
X-Google-Smtp-Source: ABdhPJwegqRpCL9X386Fsc5cN4vm2S8zWiadSCdM5gs1WykD0x/2ap4HsWVGqJQ3D4H2PxvWm7vWgacoJtPxpHPNyks=
X-Received: by 2002:a92:aa01:: with SMTP id j1mr2417103ili.301.1602069646526; 
 Wed, 07 Oct 2020 04:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJPzGv1Vd1V2a_7n2GW4RBUDgpsdyAH-8NMvW+368gigtYWd0g@mail.gmail.com>
 <CAJPzGv0bFatmLJ_dy83KgZbyMS5zM0_pAqTynkSAHXNUST_JHg@mail.gmail.com>
 <20201006202325.GB6026@xz-x1>
In-Reply-To: <20201006202325.GB6026@xz-x1>
From: Alok Prasad <prasadalok77@gmail.com>
Date: Wed, 7 Oct 2020 16:50:35 +0530
Message-ID: <CAJPzGv3biYdPe=sd9_WYjCsoSdSNyfTZq=pLucAvzYvq_SHvXw@mail.gmail.com>
Subject: Re: Fwd: Enable IOMMU Inside QEMU
To: Peter Xu <peterx@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002fcc7505b112e803"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=prasadalok77@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002fcc7505b112e803
Content-Type: text/plain; charset="UTF-8"

Thanks, Peter!
That worked for me, Not sure if Virsh XML has some issue.
for sake of other, this is the complete command I use.

/usr/bin/qemu-system-x86_64  -machine q35,kernel-irqchip=split,accel=kvm
-smp 4 -m 2G   -device intel-iommu,intremap=on,caching-mode=on -nographic
os_image.qcow2

dmesg inside VM now shows

[root@centos-8 ~]# dmesg | grep -e DMAR
[    0.013047] ACPI: DMAR 0x000000007FFE221F 000048 (v01 BOCHS  BXPCDMAR
00000001 BXPC 00000001)
[    0.100861] DMAR: IOMMU enabled
[    0.258287] DMAR: Host address width 39
[    0.259213] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
[    0.260470] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap
d2008c22260286 ecap f00f5a
[    0.262321] DMAR-IR: IOAPIC id 0 under DRHD base  0xfed90000 IOMMU 0
[    0.263755] DMAR-IR: Queued invalidation will be enabled to support
x2apic and Intr-remapping.
[    0.267498] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    2.205498] DMAR: No RMRR found
[    2.207406] DMAR: No ATSR found
[    2.209495] DMAR: dmar0: Using Queued invalidation
[    2.212938] DMAR: Hardware identity mapping for device 0000:00:00.0
[    2.216531] DMAR: Hardware identity mapping for device 0000:00:01.0
[    2.219430] DMAR: Hardware identity mapping for device 0000:00:02.0
[    2.222314] DMAR: Hardware identity mapping for device 0000:00:03.0
[    2.224804] DMAR: Hardware identity mapping for device 0000:00:1f.0
[    2.227289] DMAR: Hardware identity mapping for device 0000:00:1f.2
[    2.229850] DMAR: Hardware identity mapping for device 0000:00:1f.3
[    2.232185] DMAR: Setting RMRR:
[    2.233469] DMAR: Prepare 0-16MiB unity mapping for LPC
[    2.235443] DMAR: Ignoring identity map for HW passthrough device
0000:00:1f.0 [0x0 - 0xffffff]
[    2.238732] DMAR: Intel(R) Virtualization Technology for Directed I/O


Thanks,
Alok

On Wed, Oct 7, 2020 at 1:53 AM Peter Xu <peterx@redhat.com> wrote:

> On Tue, Oct 06, 2020 at 11:26:08PM +0530, Alok Prasad wrote:
> > root@beta-hp-p70:/home/fastlinq/alok/KVM-VM# /usr/bin/qemu-system-x86_64
> > --version
> > QEMU emulator version 4.2.1
> > Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
> >
> > I am missing here something,? Is there seperate Branch for the same in
> qemu.
>
> No, it should always be in mainline.
>
> I didn't see anything obviously wrong in your setup.  A simplest QEMU
> cmdline
> to boot a guest with vIOMMU should be:
>
> $QEMU -machine q35,kernel-irqchip=split,accel=kvm -smp 4 -m 2G \
>       -device intel-iommu ~/images/default.qcow2
>
> May worth try this directly.  Also feel free to compile the latest QEMU.
> The
> default configuration should work.
>
> --
> Peter Xu
>
>

--0000000000002fcc7505b112e803
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, Peter!<div>That worked for me, Not sure if Virsh X=
ML has some issue.</div><div><div>for sake of other, this is the complete c=
ommand=C2=A0I use.<br></div><div><br></div><div>/usr/bin/qemu-system-x86_64=
 =C2=A0-machine q35,kernel-irqchip=3Dsplit,accel=3Dkvm -smp 4 -m 2G =C2=A0 =
-device intel-iommu,intremap=3Don,caching-mode=3Don -nographic=C2=A0 os_ima=
ge.qcow2<br></div><div><br></div><div>dmesg inside VM now shows</div><div><=
br></div><div>[root@centos-8 ~]# dmesg | grep -e DMAR<br>[ =C2=A0 =C2=A00.0=
13047] ACPI: DMAR 0x000000007FFE221F 000048 (v01 BOCHS =C2=A0BXPCDMAR 00000=
001 BXPC 00000001)<br>[ =C2=A0 =C2=A00.100861] DMAR: IOMMU enabled<br>[ =C2=
=A0 =C2=A00.258287] DMAR: Host address width 39<br>[ =C2=A0 =C2=A00.259213]=
 DMAR: DRHD base: 0x000000fed90000 flags: 0x1<br>[ =C2=A0 =C2=A00.260470] D=
MAR: dmar0: reg_base_addr fed90000 ver 1:0 cap d2008c22260286 ecap f00f5a<b=
r>[ =C2=A0 =C2=A00.262321] DMAR-IR: IOAPIC id 0 under DRHD base =C2=A00xfed=
90000 IOMMU 0<br>[ =C2=A0 =C2=A00.263755] DMAR-IR: Queued invalidation will=
 be enabled to support x2apic and Intr-remapping.<br>[ =C2=A0 =C2=A00.26749=
8] DMAR-IR: Enabled IRQ remapping in x2apic mode<br>[ =C2=A0 =C2=A02.205498=
] DMAR: No RMRR found<br>[ =C2=A0 =C2=A02.207406] DMAR: No ATSR found<br>[ =
=C2=A0 =C2=A02.209495] DMAR: dmar0: Using Queued invalidation<br>[ =C2=A0 =
=C2=A02.212938] DMAR: Hardware identity mapping for device 0000:00:00.0<br>=
[ =C2=A0 =C2=A02.216531] DMAR: Hardware identity mapping for device 0000:00=
:01.0<br>[ =C2=A0 =C2=A02.219430] DMAR: Hardware identity mapping for devic=
e 0000:00:02.0<br>[ =C2=A0 =C2=A02.222314] DMAR: Hardware identity mapping =
for device 0000:00:03.0<br>[ =C2=A0 =C2=A02.224804] DMAR: Hardware identity=
 mapping for device 0000:00:1f.0<br>[ =C2=A0 =C2=A02.227289] DMAR: Hardware=
 identity mapping for device 0000:00:1f.2<br>[ =C2=A0 =C2=A02.229850] DMAR:=
 Hardware identity mapping for device 0000:00:1f.3<br>[ =C2=A0 =C2=A02.2321=
85] DMAR: Setting RMRR:<br>[ =C2=A0 =C2=A02.233469] DMAR: Prepare 0-16MiB u=
nity mapping for LPC<br>[ =C2=A0 =C2=A02.235443] DMAR: Ignoring identity ma=
p for HW passthrough device 0000:00:1f.0 [0x0 - 0xffffff]<br>[ =C2=A0 =C2=
=A02.238732] DMAR: Intel(R) Virtualization Technology for Directed I/O<br><=
/div><div><br></div><div><br></div><div>Thanks,</div><div>Alok</div></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Wed, Oct 7, 2020 at 1:53 AM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.=
com">peterx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Tue, Oct 06, 2020 at 11:26:08PM +0530, Alok Prasad=
 wrote:<br>
&gt; root@beta-hp-p70:/home/fastlinq/alok/KVM-VM# /usr/bin/qemu-system-x86_=
64<br>
&gt; --version<br>
&gt; QEMU emulator version 4.2.1<br>
&gt; Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developer=
s<br>
&gt; <br>
&gt; I am missing here something,? Is there seperate Branch for the same in=
 qemu.<br>
<br>
No, it should always be in mainline.<br>
<br>
I didn&#39;t see anything obviously wrong in your setup.=C2=A0 A simplest Q=
EMU cmdline<br>
to boot a guest with vIOMMU should be:<br>
<br>
$QEMU -machine q35,kernel-irqchip=3Dsplit,accel=3Dkvm -smp 4 -m 2G \<br>
=C2=A0 =C2=A0 =C2=A0 -device intel-iommu ~/images/default.qcow2<br>
<br>
May worth try this directly.=C2=A0 Also feel free to compile the latest QEM=
U.=C2=A0 The<br>
default configuration should work.<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div>

--0000000000002fcc7505b112e803--

