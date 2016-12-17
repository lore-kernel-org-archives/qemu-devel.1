Received: from eggs.gnu.org ([2001:4830:134:3::10]:48348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cIKTO-0003DX-1R
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 14:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cIKTN-0000Ro-3M
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 14:16:45 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cIKTM-0000R1-TZ
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 14:16:45 -0500
Received: by mail-pg0-x244.google.com with SMTP id p66so13499219pga.2
	for <qemu-devel@nongnu.org>; Sat, 17 Dec 2016 11:16:43 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20161216191405.9473-1-rth@twiddle.net>
	<20161216191405.9473-2-rth@twiddle.net>
	<CAFEAcA-MaPLfz213o=z-_dEkAp8m6SYPskGSOYbY2hOfJ6Gq-A@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <23b53d78-578c-ceac-bb47-2562decfc350@twiddle.net>
Date: Sat, 17 Dec 2016 11:16:40 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-MaPLfz213o=z-_dEkAp8m6SYPskGSOYbY2hOfJ6Gq-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/26] Revert "Remove remainders of HPPA
 backend"
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

On 12/17/2016 03:59 AM, Peter Maydell wrote:
> On 16 December 2016 at 19:13, Richard Henderson <rth@twiddle.net> wrote:
>> This reverts commit d41f3c3cc7a5fb9de144cc4022da14a9ff010671.
>
> Missing signed-off-by.

Oops.

>> +elif check_define __hppa__ ; then
>> +  cpu="hppa"
>>  else
>>    cpu=$(uname -m)
>>  fi
>
> This if-ladder is for detecting hppa host CPUs, so you
> don't want it for just adding the hppa target support.
> Or do you clean this up later in the series so that this
> commit is a pure revert?

I do remove this again in patch 18 (target-hppa: Add framework and enable 
compilation).  So, yes, this is pure revert.


r~
