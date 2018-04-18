Received: from eggs.gnu.org ([2001:4830:134:3::10]:54787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8kkM-0005I8-RW
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8kkJ-00037I-Ov
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:55:30 -0400
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
	<CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
	<20180416184406.GC14488@redhat.com>
	<CAFEAcA_uS7f-uf+-OkcskdHG3=eTgr92Mw46nk430q27-wve4g@mail.gmail.com>
	<19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
	<CAJ+F1CJ4HurD8=OC+qhHSEuNDkO7_QQaiJtH_RVHSu4-xzrqag@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <860de622-d4cc-d1bf-ae27-e4d70d5d22f0@redhat.com>
Date: Wed, 18 Apr 2018 12:55:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJ4HurD8=OC+qhHSEuNDkO7_QQaiJtH_RVHSu4-xzrqag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 18/04/2018 12:36, Marc-Andr=C3=A9 Lureau wrote:
>=20
> +            if (chr =3D=3D NULL || chr->be) {
> +                name =3D g_strdup_printf("discarding-serial%d", i);
> +                chr =3D qemu_chr_new(name, "null");
> +            } else {
> +                name =3D g_strdup_printf("serial%d", i);
> +            }
>=20
> Why do you check if chr->be ? In case of a mux chardev, it may already
> have an active frontend (yeah be is CharBackend which is the frontend,
> I still can't grasp that either, please Paolo change your mind! ;).

CharBackend is not the frontend, it is *used* by the front-end.  It is
the qemu_chr_* functions that are named wrong (they're named according
to the user rather than the recipient).

Paolo
