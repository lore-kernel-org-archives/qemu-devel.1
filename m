Received: from eggs.gnu.org ([2001:4830:134:3::10]:39823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gPRWK-0005DT-PT
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gPRWA-0005l4-QR
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:22:14 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:43669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gPRWA-0005iu-IC
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:22:06 -0500
Received: by mail-yw1-xc43.google.com with SMTP id l200so2132655ywe.10
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 04:22:05 -0800 (PST)
MIME-Version: 1.0
References: <20181120203811.18406-1-jcmvbkbc@gmail.com>
	<3526a4e0-2b26-dfc5-4b81-9fdf94734398@redhat.com>
In-Reply-To: <3526a4e0-2b26-dfc5-4b81-9fdf94734398@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 21 Nov 2018 04:21:53 -0800
Message-ID: <CAMo8Bf+oCDyOmpj9mNZF1nL3X7JgZU5fidDd-LZNGEG9dOPHew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: xtfpga: provide default
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

Hi Philippe,

thanks for your review.

On Wed, Nov 21, 2018 at 4:00 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 20/11/18 21:38, Max Filippov wrote:
> >   static const TypeInfo xtfpga_lx200_nommu_type =3D {
> > @@ -632,6 +636,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc=
, void *data)
> >       mc->init =3D xtfpga_ml605_init;
> >       mc->max_cpus =3D 4;
> >       mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
> > +    mc->default_ram_size =3D 256 * MiB;
>
> Isn't it 512 MB for the ML605?

There's 512MB on the board, but the Tensilica prototyping
user's guide for the ML605 only documents 256MB in the memory
map section. But now that you've mentioned it I recall that in reality
both ML605 and KC705 had all onboard memory minus 128MB
mapped for cores with MMU.

> >   }
> >
> >   static const TypeInfo xtfpga_ml605_type =3D {
> > @@ -648,6 +653,7 @@ static void xtfpga_ml605_nommu_class_init(ObjectCla=
ss *oc, void *data)
> >       mc->init =3D xtfpga_ml605_nommu_init;
> >       mc->max_cpus =3D 4;
> >       mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_NOMMU_TYPE;
> > +    mc->default_ram_size =3D 256 * MiB;
>
> Ditto.

For noMMU cores there's only 256MB window available for
the system memory, so it's capped at 256MB.

I'll send an updated v2.

--=20
Thanks.
-- Max
