Received: from eggs.gnu.org ([209.51.188.92]:39379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gkDgh-0007vw-5N
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gkDgg-0001ct-In
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:50:51 -0500
From: John Snow <jsnow@redhat.com>
References: <20181221135803.9583-1-npes87184@gmail.com>
	<8736abeb-60b6-e077-b6ad-0f01da4f8c0a@redhat.com>
Message-ID: <85ba040e-3e44-c8d5-568c-2b219939eb88@redhat.com>
Date: Thu, 17 Jan 2019 14:50:42 -0500
MIME-Version: 1.0
In-Reply-To: <8736abeb-60b6-e077-b6ad-0f01da4f8c0a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dmg: fix binary search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <npes87184@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com



On 1/17/19 2:29 PM, John Snow wrote:
> 
> 
> On 12/21/18 8:58 AM, yuchenlin wrote:
>> There is a possible hang in original binary searsh implemtation. That is
>> if chunk1 = 4, chunk2 = 5, chunk3 = 4, and we go else case.
>>
>> The chunk1 will be still 4, and so on.
>>
>> Signed-off-by: yuchenlin <npes87184@gmail.com>
> 
> Generally we ask that people use their full names for their
> Signed-off-by (for legal and copyright reasons) and not an alias.
> 
> If I am mistaken and your name is a mononym or written as a mononym,
> please forgive me and disregard.
> 

ah, just found the later threads. Still email backlogged, disregard.
