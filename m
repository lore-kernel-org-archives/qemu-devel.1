Received: from eggs.gnu.org ([208.118.235.92]:54061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gcMOI-0000jy-Ft
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 22:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gcMOE-0004d0-Bf
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 22:31:22 -0500
Received: from server54-2.web-hosting.com ([198.54.126.118]:60449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <admin@grossmann-venter.com>)
	id 1gcMOE-0004a2-3I
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 22:31:18 -0500
Received: from [::1] (port=45278 helo=server54.web-hosting.com)
	by server54.web-hosting.com with esmtpa (Exim 4.91)
	(envelope-from <admin@grossmann-venter.com>) id 1gcMOA-003CS7-AB
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 22:31:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Dec 2018 22:31:14 -0500
From: liebrecht@grossmann-venter.com
In-Reply-To: <201812270548.42446.randrianasulu@gmail.com>
References: <201812270548.42446.randrianasulu@gmail.com>
Message-ID: <493b54236162b1f5a6f71b115050fc22@grossmann-venter.com>
Subject: Re: [Qemu-devel] Qemu the right way -[Subthread Cores]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks a million Andrew
-enable-kvm switch really solved the erratic on of switching off the 
mouse and sound.
All I get now are small pips and pops I will have to chase sown. Sounds 
like buffer overruns of some sort due to too small buffers on the linux 
receiving end. Dont know how to adjust that, but I am sure it is 
something like that. Sounds like a gramophone scratch every now and then 
which I know to be usually too small buffers.

But, you improved the situation enormously thanks.

Regarding software cpus.
I realized something like that must be going on.
I dont understand the justification to add cpus for the guest that 
doesnt exist. That can only end in trouble.

What I want is for the guest to use a real subcollection of amount of 
cores accessed by the guest. I have 24 available, but some of my 
software to be used with qemu needs at least 6 cores so I need to get 
past this strange 2cpu limit that is now showing up in win7 pro. Since I 
do not have networking sorted out yet I cannot update win7 pro, and it 
might be the updates which are needed for allowing more than two cpus.
I uses cpus and cores interactively as for the windows guest both are 
the same number and windows only name them cpus.

I just added a subthread to the subject line to distinguish between the 
three problems I have, Networking Sound and Cpu Count in the host.
"-cpu host" seems to be what I need, so I will back up the VM and try 
it.

Thanks you have been of really great help.


On 2018-12-26 21:48, Andrew Randrianasulu wrote:
> Hello!
> 
> just saw your question in qemu-devel and trying to answer
> 
> -------------------
> Now for a very important question.
> 
> If hardware virtualization was not switched on in bios will qemu refuse 
> to
> create more cpus? I just want to know if there are not bogus software 
> cpus or
> cores created by qemu and that it actually checks it can get real cores 
> from
> the machine and make it available to the host.
> ----------------
> 
> I think qemu will create as much 'software' cpus as you told it by 
> '-smp'
> directive IF you will not use hardware virtualization. And you can run 
> with
> more virtual cpus than physical number of cpus you actually have, just 
> ..it
> will be slower, not faster.
> 
> but without hw virtualization everything will be ..sloooow [1] .... so 
> I think
> you better to add -enable-kvm to your qemu command line.  Try to use 
> -cpu host
> if you are brave (win7 may not survive this..)
> 
> 
> [1] see for example
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg03710.html
> 
> After this series, we bring down the average SPEC06int slowdown vs KVM
> from 11.47x to 7.58x.
