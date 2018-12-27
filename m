Received: from eggs.gnu.org ([208.118.235.92]:57278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liebrecht@grossmann-venter.com>) id 1gcdns-0002GF-Va
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liebrecht@grossmann-venter.com>) id 1gcdnp-0000GW-TH
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:06:56 -0500
Received: from server54-2.web-hosting.com ([198.54.126.118]:42930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liebrecht@grossmann-venter.com>)
	id 1gcdnp-0000Em-Lx
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:06:53 -0500
Received: from [::1] (port=38266 helo=server54.web-hosting.com)
	by server54.web-hosting.com with esmtpa (Exim 4.91)
	(envelope-from <liebrecht@grossmann-venter.com>) id 1gcdnm-001wF0-H1
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:06:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Dec 2018 17:06:50 -0500
From: liebrecht@grossmann-venter.com
In-Reply-To: <201812270613.51558.randrianasulu@gmail.com>
References: <201812270613.51558.randrianasulu@gmail.com>
Message-ID: <859085189a65d5c9b612dc942313f46f@grossmann-venter.com>
Subject: Re: [Qemu-devel] Qemu the right way.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I resolved it by removing the nic driver detected  by windows and 
rebooted.
It seems llike the first thing to do after the startup string is 
complete is to remove all drivers and then let windows find them again 
according to what is available from the startup string switches.

The nic problem is solved.
Thanks all for the kind help

On 2018-12-26 22:13, Andrew Randrianasulu wrote:
> re:
> 
> The network switch used above fails with
> qemu-system-x86_64: -nic: invalid option
> 
> Cant figure out why as it is what is used in the manual as is!
> 
> ----------------
> 
> May be because your qemu is not as new as documentation (documentation 
> describe
> current stable qemu - v 3.1.0) ?
> 
> I tried this line
> 
> qemu-system-x86_64 -nic user,ipv6=off,model=e1000,mac=52:54:98:76:54:32 
> -cdrom
> ~/Downloads/ISO/slax-English-US-7.0.8-x86_64.iso -m 1999 -enable-kvm 
> -cpu
> host -smp 4
> 
> and it worked for me (obviosly with Linux guest), browser in this 
> specific
> live-cd was too old for youtube, but at least it showed previews and 
> error
> messages.
> 
> My qemu is self-compiled and sort-of behind the times:
> 
> qemu-system-x86_64 --version
> QEMU emulator version 3.0.50 (v3.0.0-1559-g179f9ac887-dirty)
> Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers
