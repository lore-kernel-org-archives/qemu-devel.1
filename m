Received: from eggs.gnu.org ([2001:4830:134:3::10]:43669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cWI91-00043v-WF
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cWI8x-0000ST-7H
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:37:28 -0500
Received: from clearmind.me ([178.32.49.9]:49887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1cWI8x-0000SJ-0f
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:37:23 -0500
Date: Wed, 25 Jan 2017 08:38:28 +0100
From: Alessandro Di Federico <ale+qemu@clearmind.me>
In-Reply-To: <CAJ+F1C+B1Ncoh57a1cHUKfum1DVNs3-WbzgbaRSEmqiuxnYJ7w@mail.gmail.com>
References: <20170121084600.5860-1-ale+qemu@clearmind.me>
	<20170121084600.5860-3-ale+qemu@clearmind.me>
	<CAJ+F1C+B1Ncoh57a1cHUKfum1DVNs3-WbzgbaRSEmqiuxnYJ7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1cWIBi-0000iH-R3@clearmind.me>
Sender: ale@clearmind.me
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] *-user targets object files
 decoupling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

On Tue, 24 Jan 2017 10:09:25 +0000
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

>
> diff --git a/exec.c b/exec.c
> index 47835c1dc1..66f8187281 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -672,9 +672,11 @@ void cpu_exec_unrealizefn(CPUState *cpu)
>      if (cc->vmsd !=3D NULL) {
>          vmstate_unregister(NULL, cc->vmsd, cpu);
>      }
> +#ifndef CONFIG_USER_ONLY
>      if (qdev_get_vmsd(DEVICE(cpu)) =3D=3D NULL) {
>          vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
>      }
> +#endif
>=20
>=20
> Shouldn't this #ifndef block also include the vmsd
> vmstate_unregister() above? That would be matching
> cpu_exec_realizefn() #ifndef.
>=20

IIRC the idea here was to break a depency introduced by
"vmstate_cpu_common".
I'll include the previous if statement in the `ifndef`.

Let me know if I missed a comment on this patch.

--
Alessandro Di Federico
PhD student at Politecnico di Milano
