Received: from eggs.gnu.org ([2001:4830:134:3::10]:51697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8AoU-0003L0-VL
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8AoQ-0006pT-VS
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:28:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8AoQ-0006oO-MN
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:28:46 -0400
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
	<7598ea81-5fcb-d806-ce18-a6eb401b5259@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c55f2c76-8c22-4d77-664c-82c07220b8b6@redhat.com>
Date: Tue, 9 May 2017 14:28:40 -0500
MIME-Version: 1.0
In-Reply-To: <7598ea81-5fcb-d806-ce18-a6eb401b5259@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j7UsnLu7p1ulcBLD9jPtaCRuoALsDenaB"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] xen/9pfs: fix two resource leaks on
 error paths, discovered by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, xen-devel@lists.xen.org, aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j7UsnLu7p1ulcBLD9jPtaCRuoALsDenaB
From: Eric Blake <eblake@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, xen-devel@lists.xen.org,
 aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org
Message-ID: <c55f2c76-8c22-4d77-664c-82c07220b8b6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] xen/9pfs: fix two resource leaks on
 error paths, discovered by Coverity
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
 <7598ea81-5fcb-d806-ce18-a6eb401b5259@redhat.com>
In-Reply-To: <7598ea81-5fcb-d806-ce18-a6eb401b5259@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 02:20 PM, Eric Blake wrote:
> On 05/09/2017 02:04 PM, Stefano Stabellini wrote:
>> CID: 1374836
>>
>> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
>> CC: anthony.perard@citrix.com
>> CC: groug@kaod.org
>> CC: aneesh.kumar@linux.vnet.ibm.com
>> ---
>>  hw/9pfs/xen-9p-backend.c | 2 ++
>>  1 file changed, 2 insertions(+)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

By the way, you forgot to send a 0/3 cover letter (at least, there was
no In-Reply-To: header in your 1/3 mail).  That makes it harder to
automate handling of your series; I was going to reply to the series as
a whole.

While it is inconvenient for human readers, it is even worse for some of
the automated patch tooling we have that expects cover letters for any
multi-patch series.  More patch submission tips at
http://wiki.qemu.org/Contribute/SubmitAPatch include how to use 'git
config' to automate the creation of a cover letter.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--j7UsnLu7p1ulcBLD9jPtaCRuoALsDenaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEhhoAAoJEKeha0olJ0NqfBgIAIkwB4VvlQDvhrI5DE4CykwS
JqiEdCGhOlmaOnKqgUszwMQudB8jlg7uKiOWpKB6ELVIeQ704NDaS3s5xX0+YXO3
xffg5bUv84S3A4blIoXGPHIyTGyKh+cqI1xCshUNihWoqLsoZRKuyF2rwLnuT4TF
k0KYiWBBm4UvRu27OEzZbYeGeKsTVS7u1PN3xOVZ1AjF+F8tbzpz4zPjMvo8Q5uR
x53pH7Opwhza/xQgx3tr2oFA7LXbVXEbPTFfh35xECtj5Ct2Z7j+jOmMwDm4dbQc
VqeOeoUVPhTfp+ddHg+BE2jbzQoeyz9zxNgFBwQuiBe4Z0Qj1O8zbeIeQK+PE0c=
=IDQL
-----END PGP SIGNATURE-----

--j7UsnLu7p1ulcBLD9jPtaCRuoALsDenaB--
