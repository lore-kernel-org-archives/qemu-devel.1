Received: from eggs.gnu.org ([2001:4830:134:3::10]:38089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fnjyD-0004vj-TI
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fnjy9-00041V-0m
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:23:13 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:42246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fnjy8-000410-Ot
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:23:08 -0400
Received: by mail-ed1-x52c.google.com with SMTP id r4-v6so2764795edp.9
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 05:23:08 -0700 (PDT)
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-5-e.emanuelegiuseppe@gmail.com>
	<5bffcae7-6e0e-f07e-144f-46e2e504f7d6@redhat.com>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <a7fd57ef-d7fe-5d05-f159-c684f9ad933b@gmail.com>
Date: Thu, 9 Aug 2018 14:23:05 +0200
MIME-Version: 1.0
In-Reply-To: <5bffcae7-6e0e-f07e-144f-46e2e504f7d6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

> Perhaps we can call that "memory"  rather than "guest_allocator", as it
> gives access to the memory of the guest?
> and qos_node_produces("x86_64/pc", "memory");  (or "guest_allocator")?
>
> and perhaps later, a qos_add_test("test-memory-allocator", "memory",
> test_memory_allocator, NULL)?
I don't know, is there a test for the memory allocator? I gave it that 
name just because the actual structure representing it is called 
QGuestAllocator.

Thank you,
Emanuele
