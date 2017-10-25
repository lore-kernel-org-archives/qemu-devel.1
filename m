Received: from eggs.gnu.org ([2001:4830:134:3::10]:55081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e7IN1-0006e1-5X
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e7IMy-0001XV-15
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:53:07 -0400
Date: Wed, 25 Oct 2017 11:52:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171025115245.7702c8aa.cohuck@redhat.com>
In-Reply-To: <20171020115803.14093-1-david@redhat.com>
References: <20171020115803.14093-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] target/s390x: change CPU type name to
 "s390x-cpu"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>

On Fri, 20 Oct 2017 13:58:03 +0200
David Hildenbrand <david@redhat.com> wrote:

> For now, e.g. host-s390-cpu wasn't exposed to the user. cpu-add, -cpu
> and the CPU model qmp interfaces didn't care about the actual type,
> as that information was hidden.
> 
> This changed with CPU hotplug via device_add. Now the type is visible to
> the user. Before we get that supported in a stable version, this is our
> last chance to change it.
> 
> So change it form "s390-cpu" to "s390x-cpu", to match the architecture
> name. Example names are then e.g. z14-s390x-cpu or qemu-s390x-cpu.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  qapi-schema.json          | 4 ++--
>  target/s390x/cpu-qom.h    | 2 +-
>  target/s390x/cpu_models.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
