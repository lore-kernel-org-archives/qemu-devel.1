Received: from eggs.gnu.org ([2001:4830:134:3::10]:55858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYYcE-0004Cf-RV
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYYcD-000683-Ts
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:13:46 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYYcD-00066B-Nh
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:13:45 -0400
Received: by mail-oi0-x243.google.com with SMTP id c6-v6so5535094oiy.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:13:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180626215955.18933-1-jcd@tribudubois.net>
References: <20180626215955.18933-1-jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 16:13:24 +0100
Message-ID: <CAFEAcA_w7XjKyQZAB91ma-X89H5YhG-EU63RM+8E-hYbX02iaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] i.mx7d fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Andrey Smirnov <andrew.smirnov@gmail.com>

On 26 June 2018 at 22:59, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
> Small fixes in the i.mx7d code.
>
> Jean-Christophe Dubois (3):
>   i.mx7d: Remove unused header files
>   i.mx7d: Change SRC unimpleted device name from sdma to src
>   i.mx7d: Change IRQ number type from hwaddr to int
>
>  hw/arm/fsl-imx7.c      | 8 ++++----
>  hw/arm/mcimx7d-sabre.c | 2 --
>  2 files changed, 4 insertions(+), 6 deletions(-)

Thanks, applied all to target-arm.next.

Something seems to have gone wrong with posting of this series:
the patches didn't get sent as followups to the cover letter
(missing In-reply-to: headers). You might want to look into that
for future patch postings.

-- PMM
