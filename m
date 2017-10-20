Received: from eggs.gnu.org ([2001:4830:134:3::10]:41381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5ZUP-0004Eq-8G
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5ZUO-00066d-H3
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:45:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e5ZUO-00066G-AR
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:45:36 -0400
References: <20170913132417.24384-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ccd56ace-d877-c1e8-05b2-9422e434c89a@redhat.com>
Date: Fri, 20 Oct 2017 17:45:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170913132417.24384-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 13.09.2017 15:23, David Hildenbrand wrote:
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
> 

Just played with libvirt. It seems to automatically use the new
interface. Works great for me (including migration).


-- 

Thanks,

David
