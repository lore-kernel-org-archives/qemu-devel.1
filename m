Received: from eggs.gnu.org ([208.118.235.92]:46099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liebrecht@grossmann-venter.com>) id 1gbvT2-000578-9Y
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 17:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liebrecht@grossmann-venter.com>) id 1gbvSw-0006w8-LP
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 17:46:27 -0500
Received: from server54-2.web-hosting.com ([198.54.126.118]:48683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liebrecht@grossmann-venter.com>)
	id 1gbvSv-0006sH-BL
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 17:46:22 -0500
Received: from [::1] (port=60430 helo=server54.web-hosting.com)
	by server54.web-hosting.com with esmtpa (Exim 4.91)
	(envelope-from <liebrecht@grossmann-venter.com>) id 1gbvSr-002pDg-Jg
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 17:46:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Dec 2018 17:46:17 -0500
From: liebrecht@grossmann-venter.com
Message-ID: <b0d70556767952dc739454d074bdab52@grossmann-venter.com>
Subject: [Qemu-devel] Qemu  the right way.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I have been using Qemu in the past about 8 years ago or so to run legacy 
windows software.

I installed the latest qemu and noticed a lot changed and cant find 
conclusive answers online.

I am writing this post to find what is the right way to start to set up 
qemu with a windows 7 pro guest. I want to try and eliminate the 
iterations and find out what is really possible for the guest.

Hardware used"
24 Core AMD rackserver.
Host OS Debian 9 Stretch
Guest Windows 7 Pro 32 bit

Requirements:
1) I need to be able to run at least 4 processors in the guest. Is this 
possible with qemu as hosts ?
2) I need to at least have sound working from applications in the guest 
with pulseaudio on the Debian host. Is it  possible ?
3) USB, what is the level of support 2.0 3.0 ?
( However windo$ 7 cannot really do USB3. so usb-3 is moot anyway)
4) What kind of devices can be run through usb ?

The answers to 1-4 will be really helpful to decide if I should even be 
using it. The documentation is schetchy about all this.
I tried Virtualbox, but it is just a nice looking empty promisebox 
yielding nothing. Since Qemu helped me a lot in the past I will have 
better chances here.

5) I am currently installing win7pro guest with command
$] qemu-system-x86_64 -boot c -cdrom /dev/cdrom -m 2048M

and left out all the network card and sound driver switches as I have no 
clue what I should choose.
Can they be configured afterwards ?

Thanks
