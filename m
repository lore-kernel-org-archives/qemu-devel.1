Received: from eggs.gnu.org ([209.51.188.92]:52659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1h0kg6-0004yt-SG
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1h0kg6-0003dE-5X
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:18:34 -0500
Received: from mail-eopbgr810040.outbound.protection.outlook.com
	([40.107.81.40]:54314
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgar@xilinx.com>) id 1h0kg5-0003aU-Of
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:18:34 -0500
Date: Mon, 4 Mar 2019 11:18:19 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20190304101819.GB6010@toto>
References: <a6548846-c64d-a815-45a5-953ccc4b7ea0@greensocs.com>
	<CAFEAcA8dM_DN9Mrep8O7XVPPis0v2XcSU3fWSHTbz2MJDqjEsg@mail.gmail.com>
	<fe389f85-a52d-e469-96de-f34663a3c5a5@greensocs.com>
	<CAFEAcA_OrJ-1SzE5UpT4eHbzi-KS_GqX13KZdHzEzovXnsnsUg@mail.gmail.com>
	<63b980a2-6b28-d5e2-891c-6245ddb1e851@redhat.com>
	<CAFEAcA8L1qKaNwpr8sMZC8jQXbaLtCctaV8ecTFxXTVy0sWjVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFEAcA8L1qKaNwpr8sMZC8jQXbaLtCctaV8ecTFxXTVy0sWjVw@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC] multi phase reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Damien Hedde <damien.hedde@greensocs.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>

On Sun, Mar 03, 2019 at 10:59:30AM +0000, Peter Maydell wrote:
> On Sat, 2 Mar 2019 at 19:41, Philippe Mathieu-Daud=E9 <philmd@redhat.com>=
 wrote:
> >
> > Hi Damien,
> >
> > On 3/1/19 5:52 PM, Peter Maydell wrote:
> > > On Fri, 1 Mar 2019 at 15:34, Damien Hedde <damien.hedde@greensocs.com=
> wrote:
> > >> On 3/1/19 12:43 PM, Peter Maydell wrote:
> > >>> In my design the only thing that I thought would happen in phase 3
> > >>> was the "clear the resetting flag", but you've moved that to RELEAS=
E.
> > >>> What's left ? Do you have a concrete example where we'd need this?
> > >>
> > >> I hesitated to remove this phase (would be easy to add it after if i=
t is
> > >> really needed). I see 2 cases where it might be useful.
> >
> > If I RELEASE a PLL which need some time to warm up and stabilize, once
> > stabilized it moves the device to the POST phase where it is ready?
>=20
> No, I think that things like that where the device is not ready
> for some period of time after reset should be handled by
> the device itself. Typically we just ignore this and have
> PLLs become stable instantaneously. If you really needed to
> model it you'd just have a timer of some kind inside the
> device model.

Right, this is how we tend to model things for the Xilinx parts. We usually=
 don't care
about the delayed behaviour though.


>=20
> (This matches h/w behaviour -- a PLL which is not yet stable
> is not still in reset, it's out of reset but has different
> behaviour for an initial period of time before it stabilizes.)
>=20
> thanks
> -- PMM
