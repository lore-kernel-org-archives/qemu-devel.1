Received: from eggs.gnu.org ([2001:4830:134:3::10]:42972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gPXaE-0005ZW-So
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gPXaE-0000M6-5R
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:50:42 -0500
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:35586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gPXa6-0008Oy-TP
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:50:36 -0500
Received: by mail-yw1-xc42.google.com with SMTP id h32so2668439ywk.2
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 10:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20181121122910.20631-1-jcmvbkbc@gmail.com>
	<4aceda96-cd6c-1c82-dfea-42ebf3eef963@redhat.com>
In-Reply-To: <4aceda96-cd6c-1c82-dfea-42ebf3eef963@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 21 Nov 2018 10:50:15 -0800
Message-ID: <CAMo8BfK1uxjqZJDJ6n04TjZMzA1Xwh=LyE=7JhyMwG9d387_Fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/xtensa: xtfpga: provide default
 memory sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Nov 21, 2018 at 10:34 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> >   static const TypeInfo xtfpga_lx200_nommu_type =3D {
> > @@ -632,6 +636,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc=
, void *data)
> >       mc->init =3D xtfpga_ml605_init;
> >       mc->max_cpus =3D 4;
> >       mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
> > +    mc->default_ram_size =3D 384 * MiB;
>
> Hmm this is now correct but I feel we are hiding information to further
> reviewers/developers. Without reading your v1 comment and looking at the
> new code I'd wonder why 384 and not 512.
>
> What about adding a definition such:
>
> #define XTENSA_CPU_MMU_RESERVED_IO_SIZE (128 * MiB)
>
> Then use:
>
>      mc->default_ram_size =3D 512 * MiB - XTENSA_CPU_MMU_RESERVED_IO_SIZE=
;

I'm not sure what's the reason that 128MB are reserved, and I'm sure
it's not a property of the CPU, but rather how it's wired to the board.
I'll call it
XTFPGA_MMU_RESERVED_MEMORY_SIZE
in the v3.

> If this patch goes thru your tree and you agree with the suggested
> changes, then you can directly add:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

--=20
Thanks.
-- Max
