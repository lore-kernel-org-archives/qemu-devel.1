Received: from eggs.gnu.org ([2001:4830:134:3::10]:59273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1cJ2oe-0005j6-Ve
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:37:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1cJ2ob-0004IA-UH
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:37:41 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:17546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1cJ2ob-0004EN-KM
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:37:37 -0500
References: <1a3a7aef-55f1-11b6-b33f-621979cbb59f@profihost.ag>
	<1383290552.4515122.1481729638569.JavaMail.zimbra@oxygem.tv>
	<32c0e94e-8beb-03f3-2605-46225500e6ad@profihost.ag>
	<464605215.4528644.1481784392571.JavaMail.zimbra@oxygem.tv>
	<ba2e2786-a7ba-5ad9-86ef-aae1c4def034@profihost.ag>
	<20161219110346.GC17374@stefanha-x1.localdomain>
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <549beab5-be5b-f8dc-ff3a-a7ce483324e3@profihost.ag>
Date: Mon, 19 Dec 2016 19:37:30 +0100
MIME-Version: 1.0
In-Reply-To: <20161219110346.GC17374@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] any known virtio-net regressions in Qemu 2.7?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, qemu-devel <qemu-devel@nongnu.org>, power-management@lists.fedoraproject.org, jskarvad@redhat.com


Am 19.12.2016 um 12:03 schrieb Stefan Hajnoczi:
> On Fri, Dec 16, 2016 at 10:00:36PM +0100, Stefan Priebe - Profihost AG wrote:
>>
>> Am 15.12.2016 um 07:46 schrieb Alexandre DERUMIER:
>>> does rollbacking the kernel to previous version fix the problem ?
>>
>> The culprit is the used tuned agent from Redhat
>> (https://github.com/redhat-performance/tuned). The used profile
>> virtual-host results in these problems. Stopping tuned or using another
>> profile like throughput-performance everything is fine again.
> 
> Interesting discovery.  Have you filed a bug report about it?

As we're not using RHEL, nor CentOS i didn't expect this to make sense
;-) I just believed that something in the kernel changed.

Greets,
Stefan

>> after upgrading a cluster OS, Qemu, ... i'm experiencing slow and
>> volatile network speeds inside my VMs.
>>
>> Currently I've no idea what causes this but it's related to the host
>> upgrades. Before i was running Qemu 2.6.2.
>>
>> I'm using virtio for the network cards.
> 
> Stefan
> 
