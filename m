Received: from eggs.gnu.org ([2001:4830:134:3::10]:54684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dvOa9-000095-U4
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dvOa4-0002X3-UD
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:05:29 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:34306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dvOa4-0002Ws-PI
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:05:24 -0400
Received: by mail-io0-x242.google.com with SMTP id g32so716380ioj.1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 07:05:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170921213052.1765-1-david@redhat.com>
	<9d640173-93fe-0850-9335-d545dd34b2de@twiddle.net>
	<cd4dda74-77c1-27a2-7427-d963a51e06ca@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d05db15e-11f7-120b-88fb-156620b2ee6b@twiddle.net>
Date: Fri, 22 Sep 2017 09:05:19 -0500
MIME-Version: 1.0
In-Reply-To: <cd4dda74-77c1-27a2-7427-d963a51e06ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/kvm: fix and cleanup storing CPU
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 09/22/2017 08:18 AM, David Hildenbrand wrote:
> On 22.09.2017 15:12, Richard Henderson wrote:
>> I don't believe you need to use QEMU_PACKED.  Unless the "addr" that's passed
>> in can really be arbitrary?  (If so, the memory returned by
>> cpu_physical_memory_map will be unaligned and so we do need the PACKED to force
>> the compiler to generate unaligned stores into the structure.)
> 
> The address is either 0x1200 or it is masked with 0x7ffffe00u.
> 
> So most probably this should be fine without QEMU_PACKED, right?

Yes.


r~
