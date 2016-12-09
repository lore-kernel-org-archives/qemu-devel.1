Received: from eggs.gnu.org ([2001:4830:134:3::10]:40478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFLdE-0003QR-1W
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 08:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFLdB-00070B-FC
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 08:54:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cFLdB-0006ze-6P
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 08:54:33 -0500
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
	<09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA156A93@DGGEMA505-MBX.china.huawei.com>
	<20d0895e-9d22-8718-a1d8-618d5b7d75d0@redhat.com>
	<9100954e-d7e6-8670-e614-0fa611d6f248@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA158099@DGGEMA505-MBX.china.huawei.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5a0a4eab-5de3-493b-ff92-e17796a17058@redhat.com>
Date: Fri, 9 Dec 2016 14:54:28 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA158099@DGGEMA505-MBX.china.huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JkqaA8n5L1aIEHBTH8LhLoQqSLILUecQb"
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
--JkqaA8n5L1aIEHBTH8LhLoQqSLILUecQb
From: Max Reitz <mreitz@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eric Blake
 <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
Message-ID: <5a0a4eab-5de3-493b-ff92-e17796a17058@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
 <09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
 <33183CC9F5247A488A2544077AF19020DA156A93@DGGEMA505-MBX.china.huawei.com>
 <20d0895e-9d22-8718-a1d8-618d5b7d75d0@redhat.com>
 <9100954e-d7e6-8670-e614-0fa611d6f248@redhat.com>
 <33183CC9F5247A488A2544077AF19020DA158099@DGGEMA505-MBX.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA158099@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.12.2016 02:42, Gonglei (Arei) wrote:
> Hi,
>=20
>>
>> Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize th=
e key
>> material before free
>>
>> On 08.12.2016 16:23, Eric Blake wrote:
>>> On 12/07/2016 08:28 PM, Gonglei (Arei) wrote:
>>>
>>>>> As far as I'm aware, other projects usually have a special memset
>>>>> variation for doing this. That is because compilers may choose to
>>>>> "optimize" memset(p, ...) + free(p) to just the free(p). Having a
>>>>
>>>> Actually, I googled this, but I didn't find a definite answer. And
>>>>
>>>> The Linux kernel uses kzfree instead of memset + kfree
>> (mm/slab_common.c).
>>
>> Well, I personally don't mind whether we use a custom zfree() or a
>> custom memset_s() + free(). I only mind that this patch actually alway=
s
>> does what it is intended to do.
>>
> Yes, but why linux kernel to think about the compiler optimization for
> memset for sensitive data?

I'm afraid I don't quite (syntactically) understand this question. Do
you mean to ask why the Linux kernel would have to think about this
optimization? My answer to that would be because the optimization of
memset() + free() is known, and they probably want to protect against
the compiler optimizing it even with -ffreestanding and differently
called functions -- you never know.

Related example: gcc detects code that basically does a memset() and
replaces it with a call to memset(). There were a couple of versions
where it did that even with -ffreestanding or -fno-builtin, which is bad
if you want to actually write a memset(). They fixed it by now (so that
-ffreestanding and -fno-builtin will imply
-fno-tree-loop-distribute-patterns, which will disable that optimization.=


Now imagine the same case here: Maybe at some point gcc is able to
detect that kfree() is basically free() and will then optimize the
memset() before kfree() away. A couple of versions later, somebody will
notice that -- but at that point, the damage has been done already and
there are compiled versions out which leak sensitive data somewhere.

I think this is why the Linux kernel decides to be proactive and use
kzfree() from the start, and this is also why I'm proposing to not delay
this issue in qemu until some compiler actually makes it a real issue.

>>> If we're worried about cleaning things without allowing the compiler =
a
>>> chance to optimize, then writing our own qemu_zfree() wrapper may ind=
eed
>>> make sense.  But that won't cover the case in Daniel's earlier patch
>>> (referenced elsewhere in this thread), as that was zeroizing stack
>>> memory (before it went out of scope) rather than heap memory (before
>>> free).  So you'd still need some sort of 'write this memory no matter=

>>> what' primitive that would be directly usable on stack memory and
>>> indirectly used as part of the qemu_zfree() wrapper.
>>>
> If we wrap a secure_memset(), then both stack memory and heap
> memory can use it.
>=20
> Pls see:
>=20
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1381.pdf
>=20
> But the secure_memset() is not as efficient as possible due to the natu=
re of the volatile
> type qualifier preventing the compiler from optimizing the code at all.=

>=20
> It will cause huge performance regression at hot path of data plane...

I would suggest we implement an own secure_memset() or secure_bzero()
which falls back on what we have:
- memset_s(), if that is available;
- explizit_bzero() if we have libbsd;
- SecureZeroMemory() on Windows

Or we have to write it ourselves:
https://sourceware.org/ml/libc-alpha/2014-12/msg00506.html suggests that
putting a full memory barrier after the memset() should be enough.

>>> But I wouldn't worry about it for now, unless someone proves we actua=
lly
>>> have a compiler optimizing away the cleanups.
>>
>> It's true that we don't have to worry about it *now*, but the approach=

>> of waiting until the compiler breaks it does not seem right to me.
>>
>> If at some point some compiler recognizes g_free() as being the same
>> function as free() and thus optimizes memset() + g_free(), we simply
>> won't notice because nobody will keep track of the generated assembly
>> output all the time.
>>
>> There is a reason C11 introduced memset_s(), and it is this.
>>
> ...does it make sense if we introduce secure_memset() now ?=20
>=20
> Waiting for your feedback. Thanks!

I would propose so; or better something like secure_bzero() or
secure_memzero(), because we can then fall back on existing
implementations like explizit_bzero() or SecureZeroMemory().

We don't have to implement this immediately, but we should do it before
the 2.9 release.

Max


--JkqaA8n5L1aIEHBTH8LhLoQqSLILUecQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhKt5QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A8+IH/3zYLEyKIx20l0fHzwZnCHNDV70DRTdB
vzA9C1pmcTxiiutcfzxJ4zT3HWHCGz5eRDsRDhOwoE2VC7MwQ7CfHgU9VLSbXfbs
x3cDoP6T+aDr/HzuhonqxXZBg/llWwmsUjVKWszDZB3HG7pYFRs8qNpxDBcAhRyC
xLLjMGsp+KPNoxOAJqQVASOfoHuh5qo4BHRVZsYSBtzqLxKVPjSsDhMqKcR4QQ9k
rezKo29dbPg09j2aCaKGbIjfaepnXb8LnF+33DL6XGc5NzAxK33/7+69jnihHPUq
RUdVmqb2tRGpA9fsvjCXou4j+Fei9stGuyoEFdB/0s30OKOGRX/b16Y=
=m/lF
-----END PGP SIGNATURE-----

--JkqaA8n5L1aIEHBTH8LhLoQqSLILUecQb--
