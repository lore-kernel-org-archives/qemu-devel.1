Received: from eggs.gnu.org ([2001:4830:134:3::10]:55853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ebyWb-0000zJ-5M
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 19:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ebyWW-0006NV-Ah
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 19:57:49 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:44043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ebyWW-0006N3-3A
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 19:57:44 -0500
Received: by mail-pf0-x243.google.com with SMTP id m26so12891619pfj.11
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 16:57:43 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <bd66250ff262528199614f778a8323ced130a4db.1516221466.git.alistair.francis@xilinx.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c5e23caa-770f-3b3d-14b8-33dba2c82c57@twiddle.net>
Date: Wed, 17 Jan 2018 16:57:39 -0800
MIME-Version: 1.0
In-Reply-To: <bd66250ff262528199614f778a8323ced130a4db.1516221466.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] linux-user: Fix webkitgtk hangs on
 32-bit x86 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, alistair23@gmail.com, riku.voipio@iki.fi

On 01/17/2018 12:39 PM, Alistair Francis wrote:
> Since commit "linux-user: Tidy and enforce reserved_va initialization"
> (18e80c55bb6ec17c05ec0ba717ec83933c2bfc07) the Yocto webkitgtk build
> hangs when cross compiling for 32-bit x86 on a 64-bit x86 machine using
> musl.
> 
> To fix the issue reduce the MAX_RESERVED_VA macro to be a closer match
> to what it was before the problematic commit.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---

I don't like this at all.  You don't say why this hangs.
What is the actual host, x86_64 or i686?


r~
