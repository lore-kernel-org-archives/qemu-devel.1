Received: from eggs.gnu.org ([2001:4830:134:3::10]:39026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d90e1-0005sk-Je
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d90e0-00021f-Si
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:49:29 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-3-f4bug@amsat.org>
	<5a888274-0687-16ef-79d0-2c5ba9513164@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5393d0ff-03f6-395a-bcdf-fa9565ca471e@amsat.org>
Date: Thu, 11 May 2017 23:49:18 -0300
MIME-Version: 1.0
In-Reply-To: <5a888274-0687-16ef-79d0-2c5ba9513164@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/8] target/arm: optimize smul_dual() and
 neon_trn_u8() using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org

Hi Eric,

On 05/10/2017 05:15 PM, Eric Blake wrote:
> On 05/10/2017 03:05 PM, Philippe Mathieu-Daudé wrote:
>> Applied using Coccinelle script.
>
> Thinking forward a year - if I want to reproduce this (to see if other
> instances have crept in), I have to dig up a mail archive to learn the
> formula you used.  Better is to list your coccinelle command line
> directly in the commit message, so that reproducing the fix involves
> less effort.  Same comment applies throughout the series.
>
> For reference, see how I did it in commit de6e7951.

Ok!

In the cover I used cocci spatch directly thru a unofficial docker image 
which I have no idea it will be around in a year...
I'll let the docker example in the cover and add the spatch command in 
the commits.

Regards,

Phil.
