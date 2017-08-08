Received: from eggs.gnu.org ([2001:4830:134:3::10]:45689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1df5wQ-00053t-D7
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1df5wP-0006CV-9o
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:57:06 -0400
Date: Tue, 8 Aug 2017 17:56:20 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170808145620.wlb5rdutuseutclx@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-6-el13635@mail.ntua.gr>
	<w51valyjj7j.fsf@maestria.local.igalia.com>
	<20170808134544.paekftiounmirhbo@postretch>
	<w51poc6jeln.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hvp27giwc7lme2hw"
Content-Disposition: inline
In-Reply-To: <w51poc6jeln.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--hvp27giwc7lme2hw
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 04:53:08PM +0200, Alberto Garcia wrote:
>On Tue 08 Aug 2017 03:45:44 PM CEST, Manos Pitsidianakis wrote:
>> On Tue, Aug 08, 2017 at 03:13:36PM +0200, Alberto Garcia wrote:
>>>On Mon 31 Jul 2017 11:54:41 AM CEST, Manos Pitsidianakis wrote:
>>>> block/throttle.c uses existing I/O throttle infrastructure inside a
>>>> block filter driver. I/O operations are intercepted in the filter's
>>>> read/write coroutines, and referred to block/throttle-groups.c
>>>>
>>>> The driver can be used with the syntax
>>>> -drive driver=3Dthrottle,file.filename=3Dfoo.qcow2, \
>>>>         limits.iops-total=3D...,throttle-group=3Dbar
>>>
>>>Sorry for not having noticed this earlier, but can't you define the
>>>throttling group (and its limits) using -object throttle-group ... as
>>>shown in the previous patch, and simply reference it here? Or would we
>>>have two alternative ways of setting the throttling limits?
>>>
>>>What happens if you have many -drive lines each one with a different set
>>>of limits but with the same throttling group?
>>
>> The limits of the last one to be processed will win.
>
>That's what the current throttling API does, and I tend to agree that
>it's not completely straightforward (a few people have asked me the same
>question since this feature is available).
>
>If we're going to add a new API we could eliminate this ambiguity. After
>all the previous -drive throttling.iops-total=3D... would still be
>available, wouldn't it?

Indeed, it already is.

>
>> So basically if we have anonymous groups, we accept limits in the
>> driver options but only without a group-name.
>
>In the commit message you do however have limits and a group name, is
>that a mistake?
>
>    -drive driver=3Dthrottle,file.filename=3Dfoo.qcow2, \
>           limits.iops-total=3D...,throttle-group=3Dbar
>

Sorry this wasn't clear, I'm actually proposing to remove limits from=20
the throttle driver options and only create/config throttle groups via=20
-object/object-add.

--hvp27giwc7lme2hw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmJ0RQACgkQc2J8L2kN
9xAH2hAAnjhnLz7ycE5lPul4B8HNXkxDYGdRAmargOtRgLy/geaFXFhQTp0IBybC
UthOLRRvj9x/fS1L7k8bYsqEfk6CJ0Of0EPkGp8yY5+dtV+Iw2ioAHiboixvNgX0
oaam0OHat60ythUqVRF1yh6PouEnEwnx2FlOv8WkFqjFYOqCL8x37BIOf5/9v8X2
kApKrdmJFx0MvSY8iFz3z7Zja6CZW9STZr3qCvuG4amU8iIMhpcYgHfpUgLlJkD6
j8hF8FiVd6NwVPcrUOo9UCaG81wz1w5iFwQxnagnz7HkP4LuhI0f3NfgAX0qhpSX
eyPWSKWegiy0H2MYAW4FcUyN0KHQWMfnpZa8qD8SQJR0+j4TQVcEcRrTDJ7tVwX1
EP7a3smuQ7o6Vp2W1JLvb6gMYwdpz73dcx0HACzUVWXmsQmB2Hg8xhjY1zCiPHi0
5e8xzaUB91VdJ6TIg4olSSb5VyGpz9pXe/VD3EZpQ8VH7Pw8BMn1w81FEeyAFGLj
IrLBWLjs25yX7ZuzbGBaBBAKIpXikj3Pt7pqA48HZAwSvexReXv+jepXvqZN1xmQ
K+78R/lfTASqAbAeyEnLgZSZFgJjxIC10XurMqGpqt8sr9lazS9tZXcZBaETmMvf
u08q+TbiXo3RLDHjuDMEUYWbCYn6GrDD17VNSLee204s6GHXZ7U=
=/5RQ
-----END PGP SIGNATURE-----

--hvp27giwc7lme2hw--
