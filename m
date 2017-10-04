Received: from eggs.gnu.org ([2001:4830:134:3::10]:39441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzegg-0002eK-FJ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzega-0004r6-U2
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:05:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dzega-0004ox-Nr
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:05:44 -0400
Date: Wed, 4 Oct 2017 10:05:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171004100535.3f8116e8.cohuck@redhat.com>
In-Reply-To: <87fub2q9ch.fsf@dusky.pond.sub.org>
References: <20170913132417.24384-1-david@redhat.com>
	<20170913185827.1f7790f2.cohuck@redhat.com>
	<87fub2q9ch.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 02 Oct 2017 09:47:58 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Cornelia Huck <cohuck@redhat.com> writes:
> 
> > On Wed, 13 Sep 2017 15:23:55 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >  
> >> The first patches are a bunch of cleanups. I decided to go the
> >> extra mile and implement CPU hotplug via "device_add", as well as
> >> "query-hotpluggable-cpus".
> >> 
> >> On s390x, only complete cores can be plugged. CPU hot unplug is currently
> >> not supported by the architecture.
> >> 
> >> Support for hotplugging CPUs in random core-id order (last two patches)
> >> is added. We once hat a KVM bug preventing this, but the stable patch
> >> should now be included in relevant places - 152e9f65d66f ("KVM: s390: fix
> >> wrong lookup of VCPUs by array index"). Current tooling will plug them in
> >> sequential order anyway, so it should not hurt.  
> >
> > Thanks, applied.  
> 
> Please squash in the one-liner fix I asked for in my (late!) review of
> PATCH 18.

Sadly, the review was a bit too late (already merged)...
