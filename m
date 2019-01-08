Received: from eggs.gnu.org ([209.51.188.92]:42560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1ggsgY-0004M7-AM
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1ggsgW-0008FZ-Au
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:48:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1ggsgV-0008A9-1t
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:48:52 -0500
References: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
	<1545422632-24444-5-git-send-email-liam.merwick@oracle.com>
	<20190102131841.GO24009@stefanha-x1.localdomain>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <324f45ae-d537-180d-c6aa-92410b9cee6c@oracle.com>
Date: Tue, 8 Jan 2019 14:48:44 +0000
MIME-Version: 1.0
In-Reply-To: <20190102131841.GO24009@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 4/4] pvh: Boot uncompressed kernel using
 direct boot ABI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, maran.wilson@oracle.com, george.kennedy@oracle.com, boris.ostrovsky@oracle.com



On 02/01/2019 13:18, Stefan Hajnoczi wrote:
> On Fri, Dec 21, 2018 at 08:03:52PM +0000, Liam Merwick wrote:
>> @@ -1336,7 +1470,7 @@ void pc_memory_init(PCMachineState *pcms,
>>       int linux_boot, i;
>>       MemoryRegion *ram, *option_rom_mr;
>>       MemoryRegion *ram_below_4g, *ram_above_4g;
>> -    FWCfgState *fw_cfg;
>> +    FWCfgState *fw_cfg = NULL;
> 
> What is the purpose of this change?
> 

I've removed this. There is no need for it - it dated from when these 
changes used the Clear Containers -nofw patches.

Regards,
Liam
