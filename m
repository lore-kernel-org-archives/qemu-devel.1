Received: from eggs.gnu.org ([208.118.235.92]:57458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfMP8-0007Kc-R8
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfMP6-0004bV-U0
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:08:38 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfMP6-0004aN-PC
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:08:36 -0500
Received: by mail-ot1-x344.google.com with SMTP id a11so31676369otr.10
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 02:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20190104090610.652-1-clg@kaod.org>
In-Reply-To: <20190104090610.652-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 10:08:23 +0000
Message-ID: <CAFEAcA9qKgxY=u4YdymWz3oEDx8Fu-Z5_PfSaznxuWWY-m+=ZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr: return from post_load method when
 RTC import fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 4 Jan 2019 at 09:07, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The error value can be squashed by the section handling radix migration.
> Simply bail out if an error occurs when the RTC offset is imported.
>
> Fixes: d39c90f5f3ae ("spapr: Fix migration of Radix guests")

You could also mention that this fixes the Coverity
issue CID 1398591.

thanks
-- PMM
