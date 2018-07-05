Received: from eggs.gnu.org ([2001:4830:134:3::10]:47996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb7ya-0007Hz-LD
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb7yZ-0007X3-Vb
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:23:28 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:35222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb7yZ-0007Vj-P2
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:23:27 -0400
Received: by mail-oi0-x235.google.com with SMTP id i12-v6so18346724oik.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 10:23:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9419467c-62a0-2bbc-1685-7eb9e3f40845@steffen-goertz.de>
References: <20180626093204.27612-1-contrib@steffen-goertz.de>
	<20180627094456.GB4325@stefanha-x1.localdomain>
	<CAFEAcA-j8z4TLN=Qo82JicSQ_=YnJnGjAoLiMOnyfmd1QtQo7w@mail.gmail.com>
	<20180703093113.GF16791@stefanha-x1.localdomain>
	<CAFEAcA-_LjPDWpVPt1mfGA815ur_6i_MjBMtFLqohFCaO0R9Uw@mail.gmail.com>
	<9419467c-62a0-2bbc-1685-7eb9e3f40845@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 18:23:06 +0100
Message-ID: <CAFEAcA_UBdBNyfKWGqZhGsx7qUPUJh_Zr2N52EA61mqgKRGcUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2] arm: Add NRF51 SOC non-volatile memory
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>

On 5 July 2018 at 18:14, Steffen G=C3=B6rtz <mail@steffen-goertz.de> wrote:
> I would like to provide all four devices (NVMC, CODE, FICR, UICR) from
> one module and rename nrf51_nvmc.[ch] to nrf51_nvm.[ch]. Is this
> acceptable or would you rather prefer three modules?

Yeah, that would be ok too.

thanks
-- PMM
