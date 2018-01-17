Received: from eggs.gnu.org ([2001:4830:134:3::10]:43582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebqY0-0008Pz-Kk
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebqXy-0000W8-SO
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:26:44 -0500
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-14-david@redhat.com>
	<20180109183230.5dfae15e.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8e09e044-2689-c510-cfa1-30c8f393726c@redhat.com>
Date: Wed, 17 Jan 2018 17:26:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180109183230.5dfae15e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2-12 13/15] s390x/tcg:
 STSI overhaul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


>> +union sysib {
>> +    struct sysib_111 sysib_111;
>> +    struct sysib_121 sysib_121;
>> +    struct sysib_122 sysib_122;
>> +    struct sysib_221 sysib_221;
>> +    struct sysib_222 sysib_222;
>> +    struct sysib_322 sysib_322;
>> +};
> 
> Wondering whether you should add some typedefery to make this more
> qemu-y.

I'll include that in the previous patch. (typedef ... )

Thanks!

-- 

Thanks,

David / dhildenb
