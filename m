Received: from eggs.gnu.org ([2001:4830:134:3::10]:36526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emgdc-0002G2-Hx
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emgdY-0004HQ-Bg
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:05:20 -0500
References: <1518782691-1232-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518782691-1232-4-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dfd51042-b0a7-cee9-7de1-e2b8fc7d0b15@redhat.com>
Date: Fri, 16 Feb 2018 08:05:12 -0600
MIME-Version: 1.0
In-Reply-To: <1518782691-1232-4-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 3/4] qmp: add architecture specific cpu
 data for query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On 02/16/2018 06:04 AM, Viktor Mihajlovski wrote:
> The s390 CPU state can be retrieved without interrupting the
> VM execution. Extendend the CpuInfoFast union with architecture

s/Extendend/Extend/
(And I mentioned this on my last review - it's no fun when new revisions 
miss picking up fixes)

> specific data and an implementation for s390.
> 
> Return data looks like this:
>   [
>     {"thread-id":64301,"props":{"core-id":0},
>      "arch":"s390","cpu-state":"operating",
>      "qom-path":"/machine/unattached/device[0]","cpu-index":0},
>     {"thread-id":64302,"props":{"core-id":1},
>      "arch":"s390","cpu-state":"operating",
>      "qom-path":"/machine/unattached/device[1]","cpu-index":1}
> ]
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Acked-by: Eric Blake <eblake@redhat.com>
> ---
>   cpus.c           | 10 ++++++++++
>   qapi-schema.json | 25 ++++++++++++++++++-------
>   2 files changed, 28 insertions(+), 7 deletions(-)
> 

I've now gone through the entire patch, so you can upgrade my Acked-by into

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
