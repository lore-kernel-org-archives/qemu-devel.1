Received: from eggs.gnu.org ([2001:4830:134:3::10]:53546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5YVR-0005xI-Mf
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5YVN-0002o2-6v
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:42:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e5YVM-0002na-T5
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:42:33 -0400
References: <1B925CC0CD9F3341B32D442251E7E1DC391048B2@shsmsx102.ccr.corp.intel.com>
	<CAFEAcA81-ht6tTc-nwiios3pjnWjNC49gZp8RQAOdNntM3tkUw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df45c8eb-320b-8a5b-fd96-4645a436c9d0@redhat.com>
Date: Fri, 20 Oct 2017 09:42:25 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81-ht6tTc-nwiios3pjnWjNC49gZp8RQAOdNntM3tkUw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HLDTqQI59nlOE1eG8vLc1nJsmvWTPuPUT"
Subject: Re: [Qemu-devel] qemu compile error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Chen, Farrah" <farrah.chen@intel.com>
Cc: "Hu, Robert" <robert.hu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HLDTqQI59nlOE1eG8vLc1nJsmvWTPuPUT
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 "Chen, Farrah" <farrah.chen@intel.com>
Cc: "Hu, Robert" <robert.hu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <df45c8eb-320b-8a5b-fd96-4645a436c9d0@redhat.com>
Subject: Re: [Qemu-devel] qemu compile error
References: <1B925CC0CD9F3341B32D442251E7E1DC391048B2@shsmsx102.ccr.corp.intel.com>
 <CAFEAcA81-ht6tTc-nwiios3pjnWjNC49gZp8RQAOdNntM3tkUw@mail.gmail.com>
In-Reply-To: <CAFEAcA81-ht6tTc-nwiios3pjnWjNC49gZp8RQAOdNntM3tkUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 07:41 AM, Peter Maydell wrote:
> Fan: this happens because we tried to run a 'git submodule'
> command and it failed. If you edit scripts/git-submodule.sh
> to remove the "1>/dev/null 2>&1" part of the 'git submodule
> update' command line then rerun make it should print the
> error messages from git which will tell you what the
> problem is.
>=20
> (The fact you needed to say 'tsocks git clone...' on your
> original command suggests to me that the problem is that
> plain 'git submodule update' can't access the git repo.)

It is also possible to use 'git config' to set up rewrite rules; if you
can't use git to access a git:// repo, but CAN use it to access an
http[s]:// repo, then setting up:

[url "http://server-of-http-clone/..."]
	insteadof =3D git://git.qemu-project.org/

I haven't personally tried it for git (it's been a while since I've been
a machine where I had to use rewriting rules to get past inability to
access git://), but have used the trick in other projects in the past.
I'm also fairly certain we have at least a github clone of all qemu
projects involved in qemu submodules, so that you can rewrite all of
your URLs to point to the github http:// service.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HLDTqQI59nlOE1eG8vLc1nJsmvWTPuPUT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqC1EACgkQp6FrSiUn
Q2pvbQf6A74+m6NrgNPgk69D0TUkc5cWf2E/yaAKeHjcFuqqaRK1EGHqJk8WXvpp
qqnvNLyprE/rJ+U+LZvI09yZC+4oszSQ75IUJcw6YM+fTw8Knx4WeSfgzCVLuNru
RAOfqQ0IszGh8KwJ2jR3Ydu4P5LiBwko4yBncWDI7i81YI38g5VmgeR9OUw6AqRc
JMazHYF9PVpbjuO3ndB5ByKN/NCB+n8TUvxE0Y4nl340mOQ0cTfNioI4xTo9hDH/
kKvZguLQ5tyW20UwXnZGLlavUzRHUmI2JH3IEf0x2OM7RF/o1HLIkyzWWLQdyP/B
4cUB/4agJzT8nn0+owgR+skVhZ1nEQ==
=kLwP
-----END PGP SIGNATURE-----

--HLDTqQI59nlOE1eG8vLc1nJsmvWTPuPUT--
