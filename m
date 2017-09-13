Received: from eggs.gnu.org ([2001:4830:134:3::10]:37266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsBP7-0004zI-RJ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsBP6-00051T-UZ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:24:49 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1504812251-23438-1-git-send-email-sundeep.lkml@gmail.com>
	<1504812251-23438-5-git-send-email-sundeep.lkml@gmail.com>
	<26693abe-07a2-1744-1a8d-4d08941837c5@amsat.org>
	<CALHRZurB_6GT+KccybDgWb8bPdU89Ey1si46HnbQgsLuHYCh_w@mail.gmail.com>
	<CALHRZurVQzOX+U7OioHGiMKSoZNSOA77zqhyEGgp=H_5fKC7qg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f5ac4d0e-dc40-8ca4-c0a2-a7b34752549b@amsat.org>
Date: Wed, 13 Sep 2017 14:24:39 -0300
MIME-Version: 1.0
In-Reply-To: <CALHRZurVQzOX+U7OioHGiMKSoZNSOA77zqhyEGgp=H_5fKC7qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu devel v8 PATCH 4/5] msf2: Add Smartfusion2
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sundeep subbaraya <sundeep.lkml@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

Hi Sundeep,

On 09/13/2017 06:21 AM, sundeep subbaraya wrote:
> All patches got Reviewed-by. Do you want me to change alias to remap and
> send

This is just cosmetic for the "alias MSF2.eNVM.alias":

(qemu) info mtree
address-space: cpu-memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): armv7m-container
     0000000000000000-ffffffffffffffff (prio -1, i/o): system
       0000000000000000-000000000003ffff (prio 0, i/o): alias 
MSF2.eNVM.alias @MSF2.eNVM 0000000000000000-000000000003ffff
       0000000020000000-000000002000ffff (prio 0, ram): MSF2.eSRAM
       0000000060000000-000000006003ffff (prio 0, rom): MSF2.eNVM
       00000000a0000000-00000000a3ffffff (prio 0, ram): ddr-ram

 > v9 or wait so that you get time to review?

I have a draft for your patch 2, I'll send within the day.

Regards,

Phil.
