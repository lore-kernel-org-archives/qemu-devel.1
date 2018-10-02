Received: from eggs.gnu.org ([2001:4830:134:3::10]:51341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7KXs-0004Zy-Ot
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7KXs-00049t-2H
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:17:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7KXr-00049k-Ti
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:16:59 -0400
Received: by mail-ot1-x342.google.com with SMTP id h15-v6so1807898otj.5
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 06:16:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-9-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-9-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 14:16:38 +0100
Message-ID: <CAFEAcA--vgw9sMbd1LgWbmbYpkexdEtfRDEJysD-E5DmPjMCtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/15] hw/mips/gt64xxx_pci: Mark as bridge
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 1 October 2018 at 23:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> The gt64120 is currently listed as uncategorized device.
> Mark it as bridge device.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/gt64xxx_pci.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Should this device be in hw/pci-host/ with the other PCI
host controller models ?

thanks
-- PMM
