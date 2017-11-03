Received: from eggs.gnu.org ([2001:4830:134:3::10]:50542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAie9-0005Gi-UT
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAie6-0006fS-RP
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:32:57 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <w518tfnglio.fsf@maestria.local.igalia.com>
References: <cover.1509718618.git.berto@igalia.com>
	<fb53467cf48e95ff3330def1cf1003a5b862b7d9.1509718618.git.berto@igalia.com>
	<ad3990d7-4356-4764-4da2-01cc59a63075@redhat.com>
	<w518tfnglio.fsf@maestria.local.igalia.com>
Date: Fri, 03 Nov 2017 21:32:50 +0100
Message-ID: <w5160argl1p.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 3/7] qcow2: Prevent
 allocating compressed clusters at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri 03 Nov 2017 09:22:39 PM CET, Alberto Garcia wrote:
>>> -        assert(offset);
>>
>> I don't think this assert() was meant as a protection against offset
>> being 0. :-)
>
> After the new check offset is now guaranteed to be 0, so what's the
> point of keeping the assert() ?

I meant "guaranteed _not_ to be 0" :-)

Berto
