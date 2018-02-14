Received: from eggs.gnu.org ([2001:4830:134:3::10]:57445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elu67-0003TV-TT
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:15:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elu64-0006d9-Gn
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:15:31 -0500
Date: Wed, 14 Feb 2018 11:15:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180214111522.677d77bc.cohuck@redhat.com>
In-Reply-To: <1518542328-25741-4-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518542328-25741-4-git-send-email-mihajlov@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 3/3] qmp: add architecture specific cpu
 data for query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

On Tue, 13 Feb 2018 18:18:48 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> The s390 CPU state can be retrieved without interrupting the
> VM execution. Extendend the CpuInfoFast union with architecture
> specific data and an implementation for s390.
> 
> Return data looks like this:
>  [
>    {"thread-id":64301,"props":{"core-id":0},
>     "arch":"s390","cpu-state":"operating",
>     "qom-path":"/machine/unattached/device[0]","cpu-index":0},
>    {"thread-id":64302,"props":{"core-id":1},
>     "arch":"s390","cpu-state":"operating",
>     "qom-path":"/machine/unattached/device[1]","cpu-index":1}
> ]
> 
> Currently there's a certain amount of duplication between
> the definitions of CpuInfo and CpuInfoFast, both in the
> base and variable areas, since there are data fields common
> to the slow and fast variants.
> 
> A suggestion was made on the mailing list to enhance the QAPI
> code generation to support two layers of unions. This would
> allow to specify the common fields once and avoid the duplication
> in the leaf unions.
> 
> On the other hand, the slow query-cpus should be deprecated
> along with the slow CpuInfo type and eventually be removed.
> Assuming that new architectures will not be added at high
> rates, we could live with the duplication for the time being.

What would be a realistic timeframe for deprecation/removal of
query-cpus, considering the libvirt usage? Are we aware of other users?

> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>  cpus.c           | 10 ++++++++++
>  hmp.c            | 10 ++++++++++
>  qapi-schema.json | 35 +++++++++++++++++++++++++++++------
>  3 files changed, 49 insertions(+), 6 deletions(-)

Patch looks good to me.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
