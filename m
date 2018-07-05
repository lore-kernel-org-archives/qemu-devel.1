Received: from eggs.gnu.org ([2001:4830:134:3::10]:53509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb32S-0006W6-UP
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb32R-0002gC-QY
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:07:08 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb32R-0002do-Dm
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:07:07 -0400
Received: by mail-oi0-x244.google.com with SMTP id 13-v6so16380108ois.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 05:07:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d9228ff1-bdfa-506c-e32f-d0fbb69578be@mail.ru>
References: <20180704195812.28798-1-jusual@mail.ru>
	<20180704195812.28798-2-jusual@mail.ru>
	<CAFEAcA_ojVz=2Kbivr8b-VQQRCJUwnOf4w+pLAb4AoukMd8c_g@mail.gmail.com>
	<d9228ff1-bdfa-506c-e32f-d0fbb69578be@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 13:06:46 +0100
Message-ID: <CAFEAcA-dP0vRB4P1k-sQqs-E_H3ibfObGKXh8CJZ74+hy=4Fzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] nvic: Handle ARMv6-M SCS reserved
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 5 July 2018 at 12:25, Julia Suvorova <jusual@mail.ru> wrote:
> Thank you for the review. I did not dare to set the ARM_FEATURE_M_MAIN,
> because I was not completely sure about the v8M behavior in certain cases.
> I'll update the code taking into account all the comments, and send v2.

FWIW, I was working from the v8M Arm ARM, which is downloadable from
https://developer.arm.com/products/architecture/m-profile/docs
-- the descriptions for each register include a "Configurations"
sections which will say if the register is present only if
the main extension is implemented.

thanks
-- PMM
