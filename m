Received: from eggs.gnu.org ([2001:4830:134:3::10]:56254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fmg3R-0002eI-FO
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fmg3L-0003Jm-Uw
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:00:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fmg3L-0003J9-NO
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:00:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id h14-v6so12450104wrw.13
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:00:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806100114.21410-2-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-2-contrib@steffen-goertz.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 6 Aug 2018 15:00:03 +0100
Message-ID: <CAJSP0QXO5z9OCjFY5zgbWOeAUcpo1h-_Sqb1MQrZOiETRDntnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] hw/misc/nrf51_rng: Add NRF51 random
 number generator peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Mon, Aug 6, 2018 at 11:01 AM, Steffen G=C3=B6rtz
<contrib@steffen-goertz.de> wrote:
> +#define NRF51_TRIGGER_TASK 0x01
> +#define NRF51_EVENT_CLEAR  0x00

Please consider putting these generic constants into hw/arm/nrf51.h or
a similar file that all nRF51 devices can include.  That way code
duplication is eliminated.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
