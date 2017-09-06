Received: from eggs.gnu.org ([2001:4830:134:3::10]:41492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpZHs-0007rt-Rr
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpZHr-0004zG-UM
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:18:32 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpZHr-0004y5-N7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:18:31 -0400
Received: by mail-wr0-x235.google.com with SMTP id a47so11760793wra.1
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 05:18:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAF6HrYym57hZjSFE=iExPkp8vBX82zqXvTxh8GJDYNPL1FTSqA@mail.gmail.com>
References: <CAF6HrYxj5BoTQpQjz95Z1_N_p615jpEE12xh_afuuqE4fcTyLg@mail.gmail.com>
	<CAFEAcA9YNO7kgC8yzZ_RUKck=+98pUET0ogVZ7TvC1kxV+_fFA@mail.gmail.com>
	<CAF6HrYwT7WP_i7cVhvEyRvqSK7J+bLnKU4b+WrMQfVkLaNDrvQ@mail.gmail.com>
	<CAFEAcA9kEEyUj7=7Wd-jNbVOWwfgkj0a201q+L4e5CDR22JUgw@mail.gmail.com>
	<CAF6HrYw9B1ns0ZVtU_gxqJZxOe0dG03UQiAV7FHxBB-wQh6kNQ@mail.gmail.com>
	<CAF6HrYym57hZjSFE=iExPkp8vBX82zqXvTxh8GJDYNPL1FTSqA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Sep 2017 13:18:08 +0100
Message-ID: <CAFEAcA_iKqs_QXz_qSwsOw6A-Z1BJjVN3WPAgaERejWQXrQhNw@mail.gmail.com>
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
To: Ramy Sameh <ramysameh26@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ahmed Aly <ahmedaly50@gmail.com>

On 6 September 2017 at 13:12, Ramy Sameh <ramysameh26@gmail.com> wrote:
> Do the emulated baud rate registers have any effect? (I think they would
> have no effect, because there is no real clock that can be used to produce
> the baud rate).

No, they don't have any effect. (In this UART model we don't implement
the feature that you can connect a guest serial port to a host serial
port and have the guest baud rate etc settings propagate through.
We do that in other UART models and maybe one day we'll add it here,
but for now, baud rate settings are ignored.)

thanks
-- PMM
