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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F363C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2772072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLGbPuLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2772072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jncXn-0003Nu-KK
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 02:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jncXC-0002ri-TF; Tue, 23 Jun 2020 02:35:54 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:45045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jncXB-0001RZ-2z; Tue, 23 Jun 2020 02:35:54 -0400
Received: by mail-yb1-xb43.google.com with SMTP id n123so10328170ybf.11;
 Mon, 22 Jun 2020 23:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=N1qEleLQKGSNa8UdSAfSfiKKgieKHNfKzwMoxFRxyF8=;
 b=XLGbPuLVrV9jAvsnZKHNkLhVwBjhEsWq23ZzPyBBiPHxa0jejhrsIToZbabUzT1lCF
 2tcEnHr9MxrgUGRDhFNcWb4bKM4dmwbzRkP7PYP195shmhegqxLmYhrQhSNyEo2+M1QG
 QAVdYwjKOSrDOxX7zmya1ZTPua0fYT9pJ4BWiRmAnlxXV0Q370Qw9GOBRkTdSmjzxMrG
 Gs7RscSzgi1CV31ODSoqs++ObqG5jOZ3HjNqrfh9VepbHVttvhBq66Fx1NPS/eMThTIi
 kVx0smWZjbYuL9ZHacL6uH+OfLIwWdHBXMU8xuizxcZ6n188iegVxb9PesW0U1lKC96+
 qEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=N1qEleLQKGSNa8UdSAfSfiKKgieKHNfKzwMoxFRxyF8=;
 b=M8F36MWs7VoRShBQSXUyWkYQ5MT2J2KnWiB44mpnCscqV6Ksjw/sb/5v4p/2//YHW5
 lyxdHyMz4Hgcfp9ktM7xdTR78soDfTxdj8V5PXRbodURDCb7lt6HX+cMXnE9CRtpoZvP
 fJYjBy3WXCjb0jtHbgFKbiebBwoiNkiNJdvV6/y9oMVMBRDpc7wyDsl7QKfyKCsuwIih
 kuZQ07EFhOLAQDaBUKar995FTnrse+KI/K3qGl/mwiP6xAYDlnB0onulent4OAzJFoZH
 /6hZ9x3CfKDyPaDuXJYiKjyi+Oz+RuaE/933oAOeDrJrmUAstPFSb1wY8zjjeY2K6sp4
 xwEw==
X-Gm-Message-State: AOAM5331TZT02EdWzbuxF+9YOUhviApTkUVS7875Wb4YcEQQGny8cBAG
 bBORt3e4vbLI/eevWWY3lpNWEcT524gkPiZOof8=
X-Google-Smtp-Source: ABdhPJx08B6j4i1zQhqjbZ4mWEi+cvaJlUzyLp2u79CVw7hBwPSwpu2VphBatfHxULj+RtsP276TOy8GmYeSTpKyz9A=
X-Received: by 2002:a25:38c5:: with SMTP id
 f188mr34233228yba.332.1592894151376; 
 Mon, 22 Jun 2020 23:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmXh_tYqubC4nF6PymQW795ExfPUN9Ap1u7PNPN2hws=CA@mail.gmail.com>
 <mhng-fd27972e-5f98-4fdb-b4dc-bd020f4fe8e2@palmer-si-x1e>
