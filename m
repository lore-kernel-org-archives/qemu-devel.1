Received: from eggs.gnu.org ([209.51.188.92]:49812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goUqU-0006Fb-Nu
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goUXc-00005V-R0
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:39:14 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goUXW-0008Vu-3g
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:39:08 -0500
Received: by mail-oi1-x243.google.com with SMTP id m6so16257059oig.11
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 06:38:58 -0800 (PST)
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-5-richard.henderson@linaro.org>
	<CAFEAcA9Yz53O1OiG-eN=0eCdnO=Lz+yJPUtqVxfFSb3rrG4TEg@mail.gmail.com>
	<ae0d3ea5-e7e1-da8e-9b10-4534a1ff9162@linaro.org>
	<CAFEAcA9OuF=rdRBRpoXFG3r4_rntc-fRa2m2g=+w+cpfC1Vg1w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <be92c862-e7ac-23fb-0ad8-b7f86f7f2e36@linaro.org>
Date: Tue, 29 Jan 2019 06:38:35 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9OuF=rdRBRpoXFG3r4_rntc-fRa2m2g=+w+cpfC1Vg1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/11] target/arm: Record the GP bit for a
 page in MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1/29/19 1:55 AM, Peter Maydell wrote:
>> As written above, this will execute more than once.
> 
> I don't see how -- all the code paths forward from
> "guarded |= extract64(descriptor, 50, 1);" reach a
> "break" statement that terminates the loop, don't they?

You're right.  I've misread the surrounding code.


r~
