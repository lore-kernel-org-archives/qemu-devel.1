Received: from eggs.gnu.org ([2001:4830:134:3::10]:41165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYw0R-00006K-Ia
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYw0O-0007PT-HB
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:40:03 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:37097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eYw0O-0007Oc-9y
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:40:00 -0500
Received: by mail-pg0-x243.google.com with SMTP id z17so2278234pgc.4
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 07:40:00 -0800 (PST)
References: <20171219115041.6611-1-syq@debian.org>
	<0cf81c46-41c7-da9f-0a4b-0ac56a2fac6a@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0871fe14-f1a5-b735-f7e0-b5f6e1c16dcc@linaro.org>
Date: Tue, 9 Jan 2018 07:39:55 -0800
MIME-Version: 1.0
In-Reply-To: <0cf81c46-41c7-da9f-0a4b-0ac56a2fac6a@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: MIPS set cpu to r6 CPU if
 binary is R6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>
Cc: YunQiang Su <syq@debian.org>, qemu-devel@nongnu.org

On 01/08/2018 03:34 PM, Laurent Vivier wrote:
> Peter, Riku,
> 
> what do you think of the idea of using the ELF header to select the CPU
> to emulate?

I think it's a good way to cut down on mistakes and reduce -- or at least not
increase -- the number of binaries we build.


r~
