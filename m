Received: from eggs.gnu.org ([2001:4830:134:3::10]:55569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5NhP-0008RH-3q
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5NhK-00068P-5g
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:10:15 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171019151249.13663-1-clg@kaod.org>
	<20171019151249.13663-2-clg@kaod.org>
	<CAFEAcA-6gXF9skgYRTke5-0Ds_SLceAgX-Dz6WyyuiYJSz7afw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <114c397f-7540-15ca-a44d-0b3a4cdcc238@amsat.org>
Date: Fri, 20 Oct 2017 00:10:02 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-6gXF9skgYRTke5-0Ds_SLceAgX-Dz6WyyuiYJSz7afw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 1/8] aspeed: use a ROM memory region to
 catch invalid writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>

On 10/19/2017 12:44 PM, Peter Maydell wrote:
> On 19 October 2017 at 16:12, Cédric Le Goater <clg@kaod.org> wrote:
>> Some legacy firmwares access unimplemented addresses on the Aspeed SoC
>> (old U-Boot code using variables in the bss when it shouldn't do).
>> Let's use a ROM memory region to catch the invalid writes and support
>> new boards without using the 'ignore_memory_transaction_failures'
>> flag.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>
>>  Changes since v4 :
>>
>>  - use a ROM memory region
> 
> Probably worth mentioning in the commit message that this
> is a migration compatibility break for these boards.

What about the eeprom_buf from patch 6 "Add EEPROM I2C devices"?

My understanding is a migrated board would resume with a zeroized
eeprom, is this the expected behaviour?

Regards,

Phil.
