Received: from eggs.gnu.org ([2001:4830:134:3::10]:45695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsvSP-0007AA-Eb
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsvSK-0004Dc-RJ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:35:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dsvSK-0004C3-9e
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:35:12 -0400
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-15-git-send-email-peterx@redhat.com>
	<20170914153334.GC7370@stefanha-x1.localdomain>
	<20170915025947.GL3617@pxdev.xzpeter.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a43ad04c-77f8-928c-949e-48129711154c@redhat.com>
Date: Fri, 15 Sep 2017 13:34:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170915025947.GL3617@pxdev.xzpeter.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XQUpnnWSVFxirpX6fLoH5vBd5Jxos9CjS"
Subject: Re: [Qemu-devel] [RFC 14/15] qmp: support out-of-band (oob)
 execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XQUpnnWSVFxirpX6fLoH5vBd5Jxos9CjS
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <a43ad04c-77f8-928c-949e-48129711154c@redhat.com>
Subject: Re: [RFC 14/15] qmp: support out-of-band (oob) execution
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
 <1505375436-28439-15-git-send-email-peterx@redhat.com>
 <20170914153334.GC7370@stefanha-x1.localdomain>
 <20170915025947.GL3617@pxdev.xzpeter.org>
In-Reply-To: <20170915025947.GL3617@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/14/2017 09:59 PM, Peter Xu wrote:
> On Thu, Sep 14, 2017 at 04:33:34PM +0100, Stefan Hajnoczi wrote:
>> On Thu, Sep 14, 2017 at 03:50:35PM +0800, Peter Xu wrote:
>>> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.=
txt
>>> index 61fa167..47d16bb 100644
>>> --- a/docs/devel/qapi-code-gen.txt
>>> +++ b/docs/devel/qapi-code-gen.txt

>>
>> Is there a more relevant place to document QMP run-oob behavior than t=
he
>> "How to use the QAPI code generator document"?
>=20
> I agree, but I don't really know it. :(
>=20
> Markus, could you provide a hint?

I'm not Markus, but I suggest docs/interop/qmp-spec.txt

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XQUpnnWSVFxirpX6fLoH5vBd5Jxos9CjS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8HTAACgkQp6FrSiUn
Q2pqeQf+NdZp2wJ0sulAvXpZNc5Aja/qOmT8utDZfTU1Us/Y5Fms3M3PVN4yEfjT
K3pE4kY/Tc8u7gYX+OUSXMZiEFCbSDTO023FvRhv2W0rb3u8ICc21debEzfsNI0T
pIna21QwcKF/jnW3FTqK5iZtpBNwoYX5rIta49N1ZRHxEdXuOlbHellC8HCwx60z
+0/nHmEQ7fqV2BB7ErXZqA4kiS5GE9juy2eU/JvjtRrxgbZUsSZea8RvNzOU91Bk
oVcvPI/AB/G1t6RIR0xowFkIsUU5oHcB8CZKFeS7Q6wI8KOiBPxCB4FKjGY5B/yE
n5/Hfd+F4ZguHjQ2WvzcM540vkD0/A==
=a+tO
-----END PGP SIGNATURE-----

--XQUpnnWSVFxirpX6fLoH5vBd5Jxos9CjS--
