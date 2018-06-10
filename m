Received: from eggs.gnu.org ([2001:4830:134:3::10]:36899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fS5i7-0006kn-IR
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 15:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fS5i3-0002SA-G6
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 15:09:07 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:38400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fS5i3-0002Rm-9P
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 15:09:03 -0400
Received: by mail-pf0-x241.google.com with SMTP id b74-v6so9094166pfl.5
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 12:09:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Message-ID: <cdda2fb1-d360-484c-c4ef-081d2692ff8d@linaro.org>
Date: Sun, 10 Jun 2018 09:08:58 -1000
MIME-Version: 1.0
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 000/108] linux-user: Split do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

On 06/09/2018 05:00 PM, Richard Henderson wrote:
> * Changed the table into a switch, for the reason documented.
>   Use macros to actually enter the syscall into the switch.
> * Finish the split.
> * Fix some bugs along the way.

I forgot to mention, this is based on

https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01764.html

and nothing else.  V1 already had the is_hostfd and openat patches folded in.
I think that it will be much clearer to do those the other way around.

For the record, the whole tree is available at

https://github.com/rth7680/qemu/tree/lu-split-2


r~
