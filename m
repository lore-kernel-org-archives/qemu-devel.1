Received: from eggs.gnu.org ([2001:4830:134:3::10]:37424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ecMgX-0000TZ-09
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 21:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ecMgS-0001YC-3E
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 21:45:41 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ecMgR-0001Xv-Sw
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 21:45:36 -0500
Received: by mail-pg0-x241.google.com with SMTP id k68so305544pga.3
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 18:45:35 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <bd66250ff262528199614f778a8323ced130a4db.1516221466.git.alistair.francis@xilinx.com>
	<c5e23caa-770f-3b3d-14b8-33dba2c82c57@twiddle.net>
	<CAKmqyKPUWb7cKDjB+=ByK2fCNBYm-GELmET6yksQETU+neFU2w@mail.gmail.com>
	<CAKmqyKPbrubJUo0X2cxBYmUQh0G2WeJCu7BKxAFo1nU8rH4R4g@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1b1ceb08-3045-f54c-cbf9-542aed36715f@twiddle.net>
Date: Thu, 18 Jan 2018 18:45:31 -0800
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPbrubJUo0X2cxBYmUQh0G2WeJCu7BKxAFo1nU8rH4R4g@mail.gmail.com>
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
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, riku.voipio@iki.fi

On 01/18/2018 04:08 PM, Alistair Francis wrote:
> Ok, this is not going to be straightforward at all.
> 
> The webkitgtk cmake command hangs when targeting i686 without this
> patch. Somewhere in the Yocto build flow this causing some change
> resulting in that hang. I don't know how to find out where the exact
> problem is though.
> 
> It looks like only flipping the MSB to 0 fixes the issue, so maybe
> there is a signed/unsigned issue somewhere? I'll keep digging.

There shouldn't be.  All of the variables involved on the x86_64 host should be
64-bit.


r~
