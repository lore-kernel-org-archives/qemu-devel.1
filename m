Received: from eggs.gnu.org ([2001:4830:134:3::10]:43180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eYthS-0007LB-9H
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eYthO-0001Q8-93
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:12:18 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:57376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1eYthN-0001PM-UL
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:12:14 -0500
References: <cb61acc7-1a7a-616a-e2f7-29e8226ca0c3@profihost.ag>
	<a094668d-3294-e4b8-47a0-08ed8da5f9df@redhat.com>
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <6ee8cc16-0af4-1cf3-b9e2-2c9268d1c672@profihost.ag>
Date: Tue, 9 Jan 2018 14:12:11 +0100
MIME-Version: 1.0
In-Reply-To: <a094668d-3294-e4b8-47a0-08ed8da5f9df@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] how to pass pcid to guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>


Am 08.01.2018 um 23:07 schrieb Eric Blake:
> On 01/08/2018 02:03 PM, Stefan Priebe - Profihost AG wrote:
>> Hello,
>>
>> for meltdown mitigation and performance it's important to have the pcid
>> flag passed down to the guest (f.e.
>> https://groups.google.com/forum/m/#!topic/mechanical-sympathy/L9mHTbeQLNU).
> 
> Indeed; you are still waiting on the qemu patch mentioned here:
> https://www.qemu.org/2018/01/04/spectre/
> 
> which is still undergoing the review process, but should be up (in the
> form of 2.11.1) "in the next few days".

OK thanks as the performance difference is significant:

no pcid:
# time for i in $(seq 1 1 50); do du -sx /; done
...
real    0m26.614s
user    0m17.548s
sys     0m9.056s


kvm started with +pcid:
# time for i in $(seq 1 1 50); do du -sx /; done
...
real    0m14.734s
user    0m7.755s
sys     0m6.973s

Greets,
Stefan
