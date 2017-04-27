Received: from eggs.gnu.org ([2001:4830:134:3::10]:49928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d3ds5-00004v-I8
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d3ds4-0005t4-Qo
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:29:49 -0400
MIME-Version: 1.0
In-Reply-To: <20170427072612.GM9205@lemon.lan>
References: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
	<1493150351-28918-4-git-send-email-ashijeetacharya@gmail.com>
	<5e859188-5072-ab41-c10a-82c0182406cc@redhat.com>
	<20170427072612.GM9205@lemon.lan>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 27 Apr 2017 12:59:45 +0530
Message-ID: <CAC2QTZaEJL-jRt-UgnLwff6g_LizsD-XJ2paDoSvKPVGid-Zyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v1 3/8] dmg: Limit the output buffer size
 to a max of 2MB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Peter Wu <peter@lekensteyn.nl>

On Thu, Apr 27, 2017 at 12:56 PM, Fam Zheng <famz@redhat.com> wrote:
> On Wed, 04/26 17:30, John Snow wrote:
>> Seems OK otherwise, but I would normally expect you to fix the buffering
>> problems first, and then reduce the size of the buffer -- not the other
>> way around. This version introduces new limitations that didn't exist
>> previously (As of this commit, QEMU can't open DMG files with chunks
>> larger than 2MB now, right?)
>
> Yes, each commit should _not_ introduce issues (compiling failures, functional
> degeneration, etc.), and cannot rely on following commits to fix things screwed
> up in this one.
>
> This is important for bisectability - each commit can be built and tested in the
> whole git history.

Yes, understood. That's why I am gonna squash it with the last patch
(patch 8) which removes this limitation completely.

Ashijeet
