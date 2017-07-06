Received: from eggs.gnu.org ([2001:4830:134:3::10]:48756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dT2x0-0000D5-S9
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dT2wx-00059e-PB
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:19:54 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:62589)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dT2wx-000594-Dt
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:19:51 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue005 [212.227.15.167]) with ESMTPSA (Nemesis) id
	0LhRY4-1e6pfR0THU-00mfFz for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017
	11:19:49 +0200
References: <20170706002401.10507-1-rth@twiddle.net>
	<20170706002401.10507-6-rth@twiddle.net>
	<e969146b-3061-e0ee-3e5c-e709c73abc11@vivier.eu>
	<20170706081045.GA7838@physik.fu-berlin.de>
	<25f0470b-4a22-32e4-a298-c93975537ee8@vivier.eu>
	<20170706091328.GC23904@physik.fu-berlin.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <34fea9cf-2d6e-944e-a3ad-ad478965dea0@vivier.eu>
Date: Thu, 6 Jul 2017 11:19:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170706091328.GC23904@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/11] linux-user/sh4: Notice gUSA regions
 during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Le 06/07/2017 à 11:13, John Paul Adrian Glaubitz a écrit :
> On Thu, Jul 06, 2017 at 10:35:15AM +0200, Laurent Vivier wrote:
>> I think it would be interesting if you generate a qemu binary with it
>> and use it in your buildds to test it.
>>
>> I guess the series can be pulled directly from Richard's branch:
>>
>> git://github.com/rth7680/qemu.git tgt-sh4
> 
> Pull from this tree and built qemu-sh4-user as static from the tgt-sh4
> branch. Copied in Debian/sh4 chroot and tried to enter it:
> 
> root@nofan:/local_scratch/sid-sh4-sbuild> chroot .
> bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault
> root@nofan:/local_scratch/sid-sh4-sbuild>

Could you try origin/master to see if the regression is introduced by
this series or by a previous one?

Thanks,
Laurent
