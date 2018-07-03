Received: from eggs.gnu.org ([2001:4830:134:3::10]:50729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faKji-0001PX-6F
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faKje-00076I-Dx
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:48:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faKje-000761-88
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:48:46 -0400
References: <20180702165842.11423-1-rkagan@virtuozzo.com>
	<42e1ca43-c31a-43a7-950e-57695c5ddd7f@redhat.com>
	<20180703074717.GB30904@rkaganb.sw.ru>
	<20180703080035.GF485@lemon.usersys.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0688fe25-4b5c-38f6-03fb-a4d3e7cb9ce7@redhat.com>
Date: Tue, 3 Jul 2018 07:48:43 -0500
MIME-Version: 1.0
In-Reply-To: <20180703080035.GF485@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] patchew header docs [was: Re: [PATCH 0/6] hyperv:
 refactor HvSintRoute management]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>

On 07/03/2018 03:00 AM, Fam Zheng wrote:
> On Tue, 07/03 10:47, Roman Kagan wrote:
>> On Mon, Jul 02, 2018 at 03:55:33PM -0500, Eric Blake wrote:
>>> On 07/02/2018 11:58 AM, Roman Kagan wrote:
>>>> This series modifies the management of HvSintRoute, which is an
>>>> important building block in Hyper-V emulation infrastructure, to make it
>>>> easier to maintain and enhance, and paves the way to the more complete
>>>> Synthetic Interrupt Controller (SynIC) emulation.
>>>>
>>>> This series applies on top of "[PATCH 0/2] hyperv: ensure VP index equal
>>>> to QEMU cpu_index" series (message-id:
>>>> <20180702134156.13404-1-rkagan@virtuozzo.com>).
>>>
>>> Rewriting that in a form that patchew can parse:
>>>
>>> Based-on: 20180702134156.13404-1-rkagan@virtuozzo.com
>>
>> Thanks!
>>
>> Are patchew-recognized headers documented anywhere?
> 
> No dedicated documentation so far becasue the only recognized syntax is this
> "^Based-on: $MESSAGE_ID$" line, which is mentioned in

I seem to recall that "^Based-on: $URL$" also works, when $URL points to 
a message within https://lists.gnu.org/archive/html/qemu-devel/ (at 
least, I've used it in a few cases, rather than further looking up the 
translation from $URL to $MESSAGE_ID myself).

> 
> https://wiki.qemu.org/Contribute/SubmitAPatch
> 
> There are requests to support more, such as the git base tree information:
> 
> https://github.com/patchew-project/patchew/issues/79

And if my recollection was wrong, adding $URL support would be one of 
those requests, and perhaps ought to be given an issue so we don't 
forget it.

> 
> and once we get there, we'll find a better place to document these features so
> that people can read about it more easily.
> 
> Fam
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
