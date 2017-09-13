Received: from eggs.gnu.org ([2001:4830:134:3::10]:39003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds9ri-0005Z9-Qv
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds9re-0007hi-UJ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:46:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ds9re-0007fe-P7
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:46:10 -0400
Date: Wed, 13 Sep 2017 17:45:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913174557.146b83af.cohuck@redhat.com>
In-Reply-To: <20170913132417.24384-18-david@redhat.com>
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-18-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 17/22] s390x: CPU hot unplug via
 device_del cannot work for now
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

On Wed, 13 Sep 2017 15:24:12 +0200
David Hildenbrand <david@redhat.com> wrote:

> device_del on a CPU will currently do nothing. Let's emmit an error

s/emmit/emit/

(fixing while applying)

> telling that this is will currently not work (there is no architecture
> support on s390x). Error message copied from ppc.
> 
> (qemu) device_del cpu1
> device_del cpu1
> CPU hot unplug not supported on this machine
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
