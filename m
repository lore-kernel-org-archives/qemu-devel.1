Received: from eggs.gnu.org ([2001:4830:134:3::10]:47701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUiX7-0005yS-67
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUiX4-0007kk-6i
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:56:05 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUiX4-0007kX-0S
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:56:02 -0400
Received: by mail-qk0-f177.google.com with SMTP id 16so87673072qkg.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 16:56:01 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAPybu_28Fi-QEpoCP2APs+FdEuEOmSJnEK==ubJimE907-WLYw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d4dc76c1-ea7a-1e11-0070-2685c970db3e@twiddle.net>
Date: Mon, 10 Jul 2017 13:54:55 -1000
MIME-Version: 1.0
In-Reply-To: <CAPybu_28Fi-QEpoCP2APs+FdEuEOmSJnEK==ubJimE907-WLYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-x86_64: Error processing bextr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, qemu-devel@nongnu.org, Blue Swirl <blauwirbel@gmail.com>

On 07/10/2017 01:17 PM, Ricardo Ribalda Delgado wrote:
>     0x00000040008179bf <+31>: 8f ea 78 10 d0 08 04 00 00 bextr  $0x408,%eax,%edx
...
> It seems that, bextr is not supported by the emulator/cpu, althoug I
> have launched the emualtor with -cpu Haswell, that should support bmi1
> (https://en.wikipedia.org/wiki/Bit_Manipulation_Instruction_Sets#BMI1)

This is not the BMI1 version of bextr, it's the TBM version of bextr.

https://en.wikipedia.org/wiki/Bit_Manipulation_Instruction_Sets#TBM_.28Trailing_Bit_Manipulation.29

TBM is not implemented in qemu yet.


r~
