Received: from eggs.gnu.org ([2001:4830:134:3::10]:42171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea4At-0000hz-32
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea4Ap-0005Ks-VQ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:35:31 -0500
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:40209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ea4Ap-0005Jz-OD
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:35:27 -0500
Received: by mail-pf0-x22e.google.com with SMTP id i66so4998078pfd.7
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:35:27 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-14-alex.bennee@linaro.org>
	<CAFEAcA_H_aoRqEoS8ynNknxgF4pvYbOcP3PLBgu1fwZSKCXVwQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <958f33cd-29e7-f2b5-ab24-b5394c9feb16@linaro.org>
Date: Fri, 12 Jan 2018 10:35:23 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_H_aoRqEoS8ynNknxgF4pvYbOcP3PLBgu1fwZSKCXVwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/20] fpu/softfloat: re-factor div
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

On 01/12/2018 08:22 AM, Peter Maydell wrote:
>> +/* Nicked from gmp longlong.h __udiv_qrnnd */
> Can we have a copyright/license attribution for code we nick
> from other projects, please? :-)
> 

LGPL 2.1 in this case.  ;-)


r~
