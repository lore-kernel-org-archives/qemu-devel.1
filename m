Received: from eggs.gnu.org ([2001:4830:134:3::10]:40764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cnha5-0001RN-Iq
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cnha2-0002VI-EX
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:13:21 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cnha2-0002Uz-8s
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:13:18 -0400
Received: by mail-pg0-x243.google.com with SMTP id 77so22815881pgc.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 01:13:18 -0700 (PDT)
Date: Tue, 14 Mar 2017 16:13:12 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170314081312.GB13140@stefanha-x1.localdomain>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 11:02:01AM +0100, Peter Maydell wrote:
> On 12 March 2017 at 21:45, Juan Quintela <quintela@redhat.com> wrote:
> >
> >
> > Hi
> >
> > Please, send any topic that you are interested in covering.
> >
> > So far the agenda is:
> >
> > - Direction of QEMU and toolstack in light of Google Cloud blog:
> >   https://cloudplatform.googleblog.com/2017/01/7-ways-we-harden-our-KVM=
-hypervisor-at-Google-Cloud-security-in-plaintext.html
>=20
>=20
> Ah, I'd forgotten that this was on the call agenda. I actually
> had an interesting conversation with Alex Graf last week about
> some similar topics, which I guess you could generally summarize
> as "what are the issues we need to address as a project in order
> to not become irrelevant in five years time". Since I wrote them
> up for an internal "what I did on my holi^Wconference trip" report
> I might as well repost them here:
>=20
>   - on the "VM support" side, QEMU is more used because it's the only
>     production-quality option in this space, rather than because its
>     users love it. (cf the Google choice to replace it.) It's also got
>     a pretty poor security record. It wouldn't be too surprising if
>     some time in the next five years somebody writes a replacement in
>     a safer language (perhaps also targeting only the VM support role)
>     and it got enough mindshare and takeup to eclipse QEMU.
>     [Is it too early/daft to think about prototyping being able to
>      write QEMU device emulation in Rust ?]

We can move to a safer language starting with the device emulation
layer.  Keep the rest in C for now.  Use a language that has good C
interoperability or a convenient foreign function interface.

Start writing new device models in the new language.  Convert existing
devices if they are good candidates, like the e1000 NIC emulation.

The minimum requirements for the new language:
1. Does it support the host operating systems that QEMU runs on?
2. Does it support the host architectures that QEMU runs on?
3. Is it safer than C even when writing code to operate on guest RAM
   (i.e. it's no good if you must use unsafe primitives to do the
   systems programming tasks that QEMU requires)?
4. Is C interoperability convenient and high performance?

Stefan

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYx6YYAAoJEJykq7OBq3PINI8H/3NsbF4BvEKo4hWKFxWWT2dV
LGpG+gQuRA5B72/eWG/0OAfcZrFjNesyyYKgvBvmO1eAwFqhEv0PrXHID7UJvzaD
ZqcoTWS/GDS3xgZ3HDwoISCXda9M+DYTwxWgHxLv5s0mx2UjdZqV1AJz8G7ih/s5
gUDPPJZG+ksNDNNwb+Q6rP/ygYV79gzGleBVhbKP3UqcA41PuS3/2Eu8Tv69zfw3
3wfP3ja5SncNCatUh3nbO/hhN0SHiN4kj2+4Sp7me/E64Qh8VZFdgFcAbR+xKk8w
B+pJs0lq0Lz20WuDf1E0Mqb6/lgP3r6Q9ENJ3nvDVEcKIlFsw/xchUcvk/t5770=
=lyK5
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
