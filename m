Received: from eggs.gnu.org ([209.51.188.92]:51427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go8X9-0008JS-Mp
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go8Mx-0004MC-81
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:58:39 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:43095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go8Mx-0004Kb-3Q
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:58:39 -0500
Received: by mail-ot1-x335.google.com with SMTP id a11so14806076otr.10
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 06:58:30 -0800 (PST)
MIME-Version: 1.0
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<20190128124027.776wwcqrckalvr7x@sirius.home.kraxel.org>
	<CAFEAcA-jwBhBXQb-SHT=b_Vy5Sq+M2iaMP2XtVn_2HQvzaEoVQ@mail.gmail.com>
	<5daf9f5e-cbda-8642-f4f6-46939fe223d1@redhat.com>
In-Reply-To: <5daf9f5e-cbda-8642-f4f6-46939fe223d1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 14:58:18 +0000
Message-ID: <CAFEAcA_XxEXVcvR-3DMQsWpu8YRYspdDQ5SsrNKHnKjNw0YA-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [libvirt] Configuring pflash devices for OVMF
 firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On Mon, 28 Jan 2019 at 14:56, Laszlo Ersek <lersek@redhat.com> wrote:
> Regarding OVMF, I kept the flash driver intentionally in the dark about
> split vs. unified pflash, so OVMF will not care, as long as the same
> GPAs behave the same as before.
>
> Regarding ArmVirtQemu, I'm not so sure. It think it already depends on
> two separate pflash chips, through the DTB that QEMU exposes. So
> unifying the chips (albeit with multiple regions) might actually confuse
> the firmware.

"virt" is a funny case because there is no underlying hardware
that we're trying to match. So it is whatever we say it is
and we've said it's two separate pflash chips. We don't need
to change that I think. (IIRC this is derived partly from
OVMF usecase requirements and partly from the vexpress devboards
having 2 flash chips.)

thanks
-- PMM
