Received: from eggs.gnu.org ([2001:4830:134:3::10]:48296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dMgxx-0005ko-Hd
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 16:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dMgxt-0006gY-Iz
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 16:38:37 -0400
In-Reply-To: <OFEB04B3D4.4F8B4FD7-ON86258143.0070FC87-86258143.00713D4F@ddci.com>
References: <mailman.79275.1497783014.22739.qemu-devel@nongnu.org>
	<AF8C3FA5-35D0-4391-8F3B-C9723FBEE2BE@gmail.com>
	<OFEB04B3D4.4F8B4FD7-ON86258143.0070FC87-86258143.00713D4F@ddci.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B89DC65F-3BF3-4140-9467-5E0921E100FE@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Sun, 18 Jun 2017 16:38:29 -0400
Subject: Re: [Qemu-devel] [PATCH v3] target-ppc: Enable open-pic timers to
 count and generate interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alarson@ddci.com
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>


On Jun 18, 2017, at 4:36 PM, alarson@ddci.com wrote:

> G 3 <programmingkidx@gmail.com> wrote on 06/18/2017 09:45:25 AM:
>
>>>>> From: Aaron Larson <alarson@ddci.com>
>>>>> To: agraf@suse.de, alarson@ddci.com, david@gibson.dropbear.id.au,
>>>> qemu-devel@nongnu.org, qemu-ppc@nongnu.org
>>>>> Date: 06/05/2017 12:22 PM
>>>>> Subject: [PATCH v3] target-ppc: Enable open-pic timers to count  
>>>>> and
>>>> generate interrupts
>>>>>
>>>>> Previously QEMU open-pic implemented the 4 open-pic timers  
>>>>> including
>>>>> all timer registers, but the timers did not "count" or generate  
>>>>> any
>>>>> interrupts.  The patch makes the timers both count and generate
>>>>> interrupts.  The timer clock frequency is fixed at 25MHZ.
>
> G3> Does QEMU behave differently after this patch is implemented?
>
> If the open-pic timers are programmed, then QEMU behaves
> differently, otherwise there should be no difference.

I guess I should have asked what differences did you see in QEMU's  
behavior?
