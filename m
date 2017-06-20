Received: from eggs.gnu.org ([2001:4830:134:3::10]:33703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNMqF-0007HP-IA
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNMqC-0004Ei-DV
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:21:27 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNMqC-0004E5-7t
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:21:24 -0400
Received: by mail-pg0-x243.google.com with SMTP id j186so22784002pge.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 10:21:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170620000405.3391-16-rth@twiddle.net>
	<169e898c-98f6-a6d6-7045-1b2606469fe4@redhat.com>
	<f6f19088-0284-2f22-c6fb-0739efe35ee1@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8a99b514-550a-abbc-0961-c3ea5667bcf1@twiddle.net>
Date: Tue, 20 Jun 2017 10:21:20 -0700
MIME-Version: 1.0
In-Reply-To: <f6f19088-0284-2f22-c6fb-0739efe35ee1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 15/18] target/s390x: Implement SRSTU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

On 06/20/2017 01:27 AM, David Hildenbrand wrote:
> 2. We must not overwrite bit 0-31 in 24/31 bit mode:
> 
> (PoP page 3-6)
> Unless specifically stated to the contrary, the follow-
> ing definition applies in this publication: whenever the
> machine generates and provides to the program a
> 24-bit or 31-bit address, the address is made avail-
> able (placed in storage or loaded into a general regis-
> ter) by being imbedded in a 32-bit field, with the
> leftmost eight bits or one bit in the field, respectively,
> set to zeros. When the address is loaded into a gen-
> eral register, bits 0-31 of the register remain
> unchanged.

Yes, Aurelien started down these lines when he added the set_address/set_length 
functions.  We just need to use them more often, I suppose.


r~
