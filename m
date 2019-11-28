Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61003C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397AC21775
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397AC21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaHmo-000330-5o
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 06:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1iaHjK-0001FA-9j
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:13:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iaHfD-0004II-Eh
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:08:49 -0500
Received: from mail.ispras.ru ([83.149.199.45]:47332)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iaHfC-0004Ec-6X
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:08:47 -0500
Received: from mail.ispras.ru (localhost [127.0.0.1])
 by mail.ispras.ru (Postfix) with ESMTPSA id EDD40540022;
 Thu, 28 Nov 2019 14:08:42 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 28 Nov 2019 14:08:42 +0300
From: dovgaluk <dovgaluk@ispras.ru>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [RFC PATCH 06/10] hw/avr: Add ATmega microcontrollers
In-Reply-To: <CAL1e-=ib7h8szh48ckOk8yvF+7SQd9_hyoYU3E+K=CGy0EJkGA@mail.gmail.com>
References: <20191128015030.27543-1-f4bug@amsat.org>
 <20191128015030.27543-7-f4bug@amsat.org>
 <CAL1e-=i=1zhx3q4xzh7oPzXLWAHwtEkUVTSHKqv5yy9BBRrVKw@mail.gmail.com>
 <4ed9736f9e88d9d242a0aed10fb65aac@ispras.ru>
 <CAL1e-=ib7h8szh48ckOk8yvF+7SQd9_hyoYU3E+K=CGy0EJkGA@mail.gmail.com>
Message-ID: <90a1f5a14be4a6e225e6bf99484c4718@ispras.ru>
X-Sender: dovgaluk@ispras.ru
User-Agent: Roundcube Webmail/1.1.2
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aleksandar Markovic =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-11-28 13:20:
> On Thursday, November 28, 2019, dovgaluk <dovgaluk@ispras.ru> wrote:
>=20
>> Aleksandar Markovic =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-11-28 12:28:
>> On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9
>> <f4bug@amsat.org> wrote:
>>=20
>> Add famous ATmega MCUs:
>>=20
>> - middle range: ATmega168 and ATmega328
>> - high range: ATmega1280 and ATmega2560
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>=20
>> Philippe, hi.
>>=20
>> Thank you for the impetus you give us all.
>>=20
>> However, is this the right direction?
>>=20
>> Let's analyse some bits and pieces.
>>=20
>> Starting from the commit message, the word "famous" is used, but I
>> really don't see enumerated CPUs/MCUs are any special in Atmel
>> lineup.
>> Other than we often used the doc describing them (cited several
>> times
>> in our discussions) as our reference, but that doesn't make them
>> "famous". Ofcourse, there other docs for other Atmel CPUs/MCUs, of
>> at
>> lest equivalent significance. For example, "tiny" ones are at least
>> as
>> famous as "mega" ones.
>>=20
>> Then, you introduce the term MCU, without proper discussion with
>> others on terminology. In parlance of QEMU, ATmega168 at al. are
>> CPUs
>> (we all know and assume that that are some peripherals in it). I am
>> not against using the term MCU, but let's first sync up on that.
>>=20
>> The added terminology trouble is that MCUs, as you defined them,
>> have
>> in array atmega_mcu[] a field called "cpu_type" - why is that field
>> not called "mcu_type"? *Very* confusing for any future reader. And
>> then, similar terminology conundrum continues with macro
>> AVR_CPU_TYPE_NAME().
>=20
> MCU is a system-on-chip which includes CPU core and peripheral
> devices.
> Separating this is better that including everything into the machine.
>=20
> E.g., different MCUs may have different IO addresses for USART.
>=20
> Pavel,
>=20
> Do you know how is this resolved for other platforms?
>=20
> How other platfirms organize and use terms "soc", "mcu", "cpu",
> "core", "cpu core"? And what is the relation between each of them and
> QEMU command line options "-cpu" and "-machine"? Is thar organization
> the same accross all platforms?

Here is an ARM example:
  SoCs: hw/arm/aspeed_soc.c include/hw/arm/aspeed_soc.h
  Boards: hw/arm/aspeed.c

> (I am asking you as you most likely have much wider experience in the
> topic, sincr mine i limited to mips emulation)

As far as I know, there are MIPS SoCs too.
Doesn't QEMU emulate any of them?

>>> All of the above is far less important than this question: What
>>> are we
>>> achieving with proposed CPU/MCU definitions? I certainly see the
>>> value
>>> of fitting the complex variety of AVR CPUs/MCUs into QEMU object
>>> model. No question about that. However, is this the right moment
>>> to do
>>> it? There are still some unresolved architectural problems with
>>> peripheral definitions, as I noted in yhe comment to Michael's
>>> last
>>> cover letter. This patch does not solve them. It just assumes
>>> everything is ready with peripherals, let's build CPUs/MCUs. The
>>> machines based on proposed CPUs/MCUs are not more real that
>>> machine
>>> based on Michael's "sample" machine. At least Michal says "this is
>>> not
>>> a real machine". If we used proposed CPUs/MCUs from this patch,
>>> the
>>> resulting machine is as "paper" machine as yhe "sample" machine.
>>> We
>>> would just live in a la-la lend of thinking: "wow, we model real
>>> hardware now".
>>>=20
>>> I would rather accept into QEMU a series admitting we are still
>>> far
>>> from modelling real machine or CPU/MCU, than a series that gives
>>> an
>>> illusion that we are modelling real machine or CPU/MCU.
>>>=20
>>> As far as utility of this patch for Michael's series, it looks to
>>> me
>>> they add more headake than help (not saying that the help is not
>>> present) to Michael. He would have anotter abstraction layer to
>>> think
>>> of, at the moment he desperately needs (in my opinion) to focus on
>>> providing the as solid as possible, and as complete as possinle
>>> foundations. This patch looks like building castles in the air.
>>> Again,
>>> I am not claiming that the patch is not helpful at all.
>>>=20
>>> In summary, I think that this patch is premature.



Pavel Dovgalyuk


