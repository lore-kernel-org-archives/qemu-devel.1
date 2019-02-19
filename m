Received: from eggs.gnu.org ([209.51.188.92]:46958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw89u-0005Cg-6c
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw89s-0007om-5D
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:22:14 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw89q-0007nV-9j
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:22:12 -0500
Received: by mail-ot1-x344.google.com with SMTP id v62so26275599otb.3
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-7-armbru@redhat.com>
	<15b742d6-18e9-dfd6-dac2-2613c0b93e76@redhat.com>
In-Reply-To: <15b742d6-18e9-dfd6-dac2-2613c0b93e76@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 16:21:56 +0000
Message-ID: <CAFEAcA84KnN4GVnNyw1V7r2-=DLdNJEzwMQEn8e5ZGV2Vr_RQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/10] r2d: Flash memory creation is
 confused about size, mark FIXME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Tue, 19 Feb 2019 at 16:07, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 2/18/19 1:56 PM, Markus Armbruster wrote:
> Good news: when you read (0x0000, 0x0000, 0x0000, 0x0000) pflash IDs,
> that means the code uses the "Virt PFlash". IOW this is not a physical
> model, since the guest obviously doesn't care about checking the flash
> model.
> The "VirtPFlash" only has 64KiB sectors.
>
> I suggest we add a pflash_cfi02_create_virt(reduced args) helper to make
> this obvious:
>
>   pflash_cfi02_create_virt(paddr, name, size_bytes, mapping?).

What would this be, and when would you use it without a
/* FIXME this is not what the real hardware does */ ?

The real problem with most of these pflash creation calls
is that they're using bogus data for the flash device
(wrong IDs, wrong width, using the legacy weird implementation,
etc etc) because nobody cares much about the boards or has
real hardware to see what the hardware really is doing.

thanks
-- PMM
