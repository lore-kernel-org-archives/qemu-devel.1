Received: from eggs.gnu.org ([2001:4830:134:3::10]:45461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frm6R-0003Lc-Sq
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frm6P-0002Ir-2d
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:28:23 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1frm6O-0002GX-OQ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:28:20 -0400
References: <20180819221707.20693-1-laurent@vivier.eu>
	<CAFEAcA8k0Pe0k4rRaMTs39iUenOT5wJNKM-hva6ZnZ2n4fxoPA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4c462803-6f6a-590d-1b19-39c9e7aeff2e@vivier.eu>
Date: Mon, 20 Aug 2018 17:27:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8k0Pe0k4rRaMTs39iUenOT5wJNKM-hva6ZnZ2n4fxoPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 0/6] Linux user for 3.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Le 20/08/2018 à 16:44, Peter Maydell a écrit :
> On 19 August 2018 at 23:17, Laurent Vivier <laurent@vivier.eu> wrote:
>> The following changes since commit 0abaa41d936becd914a16ee1fe2a981d96d19428:
>>
>>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-08-17 09:46:00 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request
>>
>> for you to fetch changes up to c072a24c11e713f14ab969799433218d8ceebe19:
>>
>>   linux-user: add QEMU_IFLA_INFO_KIND nested type for tun (2018-08-20 00:11:06 +0200)
>>
>> ----------------------------------------------------------------
>> linux-user fixes:
>> - netlink fixes (add missing types, fix MSG_TRUNC)
>> - sh4 fix (tcg state)
>> - sparc32plus fix (truncate address space to 32bit)
>> - add x86_64 binfmt data
>>
>> ----------------------------------------------------------------

Hi

> Hi -- I'm afraid this doesn't build on my ppc64 test box:
> 
> /home/pm215/qemu/linux-user/syscall.c: In function
> ‘host_to_target_data_route_rtattr’:
> /home/pm215/qemu/linux-user/syscall.c:2719:10: error: ‘RTA_PREF’
> undeclared (first use in this function)
>      case RTA_PREF:

I've tested this on ppc64 box too before the p-l, and it has worked. The
macro is in /usr/include/linux/rtnetlink.h that comes with
kernel-headers-4.17.14-3.fc28.ppc64.

I've checked in the kernel sources and the macro appears in the file in
kernel v4.1 (c78ba6d64c78 ipv6: expose RFC4191 route preference via
rtnetlink).

I'm going to fix that. Thank you.

Laurent
