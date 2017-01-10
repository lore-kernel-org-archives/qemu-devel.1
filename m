Received: from eggs.gnu.org ([2001:4830:134:3::10]:55996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cQzXq-0004wH-H9
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cQzXl-0000im-S4
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:45:10 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:34138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cQzXl-0000ii-LB
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:45:05 -0500
Received: by mail-wj0-x242.google.com with SMTP id qs7so50519371wjc.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 08:45:05 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1478772703-28185-1-git-send-email-thuth@redhat.com>
	<1478772703-28185-7-git-send-email-thuth@redhat.com>
	<20170110053133-mutt-send-email-mst@kernel.org>
	<362c2ee4-b230-d407-c3eb-af80fbfafa96@redhat.com>
	<148406606920.24341.4122999103047828613@loki>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6d6c6198-10e1-f5a3-e436-f92e306e6833@redhat.com>
Date: Tue, 10 Jan 2017 17:45:02 +0100
MIME-Version: 1.0
In-Reply-To: <148406606920.24341.4122999103047828613@loki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 6/6] MAINTAINERS: Remove obsolete stable
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 10/01/2017 17:34, Michael Roth wrote:
> Quoting Thomas Huth (2017-01-10 01:54:40)
>> On 10.01.2017 04:32, Michael S. Tsirkin wrote:
>>> On Thu, Nov 10, 2016 at 11:11:43AM +0100, Thomas Huth wrote:
>>>> There are only very old and orphaned stable branches listed
>>>> in the MAINTAINERS file - so this section is pretty useless
>>>> nowadays. Let's remove it.
>>>>
>>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>>
>>> Could you add some kind of entry for stable though?
>>> Otherwise people won't know which address to CC.
>>
>> I think that's a question to Michael Roth - whether such an entry should
>> be added and how it should look like.
> 
> Hmm, not sure how to make this very readable. Something like this
> perhaps?
> 
> Stable branches
> ---------------
> Current M.(N-1) Stable Branch (e.g. v2.8 if latest M.N.0 release was v2.9.0)
> M: Michael Roth <mdroth@linux.vnet.ibm.com>
> L: qemu-stable@nongnu.org
> T: git git://git.qemu-project.org/qemu.git stable-M.(N-1)
> S: Supported

I would just say

Stable branches
---------------
Current Stable Branch (e.g. v2.8 if latest M.N.0 release was v2.9.0)
M: Michael Roth <mdroth@linux.vnet.ibm.com>
L: qemu-stable@nongnu.org
S: Supported

Is the stable git tree used in practice, except in the days right before
a release?

Paolo

>>
>>  Thomas
>>
>>
>>>> ---
>>>>  MAINTAINERS | 22 ----------------------
>>>>  1 file changed, 22 deletions(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index d8575ab..4a60579 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1574,28 +1574,6 @@ F: tcg/tci/
>>>>  F: tci.c
>>>>  F: disas/tci.c
>>>>  
>>>> -Stable branches
>>>> ----------------
>>>> -Stable 1.0
>>>> -L: qemu-stable@nongnu.org
>>>> -T: git git://git.qemu-project.org/qemu-stable-1.0.git
>>>> -S: Orphan
>>>> -
>>>> -Stable 0.15
>>>> -L: qemu-stable@nongnu.org
>>>> -T: git git://git.qemu-project.org/qemu-stable-0.15.git
>>>> -S: Orphan
>>>> -
>>>> -Stable 0.14
>>>> -L: qemu-stable@nongnu.org
>>>> -T: git git://git.qemu-project.org/qemu-stable-0.14.git
>>>> -S: Orphan
>>>> -
>>>> -Stable 0.10
>>>> -L: qemu-stable@nongnu.org
>>>> -T: git git://git.qemu-project.org/qemu-stable-0.10.git
>>>> -S: Orphan
>>>> -
>>>>  Block drivers
>>>>  -------------
>>>>  VMDK
>>>> -- 
>>>> 1.8.3.1
>>>>
>>
> 
> 
> 
