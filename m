Received: from eggs.gnu.org ([2001:4830:134:3::10]:38584)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gBOYd-0005fD-U9
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gBOYY-0007jH-V3
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:22:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:39789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gBOYY-0007Jx-HJ
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:22:30 -0400
References: <20181007153731.GA32288@humpty.home.comstyle.com>
	<a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
	<CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
	<933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
	<a67f0c2c-5a5b-7a78-141b-2e829304e72e@comstyle.com>
	<CAFEAcA9rJZNeRJdjLU724qgr6PEyVE-8hOn_gk_uU+mYSxuxDw@mail.gmail.com>
	<cae2d61f-c643-5be7-4200-fcafd2f92cc5@gmx.com>
	<486f95ef-db10-e0f2-e9a8-dd3eff0d3200@comstyle.com>
	<6225f3eb-5f1e-d63d-c39c-d67a92fa1a2e@gmx.com>
	<20181011212059.GA44995@humpty.home.comstyle.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <6b5a228a-a09d-973d-9481-48c48796ba2a@gmx.com>
Date: Sat, 13 Oct 2018 20:23:31 +0200
MIME-Version: 1.0
In-Reply-To: <20181011212059.GA44995@humpty.home.comstyle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KGpWYdeBO0G8utchYxvYf6mrD5icTf4Db"
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KGpWYdeBO0G8utchYxvYf6mrD5icTf4Db
From: Kamil Rytarowski <n54@gmx.com>
To: Brad Smith <brad@comstyle.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <6b5a228a-a09d-973d-9481-48c48796ba2a@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
References: <20181007153731.GA32288@humpty.home.comstyle.com>
 <a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
 <CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
 <933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
 <a67f0c2c-5a5b-7a78-141b-2e829304e72e@comstyle.com>
 <CAFEAcA9rJZNeRJdjLU724qgr6PEyVE-8hOn_gk_uU+mYSxuxDw@mail.gmail.com>
 <cae2d61f-c643-5be7-4200-fcafd2f92cc5@gmx.com>
 <486f95ef-db10-e0f2-e9a8-dd3eff0d3200@comstyle.com>
 <6225f3eb-5f1e-d63d-c39c-d67a92fa1a2e@gmx.com>
 <20181011212059.GA44995@humpty.home.comstyle.com>
In-Reply-To: <20181011212059.GA44995@humpty.home.comstyle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.10.2018 23:20, Brad Smith wrote:
> On Thu, Oct 11, 2018 at 09:31:23PM +0200, Kamil Rytarowski wrote:
>> On 11.10.2018 16:25, Brad Smith wrote:
>>> On 10/11/2018 5:41 AM, Kamil Rytarowski wrote:
>>>
>>>> On 11.10.2018 11:36, Peter Maydell wrote:
>>>>> On 11 October 2018 at 00:55, Brad Smith <brad@comstyle.com> wrote:
>>>>>> And from FreeBSD...
>>>>>>
>>>>>> ?????????? MAP_STACK MAP_STACK implies MAP_ANON, and offset of 0.?=
? The fd
>>>>>> argument must be -1 and prot must include at least
>>>>>> PROT_READ and PROT_WRITE.
>>>>>>
>>>>>> This option creates a memory region that grows to at
>>>>>> most len bytes in size, starting from the stack top
>>>>>> and growing down.?? The stack top is the starting
>>>>>> address returned by the call, plus len bytes.?? The
>>>>>> bottom of the stack at maximum growth is the starting
>>>>>> address returned by the call.
>>>>>>
>>>>>> Stacks created with MAP_STACK automatically grow.
>>>>>> Guards prevent inadvertent use of the regions into
>>>>>> which those stacks can grow without requiring mapping
>>>>>> the whole stack in advance.
>>>>> Hmm. That "automatically growing" part sounds like
>>>>> behaviour we definitely do not want for our use case.
>>>>> So we're going to need to make this OS-specific :-(
>>>>>
>>>> I propose to restrict MAP_STACK it to OpenBSD (with a comment in the=

>>>> code). Once it will be needed by someone else will be able to enable=
 it
