Received: from eggs.gnu.org ([2001:4830:134:3::10]:33985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emgTy-0002eB-87
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emgTu-0002xw-93
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:55:22 -0500
References: <1518782691-1232-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518782691-1232-2-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <87e8b127-7f91-3f9a-7d2e-9195ef6cb48d@redhat.com>
Date: Fri, 16 Feb 2018 07:55:13 -0600
MIME-Version: 1.0
In-Reply-To: <1518782691-1232-2-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 1/4] qmp: expose s390-specific CPU info
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
> Presently s390x is the only architecture not exposing specific
> CPU information via QMP query-cpus. Upstream discussion has shown
> that it could make sense to report the architecture specific CPU
> state, e.g. to detect that a CPU has been stopped.
> 
> With this change the output of query-cpus will look like this on
> s390:
> 
>     [
>       {"arch": "s390", "current": true,
>        "props": {"core-id": 0}, "cpu-state": "operating", "CPU": 0,
>        "qom_path": "/machine/unattached/device[0]",
>        "halted": false, "thread_id": 63115},
>       {"arch": "s390", "current": false,
>        "props": {"core-id": 1}, "cpu-state": "stopped", "CPU": 1,
>        "qom_path": "/machine/unattached/device[1]",
>        "halted": true, "thread_id": 63116}
>     ]

Maybe worth adding the comment that:

HMP "info cpus" is intentionally not modified, as a later patch will be 
pruning it down anyways.

> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Acked-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>   cpus.c                     |  6 ++++++
>   hw/intc/s390_flic.c        |  4 ++--
>   hw/s390x/s390-virtio-ccw.c |  2 +-
>   qapi-schema.json           | 28 +++++++++++++++++++++++++++-
>   target/s390x/cpu.c         | 24 ++++++++++++------------
>   target/s390x/cpu.h         |  7 ++-----
>   target/s390x/kvm.c         |  8 ++++----
>   target/s390x/sigp.c        | 38 +++++++++++++++++++-------------------
>   8 files changed, 73 insertions(+), 44 deletions(-)
> 

I've now read closely through the entire patch; you can upgrade my 
Acked-by into

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