In-Reply-To: <mhng-fd27972e-5f98-4fdb-b4dc-bd020f4fe8e2@palmer-si-x1e>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 23 Jun 2020 14:35:40 +0800
Message-ID: <CAEUhbmUgE7v0-E4q128Tw-94938w4ibsxcPHQgHAk=5qhTViPA@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH] riscv: sifive_e: Correct
 various SoC IP block sizes
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Thu, Sep 5, 2019 at 2:34 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Tue, 03 Sep 2019 20:41:52 PDT (-0700), bmeng.cn@gmail.com wrote:
> > Palmer,
> >
> > On Wed, Aug 14, 2019 at 5:34 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>
> >> Hi Palmer,
> >>
> >> On Wed, Aug 7, 2019 at 10:53 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >> >
> >> > On Wed, Aug 7, 2019 at 5:06 AM Philippe Mathieu-Daud=C3=A9 <philmd@r=
edhat.com> wrote:
> >> > >
> >> > > On 8/5/19 8:43 AM, Bin Meng wrote:
> >> > > > On Mon, Aug 5, 2019 at 2:14 PM Chih-Min Chao <chihmin.chao@sifiv=
e.com> wrote:
> >> > > >> On Sat, Aug 3, 2019 at 8:27 AM Bin Meng <bmeng.cn@gmail.com> wr=
ote:
> >> > > >>>
> >> > > >>> Some of the SoC IP block sizes are wrong. Correct them accordi=
ng
> >> > > >>> to the FE310 manual.
> >> > > >>>
> >> > > >>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >> > > >>> ---
> >> > > >>>
> >> > > >>>  hw/riscv/sifive_e.c | 6 +++---
> >> > > >>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >> > > >>>
> >> > > >>> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> >> > > >>> index 2a499d8..9655847 100644
> >> > > >>> --- a/hw/riscv/sifive_e.c
> >> > > >>> +++ b/hw/riscv/sifive_e.c
> >> > > >>> @@ -53,13 +53,13 @@ static const struct MemmapEntry {
> >> > > >>>      hwaddr base;
> >> > > >>>      hwaddr size;
> >> > > >>>  } sifive_e_memmap[] =3D {
> >> > > >>> -    [SIFIVE_E_DEBUG] =3D    {        0x0,      0x100 },
> >> > > >>> +    [SIFIVE_E_DEBUG] =3D    {        0x0,     0x1000 },
> >> > > >>>      [SIFIVE_E_MROM] =3D     {     0x1000,     0x2000 },
> >> > > >>>      [SIFIVE_E_OTP] =3D      {    0x20000,     0x2000 },
> >> > > >>>      [SIFIVE_E_CLINT] =3D    {  0x2000000,    0x10000 },
> >> > > >>>      [SIFIVE_E_PLIC] =3D     {  0xc000000,  0x4000000 },
> >> > > >>> -    [SIFIVE_E_AON] =3D      { 0x10000000,     0x8000 },
> >> > > >>> -    [SIFIVE_E_PRCI] =3D     { 0x10008000,     0x8000 },
> >> > > >>> +    [SIFIVE_E_AON] =3D      { 0x10000000,     0x1000 },
> >> > > >>> +    [SIFIVE_E_PRCI] =3D     { 0x10008000,     0x1000 },
> >> > > >>>      [SIFIVE_E_OTP_CTRL] =3D { 0x10010000,     0x1000 },
> >> > > >>>      [SIFIVE_E_GPIO0] =3D    { 0x10012000,     0x1000 },
> >> > > >>>      [SIFIVE_E_UART0] =3D    { 0x10013000,     0x1000 },
> >> > > >>> --
> >> > > >>> 2.7.4
> >> > > >>>
> >> > > >>
> >> > > >> It seems the modification follows  E310-G002(Hifive1 Rev B) spe=
c and the origin is for E310-G000(Hifive1) spec.
> >> > > >> There should be some way to specify different board version wit=
h different memory map or we have policy, always support the latest spec.
> >> > >
> >> > > I agree with Chao, it would be cleaner to have two different board=
s
> >> > > (machines).
> >> > > Since the SoCs are very similar, you could add a 'revision' proper=
ty and
> >> > > use it to select the correct map.
> >> > >
> >> >
> >> > I am not sure if adding two different machines will bring us a lot o=
f
> >> > benefits, since the only difference is the SoC revision with differe=
nt
> >> > block sizes.
> >> >
> >> > > >>
> >> > > >
> >> > > > Yes, I checked both specs. The older spec says these bigger size=
s,
> >> > > > however their register sizes fit well in the smaller range as we=
ll. So
> >> > > > I think the modification works well for both.
> >> > >
> >> > > This is OK for the PRCI, since sifive_prci_create() does not use
> >> > > memmap[SIFIVE_E_PRCI].size.
> >> > >
> >> > > However the AON case is borderline, since you shrink it from 32KiB=
 to 4KiB.
> >> > >
> >> >
> >> > AON is not implemented anyway currently. And I checked the FE310 old
> >> > spec, its register block size is still within the 4KiB range, so
> >> > shrinking the size should be fine for both old and new SoC.
> >> >
> >> > > BTW (not related to this patch) it is odd a function named
> >> > > sifive_mmio_emulate() creates a RAM region with memory_region_init=
_ram()
> >> > > and does not use the UnimplementedDevice (see make_unimp_dev() in
> >> > > hw/arm/musca.c).
> >> > >
> >>
> >> What's your suggestion regarding this patch?
> >
> > Ping?
>
> Sorry, I missed this the first time around.  In retrospect, it looks like=
 we
> ended up with the wrong naming scheme for boards: sifive_e is very ambigu=
ous,
> as there are many boards that look like this.  We'd originally chosen a m=
ore
> explicit scheme (something like "sifive-fe310-g000"), but that was NAK'd =
as
> resulting in too many machine types.
>
> Peter: would you be OK deprecating "sifive_e" and adding "sifive-fe310-g0=
00"
> and "sifive-fe310-g002" targets?  We'll end up with a lot of machines thi=
s way,
> but I don't see another way to closely match what's out there.  In embedd=
ed
> land there isn't really any runtime portability, so if the memory maps do=
n't
> match exactly then it's not a useful target for users.

Just want to restart the discussion for this patch. Now that we have
"revB" support for sifive_e machine, I guess we can do something?

But renaming the sifive_e machine to something like sifive-fe31-g000
is another topic .. Thoughts?

Regards,
Bin

