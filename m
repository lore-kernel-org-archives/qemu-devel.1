Received: from eggs.gnu.org ([2001:4830:134:3::10]:34277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dVFKO-0008Cn-23
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dVFKL-00047p-0f
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:57:08 -0400
References: <CAFEAcA_HPtBhES_9L1KZzJTDJRpxD=0Ux-OyC3BV2UDNKZg2hg@mail.gmail.com>
	<40961524-561e-aa31-b043-7b8ae9203b7c@suse.de>
	<7bb17d85-a21b-d890-03cc-18f56b785361@redhat.com>
	<dfa89a7f-263d-c7b4-9866-7d972bed6057@suse.de>
	<3d688e8e-1140-557b-d2ed-1d96e6f5831a@redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <52384cdc-7a38-876f-b1a8-e00b19c7f158@suse.de>
Date: Wed, 12 Jul 2017 12:56:56 +0200
MIME-Version: 1.0
In-Reply-To: <3d688e8e-1140-557b-d2ed-1d96e6f5831a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] should we update QEMU's u-boot submodule and
 binary?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>



On 12.07.17 12:49, Thomas Huth wrote:
> On 12.07.2017 12:44, Alexander Graf wrote:
>>
>>
>> On 12.07.17 12:34, Thomas Huth wrote:
>>> On 11.07.2017 20:22, Alexander Graf wrote:
>>>>
>>>> On 11.07.17 19:43, Peter Maydell wrote:
>>>>> Hi; I just noticed that our u-boot submodule is still stuck on
>>>>> a commit from 2014 when it was first added to QEMU. Should we
>>>>> move this forward to some more recent u-boot release?
>>>>>
>>>>> I think we only use this for our ppc e500 rom...
>>>>
>>>> It probably makes sense to update the e500 rom and bump the submodule to
>>>> the latest U-Boot release along the way, yes.
>>>>
>>>> U-Boot 2017.07 just got released, so now is quite a good point in time
>>>> to do so.
>>>
>>> I think we should rather update the submodule to commit 79c884d7e4 since
>>> that is the level that is used for the pc-bios/u-boot.e500 binary (see
>>> http://git.qemu.org/?p=qemu.git;a=commitdiff;h=d4574435a6530bbd96ae13 ).
>>
>> Why not update both?
> 
> Because it needs some proper tests in that case...?
> 
>>> The problematic mv_gen_reg.h is also not part of that commit level
>>> anymore.
>>>
>>> Alex, could you please send a patch for the update? Or shall I prepare
>>> one?
>>
>> I tried to compile U-Boot from 2017.07 earlier, but don't have a working
>> ppc build environment anymore :(
> 
> I've never been into that e500 stuff, so I also do not have a proper
> test environment for that embedded ppc stuff ==> let's update just the
> submodule to 79c884d7e4 and call it a day?

You don't need much of a test environment. Just check if it comes up in 
QEMU :).


Alex
