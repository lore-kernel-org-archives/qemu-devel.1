Received: from eggs.gnu.org ([2001:4830:134:3::10]:52269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXF62-0006zg-4e
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXF5x-0002zh-Bo
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:06:34 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:36297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXF5x-0002zV-5t
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:06:29 -0400
Received: by mail-qt0-x22a.google.com with SMTP id 21so3252310qtx.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:06:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAPybu_2GjvyCJHzgbA1_oeiHU=enbK5U0kz+J6dQGr1m1V9vtA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <34d1987c-14e9-1d97-eef4-6af08ecd9f51@twiddle.net>
Date: Mon, 17 Jul 2017 13:06:23 -1000
MIME-Version: 1.0
In-Reply-To: <CAPybu_2GjvyCJHzgbA1_oeiHU=enbK5U0kz+J6dQGr1m1V9vtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Different feature status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, qemu-devel@nongnu.org

On 07/17/2017 12:45 PM, Ricardo Ribalda Delgado wrote:
> Hi
> 
> I am missing the following functionality to fully emulate an AMD bulldozer v4:
> 
> -mno-avx
> -mno-avx2
> -mno-f16c
> -mno-fma
> -mno-fma4
> -mno-prfchw
> -mno-rdrnd
> -mno-xop

To my knowledge, no one is working on any of these at present.

Getting AVX2 into qemu is a significant amount of work.

Once upon a time I began cleaning up the SSE support in the i386 translator, 
modeling it off of the way vector support is done for the AArch64 translator. 
I got just about far enough to think the SSE support was starting to look ok, 
but never actually started in on actual AVX1 support.

The code is still sitting in

   git://github.com/rth7680/qemu.git i386-avx

if you wish to look at what I was doing.

There may well be a simpler and more direct way of getting AVX support done. 
The ugliest bit is the difference between any given SSE instruction when it is, 
or isn't, encoded with the VEX prefix.  Which to me implies getting rid of the 
existing SSE tables.


r~
