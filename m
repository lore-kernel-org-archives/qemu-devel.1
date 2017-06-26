Received: from eggs.gnu.org ([2001:4830:134:3::10]:48869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPWrG-00029J-03
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPWrF-00023J-7M
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:27:26 -0400
Date: Mon, 26 Jun 2017 19:26:41 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170626162641.cavidsn7d67absxb@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
	<20170626143055.GC29664@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jdy4gbpivvd37w3l"
Content-Disposition: inline
In-Reply-To: <20170626143055.GC29664@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 3/8] block: add
 throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--jdy4gbpivvd37w3l
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

On Mon, Jun 26, 2017 at 03:30:55PM +0100, Stefan Hajnoczi wrote:
>> +    bs->file = bdrv_open_child(NULL, options, "file",
>> +                                    bs, &child_file, false, &local_err);
>> +
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return -EINVAL;
>> +    }
>> +
>> +    qdict_flatten(options);
>> +    return throttle_configure_tgm(bs, tgm, options, errp);
>
>Who destroys bs->file on error?

It is reaped by bdrv_open_inherit() on failure, if I'm not mistaken.
That's how other drivers handle this as well. Some (eg block/qcow2.c)
check if bs->file is NULL instead of the error pointer they pass, so
this is not not very consistent.

--jdy4gbpivvd37w3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllRNcEACgkQc2J8L2kN
9xDAzg/9GqYGRgh/aZYNOpOT9OL48sXBcno06WdDTGZHF9gtqyxzY8NKNMtDgxG2
f/EsSXHfrFbLHW0UFBCshU5AihIQ91YxpL1ALUQXM4H0ge0kAZh+tXriylgZwQmo
q3n71dirvAevo1Kqi/kIBp1tVpcnZ3kO2nqyH9sdXwXyRc3njjpkf1VreuBA0AYb
yfOH5ZNIIsFePbrEBQbmvfSKtUNHRe4+iPnY2kFCzx10EzYar8/5uo/AvPXUBNiO
DpvYx6qKNNBFfZ4jKS1dodZL1p5IhizyiMF6cD6fVlmHYt5Z0BA/LQxBnncONeV1
2k7NLBKIxLE1H09NTkbB6ne3xTOluRBmPzRLwKdBaYqMcCw/7qg2En6AyS9yfZ+o
es3sPcR99+4+1LYOZhO+Lar3eVpyHiatQvrwQskgM24IVT8Htz/w5sc9P3DPfZd9
CVnLtPNUKjZUBWMcfbisM2RvnrA2YVODU/TkdYj06+c5SVnvr/StB9HdR+M/eLAH
591neLLcg4JaozR8d2hlvEPA5ANOBjGNffwlalI1BVSTzMC2uxhQQVPQ8J7sFFOf
ztncacXAUH7TCRdb6aKHpVbS9a96a9oZkuS3dx6G4I3nzqPb0qsBTRTLsO2CRH9V
K1PesMedvYXmJMPPqL5veY2e7R9k2GyEdfEvsqB4IvE2vxKoc3E=
=U71p
-----END PGP SIGNATURE-----

--jdy4gbpivvd37w3l--
