Received: from eggs.gnu.org ([2001:4830:134:3::10]:53096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnTW7-0002zH-E8
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 13:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnTW4-0007Ey-6t
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 13:12:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnTW3-0007EO-UJ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 13:12:16 -0400
References: <20170313165927.19961-1-git@kirschju.re>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fe605e60-1a67-bedd-753f-aea0617de778@redhat.com>
Date: Mon, 13 Mar 2017 12:12:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170313165927.19961-1-git@kirschju.re>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lp2FLdVeQqpborSr9vNWuJLR5iUFjUEwW"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] X86/HMP: Expose x86 model specific
 registers via human monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Kirsch <git@kirschju.re>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lp2FLdVeQqpborSr9vNWuJLR5iUFjUEwW
From: Eric Blake <eblake@redhat.com>
To: Julian Kirsch <git@kirschju.re>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <fe605e60-1a67-bedd-753f-aea0617de778@redhat.com>
Subject: Re: [PATCH v2 0/2] X86/HMP: Expose x86 model specific registers via
 human monitor
References: <20170313165927.19961-1-git@kirschju.re>
In-Reply-To: <20170313165927.19961-1-git@kirschju.re>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 11:59 AM, Julian Kirsch wrote:
> Provide read/write access to x86 model specific registers (MSRs) by mea=
ns of
> two new HMP commands "msr-get" and "msr-set". The rationale behind this=

> is to improve introspection capabilities for system virtualization mode=
=2E
> For instance, many modern x86-64 operating systems maintain access to i=
nternal
> data structures via the MSR_GSBASE/MSR_KERNELGSBASE MSRs. Giving
> introspection utilities (such as a remotely attached gdb) a way of
> accessing these registers improves analysis results drastically.
>=20
> Changes v1 -> v2:
> * Rename HMP commands to "msr-get" and "msr-set"

Most HMP commands still use '_'; it is only QMP where we insist on '-'
in new interfaces.  (And yes, there's not much rhyme or reason to that
other than backwards consistency.)

> * HMP commands Operate on the current default CPU only
>   (removes need for cpu_index argument)
> * Remove QMP command alltogether
> * Implement HMP command in target/i386/monitor.c
> * Add #ifdef TARGET_I386 around msr-get/msr-set in hmp-commands.hx
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Lp2FLdVeQqpborSr9vNWuJLR5iUFjUEwW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxtLtAAoJEKeha0olJ0NqgXkH/3D8nexMFYfwVIKW0GgersE0
EohJ+qu00xWOCbPJF57XCjBT8Pn85F0761PDAxGwm7f0OZQUuVn1auC/RZE9eiiG
ORgta6jzcXmSHvQ9lDFaeFqp0yq//dUDxNE+jNi6HdlRKjI7gFjkd2/QAFLo4NZB
Io1Tc8se5AhoUKhVNU6qcjoc7+bAc7GxLhGpYPkLNCmNrWn8Is1Iqh55I+JEXO2p
CsnPXmGk14Bx/Sdf4ZFL2SBsz4dFv0M/0VBhNFtTUYPtlP6/8Bgoahhl5lv4l6yY
bG2vPLIHgJfXemv/sSUMDqnJ7T3fP0LJT4UNCI3zP2hEq9c2RjMacJ64ikVEXAs=
=09qW
-----END PGP SIGNATURE-----

--Lp2FLdVeQqpborSr9vNWuJLR5iUFjUEwW--
