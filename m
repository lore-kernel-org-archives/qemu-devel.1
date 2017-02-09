Received: from eggs.gnu.org ([2001:4830:134:3::10]:34684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cbsTG-0004ms-Pv
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cbsTC-0001vK-QK
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:25:26 -0500
Received: from mail-out.m-online.net ([2001:a60:0:28:0:1:25:1]:49237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cbsTC-0001v8-J6
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:25:22 -0500
References: <1486595166-34097-1-git-send-email-juro.bystricky@intel.com>
	<1486595166-34097-2-git-send-email-juro.bystricky@intel.com>
	<4c51c959-fe9c-b27f-552a-84d8a2fe68c1@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FB1B4@ORSMSX112.amr.corp.intel.com>
	<ad0b171b-ae9d-11f9-15e8-c500cd4ef5c2@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FB84B@ORSMSX112.amr.corp.intel.com>
	<8a5c3932-5ca6-6127-35b4-b8b8f57d923f@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FBCB0@ORSMSX112.amr.corp.intel.com>
	<55a9d36b-c848-fd5f-623d-0456bfcaae40@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FBD03@ORSMSX112.amr.corp.intel.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <73cda6b5-245f-8753-f085-7defbd2fc167@denx.de>
Date: Thu, 9 Feb 2017 18:25:16 +0100
MIME-Version: 1.0
In-Reply-To: <6E51916E4A1F32428260031F4C7CD2B6118FBD03@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] nios2: Add Altera JTAG UART
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Bystricky, Juro" <juro.bystricky@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "crwulff@gmail.com" <crwulff@gmail.com>, "jurobystricky@hotmail.com" <jurobystricky@hotmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>

On 02/09/2017 05:34 PM, Bystricky, Juro wrote:
>> The code running on nios2 can issue unaligned access to the jtag uart
>> registers, yes ? If that happens, what happens on real HW and how is
>> this emulated ?
> 
> Misaligned accesses to any registers would raise an exception.
> The exception is handled by interrupt controller, either "real"
> or emulated. Such access should never reach code for jtag uart.
> 
> Also note we only allow access size 4 in the code:
> 
> static const MemoryRegionOps juart_ops = {
>     .read = altera_juart_read,
>     .write = altera_juart_write,
>     .endianness = DEVICE_LITTLE_ENDIAN,
>     .valid = {
>         .min_access_size = 4,
>         .max_access_size = 4
>     }
> };

This answers my question , thanks.

-- 
Best regards,
Marek Vasut
