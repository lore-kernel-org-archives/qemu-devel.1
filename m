Received: from eggs.gnu.org ([2001:4830:134:3::10]:51486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cayif-00019M-82
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 00:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cayic-0002H1-6Q
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 00:53:37 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cayib-0002Gs-VU
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 00:53:34 -0500
Received: by mail-pg0-x242.google.com with SMTP id 204so11122870pge.2
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 21:53:33 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
	<20170114080435.GF25986@lianli.shorne-pla.net>
	<20170120163918.GD7836@lianli.shorne-pla.net>
	<d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
	<01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
	<20170125123430.GG7836@lianli.shorne-pla.net>
	<39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
	<20170126131229.GB16014@lianli.shorne-pla.net>
	<ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
	<20170201100423.GE21641@lianli.shorne-pla.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d3dac109-ad39-8bb9-2012-f7a6824139eb@twiddle.net>
Date: Mon, 6 Feb 2017 21:53:26 -0800
MIME-Version: 1.0
In-Reply-To: <20170201100423.GE21641@lianli.shorne-pla.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org, openrisc@lists.librecores.org

On 02/01/2017 02:04 AM, Stafford Horne wrote:
> For kernel builds I have created toolchain binaries here:
>
>   http://shorne.noip.me/crosstool/files/bin/x86_64/5.4.0/
>
> These should work.

This gdb crashes on the first "stepi" that I issue.  To reproduce,

$ cat z.c
int main() { return 0; }
$ or1k-musl-linux-gcc -g z.c
$ qemu-or32 -g 10001 ./a.out

// another window

$ or1k-musl-linux-gdb ./a.out
(gdb) target remote localhost:10001
// should see that the pc is at _start
(gdb) stepi
// crash

I won't be able to debug this myself until I can build my own gdb.


r~
