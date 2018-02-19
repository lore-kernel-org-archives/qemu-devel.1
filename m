Received: from eggs.gnu.org ([2001:4830:134:3::10]:40455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1enmuT-0004IV-CZ
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 09:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1enmuO-0001Yt-IV
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 09:59:17 -0500
Date: Mon, 19 Feb 2018 15:59:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180219155907.55ea1fc6.cohuck@redhat.com>
In-Reply-To: <1518797321-28356-6-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518797321-28356-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518797321-28356-6-git-send-email-mihajlov@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv5 5/5] hmp: change hmp_info_cpus to use
 query-cpus-fast
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

On Fri, 16 Feb 2018 17:08:41 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> Changing the implementation of hmp_info_cpus() to call

s/Changing/Change/

> qmp_query_cpus_fast() instead of qmp_query_cpus. This has the
> following consequences:
> 
>   o No further code change required for qmp_query_cpus deprecation
> 
>   o HMP profits from the less disruptive cpu information retrieval
> 
>   o HMP 'info cpus' won't display architecture specific data anymore,
>     which should be tolerable in the light of the deprecation of
>     query-cpus.
> 
> In order to allow 'info cpus' to be executed completely on the
> fast path, monitor_get_cpu_index() has been adapted to not synchronize
> the cpu state.
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>  hmp.c     | 41 +++++++----------------------------------
>  monitor.c | 13 ++++++++++---
>  2 files changed, 17 insertions(+), 37 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
