Received: from eggs.gnu.org ([2001:4830:134:3::10]:57308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyvSP-0001J7-Nz
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 03:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyvSM-0003d2-Mi
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 03:48:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dyvSM-0003cU-Gp
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 03:48:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170913132417.24384-1-david@redhat.com>
	<20170913185827.1f7790f2.cohuck@redhat.com>
Date: Mon, 02 Oct 2017 09:47:58 +0200
In-Reply-To: <20170913185827.1f7790f2.cohuck@redhat.com> (Cornelia Huck's
	message of "Wed, 13 Sep 2017 18:58:27 +0200")
Message-ID: <87fub2q9ch.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 00/22] s390x cleanups and CPU hotplug
 via device_add
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Cornelia Huck <cohuck@redhat.com> writes:

> On Wed, 13 Sep 2017 15:23:55 +0200
> David Hildenbrand <david@redhat.com> wrote:
>
>> The first patches are a bunch of cleanups. I decided to go the
>> extra mile and implement CPU hotplug via "device_add", as well as
>> "query-hotpluggable-cpus".
>> 
>> On s390x, only complete cores can be plugged. CPU hot unplug is currently
>> not supported by the architecture.
>> 
>> Support for hotplugging CPUs in random core-id order (last two patches)
>> is added. We once hat a KVM bug preventing this, but the stable patch
>> should now be included in relevant places - 152e9f65d66f ("KVM: s390: fix
>> wrong lookup of VCPUs by array index"). Current tooling will plug them in
>> sequential order anyway, so it should not hurt.
>
> Thanks, applied.

Please squash in the one-liner fix I asked for in my (late!) review of
PATCH 18.
