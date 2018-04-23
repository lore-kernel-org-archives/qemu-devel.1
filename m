Received: from eggs.gnu.org ([2001:4830:134:3::10]:57737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAP79-0001tM-6j
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 20:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAP74-00028z-Sj
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 20:13:51 -0400
Received: from ozlabs.org ([203.11.71.1]:39277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fAP73-00026V-NQ
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 20:13:46 -0400
Date: Mon, 23 Apr 2018 10:10:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180423001010.GA19804@umbus.fritz.box>
References: <20180417224054.26363-1-lersek@redhat.com>
	<87po2wzysh.fsf@dusky.pond.sub.org>
	<8a52bb49-4194-3b91-8b67-a0e5700fd6ed@redhat.com>
	<87in8nvdpn.fsf@dusky.pond.sub.org>
	<20180419075629.GC10259@redhat.com>
	<5ed8b01f-7faa-b23d-5fd2-f4715294e061@redhat.com>
	<20180419091201.GI10259@redhat.com>
	<a9006770-b4e3-cf57-3efa-c967740f7a94@redhat.com>
	<20180420093457.GE21035@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20180420093457.GE21035@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, libvir-list@redhat.com, Michal Privoznik <mprivozn@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <dgibson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 10:34:57AM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Apr 20, 2018 at 10:11:08AM +0200, Laszlo Ersek wrote:
> > On 04/19/18 11:12, Daniel P. Berrang=E9 wrote:
> > > On Thu, Apr 19, 2018 at 10:39:32AM +0200, Laszlo Ersek wrote:
> > >> On 04/19/18 09:56, Daniel P. Berrang=E9 wrote:
> > >>> On Thu, Apr 19, 2018 at 09:48:36AM +0200, Markus Armbruster wrote:
> > >>>> Laszlo Ersek <lersek@redhat.com> writes:
> > >>>>
> > >>>>> On 04/18/18 10:47, Markus Armbruster wrote:
> > >>>>>> Laszlo Ersek <lersek@redhat.com> writes:
> > >>>> Replacing CpuInfoArch by such an enum will change the discriminator
> > >>>> value from "other" to the real architecture, with the obvious
> > >>>> compatibility concerns.  But we've accepted similar changes twice
> > >>>> already: commit 9d0306dfdfb and commit 25fa194b7b1, both v2.12.0-r=
c0.
> > >>>>
> > >>>> "other" was a bad idea.  Hindsight 20/20.
> > >>>>
> > >>>> Getting rid of it in one go rather than piecemeal seems like the l=
east
> > >>>> bad way out.  Too late for 2.12, though.  Eric, what do you think?
> > >>>
> > >>> Given the context in which this "other" value is used, I think it is
> > >>> reasonable to kill it and put a full arch list in there.
> > >>>
> > >>> No app is likely to be accessing the struct under "other" because it
> > >>> is just an empty placeholder.
> > >>
> > >> Commit 9d0306dfdfb added "s390" and "CpuInfoS390", which I guess had=
 the
> > >> potential to confuse QMP clients that didn't expect "s390", but
> > >> otherwise it didn't mess with preexistent enum values / structures.
> > >=20
> > > NB, qemu-system-s390x would previously have returned "other" in
> > > this field, and now it returns "s390".  So while it didn't
> > > remove "other" from the list of things that could potentially
> > > exist, it did change what the s390x binary will actually report.
> > >=20
> > >> The same applies to commit 25fa194b7b1, just with "riscv" /
> > >> "CpuInfoRISCV" substituted.
> > >>
> > >> Removing "other" might confuse QMP clients that expect it, except
> > >> (according to Daniel) no such client exists, probably.
> > >=20
> > > When I say removing "other", I imply that we add an explicit arch
> > > for all those which we currently are missing. IOW, all qemu-system-XXX
> > > binaries which currently report "other" would change to report their
> > > respective "XXX" values.
> > >=20
> > > So in this way, it is exactly the same as what we did when we
> > > introduced "s390" as an option.
> > >=20
> > > The only difference is that once we have every binary reporting the
> > > correct arch, we can now also remove "other" from the schema itself
> > > as it will then be unused.
> >=20
> > Can we please translate this into more actionable items for me, because
> > I'm getting confused :)
> >=20
> > First, if I add "i386" and "x86_64" to the enum list, we'll have all
> > three of "i386", "x86_64" and "x86". Is that useful? How will that work?
>=20
> Hmm, yes, on closer look this is a big mess as it is. We've been using
> generic terms for covering multiple architectures :-(  'x86' for both
> i386 and x86_64,  'sparc' for sparc and sparc64, etc. If we try to fix
> that we'll be entering a world of backcompat hurt :-(
>=20
> Since your schema is likely to end up just being a file in docs/specs,
> rather than directly part of our existnig qapi schema, I suggest we just
> ignore whats there. Just define an arch enum in your spec which is right,
> and let someone else worry about fixing the mess

Trouble is, for these "biarch" cases, I'm not sure it's always clear
what the right value for a firmware is.  While whether a userspace
binary is i386 or x86_64 is clear and well-defined, a firmware could
well be responsible for switching the CPU from its reset mode into the
more modern 64-bit mode, and would therefore have at least some code
in both archs.

> > Second, assuming I add constants for the ~10 (?) softmmu arches, can I
> > still use @CpuInfoOther as the type for the corresponding new members in
> > @CpuInfo? What C code changes will be necessary?
>=20
> Yes, we could still use the CpuInfoOther struct, since struct names are
> invisible to consumers, but as above, lets ignore the mess
>=20
> Regards,
> Daniel

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrdJGAACgkQbDjKyiDZ
s5J0shAArRT3IlJFVlu7iAE8poIcnyNg6hR+HtTFVejZz5yifD3BPMWaSoe/zjXK
zSSXVSh14++mmzoAYTY8spGlbjsa4XQf86f/N7BKSfLD60i62+Krwva0Eli9UPuA
46373rIWbRjBJxGpEv6SgDOCCFd1JDxDkSaOtvBBUFacIC5YTjG+taTFmh+WYfQj
AqBglMD63HDlhEbaL332wInfg7cDjh8mI4fSX+FVwTOEeNqFm6LxctWFaQTYiftt
/SysgkNwmdJSCRhOQsBH1e4jIB+XnwHLhlMbbWPmfmuqxWABhIO2+qanlL4CypzZ
MsJyvPe1QJpYrTa0x8/r0Ht/8AnhaAtjIcoEBYsr98qpJ7vBJEAPm65iBiwJsmtt
IKWvg+Q1AYkQGdh8RdRgweXxr8tu9SGa2Y1/VZheUrHH2oZA327BHySfV3K+ZEXC
+5beKD90xqv/zJbfhjEkpH1bTxwVThcuBNK1Sfa3Iunt67SgdEU+BI6Wvo9a5NGZ
BsEV8lLOkoH360wezDZuVYjNIcflBRb5TCx/HS1mQp9912wN9dzcnphEqTEAvv+3
ZFKmuql4A0gWfSjZKnafbj9F30kPGYC7gIJ5nQfJsKouj6CYglo7mAHMLMcRAri6
wWq4gTtmMiFLf0EyRbOK8wpvdlz8jisG4T7KDyORru/COfKOo0s=
=LINM
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
