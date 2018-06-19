Received: from eggs.gnu.org ([2001:4830:134:3::10]:48190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVMJm-00071p-0h
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVMJl-00058m-7K
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:29:30 -0400
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-9-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c770ff9b-7b3e-af61-2216-7132eec63c58@redhat.com>
Date: Tue, 19 Jun 2018 14:29:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180615142108.27814-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 08/26] qobject: Move block-specific qdict
 code to block-qdict.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 06/15/2018 09:20 AM, Kevin Wolf wrote:
> From: Markus Armbruster <armbru@redhat.com>
> 
> Pure code motion, except for two brace placements and a comment
> tweaked to appease checkpatch.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qobject/block-qdict.c     | 640 ++++++++++++++++++++++++++++++++++++++++++++
>   qobject/qdict.c           | 629 --------------------------------------------
>   tests/check-block-qdict.c | 655 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/check-qdict.c       | 642 ---------------------------------------------
>   MAINTAINERS               |   2 +
>   qobject/Makefile.objs     |   1 +
>   tests/Makefile.include    |   4 +
>   7 files changed, 1302 insertions(+), 1271 deletions(-)
>   create mode 100644 qobject/block-qdict.c
>   create mode 100644 tests/check-block-qdict.c

and missing a change to tests/.gitignore, so that 
tests/check-block-qdict now shows up as an untracked file on an in-tree 
build.

(We really should follow through with our threat of renaming all the 
tests to use a consistent suffix-based pattern, as it's much easier to 
gitignore a suffix than a prefix)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
