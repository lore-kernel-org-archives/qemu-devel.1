Received: from eggs.gnu.org ([2001:4830:134:3::10]:56450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fN8Kw-0004AB-Ul
	for qemu-devel@nongnu.org; Sun, 27 May 2018 22:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fN8Kt-0006Xu-3E
	for qemu-devel@nongnu.org; Sun, 27 May 2018 22:56:43 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:45516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fN8Ks-0006XD-Sj
	for qemu-devel@nongnu.org; Sun, 27 May 2018 22:56:39 -0400
Received: by mail-pg0-x243.google.com with SMTP id w3-v6so4633571pgv.12
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 19:56:38 -0700 (PDT)
References: <20180527141324.11937-1-richard.henderson@linaro.org>
	<20180527141324.11937-8-richard.henderson@linaro.org>
	<ff7e23a2-ab8a-27fc-5267-8ec1fef0b58c@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d9c1e9a7-574b-aceb-ee8f-8ef88aa37512@linaro.org>
Date: Sun, 27 May 2018 21:56:33 -0500
MIME-Version: 1.0
In-Reply-To: <ff7e23a2-ab8a-27fc-5267-8ec1fef0b58c@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/20] target/openrisc: Form the spr index
 from tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

On 05/27/2018 08:31 PM, Philippe Mathieu-Daudé wrote:
> On 05/27/2018 11:13 AM, Richard Henderson wrote:
>> Rather than pass base+offset to the helper, pass the full index.
>> In most cases the base is r0 and optimization yields a constant.
> 
> and while here you use generic TCGv instead of 32bit version.

We always used target_ulong for the variable part of the address.


r~
