Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7516BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 03:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8F320675
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 03:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="fwE/nJ79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8F320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm7wQ-0004Yu-Fm
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 23:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1jm7va-0003qP-Ns
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 23:42:54 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1jm7vY-0000hm-FF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 23:42:54 -0400
Received: by mail-pj1-x1043.google.com with SMTP id i12so3507048pju.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 20:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=TmXn+WrPDMeidG0EK/5eV4AmYLlUduC5OfZ46f1gmqI=;
 b=fwE/nJ79zKeCorT+zA3RTmS6xRpV13aaQ04wDQ2i8onlFxfEOPBzhUN1G58eBiAk39
 v0ZGytbotCoxtnEvZyq10ou96gw6qLmTsrrFfpM0ok3ab5Ij+eRUhPlshNDsqINZrErd
 GUMt8kj7JhM2NbCTzAFL7IdD3ctLLWuZSt48ZX8HajbAAhtFvGwZ5MTCZnwsaGC2UA/e
 f5+dRv6xPK0uo0QHMDghXbImPIpL0mdDnnL2/YMLEsdvBFzSw7ho7b+lRLMCi3Tty39t
 j/mz8bnwvzEPqkLIY8xIu5ep6VHoRcZRYyjNF4ZO3zBnQ2Q9s+L2Y7vddlMgRJIn+p1v
 tfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=TmXn+WrPDMeidG0EK/5eV4AmYLlUduC5OfZ46f1gmqI=;
 b=bV16bKPNJ1rIXFqZ4kMLSlJPWnOUvHnUxuF1v8SGW0R7JfA5UeklQe5sKKf3OTPxXa
 nUoSfcomILjgLPc5Fj0lt9PB2Muc5Zay7/Z12DsAH7S4ffeSAw9Dn3odEjEF7FQP5NFF
 SlN3Onceq8fAQqNsrCXQ4nfezGVAgh3AtKit9975IyC8B70wWVM0S8dIdHhQ7MgVgRdR
 rUs9E/Fe8qebYpvaZVoyZBHFPv0w0bKoNMyT3tbKrlNxugNAgwPLzFzLPzR/MYDEI70q
 zxN1QIqNSTaaDrKEPfL4yCUBtvoevQt/9dIOdx9Cuxd+B15Uyv+TpIUxBWbWroQb+dtM
 Fy/Q==
X-Gm-Message-State: AOAM531heh0gpdsqbj7Symu/okWXdQJ9lbsv7mv7gfJuZze7qj/hwHiL
 /wHWjF8yduXimvjrzAX1nqFYaA==
X-Google-Smtp-Source: ABdhPJyNMNpcvC400/+TBTsw0TC9YAQXCVsf5APbov2gmf1VN+V1mXuIG5suEpV/N6ftCjF+6eoC7w==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr6568730pls.1.1592538170388; 
 Thu, 18 Jun 2020 20:42:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id e12sm4439337pfj.137.2020.06.18.20.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 20:42:49 -0700 (PDT)
