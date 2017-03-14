Received: from eggs.gnu.org ([2001:4830:134:3::10]:37648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cnhQo-0004nk-Hn
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cnhQl-0007Hj-Em
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:03:46 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cnhQl-0007HZ-8M
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:03:43 -0400
Received: by mail-pg0-x243.google.com with SMTP id 25so22814597pgy.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 01:03:43 -0700 (PDT)
Date: Tue, 14 Mar 2017 16:03:38 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170314080338.GA13140@stefanha-x1.localdomain>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<871su1w9jc.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <871su1w9jc.fsf@secure.mitica>
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 03:12:07PM +0100, Juan Quintela wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 12 March 2017 at 21:45, Juan Quintela <quintela@redhat.com> wrote:
> >>
> >>
> >> Hi
> >>
> >> Please, send any topic that you are interested in covering.
> >>
> >> So far the agenda is:
> >>
> >> - Direction of QEMU and toolstack in light of Google Cloud blog:
> >>   https://cloudplatform.googleblog.com/2017/01/7-ways-we-harden-our-KV=
M-hypervisor-at-Google-Cloud-security-in-plaintext.html
> >
> >
> > Ah, I'd forgotten that this was on the call agenda. I actually
> > had an interesting conversation with Alex Graf last week about
> > some similar topics, which I guess you could generally summarize
> > as "what are the issues we need to address as a project in order
> > to not become irrelevant in five years time". Since I wrote them
> > up for an internal "what I did on my holi^Wconference trip" report
> > I might as well repost them here:
> >
> >   - on the "VM support" side, QEMU is more used because it's the only
> >     production-quality option in this space, rather than because its
> >     users love it. (cf the Google choice to replace it.) It's also got
> >     a pretty poor security record.
>=20
> On a previous life, I have to work on making qemu pass Common Criteria.
> Not to be able to remove large bits of it that we were not interested
> was a mess (basically we care about kvm + a bunch of devices, but it was
> impossible to remove things like TCG).

There was a project to move the build system to Kconfig.  Today some
block drivers can be loaded at run-time instead of built into the QEMU
binary.

Actually we don't need Kconfig if we continue developing module support.
For example, if accelerators become modules then you simply don't ship
or load the TCG and qtest modules.

ISTR the next are to modularize was ui/ so that GTK, SDL, SPICE, etc can
be loaded on-demand and do not need to be included in the core QEMU
package.

Stefan

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYx6PaAAoJEJykq7OBq3PIWS8IAJEPZ8Ngk98uuZwJmNAtv6+F
8tOlYvOTzz+Kk869s6B02eKNhW8YaCZ3mO28yWjT9EbK5rFoLAPUjMlwZZp6TPh6
Y+LahExXhvHpR9mC3fxjdW54e/pCAcyJBFy5U/nPbQlv0/uEr94jfmBz7nh++kpp
d7Q0Pv+sVCLMbRwpCDIQuqgycl432dAaQ45Se6Z0O5v6Afg2f2+0rKR8DcwrChzv
3VeaxqTJNFJJUxsLhOlxYdhyPlsuZtABwlysuh77dMMGroemccAs7eq/7tk9FK2i
uRgv9l7l5WiC8PZ7zVJowLRPJPUUWc0ox/+IcNoVqXaqhvINETV0Rv4vQK+NjdY=
=bk3C
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
