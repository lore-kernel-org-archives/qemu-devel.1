Received: from eggs.gnu.org ([2001:4830:134:3::10]:40134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZzVs-0008H7-DM
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZzVp-0000xL-8v
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:41:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gZzVp-0000wp-2i
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:41:21 -0500
References: <154531078494.20640.11118060956049517137.malonedeb@wampee.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1806a1f1-b792-69b8-7e7b-c21c030adbf9@redhat.com>
Date: Thu, 20 Dec 2018 08:41:19 -0600
MIME-Version: 1.0
In-Reply-To: <154531078494.20640.11118060956049517137.malonedeb@wampee.canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1809252] [NEW] Password authentication in
 FIPS-compliant mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1809252 <1809252@bugs.launchpad.net>, qemu-devel@nongnu.org

On 12/20/18 6:59 AM, Tomasz Bara=C5=84ski wrote:
> Public bug reported:
>=20
> The documentation states, that:
>=20
> "The VNC protocol has limited support for password based authentication=
.
> (...) Password authentication is not supported when operating in FIPS
> 140-2 compliance mode as it requires the use of the DES cipher."
>=20
> Would it be possible for qemu to use a different cipher and re-enable
> password as an option in VNC console? Is there a technical reason for
> not using a stronger cipher?

The technical reason is that there are no other VNC endpoints out there=20
that support a different cipher. The VNC protocol itself declares what=20
all compliant servers/clients must use - and that spec is what makes the=20
non-FIPS-compliant requirement.  You wouldn't have to patch just qemu,=20
but every other VNC endpoint out there that you want to interoperate=20
with a patched qemu.  But it's really not worth doing that when there=20
are already better solutions available.  That is, rather than trying to=20
fix VNC, just use an alternative protocol that doesn't have a baked-in=20
authentication limitation in the first place - namely, Spice.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
