Received: from eggs.gnu.org ([2001:4830:134:3::10]:42084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1dr73L-0006lf-DO
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 14:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1dr73K-000678-ET
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 14:33:55 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:36267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ramysameh26@gmail.com>)
	id 1dr73K-00066f-8X
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 14:33:54 -0400
Received: by mail-io0-x22a.google.com with SMTP id d16so14641752ioj.3
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 11:33:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_iKqs_QXz_qSwsOw6A-Z1BJjVN3WPAgaERejWQXrQhNw@mail.gmail.com>
References: <CAF6HrYxj5BoTQpQjz95Z1_N_p615jpEE12xh_afuuqE4fcTyLg@mail.gmail.com>
	<CAFEAcA9YNO7kgC8yzZ_RUKck=+98pUET0ogVZ7TvC1kxV+_fFA@mail.gmail.com>
	<CAF6HrYwT7WP_i7cVhvEyRvqSK7J+bLnKU4b+WrMQfVkLaNDrvQ@mail.gmail.com>
	<CAFEAcA9kEEyUj7=7Wd-jNbVOWwfgkj0a201q+L4e5CDR22JUgw@mail.gmail.com>
	<CAF6HrYw9B1ns0ZVtU_gxqJZxOe0dG03UQiAV7FHxBB-wQh6kNQ@mail.gmail.com>
	<CAF6HrYym57hZjSFE=iExPkp8vBX82zqXvTxh8GJDYNPL1FTSqA@mail.gmail.com>
	<CAFEAcA_iKqs_QXz_qSwsOw6A-Z1BJjVN3WPAgaERejWQXrQhNw@mail.gmail.com>
From: Ramy Sameh <ramysameh26@gmail.com>
Date: Sun, 10 Sep 2017 20:33:51 +0200
Message-ID: <CAF6HrYx6_uv-K3JouTb4WTrEEkX25VrhkjAVg8mWG3iarvA=AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Questions regarding emulated UART in VersatilePB
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ahmed Aly <ahmedaly50@gmail.com>

Thanks Peter.

I have made a program to read a string from the UART, then write it again
to the UART.
I made a function to manipulate values in the pl011 registers (bit flipping
the flags inside the registers).
The target is to simulate hardware fault injection.

For each run of the program, I made a bit-flip in *only one flag* in *one
register*, and I observed the output of the program.

*My question is*: where to invoke the call of this fault injection function
to cause *the maximum effect* on the program's output?

*p.s.* I invoked it once inside pl011_read function, and the program gave a
certain output, and I invoked it again in pl011_update, and it gave another
output.
When I invoked the function in pl011_write, the faults injected had no
effect on the output of the program!

Do you have an explanation for this behaviour?

Thanks in advance.


On Wed, Sep 6, 2017 at 2:18 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 6 September 2017 at 13:12, Ramy Sameh <ramysameh26@gmail.com> wrote:
> > Do the emulated baud rate registers have any effect? (I think they would
> > have no effect, because there is no real clock that can be used to
> produce
> > the baud rate).
>
> No, they don't have any effect. (In this UART model we don't implement
> the feature that you can connect a guest serial port to a host serial
> port and have the guest baud rate etc settings propagate through.
> We do that in other UART models and maybe one day we'll add it here,
> but for now, baud rate settings are ignored.)
>
> thanks
> -- PMM
>



-- 
Best Regards,
Ramy Sameh
Embedded Software Engineer
+2-010-172-777-14
