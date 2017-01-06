Received: from eggs.gnu.org ([2001:4830:134:3::10]:55095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cPZ6V-0005p4-C4
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cPZ6Q-0008Se-EV
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:19:03 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cPZ6Q-0008SA-7e
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:18:58 -0500
References: <20170103203502.25907-1-jcd@tribudubois.net>
	<66b3383c-65bc-f993-d25e-9871489039de@gmail.com>
	<ae9f5406-0296-1beb-98cb-12c9d47b2d91@tribudubois.net>
	<bdc29965-3c9a-8569-dd89-7506e5deea0a@gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <d4cf5c4e-499f-c99e-edde-6df0e7bf059b@tribudubois.net>
Date: Fri, 6 Jan 2017 19:18:50 +0100
MIME-Version: 1.0
In-Reply-To: <bdc29965-3c9a-8569-dd89-7506e5deea0a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] [i.MX] fix CS handling during SPI
 access.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org

Le 06/01/2017 à 13:28, mar.krzeminski a écrit :
>>> Please make sure that in HW ECSPI_CONFIGREG_SS_POL bits are 0's 
>>> after reset/power up (defaults).
>>
>> There is already a memset to 0 of all regs (including CONFIGREG) in 
>> the reset function.
> I saw that memset, my question is rather real HW also have 0s after 
> reset (could be important
> in some cases).

Yes, all registers are set to 0 at reset except STATREG which is set to 
3 (according to reference manual).

>
> Thanks,
> Marcin
