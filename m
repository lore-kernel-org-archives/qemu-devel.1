Received: from eggs.gnu.org ([2001:4830:134:3::10]:54792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFj4b-0003WW-K3
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 09:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFj4X-0004G5-Ng
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 09:56:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cFj4X-0004Fe-G2
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 09:56:21 -0500
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
	<09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA156A93@DGGEMA505-MBX.china.huawei.com>
	<20d0895e-9d22-8718-a1d8-618d5b7d75d0@redhat.com>
	<9100954e-d7e6-8670-e614-0fa611d6f248@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA158099@DGGEMA505-MBX.china.huawei.com>
	<5a0a4eab-5de3-493b-ff92-e17796a17058@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA159216@DGGEMA505-MBX.china.huawei.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c2eeccaa-0870-102f-4e90-021402e16a0b@redhat.com>
Date: Sat, 10 Dec 2016 15:56:15 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA159216@DGGEMA505-MBX.china.huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GW0Ukg8SNTfhScxwTUcuAVauIkxhQvX48"
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GW0Ukg8SNTfhScxwTUcuAVauIkxhQvX48
From: Max Reitz <mreitz@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eric Blake
 <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
Message-ID: <c2eeccaa-0870-102f-4e90-021402e16a0b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
 <09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
 <33183CC9F5247A488A2544077AF19020DA156A93@DGGEMA505-MBX.china.huawei.com>
 <20d0895e-9d22-8718-a1d8-618d5b7d75d0@redhat.com>
 <9100954e-d7e6-8670-e614-0fa611d6f248@redhat.com>
 <33183CC9F5247A488A2544077AF19020DA158099@DGGEMA505-MBX.china.huawei.com>
 <5a0a4eab-5de3-493b-ff92-e17796a17058@redhat.com>
 <33183CC9F5247A488A2544077AF19020DA159216@DGGEMA505-MBX.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA159216@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.12.2016 03:58, Gonglei (Arei) wrote:
>>
>>
>> On 09.12.2016 02:42, Gonglei (Arei) wrote:
>>> Hi,
>>>
>>>>
>>>> Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize =
the key
>>>> material before free
>>>>
>>>> On 08.12.2016 16:23, Eric Blake wrote:
>>>>> On 12/07/2016 08:28 PM, Gonglei (Arei) wrote:
>>>>>
>>>>>>> As far as I'm aware, other projects usually have a special memset=

>>>>>>> variation for doing this. That is because compilers may choose to=

>>>>>>> "optimize" memset(p, ...) + free(p) to just the free(p). Having a=

>>>>>>
>>>>>> Actually, I googled this, but I didn't find a definite answer. And=

>>>>>>
>>>>>> The Linux kernel uses kzfree instead of memset + kfree
>>>> (mm/slab_common.c).
>>>>
>>>> Well, I personally don't mind whether we use a custom zfree() or a
>>>> custom memset_s() + free(). I only mind that this patch actually alw=
ays
>>>> does what it is intended to do.
>>>>
>>> Yes, but why linux kernel to think about the compiler optimization fo=
r
>>> memset for sensitive data?
>>
>> I'm afraid I don't quite (syntactically) understand this question. Do
>> you mean to ask why the Linux kernel would have to think about this
>> optimization? My answer to that would be because the optimization of
>> memset() + free() is known, and they probably want to protect against
>> the compiler optimizing it even with -ffreestanding and differently
>> called functions -- you never know.
>>
> Sorry, that's my typo. ;)=20
>=20
> My question is why not linux kernel to think about the compiler optimiz=
ation
> on the code layer. Because the realization of kzfree is just memset + k=
free,=20
> it didn't add any memory barrier to prevent memset is optimized, or use=

> secure_memset, or whatever.
>=20
> So you answer means they maybe use some compiler options to avoid
> the compiler optimizing?

Yes, maybe they are trusting that using -ffreestanding will keep the
compiler from optimizing the combination. I personally wouldn't trust
that, because I have seen gcc ignore that convention and just optimize
anyway, but I'm not Linus and I guess if Linus complains about gcc
breaking something, it will be fixed much more quickly than when I do.

Max


--GW0Ukg8SNTfhScxwTUcuAVauIkxhQvX48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhMF48SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATxYH/3TkC9uF+h8gRKlj+nGNR8heG3+QCguv
xCRRSZhOT5fvJ9D2GhsC0uW43mlIeEFBut59ai1cCTZsEjJ0WYUT397bKFTsXyEv
KM7b8KVvuTFn7ITkUFA22Qa3Ng9nImIHP/LEyA2gvAvvZjbgAx16Gv7FwBf7pJrk
uBU5LsUsrFxw4xdgM1QZk0TKnMu4StLp6h3Ghj3vxFD7YCgfD24cMc8rmblKk2Cx
r8xxPWlIRcryC0FlDGje6XxIXj3OGUB7t7CpFFW/dZ0CqzjgMLuQSFIiRnvsApg9
s4xuyYgH3ZQ4pSyzza7rRHtmkZqBdgArbM04RzZHbBV+gSRIlVsGYWc=
=pc9s
-----END PGP SIGNATURE-----

--GW0Ukg8SNTfhScxwTUcuAVauIkxhQvX48--
