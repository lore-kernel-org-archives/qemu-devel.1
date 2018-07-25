Received: from eggs.gnu.org ([2001:4830:134:3::10]:46931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fiJEm-0006da-0N
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fiJEj-0008Pj-2R
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:49:52 -0400
References: <20180725091233.3300-1-david@redhat.com>
	<20180725133640.3ea78c59.cohuck@redhat.com>
	<12ec6fa8-aa28-f8d6-a6ad-df87824e89e9@redhat.com>
	<20180725140631.54c1df1f.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fa2b4bc2-e23f-e7db-5caf-057421ca6f96@redhat.com>
Date: Wed, 25 Jul 2018 14:49:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180725140631.54c1df1f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpu_models: Add "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Collin Walling <walling@linux.ibm.com>, "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

>>
>>> Maybe add a comment that for kvm we try the host model, and only that
>>> can fail (i.e., for tcg this will always work)?  
>>
>> "we expect only errors under KVM, when we actually query the kernel"
> 
> "We expect errors only under KVM, where we actually query the kernel"
> 
> ?

Sure, maybe you can fit it into one line (which is what I tried).

> 
> If nobody else has further comments, I can squash in the change and
> queue it for 3.1. I'll let it sit for a bit longer on the list, though.

If I don't have to resend, can you fixup the subject "s390x/cpumodel: ..." ?

Thanks!

-- 

Thanks,

David / dhildenb
