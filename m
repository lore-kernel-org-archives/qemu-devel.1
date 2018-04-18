Received: from eggs.gnu.org ([2001:4830:134:3::10]:55099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8nTB-0004VJ-IH
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8nT8-0008Tv-AV
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:49:57 -0400
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
	<CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
	<20180416184406.GC14488@redhat.com>
	<CAFEAcA_uS7f-uf+-OkcskdHG3=eTgr92Mw46nk430q27-wve4g@mail.gmail.com>
	<19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
	<CAJ+F1CJ4HurD8=OC+qhHSEuNDkO7_QQaiJtH_RVHSu4-xzrqag@mail.gmail.com>
	<CAFEAcA-2kTYvJYWwsBwYHv+45y32uPYj+2Ut9VnZhTQwsKyhDQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <448a7d28-0ccd-28a7-9dfd-a729678f2785@redhat.com>
Date: Wed, 18 Apr 2018 15:49:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-2kTYvJYWwsBwYHv+45y32uPYj+2Ut9VnZhTQwsKyhDQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 18/04/2018 14:06, Peter Maydell wrote:
>=20
>> In case of a mux chardev, it may already
>> have an active frontend (yeah be is CharBackend which is the frontend,
>> I still can't grasp that either, please Paolo change your mind! ;).
> I agree with Marc-Andr=C3=A9 that the terminology for our chardev
> code is hopelessly confusing. The things that are logically
> backends (file, stdio, etc) are called "chardevs", and the
> thing that is called the CharBackend is, well, I don't know
> what it is. include/chardev/char.h has a helpful comment:
>      /* character device */
>      typedef struct CharBackend CharBackend;
>=20
> The doc comments for functions like qemu_chr_new() that return
> a Chardev* say they "create a new character backend".
>=20
> And then there's ChardevBackend, which is something else again.

Since CharBackend was named like that for consistency with BlockBackend,
ChardevBackend could be changed to ChardevOptions and
CHARDEV_BACKEND_KIND_* to CHARDEV_DRIVER_*.  That would be a good idea
indeed.

Paolo
