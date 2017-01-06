Received: from eggs.gnu.org ([2001:4830:134:3::10]:60977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cPZZS-0003we-G1
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cPZZP-0005rh-Bi
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:48:58 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cPZZP-0005r5-3h
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:48:55 -0500
Received: by mail-lf0-x241.google.com with SMTP id q89so603632lfi.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 10:48:54 -0800 (PST)
References: <20170103203502.25907-1-jcd@tribudubois.net>
	<66b3383c-65bc-f993-d25e-9871489039de@gmail.com>
	<ae9f5406-0296-1beb-98cb-12c9d47b2d91@tribudubois.net>
	<bdc29965-3c9a-8569-dd89-7506e5deea0a@gmail.com>
	<d4cf5c4e-499f-c99e-edde-6df0e7bf059b@tribudubois.net>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <ee0812b8-e416-6fb8-82c1-f0b07cb1a348@gmail.com>
Date: Fri, 6 Jan 2017 19:48:51 +0100
MIME-Version: 1.0
In-Reply-To: <d4cf5c4e-499f-c99e-edde-6df0e7bf059b@tribudubois.net>
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
To: Jean-Christophe DUBOIS <jcd@tribudubois.net>, qemu-devel@nongnu.org, peter.maydell@linaro.org



W dniu 06.01.2017 o 19:18, Jean-Christophe DUBOIS pisze:
> Le 06/01/2017 à 13:28, mar.krzeminski a écrit :
>>>> Please make sure that in HW ECSPI_CONFIGREG_SS_POL bits are 0's 
>>>> after reset/power up (defaults).
>>>
>>> There is already a memset to 0 of all regs (including CONFIGREG) in 
>>> the reset function.
>> I saw that memset, my question is rather real HW also have 0s after 
>> reset (could be important
>> in some cases).
>
> Yes, all registers are set to 0 at reset except STATREG which is set 
> to 3 (according to reference manual).
>
Thanks!
>>
>> Thanks,
>> Marcin
>
>
