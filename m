Received: from eggs.gnu.org ([2001:4830:134:3::10]:50219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLQp-0002ib-Q9
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLQm-0007NP-D1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:28:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daLQm-0007MT-4I
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:28:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DBDA63144
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:28:47 +0000 (UTC)
References: <20170726114437.19624-1-pbonzini@redhat.com>
	<9e187829-fc01-8140-22f0-7cf67fc294bd@redhat.com>
	<20170726121913.GJ7620@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0faa2a79-fd07-f4e3-9237-563e9e8d277d@redhat.com>
Date: Wed, 26 Jul 2017 07:28:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170726121913.GJ7620@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mUNmwx2HwM7qE43ok5O5Nvbdq2EqrxgrE"
Subject: Re: [Qemu-devel] [qemu-web PATCH] add Thomas's bug reporting dos
 and don'ts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mUNmwx2HwM7qE43ok5O5Nvbdq2EqrxgrE
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0faa2a79-fd07-f4e3-9237-563e9e8d277d@redhat.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] add Thomas's bug reporting dos and
 don'ts
References: <20170726114437.19624-1-pbonzini@redhat.com>
 <9e187829-fc01-8140-22f0-7cf67fc294bd@redhat.com>
 <20170726121913.GJ7620@redhat.com>
In-Reply-To: <20170726121913.GJ7620@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 07:19 AM, Daniel P. Berrange wrote:
> On Wed, Jul 26, 2017 at 01:57:35PM +0200, Thomas Huth wrote:
>> On 26.07.2017 13:44, Paolo Bonzini wrote:
>>> We don't want the page to become too long, but these are good suggest=
ions.
>>>
>>> Also tone down the sentence about using the latest release or latest =
git
>>> tree, though we do prefer those.
>>
>> Well, sometimes people still report bugs against QEMU 2.1 or so ... so=

>> I'd say everything that is older than the current version - 2 has a ve=
ry
>> high chance to be ignored completely. So maybe we should ask people to=

>> use at least one of the versions that is mentioned on the front-page o=
f
>> www.qemu.org ?
>=20
> The biggest reason people would be using old versions of QEMU is if the=
y
> are running a distro's build. Such people should really file bugs in
> their vendor's bug tracker, rather than against upstream directly.
>=20
> IOW, it would be worth having a bit of text on the bug reporting page
> to suggest people should preferrentially use their vendor's bug tracker=
,
> if they are using a 3rd party build of QEMU.

Which was what the patch included:

> -Bugs can be filed at our [bug tracker](https://bugs.launchpad.net/qemu=
/), which is hosted on Launchpad.
> +Bugs can be filed at our [bug tracker](https://bugs.launchpad.net/qemu=
/), which is hosted on Launchpad. If you've got a problem with how your L=
inux distribution packages QEMU, use the bug tracker from your distro ins=
tead.

Although maybe the wording can be improved to mention that ALL bugs
about qemu packaged downstream, and not just the packaging, should be
referred to the downstream vendor (the vendor may then forward the bugs
upstream).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mUNmwx2HwM7qE43ok5O5Nvbdq2EqrxgrE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4ivwACgkQp6FrSiUn
Q2oBaAf/THU7qgvLkDicwXS/R/4yWJOaIX9iW3wu+e3+eJPUWbSyjt11VNv5OE0H
TKVsiotvJHMgDKpf68bUSPGRgqXjXMI1iaAuzO14RAnH0wDqYmKwabrpXei2rg+I
kAWwh4yZZEbOcMk+leJB65T7kyHhtfF9RgHRw01VhVrQbfDG7POkU74VYM4TjFNi
To53GJUEi8V+gVo5IrNKMOQ9K62jgGU0NUu1pyWaLD1sRadh7tmizcomcIwQCbSP
NZ0Vi8xYHv2JVsgFhf2c02AsoIhrc2qzSuxiuuFOGm3Low/DUzYYnRNNTibY3vV7
VA3qQBrZHNhaE5YvN/vLbbJZKgvlnw==
=Cpxf
-----END PGP SIGNATURE-----

--mUNmwx2HwM7qE43ok5O5Nvbdq2EqrxgrE--
