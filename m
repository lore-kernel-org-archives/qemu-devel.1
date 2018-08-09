Received: from eggs.gnu.org ([2001:4830:134:3::10]:40492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnk7g-0007xq-8A
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnk7c-0008Mx-BT
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:33:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnk7c-0008Mg-5i
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:32:56 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-5-e.emanuelegiuseppe@gmail.com>
	<5bffcae7-6e0e-f07e-144f-46e2e504f7d6@redhat.com>
	<a7fd57ef-d7fe-5d05-f159-c684f9ad933b@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <471c0b89-163b-ce68-439f-1fc7d705a036@redhat.com>
Date: Thu, 9 Aug 2018 14:32:53 +0200
MIME-Version: 1.0
In-Reply-To: <a7fd57ef-d7fe-5d05-f159-c684f9ad933b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/34] tests/qgraph: x86_64/pc machine
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 09/08/2018 14:23, Emanuele wrote:
>> Perhaps we can call that "memory"=C2=A0 rather than "guest_allocator",=
 as it
>> gives access to the memory of the guest?
>> and qos_node_produces("x86_64/pc", "memory");=C2=A0 (or "guest_allocat=
or")?
>>
>> and perhaps later, a qos_add_test("test-memory-allocator", "memory",
>> test_memory_allocator, NULL)?
> I don't know, is there a test for the memory allocator? I gave it that

No, I don't think so.

> name just because the actual structure representing it is called
> QGuestAllocator.

Yes, you can give the name you want, but for me "memory" sounds nicer
than "guest_allocator"...

Thanks,
Laurent
