Received: from eggs.gnu.org ([2001:4830:134:3::10]:48471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eJilJ-0004cZ-5p
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eJilI-00008R-9T
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:29:33 -0500
References: <20171128121055.6954-1-den@openvz.org>
	<20171128160805.GE3703@localhost.localdomain>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <b5cb007b-7a6a-c8a0-b551-2efdc4b0cdac@openvz.org>
Date: Tue, 28 Nov 2017 19:29:20 +0300
MIME-Version: 1.0
In-Reply-To: <20171128160805.GE3703@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for 2.11 0/2] QEMU crashes with CD device
 without media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 11/28/2017 07:08 PM, Kevin Wolf wrote:
> Am 28.11.2017 um 13:10 hat Denis V. Lunev geschrieben:
>> There are 2 cases I have spotted so far:
>> 1) IDE ATAPI read processing. Actually this was reported from field
>> 2) QEMU IO hmp command (found during evaluation of (1))
>>
>> SCSI code checks during access that blk_is_available(). These patches add
>> same checks on different code paths.
>>
>> Pls decide whether these patches should go through sub-system trees or via
>> block tree.
> Why does this always come up in the last minute? :-(
>
> The real fix shouldn't be in the devices, but blk_aio_*() needs to
> handle empty drives gracefully. We already made a similar fix before the
> last release in commit 4da97120d, and I already didn't like it back
> then.
>
> Of course, we should have used the time to fix this properly, but as you
> can see, nothing has happened and we're running out of time again.
>
> Kevin
I see.

We have started ABRT report collection program a week ago. This
is the first result for QEMU from the real customer running
his own workload :(

What else can I say?

Den
