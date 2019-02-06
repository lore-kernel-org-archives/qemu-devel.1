Received: from eggs.gnu.org ([209.51.188.92]:53549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grN5Z-0001bl-3p
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grN5Y-0005qu-94
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:18:05 -0500
References: <1549456893-16589-1-git-send-email-thuth@redhat.com>
	<20190206135840.60a2a49f.cohuck@redhat.com>
	<124f9832-6006-06a9-f5fc-41526e37efca@redhat.com>
	<20190206141538.65852cec.cohuck@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <61d39beb-5545-e6af-fb77-19fd7e2179f6@vivier.eu>
Date: Wed, 6 Feb 2019 14:17:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190206141538.65852cec.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: Fix the confusing
 contributions-after-2012 license statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Christian Borntraeger <borntraeger@de.ibm.com>

On 06/02/2019 14:15, Cornelia Huck wrote:
> On Wed, 6 Feb 2019 14:09:40 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 2019-02-06 13:58, Cornelia Huck wrote:
>>> On Wed,  6 Feb 2019 13:41:33 +0100
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>   
>>>> The license information in these files is rather confusing. The text
>>>> declares LGPL first, but then says that contributions after 2012 are
>>>> licensed under the GPL instead. How should the average user who just
>>>> downloaded the release tarball know which part is now GPL and which
>>>> is LGPL?  
>>>
>>> FWIW, that statement was added in ccb084d3f0ec ("s390: new
>>> contributions GPLv2 or later").
>>>   
>>>>
>>>> Looking at the text of the LGPL (see COPYING.LIB in the top directory),
>>>> the license clearly states how this should be done instead:
>>>>
>>>> "3. You may opt to apply the terms of the ordinary GNU General Public
>>>>  License instead of this License to a given copy of the Library. To do
>>>>  this, you must alter all the notices that refer to this License, so
>>>>  that they refer to the ordinary GNU General Public License, version 2,
>>>>  instead of to this License."  
>>>
>>> Hm. This talks about GPL v2, not GPL v2-or-later...  
>>
>> IANAL, but since all the files originally were licensed under
>> LGPLv2-or-later, that should not be an issue, as far as I can see: You
>> then could also upgrade the LGPLv2-or-later code to LGPLv3-or-later,
>> which in turn allows you to license under GPLv3. So LGPLv2-or-later
>> means you can put the code also under GPLv2-or-later. Or do I miss
>> something?
> 
> That would seem logical, but IANAL, either...
> 
> Anyway, I'd be happy to queue this if I get acks :)
> 

For the linux-user part:

Acked-by: Laurent Vivier <laurent@vivier.eu>
