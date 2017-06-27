Received: from eggs.gnu.org ([2001:4830:134:3::10]:55491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPwqe-0007kA-HU
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPwqb-00027Y-CE
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:12:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPwqb-000277-3v
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:12:29 -0400
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<20170613165313.20954-16-ehabkost@redhat.com>
	<20170615121407.GA2399@work-vm>
	<20170617193349.GM22043@thinpad.lan.raisama.net>
	<20170619084843.GB2104@work-vm>
	<CAFEAcA8G475i8JE_X+5UHGfz7HP8gbOkmQJ8bbSFOoGbULy_tA@mail.gmail.com>
	<20170619132654.GP5016@thinpad.lan.raisama.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa23c822-0f0b-133f-fc45-9e344b8e3a93@redhat.com>
Date: Tue, 27 Jun 2017 15:12:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170619132654.GP5016@thinpad.lan.raisama.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="20V8vX092LQlDRjS4fnW6LVK7P0ViJrBT"
Subject: Re: [Qemu-devel] [RFC 15/15] [test only] Use 'Error *err[static 1]'
 instead of 'Error **errp' to catch NULL errp arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--20V8vX092LQlDRjS4fnW6LVK7P0ViJrBT
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <aa23c822-0f0b-133f-fc45-9e344b8e3a93@redhat.com>
Subject: Re: [Qemu-devel] [RFC 15/15] [test only] Use 'Error *err[static 1]'
 instead of 'Error **errp' to catch NULL errp arguments
References: <20170613165313.20954-1-ehabkost@redhat.com>
 <20170613165313.20954-16-ehabkost@redhat.com> <20170615121407.GA2399@work-vm>
 <20170617193349.GM22043@thinpad.lan.raisama.net>
 <20170619084843.GB2104@work-vm>
 <CAFEAcA8G475i8JE_X+5UHGfz7HP8gbOkmQJ8bbSFOoGbULy_tA@mail.gmail.com>
 <20170619132654.GP5016@thinpad.lan.raisama.net>
In-Reply-To: <20170619132654.GP5016@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/19/2017 08:26 AM, Eduardo Habkost wrote:

>> Is gcc's __attribute__((nonnull)) any better? It seems to apply
>> to the whole function prototype rather than an individual argument
>> though so probably not :-(
>=20
> It's possible to specify which arguments are non-null with
> nonnull(<arg-index>, ...).  It's harder to use, but probably more
> Coccinelle-friendly.

Libvirt uses it, wrapped in a macro; for example:

int ATTRIBUTE_NONNULL(1) ATTRIBUTE_NONNULL(2)
virCPUDefCopyModel(virCPUDefPtr dst,
                   const virCPUDef *src,
                   bool resetPolicy)
{ ...

and at least Coverity is able to use that information (libvirt had
problems in the past where older gcc _silently_ mis-optimized a program
that used the attribute, and ended up having our macro defined only
during Coverity and not during normal compilation; but I think that's
finally been resolved now that newer gcc is saner in its behavior). I
don't know how much smarts Coccinelle has for coming up with the right
parameter number in an automated conversion patch, though.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--20V8vX092LQlDRjS4fnW6LVK7P0ViJrBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUrwpAAoJEKeha0olJ0Nq7eAH/1CFwJjzbVhdJjRFRA8MrzFU
NWIcr4Xyp/vmTvZS9RdpF/q6YWbQht7S5VbUGJPgwcqMaex4MzXtftSzsmT6ZXEZ
XlgRUrwnQGd9NucbCmM7BhMTsWBwSEzpCDUa7LfA8Tt3xM9kG2nhnesB2nC6jS+F
+VT12Ad40cregaox1heYrDvkvRDNljFErYugnhUuwUaj9hldFFbYbl7C8jVyyWFB
/IMuF4h8rYTaZRWavz4CwTR4Vb0q/wwpdnKzYHJTP3iWwi/HQJYghjZz88xIGVyb
qqA1BuXIgBmb60wkPNH6fP8mkn1JatwPchRv/WkYvCXMqKCVsAZ86ZJPEO8F/FM=
=gDAj
-----END PGP SIGNATURE-----

--20V8vX092LQlDRjS4fnW6LVK7P0ViJrBT--
