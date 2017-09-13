Received: from eggs.gnu.org ([2001:4830:134:3::10]:50639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsAzn-0003ZP-Sn
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsAzl-0002WI-CQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:58:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dsAzl-0002UB-6P
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:58:37 -0400
Date: Wed, 13 Sep 2017 18:58:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913185827.1f7790f2.cohuck@redhat.com>
In-Reply-To: <20170913132417.24384-1-david@redhat.com>
References: <20170913132417.24384-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/22] s390x cleanups and CPU hotplug
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
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, 13 Sep 2017 15:23:55 +0200
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

Thanks, applied.
