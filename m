Received: from eggs.gnu.org ([2001:4830:134:3::10]:43295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cWnp8-0007qX-UH
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cWnp4-0000ZJ-Ep
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:27:02 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cWnp4-0000Z4-8t
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:26:58 -0500
Received: by mail-pg0-x243.google.com with SMTP id 75so22830051pgf.3
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 09:26:58 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170113215720.29598-1-shorne@gmail.com>
	<20170113220252.GE25986@lianli.shorne-pla.net>
	<CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
	<20170114080435.GF25986@lianli.shorne-pla.net>
	<20170120163918.GD7836@lianli.shorne-pla.net>
	<d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
	<01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
	<20170125123430.GG7836@lianli.shorne-pla.net>
	<39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
	<20170126131229.GB16014@lianli.shorne-pla.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
Date: Thu, 26 Jan 2017 09:26:55 -0800
MIME-Version: 1.0
In-Reply-To: <20170126131229.GB16014@lianli.shorne-pla.net>
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

On 01/26/2017 05:12 AM, Stafford Horne wrote:
> I just sent you a mail with a link to my kernel for download.
>
> One thing I noticed is you passed '-append console=ttyS0' I think that
> does nothing on openrisc since as far as I know openrisc only gets boot
> params from the device tree file. I tried with and without it and got no
> differences.

That was just reflex, wondering where the output went.

> Another thing, I am using a 'late' version of gcc built with musl cross [1]
> , I dont think it would make a difference, but maybe?

I think that's likely the difference.  I can indeed boot your kernel.


r~
