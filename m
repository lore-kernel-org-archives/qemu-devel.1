Received: from eggs.gnu.org ([2001:4830:134:3::10]:53539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drlem-0002IC-JD
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drleg-00078B-Qy
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:55:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drleg-00077M-Kn
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:55:10 -0400
Date: Tue, 12 Sep 2017 15:55:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170912155502.5ee2d753@nial.brq.redhat.com>
In-Reply-To: <20170911152150.12535-1-david@redhat.com>
References: <20170911152150.12535-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/21] s390x cleanups and CPU hotplug
 via device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 11 Sep 2017 17:21:29 +0200
David Hildenbrand <david@redhat.com> wrote:

> The first patches are a bunch of cleanups. I decided to go the
> extra mile and implement CPU hotplug via "device_add", as well as
> "query-hotpluggable-cpus".
> 
> On s390x, only complete cores can be plugged. CPU hot unplug is currently
> not supported by the architecture.
> 
> Support for hotplugging CPUs in random core-id order (last two patches)
> is added. We once hat a KVM bug preventing this, but the stable patch
> should now be included in relevant places - 152e9f65d66f ("KVM: s390: fix
> wrong lookup of VCPUs by array index"). Current tooling will plug them in
> sequential order anyway, so it should not hurt.

do you plan to convert hw/s390x/s390-virtio.c machine to possible_cpus as well?
it's not necessary to enable hotplug on it but sharing code and initializing
cpus the same way would be plus.

[...]
