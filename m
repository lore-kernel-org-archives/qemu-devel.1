Received: from eggs.gnu.org ([2001:4830:134:3::10]:48623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1dn7AB-0006YV-A1
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1dn7A7-0003xx-Ee
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:52:27 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:43065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1dn7A7-0003vF-5U
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:52:23 -0400
References: <7c9b2e44-ad64-99e0-cff6-87c669618b00@profihost.ag>
	<20170830171717.GD24565@stefanha-x1.localdomain>
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <72666cb9-f430-695b-5243-2c6cafc46c12@profihost.ag>
Date: Wed, 30 Aug 2017 19:52:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170830171717.GD24565@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] virtio: network: lost tcp/ip packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hello Stefan,


Am 30.08.2017 um 19:17 schrieb Stefan Hajnoczi:
> On Fri, Aug 18, 2017 at 04:40:36PM +0200, Stefan Priebe - Profihost AG wrote:
>> i've a problem with two VMs running on the SAME host machine using qemu
>> 2.7.1 or 2.9.0 and vhost_net + virtio.
>>
>> Sometimes TCP packets going from machine a to machine b are simply lost.
>> I see them in VM A using tcpdump going out but they never come in on
>> machine B. Both machines have iptables and stuff turned off.
>>
>> On the host both VMs network interfaces are connected to the same bridge.
>>
>> Any ideas? May be a known bug?
>>
>> Host and Guest Kernel is an OpenSuSE 42.3 kernel based on vanilla 4.4.82.
> 
> Have you tcpdumped the tap interfaces on the host?
> 
currently i can't reproduce the issue - even i was for two days.
Currently i've no idea what has happend and will report back if it
happens again.

Thanks!

Greets,
Stefan
