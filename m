Received: from eggs.gnu.org ([2001:4830:134:3::10]:51609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXNBo-0007JZ-2g
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXNBl-0004gH-0O
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:45:04 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42316
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dXNBk-0004fH-QQ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:45:00 -0400
References: <20170718060627.2107-1-anton.ivanov@cambridgegreys.com>
	<20170718072713.GC11927@redhat.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <46cbdab9-bc39-e277-a018-fcac227cc877@cambridgegreys.com>
Date: Tue, 18 Jul 2017 08:44:48 +0100
MIME-Version: 1.0
In-Reply-To: <20170718072713.GC11927@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Unified Socket Transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com

OK.

I can split it into series before next submission.

A.


On 18/07/17 08:27, Daniel P. Berrange wrote:
> On Tue, Jul 18, 2017 at 07:06:27AM +0100, anton.ivanov@cambridgegreys.com wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> 1. Creates a common recvmmsg backend for socket transports
>> 2. Migrates L2TPv3 to the new backend
>> 3. Adds gre socket transport - a vm can attach directly to GRE
>> 4. Adds raw socket transport - a vm can attach directly to an
>> Ethernet interface
>> 5. Adds simplistic static VXLAN tunnel transport (no
>> control plane).
>> 6. Sets up some of the infrastructure for future addition of
>> sendmmsg
> This list of features is a really strong sign that you should split
> this patch up into a patch series with multiple commits, each commit
> adding / changing a single feature. Especially keep refactoring of
> existing code completely separate from adding of new features.
>
> Regards,
> Daniel

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
