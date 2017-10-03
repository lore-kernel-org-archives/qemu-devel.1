Received: from eggs.gnu.org ([2001:4830:134:3::10]:58874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzPbj-0004cG-2C
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 11:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzPbi-0006Gl-EP
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 11:59:43 -0400
References: <20171003031556.15173-1-jsnow@redhat.com>
	<20171003031556.15173-4-jsnow@redhat.com>
	<2458dfaf-5c50-bdc7-3a9e-d018099a42cf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <84555a15-9ec6-2b28-a118-c209c97efd45@redhat.com>
Date: Tue, 3 Oct 2017 11:59:28 -0400
MIME-Version: 1.0
In-Reply-To: <2458dfaf-5c50-bdc7-3a9e-d018099a42cf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] blockjob: expose manual-cull property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 10/03/2017 11:57 AM, Paolo Bonzini wrote:
> On 03/10/2017 05:15, John Snow wrote:
>> For drive-backup and blockdev-backup, expose the manual-cull
>> property, having it default to false. There are no universal
>> creation parameters, so it must be added to each job type that
>> it makes sense for individually.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>

[...]

> 
> The verb "cull" is a bit weird.  The only alternative that comes to mind
> though are "reap" (like processes). There's also "join" (like threads),
> but would imply waiting if the jobs hasn't completed yet, and we
> probably don't want it.
> 
> Paolo
> 

Sure, open to suggestions. I think Kevin suggested "delete" which I have
reservations about because of people potentially confusing it with
"cancel" or "complete" -- it does not have the capacity to
end/terminate/finish/complete/cancel a job.

"reap" might be fine. I don't really have any strong preference.

--js
