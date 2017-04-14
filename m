Received: from eggs.gnu.org ([2001:4830:134:3::10]:37789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cyv0H-0007tK-3G
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cyv0G-0005b3-AU
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:46:45 -0400
MIME-Version: 1.0
In-Reply-To: <9c4b2a69-89fc-d4c2-7297-c9e52c17b4bd@redhat.com>
References: <20170411155226.6395-1-mreitz@redhat.com>
	<20170413132825.GB13387@stefanha-x1.localdomain>
	<50cc7a90-607a-f10e-f1d8-403e8fe75d77@redhat.com>
	<9c4b2a69-89fc-d4c2-7297-c9e52c17b4bd@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 14 Apr 2017 07:46:42 +0100
Message-ID: <CAJSP0QV=rsDJc5yjzMnvG6DbKr+h5h9ZW2msxw_7hr9BKXvFFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: John Snow <jsnow@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Fri, Apr 14, 2017 at 2:10 AM, John Snow <jsnow@redhat.com> wrote:
> On 04/13/2017 10:34 AM, Max Reitz wrote:
>> On 13.04.2017 15:28, Stefan Hajnoczi wrote:
>>> On Tue, Apr 11, 2017 at 05:52:26PM +0200, Max Reitz wrote:
>>>> This reverts commit e3e0003a8f6570aba1421ef99a0b383a43371a74.
>>>>
>>>> This commit was necessary for the 2.9 release because we were unable to
>>>> fix the underlying issue(s) in time. However, we will be for 2.10.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  block.c    |  6 +-----
>>>>  block/io.c | 12 ++----------
>>>>  2 files changed, 3 insertions(+), 15 deletions(-)
>>>
>>> Should we merge a fix before enabling the assertion again?  It's a known
>>> issue.  Let people using qemu.git live a little and have fun without the
>>> inevitable SIGABRT coredumps.  We don't benefit if more people encounter
>>> this crash and duplicate work debugging it.
>>
>> Yes, we should probably merge the fixes we know about before. But after
>> that, I'd rather merge this patch as soon as possible so we do have a
>> chance of getting more reports (if anything else is broken) before the
>> next freeze. :-)
>>
>> Max
>>
>
> It's nice to have a working tree, but I think Max has a good point about
> wanting to see the reports sooner rather than later, especially if we
> want to roll a 2.9.1 very shortly after release.
>
> (Which I think we should.)

I interpreted Max's reply to mean "okay, let's merge a fix first and
then immediately enable the assertion again".

Your reply seems to interpret Max's email as "the assertion might
catch other bugs so it should be enabled immediately without a fix".

Those two are not the same :).

Stefan
