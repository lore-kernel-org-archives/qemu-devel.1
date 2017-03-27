Received: from eggs.gnu.org ([2001:4830:134:3::10]:57549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cscPv-0000ia-Qy
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 17:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cscPt-0002bP-7g
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 17:43:11 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cscPt-0002bD-0V
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 17:43:09 -0400
Received: by mail-pg0-x241.google.com with SMTP id g2so16026842pge.2
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 14:43:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA-t7xRo-2CkipmYKE_vUxp8oUBML8ss7G8U_pVhM79H6w@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <64d527bd-c639-7300-0a23-a70e739f8fe8@twiddle.net>
Date: Tue, 28 Mar 2017 07:43:01 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-t7xRo-2CkipmYKE_vUxp8oUBML8ss7G8U_pVhM79H6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] packed structures and unaligned accesses (sparc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Knut Omang <knut.omang@oracle.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 03/28/2017 03:34 AM, Peter Maydell wrote:
> That all makes sense in isolation, but shouldn't something have
> at least warned that "&h.size" isn't actually a uint32_t* in
> the sense of being something you can validly pass to a
> function that takes a uint32_t* ?

That's a long-known bug in the implementation of packed data.  Yes, it should, 
but it doesn't.


r~
