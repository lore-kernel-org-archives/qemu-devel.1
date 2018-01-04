Received: from eggs.gnu.org ([2001:4830:134:3::10]:33678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eX75F-0001Px-BH
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eX75A-0001By-TK
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:05:29 -0500
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:44699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eX75A-0001Al-JF
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:05:24 -0500
Received: by mail-pf0-x22d.google.com with SMTP id m26so856452pfj.11
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 07:05:24 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-6-alex.bennee@linaro.org>
	<8b36b09f-eb89-46bf-561b-2536cc93c489@amsat.org>
	<4c8e62d1-50bd-e429-153d-3b6d8733bb88@linaro.org>
	<87h8s13ecc.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c6e3adf7-55e6-dbbe-eb51-71ca12ce2099@linaro.org>
Date: Thu, 4 Jan 2018 07:05:20 -0800
MIME-Version: 1.0
In-Reply-To: <87h8s13ecc.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 05/19] include/fpu/softfloat: add some
 float16 contants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 01/04/2018 06:09 AM, Alex Bennée wrote:
> I was following the other sizes. It seems it's x80 which uses the
> additional ones in helpers:
> 
>   floatx80_ln2
>   floatx80_pi
> 
> Should I delete all the unused constants from the other sizes as well?

Yeah, let's do that.


r~
