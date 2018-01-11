Received: from eggs.gnu.org ([2001:4830:134:3::10]:57242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZaiK-0006zS-59
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 06:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZaiC-0002jc-4p
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 06:08:04 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZaiB-0002gp-Sx
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 06:07:55 -0500
Received: by mail-ot0-x244.google.com with SMTP id w4so1782132otg.3
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 03:07:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f3ed635d-8826-4776-587b-cead5f3709d3@ilande.co.uk>
References: <20180108193124.mjei33w5wopmadmk@kentang.home>
	<CAFEAcA-dOpPiiGA28agziDyi5QKn4ErGgPyG_vL9ixk9iKUv0g@mail.gmail.com>
	<f3ed635d-8826-4776-587b-cead5f3709d3@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 11:07:34 +0000
Message-ID: <CAFEAcA8ZJRr4mqviOu7BWK7WjWobvEWjeFigNh3A60GPtUFZiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 January 2018 at 22:18, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Thanks for the hint - while it didn't crash locally, I was certainly able to
> reproduce the above trace in valgrind.
>
> Turns out the issue was that thought I could move pci_register_bus() from
> realize to init in patch 10, but evidently not :)
>
> I've moved it back and repushed the signed tag if you can try and apply the
> PR once again?

Applied updated version, thanks.

-- PMM
