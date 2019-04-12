Received: from eggs.gnu.org ([209.51.188.92]:47019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF30A-0003JI-9s
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 16:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF305-0007bk-Bq
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 16:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hF305-0007bI-3r
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 16:42:17 -0400
Date: Fri, 12 Apr 2019 17:42:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190412204213.GI31999@habkost.net>
References: <20190405064121.23662-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405064121.23662-1-richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] cleanup select_machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com

On Fri, Apr 05, 2019 at 02:41:17PM +0800, Wei Yang wrote:
> Here is two simple change related to select_machine()
> 
> [1]: make find_default_machine() local since no one outside file use it
> [2]: allocate TYPE_MACHINE list only once to select machine type
> [3]: cleanup after previous commit
> [4]: Simplify machine_parse()

Thanks!  Queued on machine-next, for 4.1.

> 
> ---
> v2:
>   * adjust changelog in [1]
>   * Markus provides [3-4]
> 
> Markus Armbruster (2):
>   vl: Clean up after previous commit
>   vl: Simplify machine_parse()
> 
> Wei Yang (2):
>   vl.c: make find_default_machine() local
>   vl.c: allocate TYPE_MACHINE list once during bootup
> 
>  include/hw/boards.h |  1 -
>  vl.c                | 69 ++++++++++++++++++---------------------------
>  2 files changed, 28 insertions(+), 42 deletions(-)
> 
> -- 
> 2.19.1
> 
> 

-- 
Eduardo
