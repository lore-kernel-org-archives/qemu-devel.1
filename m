Received: from eggs.gnu.org ([2001:4830:134:3::10]:57763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQCA7-0001hj-0c
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQCA1-0007RB-4s
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:38:11 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:44225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQCA0-0007Qo-Ug
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:38:05 -0400
Received: from player746.ha.ovh.net (unknown [10.109.105.106])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 43FC9CB472
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 15:38:03 +0200 (CEST)
Date: Tue, 5 Jun 2018 15:37:58 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180605153759.2796b54a@bahia.lan>
In-Reply-To: <cover.1527973524.git.keno@juliacomputing.com>
References: <cover.1527973524.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Prepratory cleanup for 9p darwin
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: qemu-devel@nongnu.org

On Sat,  2 Jun 2018 17:29:34 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> Hi Greg,
> 
> this is a respin of just the first couple of patches of my 9p Darwin
> series. These patches should be applicable independent of the darwin
> work.
> 

I've applied patches 2 to 5 for the time being.

> Keno Fischer (5):
>   cutils: Provide strchrnul
>   9p: xattr: Fix crashes due to free of uninitialized value
>   9p: local: Avoid warning if FS_IOC_GETVERSION is not defined
>   9p: Properly error check and translate flags in unlinkat
>   9p: xattr: Properly translate xattrcreate flags
> 
>  configure             | 15 +++++++++++++++
>  hmp.c                 |  8 ++++----
>  hw/9pfs/9p-handle.c   |  8 +-------
>  hw/9pfs/9p-local.c    | 42 ++++++++++++++++++++++++------------------
>  hw/9pfs/9p.c          | 34 ++++++++++++++++++++++++++++------
>  hw/9pfs/9p.h          |  4 ++++
>  include/qemu/cutils.h |  8 ++++++++
>  monitor.c             |  8 ++------
>  util/cutils.c         | 15 +++++++++++++++
>  util/qemu-option.c    |  6 +-----
>  util/uri.c            |  6 ++----
>  11 files changed, 104 insertions(+), 50 deletions(-)
> 
