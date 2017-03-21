Received: from eggs.gnu.org ([2001:4830:134:3::10]:60223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqN0B-0006Gd-CF
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqN0A-0002bw-LS
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:51:19 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqN0A-0002bl-D3
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:51:18 -0400
Received: by mail-wr0-x232.google.com with SMTP id u108so115725232wrb.3
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 09:51:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91CZ=QbhyeakFCSq3n6+d_cGO8hpT8o8EUwUTdkX-iE1eLg@mail.gmail.com>
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
	<CAFEAcA8HrEsuEYgpe9pJQkwSnSTU74G+3i7vWk8ka5cJ+UWFDQ@mail.gmail.com>
	<CAJy91CZ=QbhyeakFCSq3n6+d_cGO8hpT8o8EUwUTdkX-iE1eLg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 16:50:56 +0000
Message-ID: <CAFEAcA9XRwW0=UzuAXwjB-a_vWepfh+mus9bgpmdsCoQH6sDEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Guest application reading from pl011 without
 device driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 March 2017 at 16:47, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
> The actual situation is, pl011_can_receive is returning false, the fifo is
> full,   pl011_read does't start.
> At this moment, only pl011_can_recieve is keeping returning 0.

OK, so the incoming data has filled up the FIFO, and the UART
is now sitting waiting for the guest to read the data...

>>  * whether pl011_can_receive is returning true even with
>>    16 bytes in the fifo (hard to see how, given the code)
>>  * whether the fifo actually has fewer bytes in it because
>>    the guest is reading them
>
>
> No, because the guest application does't get any data.

...so if the guest isn't getting any data that suggests it's
the guest code's bug (ie it is not actually reading out of
the FIFO).

thanks
-- PMM
