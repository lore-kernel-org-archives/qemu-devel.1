Received: from eggs.gnu.org ([209.51.188.92]:57333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDsPM-0001O6-J6
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDsPL-0005XS-J1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:11:32 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDsPL-0005Wy-B8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:11:31 -0400
Received: by mail-ot1-x341.google.com with SMTP id e5so15848561otk.12
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190409134536.15548-1-philmd@redhat.com>
	<20190409110456-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190409110456-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 16:11:18 +0100
Message-ID: <CAFEAcA_ndy914qg-6QdUUZP3SkMuX-3M3QUM3m-udYbvp7zDNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 0/2] roms: Avoid iPXE/EDK2
 EFIROM variable clash, pass CFLAGS to EDK2 build tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Olaf Hering <olaf@aepfle.de>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Tue, 9 Apr 2019 at 16:06, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 09, 2019 at 03:45:34PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi,
> >
> > Two trivial fixes to avoid the latest EDK2 testing series to
> > cause trouble to downstream distributions (in particular if
> > they have PIE enforced).
> >
> > Since v2:
> > - addressed Laszlo's suggestion
> > - reworded patch description
> >
> > v2: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01033.html
> > v1: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01006.html
> > error report: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg=
00992.html
> >
> > Regards,
> >
> > Phil.
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> Peter do you want to merge this directly?

Yes, I'll do that.

thanks
-- PMM
