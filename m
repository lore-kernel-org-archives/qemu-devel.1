Received: from eggs.gnu.org ([2001:4830:134:3::10]:46104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7JBY-0002Si-Jc
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7JBX-0006Ib-QZ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:45:20 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7JBX-0006IC-KT
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:45:19 -0400
Received: by mail-wr0-x243.google.com with SMTP id z55so17464271wrz.1
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 03:45:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508006342-5304-10-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508006342-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508006342-5304-10-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Oct 2017 11:44:58 +0100
Message-ID: <CAFEAcA-o2ZRHgdCL-fO9xy2Y1-DmMGrA3hDSx_PP99w3ygH7CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCHv3 09/13] lance: move TYPE_LANCE and
 SysBusPCNetState from lance.c to sun4m.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Jason Wang <jasowang@redhat.com>

On 14 October 2017 at 19:38, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> This enables them to be used outside of lance.c.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/lance.c           |    9 ---------
>  include/hw/sparc/sun4m.h |   13 +++++++++++++
>  2 files changed, 13 insertions(+), 9 deletions(-)


I would suggest creating a new header file for this device,
include/hw/net/lance.h, rather than stuffing it into the sun4m.h header.
(That kind of header is a bit of a legacy from when we had
ad-hoc header organization, so in general we'd expect things to
go out of it rather than be added to it...)


thanks
-- PMM
