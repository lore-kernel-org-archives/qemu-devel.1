Received: from eggs.gnu.org ([2001:4830:134:3::10]:34585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4nkl-0006aV-JW
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4nkh-0003LE-Mk
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:47:19 -0400
References: <20171017164426.25277-1-f4bug@amsat.org>
	<20171017164426.25277-41-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <353e9bc4-ad88-c211-a8c3-4969c093cffd@redhat.com>
Date: Wed, 18 Oct 2017 14:47:06 +0200
MIME-Version: 1.0
In-Reply-To: <20171017164426.25277-41-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 40/42] i386/pc: move vmport.c to hw/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 17.10.2017 18:44, Philippe Mathieu-Daud=C3=A9 wrote:
> It's a x86-only device, so it does not make sense to keep it
> in the shared misc folder.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/{misc =3D> i386}/vmport.c | 0
>  hw/i386/Makefile.objs      | 1 +
>  hw/misc/Makefile.objs      | 2 --
>  3 files changed, 1 insertion(+), 2 deletions(-)
>  rename hw/{misc =3D> i386}/vmport.c (100%)

Reviewed-by: Thomas Huth <thuth@redhat.com>
