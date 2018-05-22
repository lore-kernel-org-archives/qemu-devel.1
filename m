Received: from eggs.gnu.org ([2001:4830:134:3::10]:49867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLAFo-0007qI-SU
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLAFm-0001CD-AN
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:35:16 -0400
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:42599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fLAFm-0001BH-4r
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:35:14 -0400
Received: by mail-pl0-x234.google.com with SMTP id u6-v6so11224032pls.9
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 09:35:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA-aD98+wh=XfMkY1iUwHjDJZ6dH7Juv0_o_VbgkcV0etw@mail.gmail.com>
	<214c47f3-1583-6480-4837-8b8ced37f038@twiddle.net>
	<CAFEAcA9QN_EFbfwqps+5Bu7CKX4J7GLGjBMURmk-1Jk22iixKA@mail.gmail.com>
	<7af06713-7e42-6489-5945-85545bc02f26@twiddle.net>
	<CAFEAcA90PcQH1Y-md7=dPTziP06ozripM7yPjqKJDgbk93gSzQ@mail.gmail.com>
	<a801fc3e-2dc1-06de-1ec1-0b911ea29450@twiddle.net>
	<CAFEAcA_u8f_S9ij2Yt4gYitjXrJfpn=DQbyDm-fp4QsDN+JWcw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f7faf066-10cd-fde6-0c1d-03d7cf33274b@twiddle.net>
Date: Tue, 22 May 2018 09:35:11 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_u8f_S9ij2Yt4gYitjXrJfpn=DQbyDm-fp4QsDN+JWcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] TCG helpers that return f16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/22/2018 09:31 AM, Peter Maydell wrote:
> Do we also want f16 inputs to mean uint32_t arguments?

Yes.  We don't want the compiler assuming zeros (for non-x86 abis) when we
aren't providing them.


r~
