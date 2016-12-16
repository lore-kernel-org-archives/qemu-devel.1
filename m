Received: from eggs.gnu.org ([2001:4830:134:3::10]:47437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHsD7-0001qD-6h
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHsD6-0001pU-C3
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:06:05 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:33495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHsD6-0001pI-0N
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:06:04 -0500
Received: by mail-ua0-x22b.google.com with SMTP id b35so9655960uaa.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 05:06:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481810970-9692-1-git-send-email-clg@kaod.org>
References: <1481810970-9692-1-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 13:05:43 +0000
Message-ID: <CAFEAcA-osZfCKuftxcz1y2TXFxRrzc0gqL0K7bBb-SyWsWxxiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] target-arm: Add VBAR support to ARM1176
 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 15 December 2016 at 14:09, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> ARM1176 CPUs have TrustZone support and can use the Vector Base
> Address Register, but currently, qemu only adds VBAR support to ARMv7
> CPUs. Fix this by adding a new feature ARM_FEATURE_VBAR which can used
> for ARMv7 and ARM1176 CPUs.
>
> The VBAR feature is always set for ARMv7 because some legacy boards
> require it even if this is not architecturally correct.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>
>  Hopefully, this is correct this time ...

Yep, looks good to me. Applied to target-arm.next, thanks.

-- PMM
