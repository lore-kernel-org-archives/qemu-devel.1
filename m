Received: from eggs.gnu.org ([2001:4830:134:3::10]:58036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cEIvF-0001Cd-K7
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cEIvC-0001nX-JY
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:48:53 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cEIvC-0001nT-Eu
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:48:50 -0500
Received: by mail-qt0-f195.google.com with SMTP id l20so40965985qta.1
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 08:48:50 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20161206150004.19758-1-alex.bennee@linaro.org>
	<CAFEAcA9qXOd1q+HYEMLtg9Ngqi2Atu1OQ3u07zPChOY_BLJB=g@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <33aef752-f067-e8e7-aa7f-81db44f9518f@twiddle.net>
Date: Tue, 6 Dec 2016 08:47:46 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9qXOd1q+HYEMLtg9Ngqi2Atu1OQ3u07zPChOY_BLJB=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.9] gdbstub: remove spurious
 tb_flush() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 12/06/2016 07:42 AM, Peter Maydell wrote:
> I also think that cpu_single_step() doing a flush is wrong:
> we should have the singlestep flag in the tbflags instead.

Yes.  And the parallel_cpus flag, so we don't have to keep re-translating an
instruction that cannot be handled by the host natively.

Indeed, it occurs to me that we could steal some bits out of cflags to
represent both of these, and then include cflags in the hash.


r~
