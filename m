Received: from eggs.gnu.org ([209.51.188.92]:36761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1cfw-00024w-HL
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 14:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1cfu-0007GS-V3
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 14:58:00 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1cfu-0007Et-KR
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 14:57:58 -0500
Received: by mail-ot1-x344.google.com with SMTP id g1so11889568otj.11
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 11:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20190304181813.8075-1-cota@braap.org>
	<2adf8423-458d-27c3-67bf-d4775104ad43@linaro.org>
In-Reply-To: <2adf8423-458d-27c3-67bf-d4775104ad43@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Mar 2019 19:57:44 +0000
Message-ID: <CAFEAcA_z=ky-8XPLKxXEXJxAj+M5TWv7ZNrB1B0rJ2_Jna8GUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 00/73] per-CPU locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Alistair Francis <alistair23@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Anthony Green <green@moxielogic.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Chris Wulff <crwulff@gmail.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, Laurent Vivier <laurent@vivier.eu>, Marek Vasut <marex@denx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Stafford Horne <shorne@gmail.com>

On Wed, 6 Mar 2019 at 19:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
> I had hoped that I would have been able to reproduce this on another host by
> forcing rr mode.  But so far no luck.

Have you tried rr's "chaos mode" switch?

thanks
-- PMM
