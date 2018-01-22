Received: from eggs.gnu.org ([2001:4830:134:3::10]:54869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edew3-0005pS-HZ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edew2-0006Q1-Nl
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:27:03 -0500
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:42709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edew2-0006Oc-HU
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:27:02 -0500
Received: by mail-oi0-x232.google.com with SMTP id c8so5861976oiy.9
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:27:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <016e04bd-3ee3-dffc-943f-394c8583c886@samsung.com>
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
	<CGME20180119162746epcas1p2143cef3a97b076ce3fbc0b79d7d347b7@epcas1p2.samsung.com>
	<d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
	<f399b096-6e75-c04f-bb02-80e327de45c4@samsung.com>
	<CAFEAcA-S5yB-3itnRJ41JriJYbsu2EKs9qjPjMC0488vsCZrRw@mail.gmail.com>
	<87h8rg2jdh.fsf@secure.laptop>
	<CAFEAcA-4HcQwWk2rEUuUc2PyGP8hnopbrL2zVOLiCayP3S7FrQ@mail.gmail.com>
	<016e04bd-3ee3-dffc-943f-394c8583c886@samsung.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 16:26:41 +0000
Message-ID: <CAFEAcA8wsQ7drfnyNbYHWcuNri4rn30BuE-4dXAnNFw_RZjxkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 22 January 2018 at 16:25, Alexey Perevalov <a.perevalov@samsung.com> wrote:
> I want to keep 64bit atomic operations in migration.

Sorry, you can't -- some 32 bit CPUs simply do not provide these
operations. You need to rework your design to not require this.

thanks
-- PMM
