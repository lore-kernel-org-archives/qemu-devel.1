Received: from eggs.gnu.org ([2001:4830:134:3::10]:51615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daNpg-0003ZB-3A
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daNpf-0001cS-1a
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:02:40 -0400
References: <20170726140218.15904-1-eblake@redhat.com>
	<20170726140218.15904-4-eblake@redhat.com>
	<CAFEAcA9sOaN+yLbikODGN5NTaX88rSU=vTpdD_ovfPzTv=Hu9A@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <180c347b-3718-252d-e466-426cc8a06bda@redhat.com>
Date: Wed, 26 Jul 2017 10:02:19 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9sOaN+yLbikODGN5NTaX88rSU=vTpdD_ovfPzTv=Hu9A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d0UtmlpvhuQvVGSggDcqtJdpEXdikQo1Q"
Subject: Re: [Qemu-devel] [PATCH 3/3] maint: Include bug-reporting info in
 --help output.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d0UtmlpvhuQvVGSggDcqtJdpEXdikQo1Q
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <180c347b-3718-252d-e466-426cc8a06bda@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] maint: Include bug-reporting info in
 --help output.
References: <20170726140218.15904-1-eblake@redhat.com>
 <20170726140218.15904-4-eblake@redhat.com>
 <CAFEAcA9sOaN+yLbikODGN5NTaX88rSU=vTpdD_ovfPzTv=Hu9A@mail.gmail.com>
In-Reply-To: <CAFEAcA9sOaN+yLbikODGN5NTaX88rSU=vTpdD_ovfPzTv=Hu9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 09:10 AM, Peter Maydell wrote:
> On 26 July 2017 at 15:02, Eric Blake <eblake@redhat.com> wrote:
>> These days, many programs are including a bug-reporting address,
>> or better yet, a link to the project web site, at the tail of
>> their --help output.  However, we were not very consistent at
>> doing so: only qemu-nbd and qemu-qa mentioned anything, with the
>> latter pointing to an individual person instead of the project.
>>

>>
>> +/* Bug reporting information for --help arguments, About dialogs, etc=
 */
>> +#define QEMU_BUGREPORTS \
>> +    "See <http://qemu.org/contribute/report-a-bug> for bug reports.\n=
" \
>> +    "More information on the qemu project at <http://qemu.org>"
>=20
> QEMU should be all upper case.

Will fix.  While at it, it looks weird that one sentence ends in '.' but
not the other; I omitted it on the second on the chance that it might
interfere with terminals that are able to auto-click the link, but in
testing, at least Gnome's terminal manages just fine thanks to the <>
bracketing.

>=20
>> +
>=20
> I wonder if we may regret the embedded newline when
> we come to handling UI about dialogs. I guess we
> can cross that bridge when we come to it (they
> may need to special case it anyway if they want
> to make the links clicky).

ui/cocoa.m appears to be the only UI expression version information in a
GUI (which I have no way to test); the GTK window that I get for
'./x86_64-softmmu/qemu-system-x86_64' didn't have anything in its
menubar.  Perhaps it should, but I'm not a gui guy, so I'll leave that
patch for someone with more experience.

Also, I hit this warning:

$ ./x86_64-softmmu/qemu-system-x86_64

(qemu-system-x86_64:19518): Gtk-WARNING **: Allocating size to
GtkScrollbar 0x556c628be340 without calling
gtk_widget_get_preferred_width/height(). How does the code know the size
to allocate?

(qemu-system-x86_64:19518): Gtk-WARNING **: gtk_widget_size_allocate():
attempt to allocate widget with width -426186808 and height 400

I have no idea where it's coming from (that is, whether it is a bug in
the gtk stack of Fedora 26, or whether it is the fault of qemu itself
misusing the preferred dance of gtk calls), but again that's something
that I would rather leave to a programmer more familiar with gui issues
(you can tell I usually test './x86_64-softmmu/qemu-system-x86_64
-nodefaults --nographic -qmp stdio')

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--d0UtmlpvhuQvVGSggDcqtJdpEXdikQo1Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4rvsACgkQp6FrSiUn
Q2rlEwf+LEatuEhUx+ZhafTv/ze/m+LKJj7LrQ05kgzEnhAhh9cTXzz3sxopKgFn
pdqDB+/zYYe8yEYIdxjSE6pmaPwzSQvv4f/n53yVACgtMsLQS/wyPQWAkyD3WyhF
WH9jhdUJMGfJA/jNZ+i4jNjfJPngqbL/kaSO006+uxXWWUeLW+hgE9NFnOXntUcw
ERlz6ksETcih30lLF1Un6FsXUSj1lLglbXAgq0dd5wHuHA24jnfzukwzcMO26vVq
fKRptTlZNOXz0tD1x5hU8ahawUHFxNoe9A9iN01nivst/j9BD3WnwBUP798PWQek
TAFhtXuaqwnNxo5oueyJcu6TIsTysA==
=rRah
-----END PGP SIGNATURE-----

--d0UtmlpvhuQvVGSggDcqtJdpEXdikQo1Q--
