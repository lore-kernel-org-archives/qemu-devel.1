Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD7AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC9B2076E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMAXf77u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC9B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnldb-0003SD-Tf
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 12:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jnlc1-000274-JS; Tue, 23 Jun 2020 12:17:29 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jnlbz-0000PD-J8; Tue, 23 Jun 2020 12:17:29 -0400
Received: by mail-io1-xd43.google.com with SMTP id a12so10716723ion.13;
 Tue, 23 Jun 2020 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0NXZOS3erP74m5/j5EcxH6vz7pSf9Mgae6UGdH6KvUk=;
 b=tMAXf77ukwmWT/2nCXDQIcd66NML5uAQaKpAy+du8N/ujrbDAiYLIOaLvj2C9A+ji/
 07LFOCMfyvfp5du3eSnHZh6ch7bANRoEK0tG6xhPp7ahCfghu6BL3IB//Eng79yUApSE
 rw2KGECayHP5mnuAvKNNz9Il5IbrxrBzqT1iWysphTSkvf0gUNf4yiREpstdU4NChKVY
 G05DaQgMjwpzVnITDA9FrDMcZ3tNrvOhAOXWmbI/nUoand3L9Hro+1ZHwHfFtpJgtbhB
 /AkKpQxQ1ezs2uQRlp5IGWk/HufO4q0Uc+qhtBgrRo+9hDgllZwMhjxgCI/9amqvmFgh
 LcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0NXZOS3erP74m5/j5EcxH6vz7pSf9Mgae6UGdH6KvUk=;
 b=si/8U/8z21X283vgMoeK2KM+tnoIqGFSDAJIEAr8QTFagG43jQkMHBGiGI4oiZ6CBv
 VYTRaNYybO8D2XEJIs7CkUnaNnBTO5V1GgpQj+vout83AnzzLqYL+W3fmsIg+8+KWxxG
 DpH0zKGk/5L050r3JqHIlPqA7KDcnBIlTo3TPJbxARl2oDp2XjB9UfewjMYllIbSYzSp
 5EJ8v1p+pLHNFVUu+ZvAJs8kJSMCQoTQHiXsF7NRt+7JdAfc4IM/XLgub3eh5p/aDIpy
 q3Eg6Fr8ArN9dxfSAREytxyeZt7lEcwwrlmiVAYgm0WX7cnfzr859/8PWrzZS4e40fyE
 wEkg==
X-Gm-Message-State: AOAM532I+fzF5WvxHRQqetkuk0jFJ5/kcAnnq+q6lKrdYnBbENVRJnxG
 NLgrguU5wGDPJwCMrXo/FJF0wOtGvIgC5xfVb3k=
X-Google-Smtp-Source: ABdhPJx2KlYdGeS3GmsnmhIenMciyWreLv73kD2m3XXO+09fLi3JIb2QGk3KefisZ3/Kj3oeIaldZqVgLanTdt1teJ8=
X-Received: by 2002:a05:6638:dd3:: with SMTP id
 m19mr25614181jaj.106.1592929045987; 
 Tue, 23 Jun 2020 09:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmXh_tYqubC4nF6PymQW795ExfPUN9Ap1u7PNPN2hws=CA@mail.gmail.com>
 <mhng-fd27972e-5f98-4fdb-b4dc-bd020f4fe8e2@palmer-si-x1e>
 <CAEUhbmUgE7v0-E4q128Tw-94938w4ibsxcPHQgHAk=5qhTViPA@mail.gmail.com>
