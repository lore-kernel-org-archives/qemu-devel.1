Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB116C43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 22:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB80E2147A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 22:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9UgrwWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB80E2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdimu-0007Ii-82
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 18:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60157)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hdilp-0006tT-TM
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 18:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hdilo-0002h6-R5
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 18:09:33 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:47077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hdilo-0002eu-Jn; Wed, 19 Jun 2019 18:09:32 -0400
Received: by mail-lj1-x241.google.com with SMTP id v24so676624ljg.13;
 Wed, 19 Jun 2019 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MKDh+n9uB7E/g/10x/dOQPcXAjCFeBAUMOPTkg4idJE=;
 b=T9UgrwWagX04BOQsxn2Wg+aZU/Uqg6prSikZYjXivojmdohxC70gMxu4EWeyatBWSm
 gWbW9xlokn1NXW33vi6kO6sn7w9xDIPShN+bory5MSg0KJGafas1sFVwx8rQOAnvyF03
 2XPsx69LFcnJiFo2jf1TiNZyzEb+yQc7RFltgpmgkKfcETlePKXb2W/qEKHfd5RVY9/h
 j2A+A9/fbYUygOhtZ6/BFO8ezTJCnMFlI7klL+iood2a8BvJTjSV2DPkVFhVnZvLs05Y
 xVdr666osdZ8bvtSVZpk3iiYZ8Ns8DWMrddz/LIAwYV/q+zj0O+IildtXy1CeNX/pQQS
 YewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MKDh+n9uB7E/g/10x/dOQPcXAjCFeBAUMOPTkg4idJE=;
 b=GALNWmC1kYs0Ec/zQYaSKgeER8rTAyMykl0+xvLxO78A/CEO4kuRKMfY6rIq2BM/mo
 bV2SZdGSl/bJ0i0FNleh6aLSA+LK6lTUFAF5zUEuP+Zl/zaazDFVpwo7XWBEhakyF7Dj
 5g58KsK3XhPY9/xM4HOnRMiTBSxI7exmCgDwZvaI/QyauaHFb1VWVw5LT43HJj35pHTn
 X9xN1mnNcp3BEwYoaWayYb432BcqVvkGFuqmD8T7mCOqIWvBcgPZt3pZEzvBYmkmHM9w
 rN8QLuZ9+bdOvPBvqkg2005Wg7utndOMy35fhtTmZd8oq6KM/bziNtMKDJj2VjNqsa3S
 N5Ug==
X-Gm-Message-State: APjAAAVNMKBorQYgAS+Ov6Pe92CKvzqcHqDQFrSS1lzHTiXiaWhzXT0V
 eEPiBk22UUzLMvQH7ssfFZCDq2H7Oz6qHnhEy68=
X-Google-Smtp-Source: APXvYqwAbO/wDhLJlunppjqdn5giHDzKwVac4oQvxUG14SplG232OOBGOOIDvNnITq4ap4J+wb2lRKk6LuaEBoprqg4=
X-Received: by 2002:a2e:5d83:: with SMTP id v3mr339846lje.196.1560982169334;
 Wed, 19 Jun 2019 15:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <99fc8fe28f2a0493f248d50d32d4b1bc649536ab.1560904640.git.alistair.francis@wdc.com>
 <CAEUhbmXKv7-r3KyDGnq8ysmyccy1tVgBDqwLcf46U96BZOiKYw@mail.gmail.com>
 <CAKmqyKMqWcx4-EhTrtLMdfLtid742=8exDNSQHmuxPf_7tHkaw@mail.gmail.com>
In-Reply-To: <CAKmqyKMqWcx4-EhTrtLMdfLtid742=8exDNSQHmuxPf_7tHkaw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Jun 2019 15:06:40 -0700
Message-ID: <CAKmqyKO_Rn1kwOsYk23EFNht6Ss6K05+1k=3Xvk=oJ-UDKsqFw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [RFC v1 3/5] hw/riscv: Extend the kernel loading
 support
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 2:01 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Wed, Jun 19, 2019 at 8:16 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Wed, Jun 19, 2019 at 8:56 AM Alistair Francis
> > <alistair.francis@wdc.com> wrote:
> > >
> > > Extend the RISC-V kernel loader to support uImage and Image files.
> > > A Linux kernel can now be booted with:
> > >
> > >     qemu-system-riscv64 -machine virt -bios fw_jump.elf -kernel Image
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  hw/riscv/boot.c | 19 ++++++++++++++-----
> > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > > index 392ca0cb2e..7f68035a3f 100644
> > > --- a/hw/riscv/boot.c
> > > +++ b/hw/riscv/boot.c
> > > @@ -67,13 +67,22 @@ target_ulong riscv_load_kernel(MachineState *machine,
> > >      uint64_t kernel_entry, kernel_high;
> > >
> > >      if (load_elf(kernel_filename, NULL, kernel_translate, machine,
> > > -                 &kernel_entry, NULL, &kernel_high,
> > > -                 0, EM_RISCV, 1, 0) < 0) {
> > > -        error_report("could not load kernel '%s'", kernel_filename);
> > > -        exit(1);
> > > +                 &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0) > 0) {
> > > +        return kernel_entry;
> > > +    }
> > > +
> > > +    if (load_uimage_as(kernel_filename, &kernel_entry, NULL, NULL,
> > > +                       kernel_translate, machine, NULL) > 0) {
> >
> > We should not set the 'kernel_translate' here for uImage.
> >
> > In fact, the whole kernel_translate() is not necessary.
>
> I have removed the kernel_translate() function. I tested loading
> uImage files though and they don't seem to work as the image is loaded
> at the wrong address.
>
> I have removed uImage loading support from this series. We can look at
> it in the future if we decide we want it.

Ah, my mistake, it looks like my uImage wasn't built correctly. I'll
keep this in.

Alistair

>
> Alistair
>
> >
> > > +        return kernel_entry;
> > > +    }
> > > +
> >
> > Regards,
> > Bin

