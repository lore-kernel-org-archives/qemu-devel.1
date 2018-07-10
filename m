Received: from eggs.gnu.org ([2001:4830:134:3::10]:48522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fct0e-0002YR-EJ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fct0Z-0007v0-JY
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:48:52 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:35262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fct0Z-0007ti-Bf
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:48:47 -0400
Received: by mail-pl0-x242.google.com with SMTP id k1-v6so7650486plt.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 06:48:46 -0700 (PDT)
References: <20180709191529.13080-1-richard.henderson@linaro.org>
	<a964f8f3-b30d-b23e-d4d3-b3213943bead@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <34f1f5e5-7654-88c6-862a-0e4403987279@linaro.org>
Date: Tue, 10 Jul 2018 06:48:42 -0700
MIME-Version: 1.0
In-Reply-To: <a964f8f3-b30d-b23e-d4d3-b3213943bead@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix shmat emulation by
 honoring host SHMLBA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 07/10/2018 02:47 AM, Laurent Vivier wrote:
>> -                addr &= TARGET_PAGE_MASK;
>> +                addr &= align - 1;
> 
> and here TARGET_PAGE_MASK is also (align - 1)...
> 
> So I think it should be "addr &= -align".

Whoops, yes indeed.


r~
