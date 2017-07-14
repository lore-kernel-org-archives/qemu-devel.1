Received: from eggs.gnu.org ([2001:4830:134:3::10]:51484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1ZR-0006FX-FU
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1ZM-00080U-EA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:27:53 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:15849)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1ZM-0007xL-2r
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:27:48 -0400
Date: Fri, 14 Jul 2017 17:26:39 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170714142639.ycu6b7qeeb7akxkb@postretch>
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170714122221.pyx2pwubtaylqdu6@postretch>
	<e059cf44-53df-4d5f-3257-cc9b6be775df@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d35jmbvpqdeixl5j"
Content-Disposition: inline
In-Reply-To: <e059cf44-53df-4d5f-3257-cc9b6be775df@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>


--d35jmbvpqdeixl5j
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 03:15:06PM +0200, Pradeep Jagadeesh wrote:
>Hi Manos,
>
>Thanks for sharing the link to your code patch.
>
>On 7/14/2017 2:22 PM, Manos Pitsidianakis wrote:
>>Hello Pradeep, you might be interested in my work on refactoring the
>>block layer's throttling interface in my series:
>>https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg04191.html
>Sure will have a look.
>>In this series you copy the existing legacy interface we want to get rid
>>of. I think it will be easier work for you to use the changes introduced
>>in my patches when they are merged.
>So, should I wait till they are in?. Actually my throttle patches for=20
>fsdev are already upstream (2.9). Now I am just introducing the=20
>qmp/hmp interfaces for the same.

If you plan on using ThrottleGroups, probably yes, I think, because we'd=20
have duplicate interfaces afterwards instead of a unified one. You'd=20
have to introduce a qmp/hmp command to set fsdev throttle now and after=20
you use throttle groups it will become obsolete.

>>Have you thought about using throttle groups? It'd mean many devices
>>sharing the same limits. This way the interfaces can be unified.  Please
>>read docs/throttle.txt and see if it would be useful for you.
>
>I have read about the throttle group, last year when I was=20
>implementing the throttle feature for fsdev.My open source work=20
>depends on the projects I/my group work on. So, when I have more=20
>bandwidth work on those, I will surely take it up. Throttle group=20
>option may be useful feature even in case of fsdev devices.
>
>Regards,
>Pradeep
>
>

--d35jmbvpqdeixl5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllo1J8ACgkQc2J8L2kN
9xA0Cg/+LU2Wsuzgm1XtokhSyIHX1vEC6stdqDhDLHPbRz3INL9w/RbGu8trl3sw
KI+iTj3K76UAjqW5UgiHKWYQ/3J5+j/i8sKSpOhUoa1YTGZfXQ0/C9vmU/VReXyN
nYI+ivGUJHVquzNVz1CVHjE3XD40FFlm6u6/+FY7inxxbn5+UIXnuUKYWr8mOaIa
hcL3qz2dIaWjmwLG7A2ZbBHrHw3jcwE3XWWrC3vFN096/MG0kmQHtr/Of/v/4+Lu
NsUSl/0JUaYLb34AetSWXNKcWmOKzKCd+H/czLmV86yokvzGyp6BklX0lZH2/tvN
Ha/oD5B1NFM4CLHMsFGSsz9KB2pYGxoAZ1buU7iOOLekT2CvkEz2+49QS2xkqxKY
ej3xcwT4cENHLAmZ7jMIULzxeLLobw3qQ4FHBs9ikC+trf0wV8tZf+4CTM3ie5dn
ie2QtyHPFY9uJAmZVHQfp4//X3sazfb3Bwft/YPqZ1c8KOANycdFfkmJaZFuFH4q
W12EPI9ro5R4fbDD2ldRFUrwWFjH7y2mTAMFVIS8keu/KMrSoZKTvVXIRUAGbr3j
C/bOOet+v971qCUSFnrAvS6lQzaix4dtRISU8AejAOMNfUWqfEFTGySG02MsLedJ
cCvZcfcp1g+44wK2Le4e040+FROGxvMpvCImtA/ychgWoZoaHGE=
=r9pe
-----END PGP SIGNATURE-----

--d35jmbvpqdeixl5j--
