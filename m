Received: from eggs.gnu.org ([2001:4830:134:3::10]:49038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3dol-00066k-3d
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3dok-000231-By
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:26:23 -0400
Date: Thu, 27 Apr 2017 15:26:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170427072612.GM9205@lemon.lan>
References: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
	<1493150351-28918-4-git-send-email-ashijeetacharya@gmail.com>
	<5e859188-5072-ab41-c10a-82c0182406cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e859188-5072-ab41-c10a-82c0182406cc@redhat.com>
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
To: John Snow <jsnow@redhat.com>
Cc: Ashijeet Acharya <ashijeetacharya@gmail.com>, stefanha@gmail.com, kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, peter@lekensteyn.nl

On Wed, 04/26 17:30, John Snow wrote:
> Seems OK otherwise, but I would normally expect you to fix the buffering
> problems first, and then reduce the size of the buffer -- not the other
> way around. This version introduces new limitations that didn't exist
> previously (As of this commit, QEMU can't open DMG files with chunks
> larger than 2MB now, right?)

Yes, each commit should _not_ introduce issues (compiling failures, functional
degeneration, etc.), and cannot rely on following commits to fix things screwed
up in this one.

This is important for bisectability - each commit can be built and tested in the
whole git history.

Fam
