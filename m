Received: from eggs.gnu.org ([2001:4830:134:3::10]:45806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQu7L-0001Co-Py
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQu7H-0001rh-NO
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:34:15 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:52774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fQu7H-0001rH-FL
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:34:11 -0400
Received: by mail-wm0-x231.google.com with SMTP id p126-v6so17810594wmb.2
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 05:34:11 -0700 (PDT)
Date: Thu, 7 Jun 2018 13:34:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180607123408.GH19032@stefanha-x1.localdomain>
References: <20180602031629.3925-1-contrib@steffen-goertz.de>
	<317e07c2-b1d8-b782-9a0b-88ece8600164@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline
In-Reply-To: <317e07c2-b1d8-b782-9a0b-88ece8600164@redhat.com>
Subject: Re: [Qemu-devel] [RFC] qapi: command category to stimulate
 high-level machine devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 05:14:25PM -0500, Eric Blake wrote:
> On 06/01/2018 10:16 PM, Steffen G=F6rtz wrote:
> > From: Steffen Goertz <contrib@steffen-goertz.de>
> >=20
> > Add a new category "stimulate" to host commands that
> > act upon high-level devices associated with machines/boards.
> >=20
> > This is patch is part of an effort to add support for BBC:microbit
> > educational computer to QEMU.
> >=20
> > The microbit board, as many other microcontroller boards,
> > contains typical trivial (digital) input and output options such as but=
tons and LEDs,
> > but also more sophiscated possibilities such as analog inputs and
>=20
> s/sophiscated/sophisticated/
>=20
> > complex dedicated sensor ICs that are connected to the microbit machine
> > by means of inter-ic bus (i2c).
> > These devices interact with peripheral devices of the microcontroller
> > in use, for example with the GPIO peripheral of the used NRF51.
> >=20
> > One aim of our efforts is to create a user interface that models the
> > look and feel of the physical microbit board and lets the user interact
> > with its inputs and provide feedback on its outsputs.
>=20
> s/outsputs/outputs/
>=20
> >=20
> > For this it is necessary to transmit user inputs such as the pressing o=
f a
> > button to the machine.
> > In return, when the state of an output is changed on the machine, this
> > change needs to be reflected in the user interface.
> >=20
> > At the moment, there are only a few QMP commands that provide user inpu=
t to the
> > machine, eg. send-keys, input-button. These commands require very
> > high-level concepts, which are not really suitable for applications that
> > microcontrollers are typically used in in.
> >=20
> > This RFC is meant to start a discussion on how to provide stimuli to
> > low-complex inputs and outputs typically found in embedded
> > microcontroller applications. To the best of my knowledge, there are
> > currently no examples of how to provide such stimuli to either SoC
> > device peripheral or machine level concepts like pushbuttons and LEDs.
> >=20
> > To my understanding, the following concepts/apis are needed:
> > - QMP commands to send stimuli to machine level concepts like
> > pushbuttons
> > - Machine level devices that receive these stimuli and act as an adapter
> > to manipulate the associated SoC peripheral devices
> > - For outputs, machine level devices are needed that observe changes in
> > SoC peripherals and emit QMP events that clients can receive
> >=20
> > This patch adds a new qmp command "buttons-set-state" to update the
> > push-down state of arbitrarily identified buttons (string identifier).
>=20
> An arbitrary string has the most flexibility, but also the least
> discoverability.  Is there any way to enumerate which strings are valid,
> and/or make the button names an enum instead of an open-coded string?

The button names could defined by an enum.

Which button names are valid with a particular machine type can't be
expressed in the schema AFAIK.

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGSZAAAoJEJykq7OBq3PIrfkH/0QsjjkFSj5flBKxA9CjGv2K
EcPg8DnVQLZh6sIstRTT134OtZNuOM09o36e0d4tJKTEQSh/dbEYRv2+egRzrEGz
Pd6q2iDWZDmeHDFb/OccT1j3a9nyMPR+dDwQgdowIc1EqXJfG2OyHPaolW3+ytAg
a3B3//tmT726axcXiNDywNmtslUQxwLAcjE9VevtN2xd5JYxaEYxOPDRBqmkAruk
41gg7/cNbSGDtbwpiDdW9y/m+vgUpyoRurbCzf79G1j+fSa2/mc6lFR0eXfQtyr9
gDxI+WHPh9hOfh4mtGLB4QiaUpQG7kdnWycEPWcZYZtfLzB1iTDX1cU37hHD9xE=
=v84v
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
