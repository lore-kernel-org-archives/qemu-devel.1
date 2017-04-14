Received: from eggs.gnu.org ([2001:4830:134:3::10]:42832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyplN-0002Ol-RJ
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 21:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyplM-00043k-Ty
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 21:11:01 -0400
References: <20170411155226.6395-1-mreitz@redhat.com>
	<20170413132825.GB13387@stefanha-x1.localdomain>
	<50cc7a90-607a-f10e-f1d8-403e8fe75d77@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <9c4b2a69-89fc-d4c2-7297-c9e52c17b4bd@redhat.com>
Date: Thu, 13 Apr 2017 21:10:51 -0400
MIME-Version: 1.0
In-Reply-To: <50cc7a90-607a-f10e-f1d8-403e8fe75d77@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10] Revert "block/io:
 Comment out permission assertions"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 04/13/2017 10:34 AM, Max Reitz wrote:
> On 13.04.2017 15:28, Stefan Hajnoczi wrote:
>> On Tue, Apr 11, 2017 at 05:52:26PM +0200, Max Reitz wrote:
>>> This reverts commit e3e0003a8f6570aba1421ef99a0b383a43371a74.
>>>
>>> This commit was necessary for the 2.9 release because we were unable to
>>> fix the underlying issue(s) in time. However, we will be for 2.10.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  block.c    |  6 +-----
>>>  block/io.c | 12 ++----------
>>>  2 files changed, 3 insertions(+), 15 deletions(-)
>>
>> Should we merge a fix before enabling the assertion again?  It's a known
>> issue.  Let people using qemu.git live a little and have fun without the
>> inevitable SIGABRT coredumps.  We don't benefit if more people encounter
>> this crash and duplicate work debugging it.
> 
> Yes, we should probably merge the fixes we know about before. But after
> that, I'd rather merge this patch as soon as possible so we do have a
> chance of getting more reports (if anything else is broken) before the
> next freeze. :-)
> 
> Max
> 

It's nice to have a working tree, but I think Max has a good point about
wanting to see the reports sooner rather than later, especially if we
want to roll a 2.9.1 very shortly after release.

(Which I think we should.)

--js
