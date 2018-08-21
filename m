Received: from eggs.gnu.org ([2001:4830:134:3::10]:42868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsAXA-00076g-CT
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsAX4-000555-9E
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:33:35 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsAX3-00051m-QU
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:33:30 -0400
References: <20180818190118.12911-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d2bffda0-8479-ec8a-a7d5-0b1c562d8e35@vivier.eu>
Date: Tue, 21 Aug 2018 19:33:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 00/16] linux-user: Split do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 18/08/2018 à 21:01, Richard Henderson a écrit :
> Version 4 continues the split into multiple files, but for
> inclusion rather than separate compilation.  This allows us
> to get warnings if there are mistakes in the switch statement
> that looks up the structures.
> 
> 
> r~
> 
> 
> Richard Henderson (16):
>   linux-user: Remove DEBUG
>   linux-user: Split out do_syscall1
>   linux-user: Relax single exit from "break"
>   linux-user: Propagate goto efault to return
>   linux-user: Propagate goto unimplemented_nowarn to return
>   linux-user: Propagate goto unimplemented to default
>   linux-user: Propagate goto fail to return
...

Richard,

if you want I can include patches 1 to 7 in my next pull request, this
will avoid you to rebase them for every new version of the series.

Thanks,
Laurent
