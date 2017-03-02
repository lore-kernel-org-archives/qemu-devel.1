Received: from eggs.gnu.org ([2001:4830:134:3::10]:35039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cjWxC-00086n-19
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cjWxB-0008EP-6J
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:03:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cjWxA-0008Dv-Vr
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:03:57 -0500
References: <20170302193300.21188-1-brogers@suse.com>
	<36cb066c-4d1f-dc7f-ada6-cef224566f2d@redhat.com>
	<19443ff2-d552-4540-965b-b4840f2899ce@redhat.com>
	<58B81727020000480014092F@prv-mh.provo.novell.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d3700c72-7030-4326-d1c1-7fdfa279b578@redhat.com>
Date: Thu, 2 Mar 2017 21:03:53 +0100
MIME-Version: 1.0
In-Reply-To: <58B81727020000480014092F@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Exclude more cpu model code
 when building s390x linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, "rth@twiddle.net" <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>

Am 02.03.2017 um 20:59 schrieb Bruce Rogers:
>>>> On 3/2/2017 at 12:53 PM, <david@redhat.com> wrote:
>> Am 02.03.2017 um 20:50 schrieb David Hildenbrand:
>>> Am 02.03.2017 um 20:33 schrieb Bruce Rogers:
>>>> Currently qemu-s390x segfaults. Avoid cpu model code which doesn't
>>>> apply in linux user case.
>>>
>>> That was also my impression, but it does apply. However, for now it
>>> doesn't matter, as also tcg isn't properly wired up.
>>>
>>> In general, linux-user can support _at least_ the same features as tcg,
>>> in theory even more (all that only apply to kernel space).
>>>
>>> We had a proper fix on this list by Richard Henderson, wonder what
>>> happened to that?
>>
>> Actually it was Stefan Weil :) cc-ing him.
> 
> I'm not all so familiar with this code, I only saw a failure and fixed it the
> most obvious way for me. I'm happy if there is a better fix out there.

Thanks for taking care, seems like the other patch somehow got stuck, so
thanks for bringing that up! :)

In my original series (when I thought linux-user wouldn't care about CPU
models), your patch would have been the correct fix!

> 
> BTW: I resent the patch again with SOB.
> 
> Brue
> 

-- 
Thanks,

David
