Received: from eggs.gnu.org ([2001:4830:134:3::10]:58653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dv4Q6-0000xS-2I
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dv4Q5-0003Qe-An
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:33:46 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:48884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dv4Q5-0003Q8-43
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:33:45 -0400
Received: by mail-wm0-x232.google.com with SMTP id m127so3453047wmm.3
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 09:33:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170920201737.25723-1-f4bug@amsat.org>
References: <20170920201737.25723-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:33:23 +0100
Message-ID: <CAFEAcA_0CHhQwA-zjsEseA8D==iz401G6CrwGoN33Nwp7GV+ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 0/5] Add support for Smartfusion2 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 20 September 2017 at 21:17, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> Hi Peter,
>
> Now than Igor's patch landed, I respin Sundeep's series updating it to wo=
rk
> after the "arm: drop intermediate cpu_model -> cpu type parsing and use c=
pu
> type directly" patch.
>
> v11:
> - msf2-soc.c: add a check for null m3clk
> - msf2-soc.c, msf2-som.c: drop cpu_model to directly use cpu type
>
> --

Applied to target-arm.next.

Thanks to Sundeep for being so patient with our code review process,
and to Philippe and Alistair for doing the review and shepherding
the series through it.

thank
-- PMM
