Received: from eggs.gnu.org ([2001:4830:134:3::10]:39513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1enmqg-0001gR-RT
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 09:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1enmqd-0008Hb-Oz
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 09:55:22 -0500
Date: Mon, 19 Feb 2018 15:54:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180219155459.775d1e1e.cohuck@redhat.com>
In-Reply-To: <1518797321-28356-2-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518797321-28356-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518797321-28356-2-git-send-email-mihajlov@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv5 1/5] qmp: expose s390-specific CPU info
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

On Fri, 16 Feb 2018 17:08:37 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> Presently s390x is the only architecture not exposing specific
> CPU information via QMP query-cpus. Upstream discussion has shown
> that it could make sense to report the architecture specific CPU
> state, e.g. to detect that a CPU has been stopped.
> 
> With this change the output of query-cpus will look like this on
> s390:
> 
>    [
>      {"arch": "s390", "current": true,
>       "props": {"core-id": 0}, "cpu-state": "operating", "CPU": 0,
>       "qom_path": "/machine/unattached/device[0]",
>       "halted": false, "thread_id": 63115},
>      {"arch": "s390", "current": false,
>       "props": {"core-id": 1}, "cpu-state": "stopped", "CPU": 1,
>       "qom_path": "/machine/unattached/device[1]",
>       "halted": true, "thread_id": 63116}
>    ]
> 
> This change doesn't add the s390-specific data to HMP 'info cpus'.
> A follow-on patch will remove all architecture specific information
> from there.
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  cpus.c                     |  6 ++++++
>  hw/intc/s390_flic.c        |  4 ++--
>  hw/s390x/s390-virtio-ccw.c |  2 +-
>  qapi-schema.json           | 28 +++++++++++++++++++++++++++-
>  target/s390x/cpu.c         | 24 ++++++++++++------------
>  target/s390x/cpu.h         |  7 ++-----
>  target/s390x/kvm.c         |  8 ++++----
>  target/s390x/sigp.c        | 38 +++++++++++++++++++-------------------
>  8 files changed, 73 insertions(+), 44 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
