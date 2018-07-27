Received: from eggs.gnu.org ([2001:4830:134:3::10]:38383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fj4Bc-0006OD-6s
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fj4BZ-0002sC-6A
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:57:44 -0400
References: <20180725091233.3300-1-david@redhat.com>
	<20180725170925.GE12380@localhost.localdomain>
	<a33a67eb-2fb6-31fd-f4ca-1d883a5a7b75@redhat.com>
	<20180725201438.GG12380@localhost.localdomain>
	<36882ae2-5a00-d842-0b0d-d1458b1f0654@redhat.com>
	<20180726150754.GL12380@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5a5f4272-907c-d2d3-a7b2-30366eeed4b5@redhat.com>
Date: Fri, 27 Jul 2018 16:57:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180726150754.GL12380@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] s390x/cpu_models: Add
 "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

> If we had a S390KVMAccelerator object on machine->accelerator,
> S390KVMAccelerator::host_model would be a good candidate?

Depends if at that point the machine would already be initialized (we
disable CPU model support for KVM on some legacy machine due to
interactions). It's complicated :)
[...]

>> Right now the semantics are clear: if we have "!cpu->model" after the
>> object has been created, details about the host CPU model are not
>> available (models unavailable/unsupported). Modifying properties,
>> baselining, expanding is not possible with that model then. But it can
>> be used for execution.
> 
> This is interesting.  If most users of cpu->model don't care
> about kvm_s390_get_host_cpu_model() errors at all, the current
> solution sounds more reasonable.
> 
> Except for the error_report_err() call inside instance_init.
> This still bothers me, but it's not a big deal.

Yes, we should refactor that. I'll add this to my TODO list!


-- 

Thanks,

David / dhildenb
