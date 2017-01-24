Received: from eggs.gnu.org ([2001:4830:134:3::10]:41419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVzUe-00062L-SR
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVzUe-0006G6-0o
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:42:32 -0500
References: <0bb184fe-d348-a1d4-ac14-0f02f070c287@kamp.de>
	<20170119163845.GC16641@redhat.com>
	<8e98321f-70ce-f86a-37d3-de2c1a5f45bd@kamp.de>
	<20170119170355.GF16641@redhat.com>
	<dde6f36e-e78a-1d93-54fb-1914eea9aee1@redhat.com>
	<c1132831-e228-bfa7-b327-8963d325ed8e@kamp.de>
	<539908e5-591a-e3fc-ebb8-f2867ef5e26c@redhat.com>
	<d1644885-3191-e095-84b2-498b504b9ef4@kamp.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c3d6e32-da80-1189-5a0c-30135a45e451@redhat.com>
Date: Tue, 24 Jan 2017 12:42:25 +0100
MIME-Version: 1.0
In-Reply-To: <d1644885-3191-e095-84b2-498b504b9ef4@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-img: complains about missing iscsi option
 group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 24/01/2017 12:40, Peter Lieven wrote:
> Am 24.01.2017 um 12:29 schrieb Paolo Bonzini:
>>
>> On 24/01/2017 12:25, Peter Lieven wrote:
>>> Am 24.01.2017 um 12:24 schrieb Paolo Bonzini:
>>>> On 19/01/2017 18:03, Daniel P. Berrange wrote:
>>>>>>> Move the iscsi option registration out of vl.c and back into a
>>>>>>> shared file
>>>>>>> in block/ such that all programs see the options, not just the
>>>>>>> emulators.
>>>>>> Any preference which file? It seems no other block driver registers
>>>>>> options.
>>>>> ISCSI is somewhat bizarre in that it has a separate global -iscsi arg
>>>>> instead of just accepting all args via the -drive spec like every
>>>>> other
>>>>> block driver does, so there's no precedent to follow.
>>>>>
>>>>> So suggest we just need a block/iscsi-global.c to deal with this.
>>>> Why not block/iscsi.c itself?
>>> As far as I understand block/iscsi is now compiled as a shared object.
>> Uh, right. :(
> 
> Okay, so a new file iscsi-static.c ?

Yes, something like that.  Or block/iscsi-opts.c too.

Paolo
