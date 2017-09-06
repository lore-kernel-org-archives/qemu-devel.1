Received: from eggs.gnu.org ([2001:4830:134:3::10]:40687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpcnO-0006pn-5a
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpcnI-0005E7-Dq
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dpcnI-0005Dd-8H
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:03:12 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<67bc4b1b-d934-dff6-9ce6-f5f34c11c9ca@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <58b1ddef-e588-b976-824e-ed537740ad3a@redhat.com>
Date: Wed, 6 Sep 2017 18:03:04 +0200
MIME-Version: 1.0
In-Reply-To: <67bc4b1b-d934-dff6-9ce6-f5f34c11c9ca@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/19] s390x cleanups and CPU hotplug
 via device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>

On 05.09.2017 09:51, Christian Borntraeger wrote:
> I think we certainly want to have device_add as well (as long as the old
> interface stays for a while).
> 
> Adding Matt. Can you have a look at the cpu hotplug bits?

If there is no further feedback, I'll be sending a new version out
tomorrow, including the suggested changes. In addition, I'll be
including support to hotplug VCPUs in random order (2 additional patches).

-- 

Thanks,

David
