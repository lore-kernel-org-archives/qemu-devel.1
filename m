Received: from eggs.gnu.org ([2001:4830:134:3::10]:54246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSEf-0004KN-7b
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSEe-0001vo-Ao
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:29:09 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:41929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebSEe-0001vT-6P
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:29:08 -0500
Received: by mail-ot0-x22f.google.com with SMTP id 44so12851683otk.8
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:29:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-4-andrew.smirnov@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-4-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 14:28:47 +0000
Message-ID: <CAFEAcA-kpmTmBSxxdmDOEiYR_=X45t_O6MU-CBM85NLb22mNxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/14] i.MX: Add code to emulate i.MX7
 CCM, PMU and ANALOG IP blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 16 January 2018 at 01:36, Andrey Smirnov <andrew.smirnov@gmail.com> wrot=
e:
> Add minimal code needed to allow upstream Linux guest to boot.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/misc/Makefile.objs      |   1 +
>  hw/misc/imx7_ccm.c         | 277 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/misc/imx7_ccm.h | 139 +++++++++++++++++++++++
>  3 files changed, 417 insertions(+)
>  create mode 100644 hw/misc/imx7_ccm.c
>  create mode 100644 include/hw/misc/imx7_ccm.h
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
