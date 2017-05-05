Received: from eggs.gnu.org ([2001:4830:134:3::10]:54888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1d6fnu-000814-Ps
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1d6fnr-0001gD-Hl
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:10:02 -0400
Received: from nm41-vm3.bullet.mail.ne1.yahoo.com ([98.138.120.219]:34475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1d6fnr-0001g3-6m
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:09:59 -0400
Date: Fri, 5 May 2017 16:07:15 +0000 (UTC)
From: John Bradley <flypie@rocketmail.com>
Reply-To: John Bradley <flypie1@yahoo.com>
Message-ID: <1411476837.6183832.1494000435090@mail.yahoo.com>
In-Reply-To: <20170505150751.GD14316@stefanha-x1.localdomain>
References: <1618105799.2706822.1493821255206.ref@mail.yahoo.com>
	<1618105799.2706822.1493821255206@mail.yahoo.com>
	<20170505150751.GD14316@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Dummy Panel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, John Bradley <flypie1@yahoo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

The underlying protocol is flexible enough, though only binary at the momen=
t. I could image a situation were a device driver communicated with the emu=
lation using it or alternately an application communicated with some hardwa=
re and passed it on to the emulator. As the protocol is quite simple and op=
en it could easily be adapted, the GDummyPanel could be viewed as a separat=
e project just one of many potential clients.
Code would have to be added to each different emulation as the specifics of=
 the IO of each vary.
Here is a video of the latest version running on windows.demo may 4

 =20
| =20
|  =20
|  =20
|   |    |

   |

  |
| =20
|    | =20
demo may 4
 QEMU Emulating a Raspberry PI 2 running the QEMU IO demo from Circle low l=
evel system. Using GDummyPanel to inte...  |   |

  |

  |

=20
=C2=A0John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge H=
ill Liverpool L7 7AF=20

    On Friday, 5 May 2017, 16:07, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
=20

 On Wed, May 03, 2017 at 02:20:55PM +0000, John Bradley via Qemu-devel wrot=
e:
> Hi
> I have created a new fork on GitHub https://github.com/flypie/flypie-pi-q=
emu and an associated project https://github.com/flypie/GDummyPanel the ide=
a as well as getting the Original PI emulation working is to add some facil=
ity for simulated IO. This is a demonstration of the latest version, runnin=
g the QEMU demo from https://github.com/rsta2/circle. I took the idea from =
an implementation for the BIFFboard but only the socket number is left, the=
 commuications is all via IP. The code is only really Alpha level at the mo=
ment and needs some refing to reduce bandwidth. I could also extend the cod=
e so that the connection can be to a remote machine rather than via the loc=
al host.
>=20
> I intend to generalise the code, to work with several different boards ot=
her than the PI, could anyone suggest a board that would benefit from such =
an add on.
> Is this a worth while addon?=20
> John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge Hill =
Liverpool L7 7AF

CCing ARM maintainers (see the ./MAINTAINERS file to find the right
people to CC)

Stefan

  =20
