Received: from eggs.gnu.org ([2001:4830:134:3::10]:59694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpDBU-0006sK-O8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpDBQ-0002AM-70
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:42:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dpDBQ-00029r-0y
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:42:24 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-9-david@redhat.com>
	<20170905143801.1dc39cb1.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e4ed534e-6eef-30ea-6359-0b535f483cc3@redhat.com>
Date: Tue, 5 Sep 2017 14:42:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170905143801.1dc39cb1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/19] s390x: move sclp_service_call()
 to interrupt.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On 05.09.2017 14:38, Cornelia Huck wrote:
> On Mon,  4 Sep 2017 17:43:05 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Fix up includes and rename it to s390x_*.
> 
> I'm not quite sure whether that is the right direction: servc is just an
> instruction that does something and then happens to also generate an
> interrupt on conclusion. I'll think a bit more about it.
> 

Having CPU related stuff in sclp looks also wrong. Feel free to skip
this patch, should be unrelated to the following patches.

-- 

Thanks,

David
