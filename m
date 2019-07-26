Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D34AC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 22:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E902E21994
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 22:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otnVqLyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E902E21994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr8lV-0000CF-60
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 18:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43880)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hr8lK-0008FR-Si
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 18:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hr8lI-00010A-Az
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 18:32:29 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hr8lH-0000xW-VS; Fri, 26 Jul 2019 18:32:28 -0400
Received: by mail-lj1-x241.google.com with SMTP id x25so52976368ljh.2;
 Fri, 26 Jul 2019 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wo+Ql4m4lEudmpRZuro5gQRC3J7TbqqczKCoWAJ4VBY=;
 b=otnVqLyzFixS/QzPrgxHQPDAGkcg5Eu3bT0H3DCJlgkptUQYcg6NWIV0G3P2u4dlqM
 GHiGAfIfDlcU15C3oRt+xy8Vlel/4dAOWfYjdmzQT5fDR3YrgYAcdLz7Q0Qo+zZblXfx
 XoXSl18gEE1nQsiIe93gyCQFJ9yl6VCoccs3ikrbfSk9C4dnCgWtfwrApBsnwSW4MXBi
 OKb1bu6HabgsCF+rqG4VO9bHNDXCaqRceEPUuUSkkdYZ5MzDWM6FsJf8VZkUtR/37/rP
 AgzKsvEj5bFfK3Q0IvsGsQ+uktLku30nrFx8eoXCw5tbxCwH0KHI7AMmzgVZppoK6O9i
 rjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wo+Ql4m4lEudmpRZuro5gQRC3J7TbqqczKCoWAJ4VBY=;
 b=NzWnrSJrbcC2f+Nv0u2DchY3aWaYUDUPBI8iHuVpgXWGPfJ4tzcGu/d9fIn9Hwa7wb
 ZrAc/+6aGBEmIyYODcTxODoh/5iRa6o0xJsik42BC8i8U0kSzk3nrf2NxCgO1Knv/h2e
 ZNiakkIn8rhXzd3SIhbji+ouHZ46d1A4MVW4tJOEp3Qe3F9DlmWZq00bh3SbPWs3LHFZ
 0vzCWceLbWFandgiQX4hB+RlsgTIxOnLFjnpwaRzr7H9CORijWQEzA1iJ4VD4z8t6vuo
 G8ib0KPL8ltOKgMRk2ryRkbBSUpRyAuyiBzEVghN4WxxJ8rx1aGl6+DezGBkxvWCcN5y
 we8Q==
X-Gm-Message-State: APjAAAWkEGqMQ9WaXTVuno91S/0wNkhNtYhqb4Zge27ptiIneQCU3Oqy
 ORJ3KCYJWkU0w6xCK2iuOC6lfg1+e9s/+2EgVfo=
X-Google-Smtp-Source: APXvYqw0Ap0GZalTR057QO+jnLhNk6VHkoD58npr9VNOTvJ1jQc7WjHEyZAf6XT4Vcb4KLHCNaQ1kAkxhlhpMqJM3Fc=
X-Received: by 2002:a2e:480a:: with SMTP id v10mr48764801lja.94.1564180346145; 
 Fri, 26 Jul 2019 15:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <b415f5b51e09418760b95e5c73fad5e68b97f173.1564080680.git.alistair.francis@wdc.com>
 <CANnJOVEyy7wb74eEucj5t=xonOvUFTPWuty9R+-KP0DLc+L7zQ@mail.gmail.com>
 <CAKmqyKOh-7LE5ry_RG56-TM0bqj_kckcK74W8kFLiPHrjjx7hw@mail.gmail.com>
 <CANnJOVHWmA_KcdOC4o_4Uq9vZmNR_Sdy0L0foqqr_FwJY7ULqQ@mail.gmail.com>
In-Reply-To: <CANnJOVHWmA_KcdOC4o_4Uq9vZmNR_Sdy0L0foqqr_FwJY7ULqQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jul 2019 15:28:52 -0700
Message-ID: <CAKmqyKNKLy5+q78wB-jSEcGkjrwvpS=VL_BQEGdgq-X_ZeC+eA@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH-4.2 v1 2/6] target/riscv:
 Remove strict perm checking for CSR R/W
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

On Fri, Jul 26, 2019 at 2:00 PM Jonathan Behrens <fintelia@gmail.com> wrote=
:
>
> The remaining checks are not sufficient. If you look at the bottom of csr=
.c, you'll see that for most of the M-mode CSRs the predicate is set to "an=
y" which unconditionally allows access regardless of privilege mode. The S-=
mode CSR predicates similarly only check that supervisor mode exists, but n=
ot that the processor is current running in that mode. I do agree with you =
that using the register address to determine the required privilege mode is=
 a little strange, but RISC-V is designed so that bits 8 and 9 of the CSR a=
ddress encode that information: 0=3DU-mode, 1=3DS-mode, 2=3DHS-mode, 3=3DM-=
mode.

Ah, I didn't realise that was guaranteed. I will drop this patch from
this series and update it in my Hypervisor series.

Alistair

>
> I also tested by booting RVirt with a Linux guest and found that this pat=
ch caused it to instantly crash because guest CSR accesses weren't intercep=
ted.
>
> Jonathan
>
> On Fri, Jul 26, 2019 at 4:28 PM Alistair Francis <alistair23@gmail.com> w=
rote:
>>
>> On Thu, Jul 25, 2019 at 2:48 PM Jonathan Behrens <fintelia@gmail.com> wr=
ote:
>> >
>> > Unless I'm missing something, this is the only place that QEMU checks =
the privilege level for read and writes to CSRs. The exact computation used=
 here won't work with the hypervisor extension, but we also can't just get =
rid of privilege checking entirely...
>>
>> The csr_ops struct contains a checker function, so there are still
>> some checks occurring. I haven't done negative testing on this patch,
>> but the current check doesn't seem to make any sense so it should be
>> removed. We can separately discuss adding more checks but this current
>> way base don CSR address just seems strange.
>>
>> Alistair
>>
>> >
>> > Jonathan
>> >
>> > On Thu, Jul 25, 2019 at 2:56 PM Alistair Francis <alistair.francis@wdc=
.com> wrote:
>> >>
>> >> The privledge check based on the CSR address mask 0x300 doesn't work
>> >> when using Hypervisor extensions so remove the check
>> >>
>> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> >> ---
>> >>  target/riscv/csr.c | 3 +--
>> >>  1 file changed, 1 insertion(+), 2 deletions(-)
>> >>
>> >> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> >> index e0d4586760..af3b762c8b 100644
>> >> --- a/target/riscv/csr.c
>> >> +++ b/target/riscv/csr.c
>> >> @@ -797,9 +797,8 @@ int riscv_csrrw(CPURISCVState *env, int csrno, ta=
rget_ulong *ret_value,
>> >>
>> >>      /* check privileges and return -1 if check fails */
>> >>  #if !defined(CONFIG_USER_ONLY)
>> >> -    int csr_priv =3D get_field(csrno, 0x300);
>> >>      int read_only =3D get_field(csrno, 0xC00) =3D=3D 3;
>> >> -    if ((write_mask && read_only) || (env->priv < csr_priv)) {
>> >> +    if (write_mask && read_only) {
>> >>          return -1;
>> >>      }
>> >>  #endif
>> >> --
>> >> 2.22.0
>> >>
>> >>

