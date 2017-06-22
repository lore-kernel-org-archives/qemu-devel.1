Received: from eggs.gnu.org ([2001:4830:134:3::10]:37810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dO64o-00047G-R5
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dO64j-0006S2-U6
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:39:30 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dO64j-0006Rs-Pc
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:39:25 -0400
Received: by mail-qt0-x242.google.com with SMTP id c20so2915082qte.0
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 10:39:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170622094151.28633-1-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <13a03d8f-6191-8716-34ed-4ab1f7bf7590@twiddle.net>
Date: Thu, 22 Jun 2017 10:39:21 -0700
MIME-Version: 1.0
In-Reply-To: <20170622094151.28633-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] target/s390x: implement idte and
 improve ipte
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com

On 06/22/2017 02:41 AM, David Hildenbrand wrote:
> By adding idte, we are now able to expose the DAT-enhancement facility
> to our guest. Also, properly simulate and expose the local-tlb-clearing
> facility.
> 
> To improve the TLB flushing, we will have to remember each used table (or
> at least a hash!) for each tlb entry, just like real HW does.
> 
> This allows me to start an upstream kernel (having also the mvcos patch
> applied) compiled for z9 using:
> 
> qemu-system-s390x ... -cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on,\
>                             eimm=on,stckf=on,csst=on,csst2=on,ginste=on,\
>                             exrl=on,dateh=on,ltlbc=on
> 
> Linux will detect the DAT-enhancement facility and use idte+cspg.
> 
> v1 -> v2:
> - Allow to enable the DAT-enhancement facility.
> - Fix wrong register in idte.
> - Simply set m4 to zero in case local-tlb-clearing is not enabled.

Reviewed and applied to my target/s390x tree.


r~
