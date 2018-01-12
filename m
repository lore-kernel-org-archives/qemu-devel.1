Received: from eggs.gnu.org ([2001:4830:134:3::10]:40374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea45j-000737-BA
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea45g-00071H-7G
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:30:11 -0500
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:43702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ea45g-00070Q-11
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:30:08 -0500
Received: by mail-pg0-x22a.google.com with SMTP id f14so5064917pga.10
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:30:07 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-12-alex.bennee@linaro.org>
	<CAFEAcA-3nkmeJMHFqMeiwZtQycmieXdPiaCvKZsFuKY3MqtdCQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <721f5500-f059-bf17-6b7e-d0cb649c13eb@linaro.org>
Date: Fri, 12 Jan 2018 10:30:03 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-3nkmeJMHFqMeiwZtQycmieXdPiaCvKZsFuKY3MqtdCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/20] fpu/softfloat: re-factor add/sub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 01/12/2018 07:57 AM, Peter Maydell wrote:
> I see we're passing and returning decomposed_parts structs everywhere
> rather than pointers to them. How well does that compile? (I guess
> everything ends up inlining...)

For the x86_64 abi at least, the structure (as defined with bitfields) is 128
bits and is passed and returned in registers.

I believe the same to be true for the aarch64 abi.  I'd have to do some
research to determine what happens for the other 64-bit hosts.


r~
