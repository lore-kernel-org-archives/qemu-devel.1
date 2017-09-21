Received: from eggs.gnu.org ([2001:4830:134:3::10]:41052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duoww-0002PH-PT
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 20:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duowr-0000yf-Nb
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 20:02:37 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:38836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1duowr-0000xP-HH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 20:02:33 -0400
Received: by mail-pg0-x243.google.com with SMTP id m30so2457414pgn.5
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 17:02:33 -0700 (PDT)
References: <20170920114637.42004-1-aik@ozlabs.ru>
	<20170920114637.42004-10-aik@ozlabs.ru>
	<611f7d09-7c5d-20c4-9b9b-1c1f58525fb1@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <e9f654aa-ca37-b4fc-a4b9-e916d62a5847@ozlabs.ru>
Date: Thu, 21 Sep 2017 10:02:28 +1000
MIME-Version: 1.0
In-Reply-To: <611f7d09-7c5d-20c4-9b9b-1c1f58525fb1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 09/18] memory: Store physical root
 MR in FlatView
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 21/09/17 03:15, Paolo Bonzini wrote:
> On 20/09/2017 13:46, Alexey Kardashevskiy wrote:
>> Address spaces get to keep a root MR (alias or not) but FlatView stores
>> the actual MR as this is going to be used later on to decide whether to
>> share a particular FlatView or not.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v4:
>> * s/memory_region_unalias_entire/memory_region_get_flatview_root/
> 
> Did you try the idea of checking for single-child regions too?

No, I did not, I do not see how I can actually measure the difference - the
PCI and virtio root MRs or single child MRs are unique anyway, I can save
some time by just checking for 2 @enabled flags instead of rendering a
FlatView but rendering such cases itself is fast as well. I'll give a try
though.


-- 
Alexey
