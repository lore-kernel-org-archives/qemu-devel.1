Received: from eggs.gnu.org ([2001:4830:134:3::10]:59967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1erToY-0003Uj-JL
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1erToX-0000KN-Gj
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:24:26 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-19-jsnow@redhat.com>
	<20180228181553.GL4855@localhost.localdomain>
	<24618453-fd43-de12-1e14-2fc9ed2c4b8b@redhat.com>
	<20180301100134.GB4862@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <e7944885-0761-fdd3-beb9-a9cd5de753ce@redhat.com>
Date: Thu, 1 Mar 2018 14:24:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180301100134.GB4862@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 18/21] blockjobs: add block-job-finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 03/01/2018 05:01 AM, Kevin Wolf wrote:
> Am 28.02.2018 um 20:14 hat John Snow geschrieben:
>>
>>
>> On 02/28/2018 01:15 PM, Kevin Wolf wrote:
>>> Is it because you want to avoid that the user picks an automatic job for
>>> completing the mixed transaction?
>>
>> I wanted to avoid the case that a job without the manual property would
>> be stuck "pending" -- which I have defined to mean that it is waiting on
>> an authorization from the user -- which isn't really true: it's waiting
>> on its peers in the transaction to receive that authorization.
>>
>> It would indeed be simpler to just let them stick around in PENDING like
>> their peers, but it felt like a hacky way to allow mixed-mode
>> transactions -- like they had been promoted for just a subset of their
>> lifetime.
>>
>> So, mostly it was a semantic decision and not a functional one based on
>> what I considered "WAITING" to mean vs "PENDING".
>>
>> If the definitions (and documentation) are adjusted it can be changed
>> for the simpler layout if it seems just as good from the API
>> perspective. (It's certainly better implementationally, as you say.)
> 
> I actually like it better conceptually, too, because I think of WAITING
> as a state that waits for jobs in earlier states (i.e. RUNNING/READY
> usually) and then everything moves forward together. Also waiting for
> jobs that are already in a later state like PENDING, but only for
> automatic jobs, makes the mental model more complex (or maybe it's just
> me...).
> 
> Kevin
> 

No, that's a good point. I'll go with the simpler implementation, but
I'll leave a mention of the other approach in the RFC and we'll see if
there are other comments.

At some point I'll need to prod Pkrempa and make sure the design looks
tenable to him, too.

--js
