Received: from eggs.gnu.org ([2001:4830:134:3::10]:51159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eyUzd-0004vP-CK
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 00:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eyUza-0003r7-7d
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 00:04:53 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:36495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eyUzZ-0003ql-WC
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 00:04:50 -0400
Received: by mail-pf0-x233.google.com with SMTP id 68so1543795pfx.3
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 21:04:49 -0700 (PDT)
References: <28028831-7306-3356-6018-c7dcf72dc349@ozlabs.ru>
	<7a8ee5e0-d450-5d60-f388-278eb0b3083f@ozlabs.ru>
	<20180320074658.19fe0668@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2c61ae57-1309-636b-e24f-4b203b08fedd@ozlabs.ru>
Date: Wed, 21 Mar 2018 15:04:43 +1100
MIME-Version: 1.0
In-Reply-To: <20180320074658.19fe0668@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Partial NUMA config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

On 20/3/18 5:46 pm, Igor Mammedov wrote:
> On Mon, 19 Mar 2018 15:28:50 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 13/3/18 1:26 pm, Alexey Kardashevskiy wrote:
>>> Hi Igor,
>>>
>>> ec78f8114bc4c1 "numa: use possible_cpus for not mapped CPUs check" added a
>>> warning about "All CPU(s) up to maxcpus should be described in NUMA config,
>>> ability to start up with partial NUMA mappings is obsoleted and will be
>>> removed in future" and this is printed when I add a numa node without
>>> attached CPU like this:
>>>
>>> -numa node,nodeid=0,cpus=0,mem=4G
>>> -numa node,nodeid=1,mem=131072M
> Warning you see is about CPU(s) not assigned to any node
> and it has noting to do with cpu-less node.
> 
> What's the full CLI you are using?

I do not have it handy but it included:
-smp 2 -numa node,nodeid=0,cpus=0,mem=4G -numa node,nodeid=1,mem=131072M

And your explanation about nonassigned CPUs makes sense, thanks!


-- 
Alexey
