Received: from eggs.gnu.org ([2001:4830:134:3::10]:39830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elGPJ-0007Eo-GV
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elGPG-0004qt-Ou
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:52:41 -0500
Date: Mon, 12 Feb 2018 16:52:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180212165228.2021b4d4.cohuck@redhat.com>
In-Reply-To: <1518437672-7724-2-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518437672-7724-2-git-send-email-mihajlov@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qmp: expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, lcapitulino@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, dgilbert@redhat.com, rth@twiddle.net, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

On Mon, 12 Feb 2018 13:14:30 +0100
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
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Acked-by: Eric Blake <eblake@redhat.com>
> ---
>  cpus.c                     |  6 ++++++
>  hmp.c                      |  4 ++++
>  hw/intc/s390_flic.c        |  4 ++--
>  hw/s390x/s390-virtio-ccw.c |  2 +-
>  qapi-schema.json           | 28 +++++++++++++++++++++++++++-
>  target/s390x/cpu.c         | 24 ++++++++++++------------
>  target/s390x/cpu.h         |  7 ++-----
>  target/s390x/kvm.c         |  8 ++++----
>  target/s390x/sigp.c        | 38 +++++++++++++++++++-------------------
>  9 files changed, 77 insertions(+), 44 deletions(-)

Patch looks good to me. I presume this should go through the s390 tree?
Or do we want someone to pick up the whole series?
