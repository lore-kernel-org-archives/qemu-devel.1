Received: from eggs.gnu.org ([208.118.235.92]:58995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liebrecht@grossmann-venter.com>) id 1gcdvV-0007YJ-8R
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liebrecht@grossmann-venter.com>) id 1gcdvS-0000zm-0C
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:14:49 -0500
Received: from server54-2.web-hosting.com ([198.54.126.118]:40219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liebrecht@grossmann-venter.com>)
	id 1gcdvR-0000xw-PU
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:14:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Dec 2018 17:14:41 -0500
From: liebrecht@grossmann-venter.com
Message-ID: <7b6da43166f547478fcc8a7ffc09eddf@grossmann-venter.com>
Subject: Re: [Qemu-devel] Qemu the right way -[Subthread Cores]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liebrecht@grossmann-venter.com, qemu-devel@nongnu.org

For the record I have no crashes with
-cpu host It works perfectly. Although I can only see 2 cpus in windows 
with 4 showing up in devicemanager.

The first link you sent was actually the first thing I tried and I was 
already aware of that one.
It made no difference whatsoever.
My bios is latest on the rackserver , but it does not have the maximum 
core option in the bios.

Let me update the os to latest patches. I can vaguely remeber a similar 
problem running wi7 pro natively. I think out of the box you get win7 
home cpu limits and only after updates do you have pro lqarger cpu count 
activated. I may remeber wrong, but I will do that first and report 
back.


> Since I do not have networking sorted out yet I cannot update win7 pro, 
> and it
might be the updates which are needed for allowing more than two cpus.

hm, brief search on my side resulted in this tip:

https://answers.microsoft.com/en-us/windows/forum/windows_7-hardware/windows-7-professional-x64-only-showing-2-of-8/0155f525-df73-4642-a828-21b80d1564b0

----------
Some recommendations (in Windows, make sure you are running as 
Administrator):

- Run MSConfig -> Change to Boot tab -> Advanced Options -> "Number of
Processors", make sure there is no check mark.
- Delete processor entries listed in Device Manager, then reboot.

-------------

(I don't think BIOS options from this answer really apply directly to 
qemu case)

also, if win (or some applications inside it) keep crashing with -cpu 
host, you
can try to reload host (Linux) kvm module with additional option:

"options kvm ignore_msrs=1" line (without quotes) should be added to
  /etc/modprobe.d/kvm.conf

from
https://www.passmark.com/forum/performancetest/4748-startup-error-number-4-on-qemu-bsod
