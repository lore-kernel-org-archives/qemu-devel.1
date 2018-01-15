Received: from eggs.gnu.org ([2001:4830:134:3::10]:42903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eazZM-0001y8-Vr
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eazZJ-0006hM-Rz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:52:37 -0500
References: <20180115072715.25921-1-david@gibson.dropbear.id.au>
	<20180115072715.25921-2-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <62a187bb-cc00-7210-ea81-bcca2fc75c06@redhat.com>
Date: Mon, 15 Jan 2018 08:52:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180115072715.25921-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/ppc: Clarify compat mode
 max_threads value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, joserz@linux.vnet.ibm.com, surajjs@au1.ibm.com, sam.bobroff@au1.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 15/01/2018 08:27, David Gibson wrote:
> We recently had some discussions that were sidetracked for a while, because
> nearly everyone misapprehended the purpose of the 'max_threads' field in
> the compatiblity modes table.  It's all about guest expectations, not host
> expectations or support (that's handled elsewhere).
> 
> In an attempt to avoid a repeat of that confusion, rename the field to
> 'max_vthreads' and add an explanatory comment.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c      |  4 ++--
>  target/ppc/compat.c | 25 +++++++++++++++++--------
>  target/ppc/cpu.h    |  2 +-
>  3 files changed, 20 insertions(+), 11 deletions(-)
> 
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
