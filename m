Received: from eggs.gnu.org ([2001:4830:134:3::10]:55973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2b7-00007C-6B
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2b6-0000me-6p
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:05:17 -0500
Date: Mon, 18 Dec 2017 16:05:06 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171218210506.GJ20604@localhost.localdomain>
References: <cover.1510093478.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Code cleanup and minor fixes (for
 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, rjones@redhat.com, kwolf@redhat.com, eblake@redhat.com

On Tue, Nov 07, 2017 at 05:27:17PM -0500, Jeff Cody wrote:
> Changes from v2 -> v3:
> 
> Patch 1: Return -EIO for ssh_state_init() (Thanks Eric)
> Patch 4: fixed missed line (Thanks Eric)
> Patch 7: fixed opaque pointer assignment (Thanks Eric)
> 
> git-backport-diff -r master.. -u 81fb084
> 
> 001/7:[0007] [FC] 'block/ssh: don't call libssh2_init() in block_init()'
> 002/7:[----] [--] 'block/ssh: make compliant with coding guidelines'
> 003/7:[----] [--] 'block/sheepdog: remove spurious NULL check'
> 004/7:[0010] [FC] 'block/sheepdog: code beautification'
> 005/7:[----] [--] 'block/curl: check error return of curl_global_init()'
> 006/7:[----] [--] 'block/curl: fix minor memory leaks'
> 007/7:[0002] [FC] 'block/curl: code cleanup to comply with coding style'
> 
> 
> Jeff Cody (7):
>   block/ssh: don't call libssh2_init() in block_init()
>   block/ssh: make compliant with coding guidelines
>   block/sheepdog: remove spurious NULL check
>   block/sheepdog: code beautification
>   block/curl: check error return of curl_global_init()
>   block/curl: fix minor memory leaks
>   block/curl: code cleanup to comply with coding style
> 
>  block/curl.c     | 124 +++++++++++++++++++++++------------------
>  block/sheepdog.c | 166 +++++++++++++++++++++++++++----------------------------
>  block/ssh.c      |  69 ++++++++++++++---------
>  3 files changed, 197 insertions(+), 162 deletions(-)
> 
> -- 
> 2.9.5
> 

Applied the non-controversial patches 3-6 to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
