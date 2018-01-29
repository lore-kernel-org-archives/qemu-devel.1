Received: from eggs.gnu.org ([2001:4830:134:3::10]:43781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egAMs-0005aJ-TS
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egAMn-0002Fc-PV
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:25:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egAMn-0002Ep-GR
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:25:01 -0500
References: <151697279368.755.604390001128478490@5adcb62bf0d6>
	<4e2b09bd-c08f-ef6a-948f-a488051effcd@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b60c4753-378f-f739-c30b-ac2c590ccacf@redhat.com>
Date: Mon, 29 Jan 2018 08:24:36 -0600
MIME-Version: 1.0
In-Reply-To: <4e2b09bd-c08f-ef6a-948f-a488051effcd@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1EtzAvuxwDgYWCdzuClh4zz0lyutbNdtz"
Subject: Re: [Qemu-devel] [PATCH v3] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Cc: famz@redhat.com, ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com, pbonzini@redhat.com, marcel@redhat.com, imammedo@redhat.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1EtzAvuxwDgYWCdzuClh4zz0lyutbNdtz
From: Eric Blake <eblake@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com
Cc: famz@redhat.com, ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, marcel@redhat.com, imammedo@redhat.com, rth@twiddle.net
Message-ID: <b60c4753-378f-f739-c30b-ac2c590ccacf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] tpm: add CRB device
References: <151697279368.755.604390001128478490@5adcb62bf0d6>
 <4e2b09bd-c08f-ef6a-948f-a488051effcd@linux.vnet.ibm.com>
In-Reply-To: <4e2b09bd-c08f-ef6a-948f-a488051effcd@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/28/2018 07:38 AM, Stefan Berger wrote:
> On 01/26/2018 08:19 AM, no-reply@patchew.org wrote:
>> Hi,
>>
>> This series failed build test on s390x host. Please find the details
>> below.
>=20
> We can ignore this and the other emails' errors since the patch's
> dependencies are in my tpm-next tree.

The cover letter said this:

> The patch is based on stefanb/tpm-next git branch.

But patchew doesn't recognize that spelling.  The better way to get
patchew to not spit out those warnings in the first place is to add this
to your cover letter:

Based-on: <1516992568-3139-1-git-send-email-stefanb@linux.vnet.ibm.com>
(Merge tpm 2018/01/26)

(or whatever better message id is relevant)

Hmm, I'm also noticing that MAINTAINERS lacks a T: entry under TPM that
says where the stefanb/tpm-next git branch can be downloaded; the
above-mentioned message id mentions
git://github.com/stefanberger/qemu-tpm.git.  I don't know if patchew
recognizes a git repo+branch name as an alternative to message-id for
the Based-on tag (for that matter, a maintainer branch might not always
have stable commit ids, which could make life interesting if patchew
tests against one version then the maintainer changes by rebase and the
series would then break)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1EtzAvuxwDgYWCdzuClh4zz0lyutbNdtz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpvLqQACgkQp6FrSiUn
Q2p6QAf9HpGl4nW2wEPNuWGuuuewn0+Xj2/zVExjubgKNCYblpNPhwxDxLKD3zc9
NbjP0q5cGbtzdH11n01b0Hdoi7CQ8HKtp1H3+wNPUd271S+x67D1Hs+zdzHajmpx
nuzam6YEfCF29C3JO1tsdpOfxVNOVl3obpL8HRQL/om5KCU43V2f0aJ063/LMoAs
IUM+obCGdr9ohLLXSn1c5Vsvuu89gUAZ9fO56W+YfhJY6gD77dJQiE5B9sctW9nN
cyhaWXOcT2PAHzgzifPOvAEeaj1gpWEQWXvNnuud/Vxy7gYj8XfJ8DhnexaWK8Rv
lj2YntEC5QOxo/e5WjSbYiIAkqulZw==
=qQXB
-----END PGP SIGNATURE-----

--1EtzAvuxwDgYWCdzuClh4zz0lyutbNdtz--
