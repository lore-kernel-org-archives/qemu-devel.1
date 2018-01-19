Received: from eggs.gnu.org ([2001:4830:134:3::10]:39091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecKEV-0005qH-Rg
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 19:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecKEU-000653-RV
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 19:08:35 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:46368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ecKEU-00064M-Jc
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 19:08:34 -0500
Received: by mail-lf0-x243.google.com with SMTP id q194so17408620lfe.13
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 16:08:34 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAKmqyKPUWb7cKDjB+=ByK2fCNBYm-GELmET6yksQETU+neFU2w@mail.gmail.com>
References: <bd66250ff262528199614f778a8323ced130a4db.1516221466.git.alistair.francis@xilinx.com>
	<c5e23caa-770f-3b3d-14b8-33dba2c82c57@twiddle.net>
	<CAKmqyKPUWb7cKDjB+=ByK2fCNBYm-GELmET6yksQETU+neFU2w@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 18 Jan 2018 16:08:02 -0800
Message-ID: <CAKmqyKPbrubJUo0X2cxBYmUQh0G2WeJCu7BKxAFo1nU8rH4R4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Richard Henderson <rth@twiddle.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, riku.voipio@iki.fi

On Wed, Jan 17, 2018 at 9:46 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Wed, Jan 17, 2018 at 4:57 PM, Richard Henderson <rth@twiddle.net> wrote:
>> On 01/17/2018 12:39 PM, Alistair Francis wrote:
>>> Since commit "linux-user: Tidy and enforce reserved_va initialization"
>>> (18e80c55bb6ec17c05ec0ba717ec83933c2bfc07) the Yocto webkitgtk build
>>> hangs when cross compiling for 32-bit x86 on a 64-bit x86 machine using
>>> musl.
>>>
>>> To fix the issue reduce the MAX_RESERVED_VA macro to be a closer match
>>> to what it was before the problematic commit.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>> ---
>>
>> I don't like this at all.  You don't say why this hangs.
>> What is the actual host, x86_64 or i686?
>
> The host is x86_64 and the guest is i686. I'm not sure why it hangs,
> I'll dig through and get the actual command Yocto is running when it
> hangs.

Ok, this is not going to be straightforward at all.

The webkitgtk cmake command hangs when targeting i686 without this
patch. Somewhere in the Yocto build flow this causing some change
resulting in that hang. I don't know how to find out where the exact
problem is though.

It looks like only flipping the MSB to 0 fixes the issue, so maybe
there is a signed/unsigned issue somewhere? I'll keep digging.

Alistair

>
> Alistair
>
>>
>>
>> r~
