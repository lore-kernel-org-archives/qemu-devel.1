Received: from eggs.gnu.org ([2001:4830:134:3::10]:44219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1XAQ-000154-6k
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1XAM-0006Yd-5Q
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:02 -0400
Received: from chuckie.co.uk ([82.165.15.123]:50992
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1XAL-0006YT-UJ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:55:58 -0400
References: <F7CD9F9D-2450-46BB-A914-BCA3418975D2@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <c48c0539-fdfa-e4b1-e5a8-7ee16607b260@ilande.co.uk>
Date: Fri, 21 Apr 2017 12:55:25 +0100
MIME-Version: 1.0
In-Reply-To: <F7CD9F9D-2450-46BB-A914-BCA3418975D2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Siavash Katebzadeh <mr.katebzadeh@gmail.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>, hossein.ajallooiean@epfl.ch

On 21/04/17 12:37, Siavash Katebzadeh wrote:

> Hi,
> 
> I can reproduce this panic using debian-7.8.0 image. I’m getting this segmentation fault:
> 
> [   24.846406] busybox[1]: segfault at f78a000c ip 00000000f77ab0ac (rpc 00000000f77ab090) sp 00000000ffd95a50 error 30001 in libc.so.6[f76f0000+174000]
> 
> I found out the commit with 7268adebfda6548b8ae6865dc8337f116a5d266d hash is broken.
> Could you please take a look at this commit? Thanks.
>   
> Regards,
> Siavash.

I've just tried locally with git master and I can't reproduce this at
all? I'm booting like this:

./qemu-system-sparc64 -cdrom debian-7.8.0-sparc-netinst.iso -nographic
-boot d

and I get all the way to the installer. If I drop to a busybox shell
then I don't see any errors? Please can you give the full command line
and information about your host OS and architecture.


ATB,

Mark.
