Received: from eggs.gnu.org ([2001:4830:134:3::10]:42410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYsCh-00047u-F2
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYsCe-0001Xv-MT
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:40:58 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gYsCd-0001UF-09
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:40:56 -0500
Received: by mail-ot1-x343.google.com with SMTP id i20so12013536otl.0
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 04:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20181215184222.15127-1-clg@kaod.org>
	<20181217045022.GB5597@umbus.fritz.box>
In-Reply-To: <20181217045022.GB5597@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Dec 2018 12:40:27 +0000
Message-ID: <CAFEAcA_KV2hsXUZmCC1zNVi1kiGj6CzpcmMfT5iykzy8LWm7SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix compilation breakage on
 windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>

On Mon, 17 Dec 2018 at 05:01, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
>
> On Sat, Dec 15, 2018 at 07:42:22PM +0100, C=C3=A9dric Le Goater wrote:

> > -#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
> > -#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
> > -#define PPC_BIT8(bit)           (0x80UL >> (bit))
> > +#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> > +#define PPC_BIT32(bit)          (0x80000000ULL >> (bit))
> > +#define PPC_BIT8(bit)           (0x80ULL >> (bit))
>
> We shouldn't need the ULL for the 32-bit and (especially) 8-bit
> versions.

This is true, but I think "UL" is worth changing, as it's generally
not what you want, being a type that might be 32 or 64 bit.
Sensible suffix choices are "U", "ULL", or no suffix IMHO.

thanks
-- PMM
