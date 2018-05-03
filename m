Received: from eggs.gnu.org ([2001:4830:134:3::10]:42443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEKY7-0002hO-9n
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEKY3-0002y0-7D
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:09:55 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEKY2-0002wr-Vg
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:09:51 -0400
Received: by mail-pf0-x244.google.com with SMTP id e9so11587666pfi.4
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 13:09:50 -0700 (PDT)
References: <20180502154344.10585-1-alex.bennee@linaro.org>
	<20180502154344.10585-3-alex.bennee@linaro.org>
	<CAFEAcA80vTz25WHGKteTU3nxSi2fUHN8dp+z8paNP03conAghQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9549d686-899d-7b3b-dae3-d3cc22528e50@linaro.org>
Date: Thu, 3 May 2018 13:09:47 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA80vTz25WHGKteTU3nxSi2fUHN8dp+z8paNP03conAghQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] fpu/softfloat: support ARM
 Alternative half-precision
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 05/03/2018 11:17 AM, Peter Maydell wrote:
> (target/i386 notably does not do this, we should check how
> SSE and x87 handle NaNs in fp conversions first.)

Hardware does silence NaNs.  I tested that earlier:

https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03114.html


r~
