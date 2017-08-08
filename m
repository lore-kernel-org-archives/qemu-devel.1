Received: from eggs.gnu.org ([2001:4830:134:3::10]:48083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df62k-0007uA-IV
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df62j-0000cq-Dz
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:03:38 -0400
References: <20170804105059.11941-1-berrange@redhat.com>
	<20170804140210.GD4108@localhost.localdomain>
	<20170804140630.GC14504@redhat.com>
	<9c9832bf-1e0e-6b3a-d962-5672cb96d323@redhat.com>
	<20170804154919.GI14504@redhat.com> <20170808023929.GR14780@lemon>
	<20170808091330.GB9393@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef505f48-f876-743f-922c-1faddce3051d@redhat.com>
Date: Tue, 8 Aug 2017 10:03:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170808091330.GB9393@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C9VnX36x0O195aeiDjiBt5JFEmX94pKRj"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: document semanatics of
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C9VnX36x0O195aeiDjiBt5JFEmX94pKRj
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <ef505f48-f876-743f-922c-1faddce3051d@redhat.com>
Subject: Re: [Qemu-block] [PATCH] block: document semanatics of
 bdrv_co_preadv|pwritev
References: <20170804105059.11941-1-berrange@redhat.com>
 <20170804140210.GD4108@localhost.localdomain>
 <20170804140630.GC14504@redhat.com>
 <9c9832bf-1e0e-6b3a-d962-5672cb96d323@redhat.com>
 <20170804154919.GI14504@redhat.com> <20170808023929.GR14780@lemon>
 <20170808091330.GB9393@redhat.com>
In-Reply-To: <20170808091330.GB9393@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 04:13 AM, Daniel P. Berrange wrote:
> On Tue, Aug 08, 2017 at 10:39:29AM +0800, Fam Zheng wrote:
>> On Fri, 08/04 16:49, Daniel P. Berrange wrote:
>>> This is odd.  In the bdrv_aligned_readv() it looks very much like
>>> we'll reference qiov->niov, if bytes !=3D 0, so if qiov was NULL we
>>> would crash.
>>
>> It doesn't make sense if read doesn't have an iov, where should the da=
ta be
>> placed? :)
>>

> We can't remove it from the bdrv_co_pwritev() function, but we can remo=
ve
> it from bdrv_co_pwritev block driver callback AFAICT.

Sounds like a separate cleanup series to remove the length parameter for
both read and write (since we have write_zeroes), for the 2.11
timeframe.  You're right that the block layer does not have to have
quite the same interface as the driver callbacks.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--C9VnX36x0O195aeiDjiBt5JFEmX94pKRj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmJ0roACgkQp6FrSiUn
Q2qf9gf/aNcJqZQ2DSCtaEP/4gMKNkCrwWc94mlOXe1iPT/zyFfAWBPe6sMjBJe3
Frf4J4wyFSGa1MtSbxLix2ZcRnuNiYdBotW8gCc6gicXYs9nN+MMSr6a2yYgPzfV
0F+1TC5wp36XMym7aMHcs9ytx5v+no4Xa9V2JSrH19hLD9/ejEtRQ9szFVJ81eTz
NbfBU7GubWF0ZJ3JzAhJqeodPCsKIDnlshs8qHZHJP06nKFSagC3588n/NZ538UA
6v1syH9QLS7Maa/InE8gARREaLF/l0YukcbtBanw2ZMP0uWGFzR0sXYaocPZXfmJ
4vr+p5r2Z31drniRZ3wi1r22JjVztA==
=kmKb
-----END PGP SIGNATURE-----

--C9VnX36x0O195aeiDjiBt5JFEmX94pKRj--
