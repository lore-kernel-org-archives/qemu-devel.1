Received: from eggs.gnu.org ([2001:4830:134:3::10]:49302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOP6U-0007FG-EC
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOP6T-0003LF-JS
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:58:30 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dOP6T-0003JT-Bw
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:58:29 -0400
Received: by mail-wr0-x22b.google.com with SMTP id r103so67154311wrb.0
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 06:58:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3871c989-d00e-c2fb-4e62-18624114ada4@adacore.com>
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
	<CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
	<1db78209-e426-03b5-9a19-592da96adaee@greensocs.com>
	<CAFEAcA-pmVW-fnu6ZT=PeRcSf-U5UVsyYsJkzh2c_BFKDTU5kg@mail.gmail.com>
	<d0a7ebb7-9f3d-5b3c-692e-344f4a980c05@redhat.com>
	<CAFEAcA_BkOaRCs1tm2dv+mYZj4yaNTg7VhR2C-NAQGAhw1wazA@mail.gmail.com>
	<20170615145742.GF4859@toto>
	<CAFEAcA-zhur3vO8G_CPQuyEU3p7e81cixiZ58sFs96e+av4Mbg@mail.gmail.com>
	<20170615151530.GC12347@toto>
	<CAFEAcA-ZzVGJ+ueZXLuhtkMk=42QGhpJiu5PNZ7DAGXJf3hvXA@mail.gmail.com>
	<209d2c8f-fd46-0a6f-17ac-b4f53f47c43e@adacore.com>
	<CAFEAcA9VtPd72=HW3uMvdc5xzv+zLj_KS=WDBjau563iT9UHNA@mail.gmail.com>
	<3871c989-d00e-c2fb-4e62-18624114ada4@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2017 14:58:07 +0100
Message-ID: <CAFEAcA86P19ur+MUDMEYheZziKoYmnayOcn-5LmPFRXvR=aZvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/10] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <fred.konrad@greensocs.com>

On 23 June 2017 at 14:07, KONRAD Frederic <frederic.konrad@adacore.com> wro=
te:
> Le 06/23/2017 =C3=A0 02:47 PM, Peter Maydell a =C3=A9crit :
>> Each device "owns" its output clock objects, but input
>> clocks are just pointers to the clock object owned by the
>> device at the other end. In the board you wire up CI1 to C1,
>> and CI2 to C2 (using link properties I guess).
>> Then in device C you can implement the clock switching by
>> some kind of bind(s->CI1, &s->C3) call because you have
>> pointers to all the relevant clock objects.
>>
>> As I understand it your current implementation makes not
>> just the output clocks C1 C2 C2 be clock objects, but also
>> the inputs CI1 CI2, so effectively each link from a clock
>> source to a clock sink has two objects involved.

> Yes that makes sense but you won't have the name.

I don't think that's a big deal.

> And one other thing I wanted to have is beeing able to refresh
> the clock tree without refreshing everything. If you start a
> refresh from the "pointer" and it is bind to other things you
> will refresh the other devices as well. Maybe we don't care or we
> can workaround that but..

The pointer is for your clock inputs -- when would you
want to start a refresh from that? I would expect
refreshes to only ever go downstream -- you update
the config of your clock outputs and things downstream
of them will update in turn.

thanks
-- PMM
