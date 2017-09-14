Received: from eggs.gnu.org ([2001:4830:134:3::10]:52788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsXjQ-0007LO-SA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsXjQ-0007sa-0T
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:15:16 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:51941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsXjP-0007re-Ob
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:15:15 -0400
Received: by mail-wr0-x22b.google.com with SMTP id z39so874534wrb.8
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 10:15:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504812251-23438-6-git-send-email-sundeep.lkml@gmail.com>
References: <1504812251-23438-1-git-send-email-sundeep.lkml@gmail.com>
	<1504812251-23438-6-git-send-email-sundeep.lkml@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:14:54 +0100
Message-ID: <CAFEAcA_D=4M2vyo4m2xPi_hFDCmoKHk5kLY3s1ota602ywgHTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel v8 PATCH 5/5] msf2: Add Emcraft's
 Smartfusion2 SOM kit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 7 September 2017 at 20:24, Subbaraya Sundeep <sundeep.lkml@gmail.com> wrote:
> Emulated Emcraft's Smartfusion2 System On Module starter
> kit.
> +static void emcraft_sf2_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "SmartFusion2 SOM kit from Emcraft (M2S010)";
> +    mc->init = emcraft_sf2_s2s010_init;
> +    mc->ignore_memory_transaction_failures = true;

Please don't set ignore_memory_transaction_failures in new boards.
This is a legacy-old-code-only flag.

New boards should define enough devices, either properly
or using create_unimplemented_device(), to make whatever code
they're being tested against run.

This is a firm requirement for this code to go into master,
because once we let a board in with the flag set it's almost
impossible to clear it because we don't know what guest
code that previously worked on the board will now break.

thanks
-- PMM
