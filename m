Received: from eggs.gnu.org ([2001:4830:134:3::10]:46924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcWzt-0000aF-9N
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcWzo-00046d-Lz
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:14:05 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dcWzo-00046Q-C1
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:14:00 -0400
Received: by mail-wm0-x242.google.com with SMTP id y206so2976079wmd.5
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 06:14:00 -0700 (PDT)
Date: Tue, 1 Aug 2017 14:13:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170801131356.GB22017@stefanha-x1.localdomain>
References: <20170726112633.GE18489@stefanha-x1.localdomain>
	<CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
	<CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
	<20170728135241.GP31495@redhat.com> <87pockles6.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <87pockles6.fsf@frigg.lan>
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
To: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 07:14:33PM +0300, Llu=EDs Vilanova wrote:
> Daniel P Berrange writes:
>=20
> > On Fri, Jul 28, 2017 at 02:34:30PM +0100, Stefan Hajnoczi wrote:
> >> On Thu, Jul 27, 2017 at 04:45:35PM +0100, Daniel P. Berrange wrote:
> >> > On Thu, Jul 27, 2017 at 04:33:01PM +0100, Peter Maydell wrote:
> >> > > On 27 July 2017 at 16:21, Daniel P. Berrange <berrange@redhat.com>=
 wrote:
> >> > > > On Thu, Jul 27, 2017 at 11:54:29AM +0100, Peter Maydell wrote:
> >> > > >> That said, yes, I was going to ask if we could do this via
> >> > > >> leveraging the tracepoint infrastructure and whatever scripting
> >> > > >> facilities it provides. Are there any good worked examples of
> >> > > >> this sort of thing? Can you do it as an ordinary non-root user?
> >> > > >
> >> > > > Do you have a particular thing you'd like to see an example of ?
> >> > > >
> >> > > > To dynamically probe a function which doesn't have a tracepoint
> >> > > > defined you can do:
> >> > > >
> >> > > > probe process("/usr/bin/qemu-x86_64").function("helper_syscall")=
 {
> >> > > >   printf("syscall stasrt\n")
> >> > > > }
> >> > > >
> >> > > > but getting access to the function args is not as easy as with
> >> > > > pre-defined tracepoints.
> >> > >=20
> >> > > How do I go about actually running that script? What I
> >> > > have in mind by "worked example" is something like a blog
> >> > > post that says "ok, here's a problem, we want to find out
> >> > > what QEMU is doing in situation X, here's how you do this
> >> > > with $TRACING_THINGY" and generally steps you through how
> >> > > it works assuming you know nothing at all about whatever
> >> > > the tracing facility you're using is.
> >> >=20
> >> > Ok, so something like this example that I wrote for libvirt a
> >> > while back then
> >> >=20
> >> >   https://www.berrange.com/posts/2011/11/30/watching-the-libvirt-rpc=
-protocol-using-systemtap/
> >> >=20
> >> >=20
> >> > > > You can't typically run this as root,
> >> > >=20
> >> > > Do you mean "non-root" ?
> >> >=20
> >> > Sigh, yes, of course.
> >> >=20
> >> > > > however, I don't think that's a
> >> > > > huge issue, because most QEMU deployments are not running as you=
r own
> >> > > > user account anyway, so you can't directly interact with them no
> >> > > > matter what.
> >> > >=20
> >> > > It is important, because almost all uses of TCG QEMU are
> >> > > running it from the command line as non-root normal users,
> >> > > especially if they're trying to debug what's going on with a
> >> > > guest binary. So any tracing solution for this kind of usecase
> >> > > must work without requiring root access, I think.
> >> >=20
> >> > None of the Linux integrated tracing tools allow direct non-root acc=
ess
> >> > afaik. systemtap has ability to launch probes as non-root, via a pri=
vileged
> >> > daemon, but it is restricted to probe scripts that the administrator=
 has
> >> > pre-defined.
> >>=20
> >> One exception is gdb's static userspace probes support.  If you can run
> >> gdb on QEMU then you can trace the same events as SystemTap.  I have
> >> never tried this GDB feature:
> >>=20
> >> https://sourceware.org/gdb/onlinedocs/gdb/Static-Probe-Points.html
> >>=20
> >> It should work out of the box if your distro builds QEMU with the
> >> 'dtrace' backend enabled.
>=20
> > Wow, that's great to learn about. It does indeed work !
>=20
> > If you knew alot about ptrace() you could probably build something
> > that use ptrace() and these probe points to call your dynamic
> > instrumentation code with reasonable low overheads.
>=20
> I don't think so. Ptrace traps into the kernel and stops the process whil=
e a
> separate process decides what to do. That's between 3 and 4 orders of mag=
nitude
> slower than calling an instrumentor function.

Dan might be referring to dynamic patching a jump to the instrumentation
function.

A static userspace probe is a single nop instruction (plus metadata
stored in a separate ELF section).  Using ptrace you can binary patch
the nop instruction.

Unfortunately a single nop instruction cannot hold most x86
instructions.  uprobes places a breakpoint instruction (INT $3 - 0xcc)
there.  That works because it's just one byte.

This technique would be way out of scope for qemu.git but perhaps
perf(1) or a stand-alone tool could implement it.  There are libraries
for binary patching like http://www.dyninst.org/dyninst.

Stefan

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgH6UAAoJEJykq7OBq3PIaZEIAMWcCXgO1aQh7ofuLwaUMDyE
BuUz0bK44gDRX4LLiqf/tFot34+pWldI3rMYa7Hr3308G6IhASzoPxGe95fdYgrc
bgRKz76+lA3Lm1YNDF3CY1YZTZJuKhmcDlEnWHlG2jQ4psIG7yb5qGZi3V2m4xpe
U9gNR4Zn2A3gW1InPVikA8yTxKQ/gSOYJDgoosENC66Xo9PL4K8I3/63iaUH1c+U
KwEnBY9TAQQ1zOT3oVfNhDuFYOw8BWmsgALrpwU+X5G3bxLvUAFYvkRhtHGhJppZ
9D42t6kzc1J/KkURptUgivk+tj2MPT0zJwEMqaiAysXwVu/KgRrtdyRsdFJtdME=
=b4VT
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