Date: Thu, 18 Jun 2020 20:42:49 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jun 2020 20:27:50 PDT (-0700)
Subject: Re: [PATCH v1 2/2] sifive_e: Support the revB machine
In-Reply-To: <CAKmqyKMKF9QDFthRqLRQTziKNka5oJjcmYebyiR71y019AHE1g@mail.gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alistair23@gmail.com
Message-ID: <mhng-e6502870-4be9-42af-a89a-adfe5598059a@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=palmer@dabbelt.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 16:18:20 PDT (-0700), alistair23@gmail.com wrote:
> On Thu, Jun 18, 2020 at 3:42 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Wed, 10 Jun 2020 15:13:49 PDT (-0700), alistair23@gmail.com wrote:
>> > On Thu, May 28, 2020 at 11:13 AM Alistair Francis <alistair23@gmail.com> wrote:
>> >>
>> >> On Thu, May 21, 2020 at 8:57 AM Alistair Francis <alistair23@gmail.com> wrote:
>> >> >
>> >> > On Wed, May 20, 2020 at 4:08 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >> > >
>> >> > > On Thu, 14 May 2020 13:47:10 PDT (-0700), Alistair Francis wrote:
>> >> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> >> > > > ---
>> >> > > >  hw/riscv/sifive_e.c         | 35 +++++++++++++++++++++++++++++++----
>> >> > > >  include/hw/riscv/sifive_e.h |  1 +
>> >> > > >  2 files changed, 32 insertions(+), 4 deletions(-)
>> >> > > >
>> >> > > > diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
>> >> > > > index 472a98970b..cb7818341b 100644
>> >> > > > --- a/hw/riscv/sifive_e.c
>> >> > > > +++ b/hw/riscv/sifive_e.c
>> >> > > > @@ -98,10 +98,14 @@ static void riscv_sifive_e_init(MachineState *machine)
>> >> > > >          memmap[SIFIVE_E_DTIM].base, main_mem);
>> >> > > >
>> >> > > >      /* Mask ROM reset vector */
>> >> > > > -    uint32_t reset_vec[2] = {
>> >> > > > -        0x204002b7,        /* 0x1000: lui     t0,0x20400 */
>> >> > > > -        0x00028067,        /* 0x1004: jr      t0 */
>> >> > > > -    };
>> >> > > > +    uint32_t reset_vec[2];
>> >> > > > +
>> >> > > > +    if (s->revb) {
>> >> > > > +        reset_vec[0] = 0x200102b7;        /* 0x1000: lui     t0,0x20010 */
>> >> > > > +    } else {
>> >> > > > +        reset_vec[0] = 0x204002b7;        /* 0x1000: lui     t0,0x20400 */
>> >> > > > +    }
>> >> > > > +    reset_vec[1] = 0x00028067;        /* 0x1004: jr      t0 */
>> >> > > >
>> >> > > >      /* copy in the reset vector in little_endian byte order */
>> >> > > >      for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
>> >> > > > @@ -115,8 +119,31 @@ static void riscv_sifive_e_init(MachineState *machine)
>> >> > > >      }
>> >> > > >  }
>> >> > > >
>> >> > > > +static bool sifive_e_machine_get_revb(Object *obj, Error **errp)
>> >> > > > +{
>> >> > > > +    SiFiveEState *s = RISCV_E_MACHINE(obj);
>> >> > > > +
>> >> > > > +    return s->revb;
>> >> > > > +}
>> >> > > > +
>> >> > > > +static void sifive_e_machine_set_revb(Object *obj, bool value, Error **errp)
>> >> > > > +{
>> >> > > > +    SiFiveEState *s = RISCV_E_MACHINE(obj);
>> >> > > > +
>> >> > > > +    s->revb = value;
>> >> > > > +}
>> >> > > > +
>> >> > > >  static void sifive_e_machine_instance_init(Object *obj)
>> >> > > >  {
>> >> > > > +    SiFiveEState *s = RISCV_E_MACHINE(obj);
>> >> > > > +
>> >> > > > +    s->revb = false;
>> >> > > > +    object_property_add_bool(obj, "revb", sifive_e_machine_get_revb,
>> >> > > > +                             sifive_e_machine_set_revb, NULL);
>> >> > > > +    object_property_set_description(obj, "revb",
>> >> > > > +                                    "Set on to tell QEMU that it should model "
>> >> > > > +                                    "the revB HiFive1 board",
>> >> > > > +                                    NULL);
>> >> > > >  }
>> >> > > >
>> >> > > >  static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
>> >> > > > diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
>> >> > > > index 414992119e..0d3cd07fcc 100644
>> >> > > > --- a/include/hw/riscv/sifive_e.h
>> >> > > > +++ b/include/hw/riscv/sifive_e.h
>> >> > > > @@ -45,6 +45,7 @@ typedef struct SiFiveEState {
>> >> > > >
>> >> > > >      /*< public >*/
>> >> > > >      SiFiveESoCState soc;
>> >> > > > +    bool revb;
>> >> > > >  } SiFiveEState;
>> >> > > >
>> >> > > >  #define TYPE_RISCV_E_MACHINE MACHINE_TYPE_NAME("sifive_e")
>> >> > >
>> >> > > IIRC there are way more differences between the un-suffixed FE310 and the Rev
>> >> > > B, specifically the interrupt map is all different.
>> >> >
>> >> > The three IRQs that QEMU uses for the SiFive E (UART0, UART1 and GPIO)
>> >> > all seem to be the same.
>> >>
>> >> Ping!
>> >
>> > Ping^2
>> >
>> > Applying to RISC-V tree.
>>
>> They're not: uart0 is interrupt 3 on the rev b but 5 on the non-rev b (which
>> they don't call rev a but I'm going to :)).  There's isn't even a uart1 in the
>> DTS on the rev a, and the GPIO interrupts are different as well.
>>
>> The DTS files are in SiFive's SDK:
>>
>> https://github.com/sifive/freedom-e-sdk/blob/master/bsp/sifive-hifive1-revb/core.dts
>> https://github.com/sifive/freedom-e-sdk/blob/master/bsp/sifive-hifive1/core.dts
>>
>> which should also generate some test programs.  When I was there we tested on
>> QEMU for the platforms that were supported, so there should be some support for
>> doing so still.
>
> I am reading the wrong data sheets?
>
> For revB I looked at
> https://sifive.cdn.prismic.io/sifive%2F9ecbb623-7c7f-4acc-966f-9bb10ecdb62e_fe310-g002.pdf,
> page 46, table 26. The interrupts for the revB match what we currently
> have in QEMU.
>
> For revA https://sifive.cdn.prismic.io/sifive%2F500a69f8-af3a-4fd9-927f-10ca77077532_fe310-g000.pdf,
> page 42, table 21 also matches what we have in QEMU.
>
> To me it looks like both have two UARTs and both have the same
> interrupt numbers.
>
> The actual software I am running also hasn't changed UART interrupt
> numbering between the two boards and UART interrupts are working
> correctly.
>
> Alistair
>
>>
>> >
>> > Alistair
>> >
>> >>
>> >> >
>> >> > Alistair

