Received: from eggs.gnu.org ([2001:4830:134:3::10]:44664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWwTy-0004vU-FX
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWwTv-0001PQ-Bb
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:18:34 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fWwTv-0001P0-3D
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:18:31 -0400
Received: by mail-pg0-x244.google.com with SMTP id c10-v6so4620670pgu.9
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 21:18:31 -0700 (PDT)
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
	<1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc3cd25b-bdd1-3bc7-8d2d-5c351f2c30d5@linaro.org>
Date: Sat, 23 Jun 2018 21:18:26 -0700
MIME-Version: 1.0
In-Reply-To: <1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 06/23/2018 01:17 PM, Programmingkid wrote:
>>> https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-environments-for-32-e3087633.html
>>> This document has the information on the fdiv. Page 133 has the information on what action is executed when a division by zero situation takes place. 

Even in your referenced PDF, table 3-13, it says that frD is unmodified.

>>  struct sigaction a = { .sa_sigaction = handle, .sa_flags = SA_SIGINFO };
>>  sigaction(SIGFPE, &a, NULL);
>>  feenableexcept(FE_ALL_EXCEPT);
> 
> This is C99 code. There are a lot of floating point bugs with this implementation. I suggest all future testing be done using PowerPC assembly language only.

Um.. have you really ever seen an implementation that won't set ZE?

> What compiler did you use to compile this program?

gcc 7.2.

> What operating system did you run this program on?

CentOS 7, so kernel 3.10, glibc 2.17.

> What are the specs of the system you used to test this program on?

CHRP IBM,8231-E2B (Power7).


r~
