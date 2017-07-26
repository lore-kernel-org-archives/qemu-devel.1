Received: from eggs.gnu.org ([2001:4830:134:3::10]:53900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daDHV-0000kI-Ns
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daDHR-0006hP-T1
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:46:41 -0400
Received: from [59.151.112.132] (port=39508 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daDHR-0006cv-FT
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:46:37 -0400
References: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <3738157a-e45b-72af-53a2-de9ab4b35a98@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 11:45:35 +0800
MIME-Version: 1.0
In-Reply-To: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/4] Convert to realize and fix error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, jiri@resnulli.us, armbru@redhat.com, f4bug@amsat.org

Hi, Jason

This was posted over 2 months ago with two R-Bs(Markus & Philippe),
did it get merged or dropped?

Thanks,
Mao

On 05/23/2017 12:04 PM, Mao Zhongyi wrote:
> v5:
> * Patch 1 removed the dead error handling that was previously missing.
> * Patch 2 and 3 has not changed.
> * Patch 4 is a new patch to fix the unusual macro name.
>
> v4:
> * Patch 1 is following Markus's suggestion that remove the dead error
>   handling.
> * Patch 2 is separate from patch 1 to plug the memory leak in the v3.
> * Patch 3 is based on the patch 1 in the v3. Meanwhile, dorp the superfluous
>   prefix "rocker:" and adjust the commit message.
>
> v3:
> * Following Jason's suggstion that add suitable error message to
>   each error site.
> * Modified the commit message to make it easier to read.
>
> v2:
> * Following Philippe's suggestion that shorten the patch subject
>   "hw/net/rocker/rocker" to "net/rocker".
> * Use a consistent log format to report error message.
> * Add a specific goto label "err_name_too_long" to make a correct
>   cleanup.
>
> Mao Zhongyi (4):
>   net/rocker: Remove the dead error handling
>   net/rocker: Plug memory leak in pci_rocker_init()
>   net/rocker: Convert to realize()
>   net/rocker: Fix the unusual macro name
>
>  hw/net/rocker/rocker.c        | 93 ++++++++++---------------------------------
>  hw/net/rocker/rocker_desc.c   | 10 -----
>  hw/net/rocker/rocker_fp.c     |  4 --
>  hw/net/rocker/rocker_of_dpa.c | 20 ----------
>  hw/net/rocker/rocker_world.c  | 12 +++---
>  5 files changed, 27 insertions(+), 112 deletions(-)
>
