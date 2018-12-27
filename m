Received: from eggs.gnu.org ([208.118.235.92]:40260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gcLhP-0006Dt-2j
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 21:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gcLhK-0007Fi-PF
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 21:47:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Dec 2018 21:46:52 -0500
From: liebrecht@grossmann-venter.com
In-Reply-To: <665ec250-c4a5-18ba-ad71-90966a1b9e12@redhat.com>
References: <b0d70556767952dc739454d074bdab52@grossmann-venter.com>
	<665ec250-c4a5-18ba-ad71-90966a1b9e12@redhat.com>
Message-ID: <198d69a73104a15d25bc41052c25d713@grossmann-venter.com>
Subject: Re: [Qemu-devel] Qemu the right way.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Qemu-devel <qemu-devel-bounces+admin=grossmann-venter.com@nongnu.org>



Sound is rickety but at least I can see that it is possible as in my 
previous post which is already way better than virtualbox.

Turning to networking;
I can configure windows tcp/ip very well, but for some reason qemu fails 
at a network connection.
Windows report the qemu provided network card as Intel 1000.
However it fails when configured.
The dns and gateway is assigned correctly and known to route correctly 
from the other machines on the network.

So, I then try to explicitly add a switch to see if there is maybe a 
misreported mac or something and explicitly add the -nic network switch 
in the startup command

I work from this manual.
https://qemu.weilnetz.de/doc/qemu-doc.html

The string used is

qemu-system-x86_64 -nic user,ipv6=off,model=e1000,mac=52:54:98:76:54:32 
-soundhw all  -smp 4 -m 2048M -boot d -cdrom /dev/cdrom -drive 
format=raw,file=hd.img


The network switch used above fails with
qemu-system-x86_64: -nic: invalid option

Cant figure out why as it is what is used in the manual as is!
