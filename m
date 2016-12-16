Received: from eggs.gnu.org ([2001:4830:134:3::10]:33626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1cHzcX-00012Z-26
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1cHzcU-0004up-0j
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:00:49 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:54325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1cHzcT-0004sP-HJ
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:00:45 -0500
References: <1a3a7aef-55f1-11b6-b33f-621979cbb59f@profihost.ag>
	<1383290552.4515122.1481729638569.JavaMail.zimbra@oxygem.tv>
	<32c0e94e-8beb-03f3-2605-46225500e6ad@profihost.ag>
	<464605215.4528644.1481784392571.JavaMail.zimbra@oxygem.tv>
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <ba2e2786-a7ba-5ad9-86ef-aae1c4def034@profihost.ag>
Date: Fri, 16 Dec 2016 22:00:36 +0100
MIME-Version: 1.0
In-Reply-To: <464605215.4528644.1481784392571.JavaMail.zimbra@oxygem.tv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] any known virtio-net regressions in Qemu 2.7?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: qemu-devel <qemu-devel@nongnu.org>


Am 15.12.2016 um 07:46 schrieb Alexandre DERUMIER:
> does rollbacking the kernel to previous version fix the problem ?

The culprit is the used tuned agent from Redhat
(https://github.com/redhat-performance/tuned). The used profile
virtual-host results in these problems. Stopping tuned or using another
profile like throughput-performance everything is fine again.

Geets,
Stefan

> 
> i'm not sure if "perf" could give you some hints
> ----- Mail original -----
> De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>
> À: "aderumier" <aderumier@odiso.com>
> Cc: "qemu-devel" <qemu-devel@nongnu.org>
> Envoyé: Mercredi 14 Décembre 2016 21:36:23
> Objet: Re: [Qemu-devel] any known virtio-net regressions in Qemu 2.7?
> 
> Am 14.12.2016 um 16:33 schrieb Alexandre DERUMIER: 
>> Hi Stefan, 
>>
>> do you have upgraded kernel ? 
> 
> Yes sure. But i'm out of ideas how to debug. Sometimes it gives me 
> constant 80MB/s, sometimes 125 and sometimes only 6. While on the host 
> the cards are not busy. 
> 
> Greets, 
> Stefan 
> 
>>
>> maybe it could be related to vhost-net module too. 
>>
>>
>> ----- Mail original ----- 
>> De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag> 
>> À: "qemu-devel" <qemu-devel@nongnu.org> 
>> Envoyé: Mercredi 14 Décembre 2016 16:04:08 
>> Objet: [Qemu-devel] any known virtio-net regressions in Qemu 2.7? 
>>
>> Hello, 
>>
>> after upgrading a cluster OS, Qemu, ... i'm experiencing slow and 
>> volatile network speeds inside my VMs. 
>>
>> Currently I've no idea what causes this but it's related to the host 
>> upgrades. Before i was running Qemu 2.6.2. 
>>
>> I'm using virtio for the network cards. 
>>
>> Greets, 
>> Stefan 
>>
> 
