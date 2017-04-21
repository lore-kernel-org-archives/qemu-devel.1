Received: from eggs.gnu.org ([2001:4830:134:3::10]:42402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1V1V-0006RN-1h
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1V1Q-0007G6-5w
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:38:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d1V1P-0007Em-OF
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:38:35 -0400
References: <20170419195413.30141-2-bobby.prani@gmail.com>
	<CAJhHMCAfexwn92bt0=rfzBB0hbgqzCpRpgnsEXbG5cnmnFYztA@mail.gmail.com>
	<20170419201314.GX25239@thinpad.lan.raisama.net>
	<CAJhHMCDpJhRoeGXRvPdqLD7zeVh_dmKX9wDcZcCSFwLj_+Cwkw@mail.gmail.com>
	<20170419205706.GY25239@thinpad.lan.raisama.net>
	<CAJhHMCBN8N27M7H4a3ayv6rezKoc9+UH5xPqE4Pu2MPYKD8RgQ@mail.gmail.com>
	<20170419213349.GC25239@thinpad.lan.raisama.net>
	<CAJhHMCB1GBC6ay4O61gnF8NtHg9+DCVR3dAcVjd253-GX3BoAw@mail.gmail.com>
	<20170420022629.GD25239@thinpad.lan.raisama.net>
	<CAJhHMCAjHsRDwa5sbWeQstLCe3o4nA7-GHAYrewP59H7wYeBBg@mail.gmail.com>
	<20170420184210.GF25239@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8cf1d4e9-8177-3b09-5400-cb22a929e78b@redhat.com>
Date: Fri, 21 Apr 2017 11:38:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170420184210.GF25239@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: Do not display HT warning for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>



On 20/04/2017 20:42, Eduardo Habkost wrote:
>> -smp 4,threads=4 shows 4 cores
> This means 1 socket with 1 core, 4 threads per core. But if
> vendor ID is AMD, guests will probably ignore the hyperthreading
> info and treat each thread as a separate core. That's why we have
> a warning.

I'm not sure about the "probably".  As long as the HT bit is 1 and the
number of threads is > 1 in CPUID[EAX=1].EBX[bits 23:16], I am not sure
why the OS would care about the vendor.

x86info does care (it just does not try to detect the topology for
!Intel processors), but Linux seems not to.  detect_ht is called
unconditionally.

>> I am a bit confused why smp 4 is showing only 2 cores? and why the
>> rest are showing 4 cores
> Probably because Windows XP is limited to 2 sockets.

This is correct.

Paolo