In-Reply-To: <CAEUhbmUgE7v0-E4q128Tw-94938w4ibsxcPHQgHAk=5qhTViPA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 23 Jun 2020 09:07:53 -0700
Message-ID: <CAKmqyKPyDwv8sOsue5=w+fZowm_Kso3ceHgvRPUXLi7mE-GPow@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH] riscv: sifive_e: Correct
 various SoC IP block sizes
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 11:36 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi,
>
> On Thu, Sep 5, 2019 at 2:34 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > On Tue, 03 Sep 2019 20:41:52 PDT (-0700), bmeng.cn@gmail.com wrote:
> > > Palmer,
> > >
> > > On Wed, Aug 14, 2019 at 5:34 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >>
> > >> Hi Palmer,
> > >>
> > >> On Wed, Aug 7, 2019 at 10:53 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >> >
> > >> > On Wed, Aug 7, 2019 at 5:06 AM Philippe Mathieu-Daud=C3=A9 <philmd=
@redhat.com> wrote:
> > >> > >
> > >> > > On 8/5/19 8:43 AM, Bin Meng wrote:
> > >> > > > On Mon, Aug 5, 2019 at 2:14 PM Chih-Min Chao <chihmin.chao@sif=
ive.com> wrote:
> > >> > > >> On Sat, Aug 3, 2019 at 8:27 AM Bin Meng <bmeng.cn@gmail.com> =
wrote:
> > >> > > >>>
> > >> > > >>> Some of the SoC IP block sizes are wrong. Correct them accor=
ding
> > >> > > >>> to the FE310 manual.
> > >> > > >>>
> > >> > > >>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > >> > > >>> ---
> > >> > > >>>
> > >> > > >>>  hw/riscv/sifive_e.c | 6 +++---
> > >> > > >>>  1 file changed, 3 insertions(+), 3 deletions(-)
> > >> > > >>>
> > >> > > >>> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> > >> > > >>> index 2a499d8..9655847 100644
> > >> > > >>> --- a/hw/riscv/sifive_e.c
> > >> > > >>> +++ b/hw/riscv/sifive_e.c
> > >> > > >>> @@ -53,13 +53,13 @@ static const struct MemmapEntry {
> > >> > > >>>      hwaddr base;
> > >> > > >>>      hwaddr size;
> > >> > > >>>  } sifive_e_memmap[] =3D {
> > >> > > >>> -    [SIFIVE_E_DEBUG] =3D    {        0x0,      0x100 },
> > >> > > >>> +    [SIFIVE_E_DEBUG] =3D    {        0x0,     0x1000 },
> > >> > > >>>      [SIFIVE_E_MROM] =3D     {     0x1000,     0x2000 },
> > >> > > >>>      [SIFIVE_E_OTP] =3D      {    0x20000,     0x2000 },
> > >> > > >>>      [SIFIVE_E_CLINT] =3D    {  0x2000000,    0x10000 },
> > >> > > >>>      [SIFIVE_E_PLIC] =3D     {  0xc000000,  0x4000000 },
> > >> > > >>> -    [SIFIVE_E_AON] =3D      { 0x10000000,     0x8000 },
> > >> > > >>> -    [SIFIVE_E_PRCI] =3D     { 0x10008000,     0x8000 },
> > >> > > >>> +    [SIFIVE_E_AON] =3D      { 0x10000000,     0x1000 },
> > >> > > >>> +    [SIFIVE_E_PRCI] =3D     { 0x10008000,     0x1000 },
> > >> > > >>>      [SIFIVE_E_OTP_CTRL] =3D { 0x10010000,     0x1000 },
> > >> > > >>>      [SIFIVE_E_GPIO0] =3D    { 0x10012000,     0x1000 },
> > >> > > >>>      [SIFIVE_E_UART0] =3D    { 0x10013000,     0x1000 },
> > >> > > >>> --
> > >> > > >>> 2.7.4
> > >> > > >>>
> > >> > > >>
> > >> > > >> It seems the modification follows  E310-G002(Hifive1 Rev B) s=
pec and the origin is for E310-G000(Hifive1) spec.
> > >> > > >> There should be some way to specify different board version w=
ith different memory map or we have policy, always support the latest spec.
> > >> > >
> > >> > > I agree with Chao, it would be cleaner to have two different boa=
rds
> > >> > > (machines).
> > >> > > Since the SoCs are very similar, you could add a 'revision' prop=
erty and
> > >> > > use it to select the correct map.
> > >> > >
> > >> >
> > >> > I am not sure if adding two different machines will bring us a lot=
 of
> > >> > benefits, since the only difference is the SoC revision with diffe=
rent
> > >> > block sizes.
> > >> >
> > >> > > >>
> > >> > > >
> > >> > > > Yes, I checked both specs. The older spec says these bigger si=
zes,
> > >> > > > however their register sizes fit well in the smaller range as =
well. So
> > >> > > > I think the modification works well for both.
> > >> > >
> > >> > > This is OK for the PRCI, since sifive_prci_create() does not use
> > >> > > memmap[SIFIVE_E_PRCI].size.
> > >> > >
> > >> > > However the AON case is borderline, since you shrink it from 32K=
iB to 4KiB.
> > >> > >
> > >> >
> > >> > AON is not implemented anyway currently. And I checked the FE310 o=
ld
> > >> > spec, its register block size is still within the 4KiB range, so
> > >> > shrinking the size should be fine for both old and new SoC.
> > >> >
> > >> > > BTW (not related to this patch) it is odd a function named
> > >> > > sifive_mmio_emulate() creates a RAM region with memory_region_in=
it_ram()
> > >> > > and does not use the UnimplementedDevice (see make_unimp_dev() i=
n
> > >> > > hw/arm/musca.c).
> > >> > >
> > >>
> > >> What's your suggestion regarding this patch?
> > >
> > > Ping?
> >
> > Sorry, I missed this the first time around.  In retrospect, it looks li=
ke we
> > ended up with the wrong naming scheme for boards: sifive_e is very ambi=
guous,
> > as there are many boards that look like this.  We'd originally chosen a=
 more
> > explicit scheme (something like "sifive-fe310-g000"), but that was NAK'=
d as
> > resulting in too many machine types.
> >
> > Peter: would you be OK deprecating "sifive_e" and adding "sifive-fe310-=
g000"
> > and "sifive-fe310-g002" targets?  We'll end up with a lot of machines t=
his way,
> > but I don't see another way to closely match what's out there.  In embe=
dded
> > land there isn't really any runtime portability, so if the memory maps =
don't
> > match exactly then it's not a useful target for users.
>
> Just want to restart the discussion for this patch. Now that we have
> "revB" support for sifive_e machine, I guess we can do something?
>
> But renaming the sifive_e machine to something like sifive-fe31-g000
> is another topic .. Thoughts?

I would prefer not to have "sifive-fe310-g000" and "sifive-fe310-g002"
boards as that seems like it might lead to way too many boards in the
future.

In saying that board properties aren't that much better if there are
lots of boards as well.

One option would be something like what the ARM virt board does. Where
"sifive_e" is always the latest and you can specify different
versions. We would then have some deprecation scheme to remove older
boards.

I think for now properties seem to work, we can have revB=3Dtrue to
change anything required to match revB and the default is revA (or
whatever they call it).

If a revC comes out it should be easy to handle that via a property.
In the future we can re-evaluate what to do if that gets too hard to
maintain. Eventually we probably want the default to be the revB, but
that will break users so let's try to avoid that for now.

It's also possible that a revC won't break compatibility. For example
if revC just adds a new device, we can just expose that for all revs.

Alistair

>
> Regards,
> Bin
>

