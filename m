Received: from eggs.gnu.org ([2001:4830:134:3::10]:40593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds9v9-0008Ah-Ba
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds9v5-0001vK-Fg
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ds9v5-0001ti-93
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:49:43 -0400
Date: Wed, 13 Sep 2017 17:49:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913174933.5bc2f9ba.cohuck@redhat.com>
In-Reply-To: <20170913132417.24384-19-david@redhat.com>
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-19-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 18/22] s390x: implement
 query-hotpluggable-cpus
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

On Wed, 13 Sep 2017 15:24:13 +0200
David Hildenbrand <david@redhat.com> wrote:

> CPU hotplug is only possible on a per core basis on s390x. So let's
> add possible_cpus and properly wire everything up.

s/properly wire everything up/wire everything up properly/

?

(fixing while... you get the idea)

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  qapi-schema.json           | 16 ++++++++++++++++
>  2 files changed, 57 insertions(+)