>>>> for other OSes.
>>>
>>> I was going to propose doing something like that but you had replied
>>> before I did.
>>> What sort of comment did you have in mind?
>>>
>>
>> Why do we want it only on OpenBSD and its either unneeded or meaning
>> something else on other OSes.
>>
>> #ifdef __OpenBSD__
>> flags |=3D MAP_STACK;
>> #endif
>=20
> How about the following?
>=20

It looks good to me.

Reviewed-by: Kamil Rytarowski <n54@gmx.com>

>=20
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index fbd0dc8c57..7814e61114 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -596,6 +596,7 @@ pid_t qemu_fork(Error **errp)
>  void *qemu_alloc_stack(size_t *sz)
>  {
>      void *ptr, *guardpage;
> +    int flags;
>  #ifdef CONFIG_DEBUG_STACK_USAGE
>      void *ptr2;
>  #endif
> @@ -610,8 +611,15 @@ void *qemu_alloc_stack(size_t *sz)
>      /* allocate one extra page for the guard page */
>      *sz +=3D pagesz;
> =20
> -    ptr =3D mmap(NULL, *sz, PROT_READ | PROT_WRITE,
> -               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
> +#if defined(MAP_STACK) && defined(__OpenBSD__)
> +    /* Only enable MAP_STACK on OpenBSD. Other OS's such
> +       as Linux/FreeBSD/NetBSD have a flag with the same
> +       name but have differing functionality. */
> +    flags |=3D MAP_STACK;
> +#endif
> +
> +    ptr =3D mmap(NULL, *sz, PROT_READ | PROT_WRITE, flags, -1, 0);
>      if (ptr =3D=3D MAP_FAILED) {
>          perror("failed to allocate memory for stack");
>          abort();
>=20



--KGpWYdeBO0G8utchYxvYf6mrD5icTf4Db
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlvCOCMMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZssSQQAL2/mo1+kIJfADfceGKEcX7PbSqNdfH6nKiQeBZW
wr4G7G4KyYGOFkM4xR+VNVjo9+UDKKyqIomfHh3jyl8zqIYsYRWClJaAecesljxn
1cg4Uo/1Ggd/Nf33bDXhCxzPJeVO28ueVs1ygW2BihXRBrxMt6PLCQos1D2h9+my
uemevPQwGlYRyU0Fk5Ne80NmUO7JTiKvUpfz1S+wwibaBt6vkrtcVBGGaRiUQt4K
bmLCoi0qdnl65u7z/xiaVLE77bqFnEmHU0XtHucTbJdqhAnqQW7n3WQDhx8TCMcS
KLTtD3SzHOFn3JRvDyiemltIIU7MUaps/ZRWhGixI3K6JqUVm0MqRW6jYCkpC1TC
A2kr6geAf63wSTgREK6EG/xDzeLuwShzBv+vFDrQ9SE0iT2VYNYr1LSC9HLAJCFp
dONpyk/loReXPCAtkq1Hb9Sm6Y4XxaicjuAMhgZANWlOHwm9tQqi/Ay9eM15Hoin
9nI+Jzrz28+l3XHx8QzOtmGQq4L6Llli9KzgX4xXwBm2Y5CuWiI2qBXNiwGpqiHM
2I+TLsf2+sepWEuXwFwqlmT2/OJSzGsifr+I7wLor6JEvPRD5A3tYyMw10AY2FnL
ULY/KT74NPTstAvQS/N4gbtdrkA6VovdgRUCscbIaxt+yyTc1p45sF4shh522FbI
UCy2
=FeX/
-----END PGP SIGNATURE-----

--KGpWYdeBO0G8utchYxvYf6mrD5icTf4Db--
