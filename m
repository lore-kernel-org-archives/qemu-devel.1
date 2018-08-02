Received: from eggs.gnu.org ([2001:4830:134:3::10]:58895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flFwB-0003D8-J8
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flFwA-0007qF-Tv
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:54:51 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1flFwA-0007px-NL
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:54:50 -0400
Received: by mail-oi0-x241.google.com with SMTP id j205-v6so4618865oib.4
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 08:54:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <511b7c57-b182-43a0-44ce-e0e95cbbf5ca@amsat.org>
References: <20180802144430.13870-1-peter.maydell@linaro.org>
	<20180802144430.13870-2-peter.maydell@linaro.org>
	<511b7c57-b182-43a0-44ce-e0e95cbbf5ca@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Aug 2018 16:54:29 +0100
Message-ID: <CAFEAcA-8rZisuN7fzop8VWsX0CLn5Q6wz86=stE78JDBPGU+hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/ppc/prep: Remove ifdeffed-out stub
 of XCSR code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>, "patches@linaro.org" <patches@linaro.org>

On 2 August 2018 at 16:45, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> While not directly use the harmless UnimplementedDevice?
>
>        create_unimplemented_device("ppc-xcsr", 0xfeff0000, 0x1000);

I preferred not to change the current behaviour for this
API conversion. If the PPC/prep maintainers would like to
use unimplemented-device they can easily do so as a a
different patch...

thanks
-- PMM
