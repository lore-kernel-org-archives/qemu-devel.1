Received: from eggs.gnu.org ([2001:4830:134:3::10]:60541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9VuN-0006aj-Vy
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9VuM-0002HA-QP
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:16:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9VuM-0002EI-IW
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:16:58 -0400
References: <20180419223151.623174-1-eblake@redhat.com>
	<20180419223151.623174-3-eblake@redhat.com>
	<87d0yu1dj1.fsf@dusky.pond.sub.org> <20180420092700.GC2533@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fcc5f711-8a54-f7e2-c381-1a9adb4fcd38@redhat.com>
Date: Fri, 20 Apr 2018 08:16:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180420092700.GC2533@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xdfejXaCA8aetavxt9Y6DUSGT4smUn44o"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: Rename .json to .qapi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xdfejXaCA8aetavxt9Y6DUSGT4smUn44o
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fcc5f711-8a54-f7e2-c381-1a9adb4fcd38@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: Rename .json to .qapi
References: <20180419223151.623174-1-eblake@redhat.com>
 <20180419223151.623174-3-eblake@redhat.com>
 <87d0yu1dj1.fsf@dusky.pond.sub.org> <20180420092700.GC2533@work-vm>
In-Reply-To: <20180420092700.GC2533@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2018 04:27 AM, Dr. David Alan Gilbert wrote:
> * Markus Armbruster (armbru@redhat.com) wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> Our QAPI input files aren't quite true JSON (comments being one obvio=
us
>>> difference); naming things .json doesn't make that obvious.  Use a ne=
w
>>> suffix .qapi that makes it easy to identify our files.
>>
>> I agree that .json is sub-optimal.  Evidence: we add Emacs file
>> variables to get Python mode, because that's less wrong than JavaScrip=
t
>> mode.  Except for "trivial" files, where we can't be bothered.
>>
>> The rename lessens the human confusion, but increases the Editor
>> confusion somewhat: we get Fundamental mode for "trivial" files, which=

>> is more wrong than JavaScript mode.
>>
>> One way to avoid that would be adding file variables to all files.
>=20
> That depends on your editor;  this rename makes life **much** better
> in vim;   with them as .json files they display with white text on
> bright red background (I guess because it's upset by syntax somewhere)
> but as .qapi files it's readable (I'm not entirely sure which syntax
> it's using)

It's also possible to document that emacs users can add to their .emacs
file:

(add-to-list 'auto-mode-alist '("\\.qapi\\'" . python-mode))

to automatically treat all .qapi files with sane highlighting.  Sadly,
=2Edir-locals.el cannot do this without warning the users about an unsafe=

'eval' variable, so users that don't do their own manual setup are stuck
with fundamental mode on trivial files.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xdfejXaCA8aetavxt9Y6DUSGT4smUn44o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrZ6EgACgkQp6FrSiUn
Q2oSIAgAhdmK1rJ9cP9a8Ed+IsV4vb8RiJBuU6TRe8GKivsZ4XhYyD/L94w16wYw
JUAKb1tKeFfJNuKsIt9DG4G0QWXjPdSF5Siuw2SRqJ5pEco1uRqFoi5aN0Lg5dM9
OoKu/dVM0IcQS2vQiIaQZEKOjskhNZIUkPYrEqkglnhr5kUQturrYHJFMynAYNRb
tPbVI3NStrtPbwXOiJnnxaXCEADTCwX1hFWgYVgt0A4kpCBad+tjKPjiJUbwrdvy
S9LulYpi0Kl9wgAfiVMfosgtom9saPlDVnzHSBTthiI5279BdSHOAtFRU1MM7atR
PbTXksCv/xhsMtOg1WeqzXKB1BU/lw==
=5RVM
-----END PGP SIGNATURE-----

--xdfejXaCA8aetavxt9Y6DUSGT4smUn44o--
