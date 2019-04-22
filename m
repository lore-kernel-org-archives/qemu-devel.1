Received: from eggs.gnu.org ([209.51.188.92]:42936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hINJN-0001Yi-4P
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hINJM-000645-9P
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:59:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:25428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hINJM-00063d-20
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:59:56 -0400
Date: Mon, 22 Apr 2019 08:59:25 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190422005925.GA26676@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190321082555.21118-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321082555.21118-1-richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] Refine exec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, pbonzini@redhat.com, mst@redhat.com

Ping for this trivial series.

On Thu, Mar 21, 2019 at 04:25:49PM +0800, Wei Yang wrote:
>This serial refine exec a little.
>
>Wei Yang (6):
>  exec.c: replace hwaddr with uint64_t for better understanding
>  exec.c: remove an unnecessary assert on PHYS_MAP_NODE_NIL in
>    phys_map_node_alloc()
>  exec.c: get nodes_nb_alloc with one MAX calculation
>  exec.c: subpage->sub_section is already initialized to 0
>  exec.c: correct the maximum skip value during compact
>  exec.c: add a check between constants to see whether we could skip
>
> exec.c | 21 ++++++++++-----------
> 1 file changed, 10 insertions(+), 11 deletions(-)
>
>-- 
>2.19.1

-- 
Wei Yang
Help you, Help me
