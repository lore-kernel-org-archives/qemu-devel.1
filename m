Received: from eggs.gnu.org ([2001:4830:134:3::10]:57833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1eCOHS-0000RW-7e
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1eCOHR-00084O-7b
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:12:26 -0500
Date: Wed, 8 Nov 2017 11:12:15 +0000
From: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20171108111215.GE8971@e103592.cambridge.arm.com>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
	<20171108103630.GB8971@e103592.cambridge.arm.com>
	<87mv3xqbig.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87mv3xqbig.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 00/10] Initial support for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

On Wed, Nov 08, 2017 at 11:02:15AM +0000, Alex Benn=E9e wrote:
>=20
> Dave Martin <Dave.Martin@arm.com> writes:
>=20
> > On Tue, Nov 07, 2017 at 03:05:48PM +0000, Alex Benn=E9e wrote:
> >> Hi,
> >>
> >> These patches apply on-top of the last clean-up series:
> >>
> >>   Subject: [RISU PATCH 0/7] Add @Group support and some aarch64.risu=
 cleanups
> >>   Date: Tue, 31 Oct 2017 14:54:37 +0000
> >>   Message-Id: <20171031145444.13766-1-alex.bennee@linaro.org>
> >>
> >> This series adds support for SVE to RISU. Most of the initial patche=
s
> >> are plumbing changes to better support arch specific option flags
> >> (cleaning up a TODO in the process). I also needed to ensure configu=
re
> >> actually honoured CPPFLAGS so it could be passed yet to be released
> >> headers.
> >
> > Should there be a getauxval(AT_HWCAP) & HWCAP_SVE check in this serie=
s
> > somewhere?
> >
> > I don't know enough about how RISU is structured to know whether/wher=
e
> > this is needed.
>=20
> That would be a saner runtime check to do but it's a balance as RISU is
> a fairly specialist tool which kind of assumes people know what they ar=
e
> doing.
>=20
> The current check is on SVE_MAGIC in the header files which does mean a
> binary compiled on an SVE headered system is now carrying about a much
> larger register dump even when run without the --test-sve flag.
>=20
> Whether it makes sense to be more flexible is a call I'll leave up to
> Peter.

Fair enough.  If there is anywhere useful to put it, it would serve as
a useful example -- but as you point out, this is not a typical piece
of userspace software...

Cheers
---Dave
