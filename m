Received: from eggs.gnu.org ([2001:4830:134:3::10]:55721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erNfK-0005ot-N8
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erNfJ-0001W0-VD
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:50:30 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:34141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erNfJ-0001Vn-QH
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:50:29 -0500
Received: by mail-oi0-x229.google.com with SMTP id c83so4379523oib.1
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 04:50:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180221113012.2ee836fb@redhat.com>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-20-peter.maydell@linaro.org>
	<20180221113012.2ee836fb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 12:50:08 +0000
Message-ID: <CAFEAcA-i9LF26THZz8+RbJ0sv4iq9HJJ-aK2d_BrT=wu2BVavQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 19/19] mps2-an505: New board model: MPS2
 with AN505 Cortex-M33 FPGA image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 21 February 2018 at 10:30, Igor Mammedov <imammedo@redhat.com> wrote:
> On Tue, 20 Feb 2018 18:03:25 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>

>> +typedef struct {
>> +    MachineClass parent;
>> +    MPS2TZFPGAType fpga_type;
>> +    const char *cpu_model;
> I don't see it used in this patch, should it be removed?
>

You're right; this was a leftover from when I started out
with something that looked more like hw/arm/mps2.c. I'll just
delete the struct member.

thanks
-- PMM
