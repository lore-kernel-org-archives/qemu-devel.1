Received: from eggs.gnu.org ([2001:4830:134:3::10]:33697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkC2z-0001i0-8w
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkC2y-0007lK-En
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:33:29 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkC2y-0007l4-8u
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:33:28 -0400
Received: by mail-oi0-x241.google.com with SMTP id v8-v6so22760563oie.5
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 10:33:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725085944.11856-4-stefanha@redhat.com>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-4-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 18:33:07 +0100
Message-ID: <CAFEAcA9N370ujtaJ-jHy==sOqwq42sOYw3PWt6oATYMha=QW=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/7] hw/arm: make bitbanded IO optional
 on ARM M Profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Alistair Francis <alistair@alistair23.me>, Liviu Ionescu <ilg@livius.net>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Steffen Gortz <qemu.ml@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>

On 25 July 2018 at 09:59, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Some ARM CPUs have bitbanded IO, a memory region that allows convenient
> bit access via 32-bit memory loads/stores.  This eliminates the need for
> read-modify-update instruction sequences.
>
> This patch makes this optional feature a ARMMProfile qdev property,
> allowing boards to choose whether they want bitbanding or not.
>
> Status of boards:
>  * iotkit (Cortex M33), no bitband
>  * mps2 (Cortex M3), bitband
>  * msf2 (Cortex M3), bitband
>  * stellaris (Cortex M3), bitband
>  * stm32f205 (Cortex M3), bitband
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
