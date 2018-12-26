Received: from eggs.gnu.org ([208.118.235.92]:37481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liebrecht@grossmann-venter.com>) id 1gcIos-0001SM-Rq
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 18:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liebrecht@grossmann-venter.com>) id 1gcIop-0005Bi-M1
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 18:42:34 -0500
Received: from server54-2.web-hosting.com ([198.54.126.118]:34024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liebrecht@grossmann-venter.com>)
	id 1gcIop-0004wr-Be
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 18:42:31 -0500
Received: from [::1] (port=51784 helo=server54.web-hosting.com)
	by server54.web-hosting.com with esmtpa (Exim 4.91)
	(envelope-from <liebrecht@grossmann-venter.com>) id 1gcIoa-000qvC-DY
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 18:42:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Dec 2018 18:42:16 -0500
From: liebrecht@grossmann-venter.com
In-Reply-To: <665ec250-c4a5-18ba-ad71-90966a1b9e12@redhat.com>
References: <b0d70556767952dc739454d074bdab52@grossmann-venter.com>
	<665ec250-c4a5-18ba-ad71-90966a1b9e12@redhat.com>
Message-ID: <15cf371c804f36f0b03e008f08d356d8@grossmann-venter.com>
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


> 
> Try to run QEMU with "-smp 4".
> 

Thomas thank you for your reply.
I will try each of your suggestions in turn.

-smp 4 did help and this time i could configure 2 cpus in windows.

Now for a very important question.
If hardware virtualization was not switched on in bios will qemu refuse 
to create more cpus? I just want to know if there are not bogus software 
cpus or cores created by qemu and that it actually checks it can get 
real cores from the machine and make it available to the host.

Second question. In the past qemu was lightning fast. However with this 
newer qemu windows 7 is very slow. It takes about 1 minute to open an 
application. What can slow it dow so much ? This happens with or without 
the smp switch. It seems there is some polling botlleneck if i move the 
mouse in circles in the windows guest, it would freeze for four seconds 
and then work for about 6 seconds then freeze again etc. What is that 
about.?

What is the official posting rules in this forum, top post or bottom 
post ? Thanks
