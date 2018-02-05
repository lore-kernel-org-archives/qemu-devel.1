Received: from eggs.gnu.org ([2001:4830:134:3::10]:35469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eij36-0002TW-TQ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eij31-0007lJ-Sp
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:51:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eij31-0007jC-LK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:51:11 -0500
Date: Mon, 5 Feb 2018 15:51:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180205155108.GF28241@stefanha-x1.localdomain>
References: <CAPHFV4=P3viF0m0PtqFZZ8_JNxy7G6kXdysYAfSsOJZe=2j7gw@mail.gmail.com>
	<20180202100843.GD13090@stefanha-x1.localdomain>
	<CAFEAcA-5PwhJw9epXh+0_oe3E-vsVKkQDX3s1Go-FBzO=FA3zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEueqSqTbz/jWVG1"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-5PwhJw9epXh+0_oe3E-vsVKkQDX3s1Go-FBzO=FA3zA@mail.gmail.com>
Subject: Re: [Qemu-devel] Qemu Trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nesrine Zouari <nesrine.zouari@enis.tn>, QEMU Developers <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2018 at 03:53:45PM +0000, Peter Maydell wrote:
> On 2 February 2018 at 10:08, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > On Thu, Feb 01, 2018 at 04:30:10PM +0100, Nesrine Zouari wrote:
> >> I am a computer engineering student and I am actually working on my
> >> graduation project at Lauterbach company. The project is about Qemu Tr=
ace
> >> and as a future I would like to contribute this work to the main line.
> >>
> >> My project is divided into two parts:
> >>
> >> 1/ Collecting the Guest trace data : The trace solution should be able=
 to
> >> provide:
> >>
> >>             a/ Instruction flow Trace
> >>
> >>             b/ Memory read/write access
> >>
> >>             c/ Time Stamps.
> >>
> >>             d/ For tracing rich operating systems that are using MMU, =
we
> >> additionally need to trace the task switches.
> >
> > Llu=ECs has done the most instrumentation work in qemu.git and can expl=
ain
> > the current status.
>=20
> I think at the moment the status is that we're still discussing
> what the trace plugin API should be... there are some mailing

s/trace plugin API/instrumentation plugin API/

> list threads on the subject from I think last year some time.

The point of the instrumentation plugin API is for online analysis
(stuff that cannot be post-processed offline) with the ability for the
plugin to control QEMU (e.g. affect translation during a run).  That is
not necessary for Nesrine's use case.

I see two main requirements in Nesrine's use case:

1. Instruction flow, memory access, and task switch trace.  This doesn't
exist today and requires adding new trace events.

2. An external interface for processing traces.  There seems to be a
requirement for doing it online and not by post-processing trace files.
Therefore I suggested looking into LTTng UST, which has an efficient
interface and libraries for tracing processes.  I think no QEMU changes
are necessary here.

Stefan

--DEueqSqTbz/jWVG1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaeH1sAAoJEJykq7OBq3PID/gIAIv24wugHFzT5bcdbwFLmCOW
3ioQ1Qm/0HOHSbix/bNp4ueNv1m2zhEFp5IKl7wi5FEW1OvzFOLhmXW/4gLPXDW6
K0sCnOwCfLS3DPjzGoFH9YoThoRepFt3TJH2CtrBPcHwn8BCM7hixQVb6iFy4n6M
Oj/IkcyNHnghShP+B8T6t951dAUPG5dll8U8ML4S6D5rE0GLLEyDURGD8z4rlm3G
5RpBPA/Jc9lX1ZiHvalrsSoprqZnr9NHU6zeCVnfHfrwAfIEna4lmHyiDLqaLJYl
Cgt1Q9X5VwtxfCTnptYBlxz7MfS5ZVYYqm09PSXR7tVhlawMyxWf7y2G10Ew+/k=
=Is7M
-----END PGP SIGNATURE-----

--DEueqSqTbz/jWVG1--
