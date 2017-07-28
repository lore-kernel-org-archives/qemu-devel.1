Received: from eggs.gnu.org ([2001:4830:134:3::10]:59112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db5PZ-0005li-Gm
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db5PW-0000MT-G2
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:34:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1db5PW-0000Lh-67
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:34:34 -0400
Date: Fri, 28 Jul 2017 14:34:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170728133430.GS12364@stefanha-x1.localdomain>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<20170726112633.GE18489@stefanha-x1.localdomain>
	<CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
	<CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCKkSrrNUaKEhaIQ"
Content-Disposition: inline
In-Reply-To: <20170727154535.GY2555@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, QEMU Developers <qemu-devel@nongnu.org>


--lCKkSrrNUaKEhaIQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 04:45:35PM +0100, Daniel P. Berrange wrote:
> On Thu, Jul 27, 2017 at 04:33:01PM +0100, Peter Maydell wrote:
> > On 27 July 2017 at 16:21, Daniel P. Berrange <berrange@redhat.com> wrot=
e:
> > > On Thu, Jul 27, 2017 at 11:54:29AM +0100, Peter Maydell wrote:
> > >> That said, yes, I was going to ask if we could do this via
> > >> leveraging the tracepoint infrastructure and whatever scripting
> > >> facilities it provides. Are there any good worked examples of
> > >> this sort of thing? Can you do it as an ordinary non-root user?
> > >
> > > Do you have a particular thing you'd like to see an example of ?
> > >
> > > To dynamically probe a function which doesn't have a tracepoint
> > > defined you can do:
> > >
> > > probe process("/usr/bin/qemu-x86_64").function("helper_syscall") {
> > >   printf("syscall stasrt\n")
> > > }
> > >
> > > but getting access to the function args is not as easy as with
> > > pre-defined tracepoints.
> >=20
> > How do I go about actually running that script? What I
> > have in mind by "worked example" is something like a blog
> > post that says "ok, here's a problem, we want to find out
> > what QEMU is doing in situation X, here's how you do this
> > with $TRACING_THINGY" and generally steps you through how
> > it works assuming you know nothing at all about whatever
> > the tracing facility you're using is.
>=20
> Ok, so something like this example that I wrote for libvirt a
> while back then
>=20
>   https://www.berrange.com/posts/2011/11/30/watching-the-libvirt-rpc-prot=
ocol-using-systemtap/
>=20
>=20
> > > You can't typically run this as root,
> >=20
> > Do you mean "non-root" ?
>=20
> Sigh, yes, of course.
>=20
> > > however, I don't think that's a
> > > huge issue, because most QEMU deployments are not running as your own
> > > user account anyway, so you can't directly interact with them no
> > > matter what.
> >=20
> > It is important, because almost all uses of TCG QEMU are
> > running it from the command line as non-root normal users,
> > especially if they're trying to debug what's going on with a
> > guest binary. So any tracing solution for this kind of usecase
> > must work without requiring root access, I think.
>=20
> None of the Linux integrated tracing tools allow direct non-root access
> afaik. systemtap has ability to launch probes as non-root, via a privileg=
ed
> daemon, but it is restricted to probe scripts that the administrator has
> pre-defined.

One exception is gdb's static userspace probes support.  If you can run
gdb on QEMU then you can trace the same events as SystemTap.  I have
never tried this GDB feature:

  https://sourceware.org/gdb/onlinedocs/gdb/Static-Probe-Points.html

It should work out of the box if your distro builds QEMU with the
'dtrace' backend enabled.

> That pretty much leaves re-building QEMU, LD_PRELOADS, or something
> ptrace(), or qemu's built-in simpletrace feature, as the remaining
> options.  We have a scripts/simpletrace.py that lets you load a
> trace file into python and process it, but as written that's aimed
> as post-processing a tracefile you've previously collected.
>=20
> It would be desirable to write a more advanced simpletrace python
> module that could collect & process the trace data live, and also
> interact with the qemu monitor to change what events are enabled
> dynamically.  Basically we'd need a way for the simpletrace backend
> to output its data to a fifo, instead of creating an file on disk,
> then you could dynanically consume it.

That would be interesting, I know Alex Bennee has wrangled with large
(~10 GB?) simpletrace files and it's not a pleasant experience :).

Llu=EDs/Peter: What are the requirements for instrumentation code
interacting with the running QEMU instance?  simpletrace is
asynchronous, meaning it does not wait for anyone handle the trace event
before continuing execution, and is therefore not suitable for
SystemTap-style scripts that can interact with the program while
handling a trace event.

Stefan

--lCKkSrrNUaKEhaIQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZez1mAAoJEJykq7OBq3PIFkUH/R/Q+SNCISwT9xdevM8I+Vl5
Ivf5qnHfQ5QqJRsczNwN8rFoYs3gUNBPj3jxlE3cR+lw4oUbXBfRD/Nk8ElWNGBv
EgH5yHndZnEhug/jPxmz2hltQnajGJ2zIBM1L6YBH2hzTb+B9H40enl4QkQGdt3c
Q7IuwatFDFjvcHkNjQHhv+Ci6a/SIpGOkrzDE++B1uGMR/6eJfvmlLRAKdoDlcwN
7zueJQepRYFcqrhGQis8T113GY3Sn6OLXYlCbCGzaQ/Y+NLR0OfyeyxEFdjzcl7a
zEsij1NqBBlaaopICzDo/MRLjWQJA/Mx74KNs1OR5C2YddWdTHiQXrpK7ZztWlk=
=0XnP
-----END PGP SIGNATURE-----

--lCKkSrrNUaKEhaIQ--
