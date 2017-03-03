Received: from eggs.gnu.org ([2001:4830:134:3::10]:38411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjfvw-0000Vi-28
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 00:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjfvv-0005JQ-Cl
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 00:39:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<dba72030-5a51-c439-ff27-9bb52430b772@redhat.com>
Date: Fri, 03 Mar 2017 06:39:05 +0100
In-Reply-To: <dba72030-5a51-c439-ff27-9bb52430b772@redhat.com> (Eric Blake's
	message of "Thu, 2 Mar 2017 17:35:08 -0600")
Message-ID: <87shmu7wcm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/15] block: A bunch of fixes for Sheepdog
 and Gluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

Eric Blake <eblake@redhat.com> writes:

> On 03/02/2017 03:43 PM, Markus Armbruster wrote:
>> Bad error handling, memory leaks, and lack of blockdev-add support.
>
> How hard are we trying to get blockdev-add working in 2.9?  Or is this
> series 2.10 material now?

Definitely not 2.10: seven patches fix or document bugs, one improves
error messages, five are straightforward cleanups.  The series touches
only these two block drivers, including QAPI schema parts not used
anywhere else:

>>  block/gluster.c      | 127 +++++++--------
>>  block/sheepdog.c     | 436 +++++++++++++++++++++++++++++++++++++--------------
>>  qapi-schema.json     |  38 +++++
>>  qapi/block-core.json |  73 +++------
>>  4 files changed, 443 insertions(+), 231 deletions(-)

With the pending pull requests merged, blockdev-add *is* working, except
for sheepdog.  I'm considering that a bug, and I need *two* patches to
fix it.  One touches only sheepdog.c, and the other only adds to the
QAPI schema.

If we decide not to fix the bug, I'd recommend to declare blockdev-add
supported in 2.9 anyway, with a release note that sheepdog support is
broken.
