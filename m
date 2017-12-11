Received: from eggs.gnu.org ([2001:4830:134:3::10]:36961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eOSmW-0003ga-Al
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 13:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eOSmT-0003c5-2z
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 13:26:24 -0500
References: <20171128121055.6954-1-den@openvz.org>
	<8db8f0b0-90a7-e4c0-d76a-2383ac790048@openvz.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <26498d8f-5a3e-94d3-a016-904a4ce29c86@redhat.com>
Date: Mon, 11 Dec 2017 13:26:16 -0500
MIME-Version: 1.0
In-Reply-To: <8db8f0b0-90a7-e4c0-d76a-2383ac790048@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 12/11/2017 05:24 AM, Denis V. Lunev wrote:
> On 11/28/2017 03:10 PM, Denis V. Lunev wrote:
>> There are 2 cases I have spotted so far:
>> 1) IDE ATAPI read processing. Actually this was reported from field
>> 2) QEMU IO hmp command (found during evaluation of (1))
>>
>> SCSI code checks during access that blk_is_available(). These patches add
>> same checks on different code paths.
>>
>> Pls decide whether these patches should go through sub-system trees or via
>> block tree.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> CC: John Snow <jsnow@redhat.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>
> any decision on this?
> 

Hi Den, I was investigating it and had a long reply typed out but I
didn't want to bore you to tears with my badly written novel. I'll send
it shortly.

I couldn't reproduce the problem and I can't see how the behavior you
are seeing is possible, so I am concerned about the root cause of what's
wrong.

I will accept the hotfix before 2.12-rc0 or 2.11.1, but I want to try
and see what's going wrong in the meantime.
