Received: from eggs.gnu.org ([2001:4830:134:3::10]:53743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gJj5N-0000B9-KX
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gJj5M-00040n-Lt
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:54:49 -0500
MIME-Version: 1.0
References: <CAFEAcA_mT2FT=t+Fw7=7aUgDkX1b64oqFS99_jFN7_12MRCx+g@mail.gmail.com>
In-Reply-To: <CAFEAcA_mT2FT=t+Fw7=7aUgDkX1b64oqFS99_jFN7_12MRCx+g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Nov 2018 09:54:02 -0800
Message-ID: <CAKmqyKPuKUUkXuFW9v6Zo+Yid_U9ye_Dx5Nai5273NYSD7B+2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] coverity-spotted memory leak in hw/riscv/spike.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Mon, Nov 5, 2018 at 5:42 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Hi; Coverity has noticed a memory leak in hw/riscv/spike.c:
> it malloc()s memory into config_string(), but never frees it.
> (CID 1391015). This isn't a very serious leak since the function
> only ever runs once, but it would be nice to fix this for 3.1
> (it is the only coverity error in the riscv code, and one of
> just 8 unaddressed for QEMU as a whole).
>
> Incidentally, "malloc and then snprintf" would be better
> done using g_strdup_printf(), which automatically allocates
> sufficient memory for the string, avoiding the need to
> try to pre-calculate the right size.

I can check this out today. Thanks for pointing it out.

Alistair

>
> thanks
> -- PMM
>
