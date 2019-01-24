Received: from eggs.gnu.org ([209.51.188.92]:54583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmbLP-0006ZY-QZ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmbLO-0000E0-HM
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:30:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmbLO-0008OL-7Q
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:30:42 -0500
References: <20190123165310.9380-1-stefanha@redhat.com>
	<20190123175507.7nwm5gjx3ic2v5rm@steredhat>
	<20190123202717.GA11941@stefanha-x1.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eb8e14a4-20bf-31b1-9739-f2e763469c0e@redhat.com>
Date: Thu, 24 Jan 2019 10:30:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190123202717.GA11941@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Ia1V4xQQ3XHGkA6DwfEB07XMCl7mZMmKp"
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Add GSoC/Outreachy 2018
 retrospective blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@euphon.net>, airlied@redhat.com, jim@groklearning.com, qemu-devel@nongnu.org, joel@jms.id.au, Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com, kraxel@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ia1V4xQQ3XHGkA6DwfEB07XMCl7mZMmKp
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@euphon.net>,
 airlied@redhat.com, jim@groklearning.com, qemu-devel@nongnu.org,
 joel@jms.id.au, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, kraxel@redhat.com
Message-ID: <eb8e14a4-20bf-31b1-9739-f2e763469c0e@redhat.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Add GSoC/Outreachy 2018
 retrospective blog post
References: <20190123165310.9380-1-stefanha@redhat.com>
 <20190123175507.7nwm5gjx3ic2v5rm@steredhat>
 <20190123202717.GA11941@stefanha-x1.localdomain>
In-Reply-To: <20190123202717.GA11941@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2019-01-23 21:27, Stefan Hajnoczi wrote:
> On Wed, Jan 23, 2019 at 06:55:07PM +0100, Stefano Garzarella wrote:
>> On Wed, Jan 23, 2019 at 04:53:10PM +0000, Stefan Hajnoczi wrote:
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>> v2:
>>>  * Added mentor names
>>>  * Added additional details from Marc-Andr=E9 and Paolo
>>> ---
>>>  _posts/2019-01-23-internships-wrapup.md | 79 +++++++++++++++++++++++=
++
>>>  1 file changed, 79 insertions(+)
>>>  create mode 100644 _posts/2019-01-23-internships-wrapup.md
>>>
>>> diff --git a/_posts/2019-01-23-internships-wrapup.md b/_posts/2019-01=
-23-internships-wrapup.md
>>> new file mode 100644
>>> index 0000000..fefcc2a
>>> --- /dev/null
>>> +++ b/_posts/2019-01-23-internships-wrapup.md
>>> @@ -0,0 +1,79 @@
>>> +---
>>> +layout: post
>>> +title:  "GSoC and Outreachy 2018 retrospective"
>>> +date:   2019-01-23 07:50:00 +0100
>>> +categories: [gsoc, outreachy, internships]
>>> +---
>>> +QEMU participates in open source internship programs including Googl=
e Summer of
>>> +Code (GSoC) and Outreachy.  These full-time remote work opportunitie=
s allow
>>> +talented new developers to get involved in our community.  This post=
 highlights
>>> +what our interns achieved in 2018.
>>> +
>>> +## micro:bit board emulation
>>> +
>>> +Julia Suvorova (Outreachy) and Steffen G=F6rtz (GSoC) tackled adding=
 emulation
>>> +support for the [micro:bit ARM board](https://microbit.org/).  Altho=
ugh QEMU
>>> +already has plenty of ARM emulation code, the Cortex-M0 CPU used in =
the
>>> +micro:bit was not yet implemented and the nRF51 system-on-chip was a=
lso
>>> +missing.
>>> +
>>> +The goal of this project was to run micro:bit programs (usually crea=
ted with
>>> +the [MicroPython](https://python.microbit.org/v/1.1) or
>>> +[Javascript/Blocks](https://makecode.microbit.org/) IDEs) with a cor=
e set of
>>> +emulated devices, including the serial port, pushbuttons, and LEDs.
>>> +
>>> +QEMU 3.1 already shipped the groundwork for the new `qemu-system-arm=
 -M
>>> +microbit` machine type.  Enough functionality to run basic micro:bit=
 programs
>>> +is expected in the next QEMU release.
>>> +
>>> +This project was mentored by Jim Mussared, Joel Stanley, and Stefan =
Hajnoczi.
>>> +
>>> +## Patchew REST API improvements
>>> +
>>> +Shubham Jain (GSoC) created a REST API for the Patchew continuous in=
tegration
>>> +system that is at the heart of QEMU's development process.  The prev=
ious API
>>> +was not RESTful and exposed database schema internals.
>>> +
>>> +The improvements to the REST API have been included into Patchew and=
 are
>>> +deployed on <a href=3D"https://patchew.org/">patchew.org</a>.  They =
are not in
>>> +use yet, pending more work on authentication; this may be the topic =
of a future
>>> +Summer of Code internship.
>>> +
>>> +This project was mentored by Paolo Bonzini and Fam Zheng.
>>> +
>>> +## Qtest Driver Framework
>>> +
>>> +Emanuele Esposito (GSoC) enhanced QEMU's test infrastructure with an=
 engine
>>> +that starts tests with all variants of devices that they are capable=
 of
>>> +driving.
>>> +
>>> +This is a complicated task in QEMU since certain devices and busses =
are
>>> +available in an architecture-specific way on each emulation target, =
making it
>>> +hard to write test cases without lots of hardcoded dependencies - an=
d to keep
>>> +them up-to-date!
>>> +
>>> +The qgraph framework that Emanuele created eliminates the need to ha=
rdcode each
>>> +variant into the test.  Emanuele also converted several existing tes=
ts.  His
>>> +framework was also <a
>>> +href=3D"https://www.youtube.com/watch?v=3DN8Go4NEw0Ss">presented at =
KVM Forum 2019
>>
>> s/2019/2018
>=20
> Thanks!
>=20
> Thomas: Please s/KVM Forum 2019/KVM Forum 2018/ when merging.

Fixed and pushed:
https://www.qemu.org/2019/01/23/internships-wrapup/

 Thanks!
  Thomas




--Ia1V4xQQ3XHGkA6DwfEB07XMCl7mZMmKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcSYWfAAoJEC7Z13T+cC21ZVkP/3R8Yi+y+ZQDl+bY51JBu53A
vRVvkPbbjt4w32Rx0/HXGXVh2iORVKRn2Y1Ov08T2ZZAuQTjecXmqWByoZGz10fY
88D5q4seVHbMhX+85BuxgDZ6fHdZ32CBz34hDpv0jBXrmMTu4Huni9RLEWnT7+Pb
1lvIgGIj4XSQvh/qWW0CCTj4sFJa09nwvPr1ZvHb+NX4AAn8c1NlMEDTgsq0BZaA
NlCFVa6oKuj0HXHjUFETN9DbknNsblzgzd2TtI8cTz5tZBowTYI+m23PkmnG6xcR
wwMjPOVo7sazMjkdlCYqjp90PjUH5h/dpbbPx74aFlHGHsK8yPY0hNIW1sXXg0us
4sEbLdfvkkOJPC4YYr78ZExbbAhzHC5cjysM33zRXUfkS5zEjX2PneDZ9fUGNKY5
WPZaxVOBRSzn6sidbxKNUDxKpT2bJDo3Pg7FOc1+lsajbr1rb+tKNraq1eNeCVvS
ArS9npQa8SpU8PX0J2dgOVsz8Pht5QPR/tGoflo/pz4aqFFi7E5Pu22Q7fIwBETJ
U8aoDOpFS4LIsF6E6IUpFLUNYadtqNhhRamF1ivny0AnGExcCOPgiuwWCpNHKPlp
SL9pMzf0JfBvdlc1wVWCSR7hNE3jHvWj5rFsXAC7t8+nKXTSRqOKy5utxJsVTAlf
QZpCgqLSwlNIYV0Oo/nW
=j1W/
-----END PGP SIGNATURE-----

--Ia1V4xQQ3XHGkA6DwfEB07XMCl7mZMmKp--
