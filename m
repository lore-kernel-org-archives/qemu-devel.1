Received: from eggs.gnu.org ([209.51.188.92]:42008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0Oru-0000Ol-2S
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 06:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0OqO-0001AX-SZ
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 05:59:45 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:34678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0OqN-000194-A7
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 05:59:44 -0500
Received: by mail-oi1-x236.google.com with SMTP id g16so1668970oib.1
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 02:59:42 -0800 (PST)
MIME-Version: 1.0
References: <a6548846-c64d-a815-45a5-953ccc4b7ea0@greensocs.com>
	<CAFEAcA8dM_DN9Mrep8O7XVPPis0v2XcSU3fWSHTbz2MJDqjEsg@mail.gmail.com>
	<fe389f85-a52d-e469-96de-f34663a3c5a5@greensocs.com>
	<CAFEAcA_OrJ-1SzE5UpT4eHbzi-KS_GqX13KZdHzEzovXnsnsUg@mail.gmail.com>
	<63b980a2-6b28-d5e2-891c-6245ddb1e851@redhat.com>
In-Reply-To: <63b980a2-6b28-d5e2-891c-6245ddb1e851@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Mar 2019 10:59:30 +0000
Message-ID: <CAFEAcA8L1qKaNwpr8sMZC8jQXbaLtCctaV8ecTFxXTVy0sWjVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] multi phase reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Damien Hedde <damien.hedde@greensocs.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>

On Sat, 2 Mar 2019 at 19:41, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Hi Damien,
>
> On 3/1/19 5:52 PM, Peter Maydell wrote:
> > On Fri, 1 Mar 2019 at 15:34, Damien Hedde <damien.hedde@greensocs.com> =
wrote:
> >> On 3/1/19 12:43 PM, Peter Maydell wrote:
> >>> In my design the only thing that I thought would happen in phase 3
> >>> was the "clear the resetting flag", but you've moved that to RELEASE.
> >>> What's left ? Do you have a concrete example where we'd need this?
> >>
> >> I hesitated to remove this phase (would be easy to add it after if it =
is
> >> really needed). I see 2 cases where it might be useful.
>
> If I RELEASE a PLL which need some time to warm up and stabilize, once
> stabilized it moves the device to the POST phase where it is ready?

No, I think that things like that where the device is not ready
for some period of time after reset should be handled by
the device itself. Typically we just ignore this and have
PLLs become stable instantaneously. If you really needed to
model it you'd just have a timer of some kind inside the
device model.

(This matches h/w behaviour -- a PLL which is not yet stable
is not still in reset, it's out of reset but has different
behaviour for an initial period of time before it stabilizes.)

thanks
-- PMM
