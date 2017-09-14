Received: from eggs.gnu.org ([2001:4830:134:3::10]:53770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsXlV-0000K9-Cu
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsXlU-0002MW-J6
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:17:25 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:43236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsXlU-0002LU-DF
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:17:24 -0400
Received: by mail-wr0-x22e.google.com with SMTP id a43so12073wrc.0
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 10:17:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKONrzpGxwvirPcb+-XZk=9WhwWKcSD_=BicmTQ2ZLQFEA@mail.gmail.com>
References: <1504812251-23438-1-git-send-email-sundeep.lkml@gmail.com>
	<2b183ac5-36d8-1da6-cbac-4c6366f23261@amsat.org>
	<CALHRZuoJjSkSYaM9xz8xo2R-=oQEx5a1bkhSirc=NmEpxeG2AQ@mail.gmail.com>
	<28d6a84f-3a32-78ea-7a87-055fb14e1641@amsat.org>
	<CAKmqyKONrzpGxwvirPcb+-XZk=9WhwWKcSD_=BicmTQ2ZLQFEA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:17:02 +0100
Message-ID: <CAFEAcA-Dz_xw3pXTHg9kV2qT+fw=jfgrdw63QeWHCnSxKb0e+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel v8 PATCH 0/5] Add support for
 Smartfusion2 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, sundeep subbaraya <sundeep.lkml@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 14 September 2017 at 18:06, Alistair Francis <alistair23@gmail.com> wrote:
> Once you have all the devices there you can enable bus access errors
> as well. That's a future patch set though.

Ah, I hadn't noticed this code was opting out of bus access
errors; I don't want to permit new boards which do that,
so we do need to fix that in this round. (I just sent an
email to that effect in reply to patch 1.)

thanks
-- PMM
