Received: from eggs.gnu.org ([2001:4830:134:3::10]:51976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dwz0N-0002ij-I2
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dwz0K-0007e8-Bb
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:11:07 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:45415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dwz0K-0007dl-48
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:11:04 -0400
Received: by mail-pf0-x232.google.com with SMTP id z84so6286632pfi.2
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 16:11:04 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170926183318.12995-1-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a0e0add6-d9d6-2b9a-a875-00e1883db150@twiddle.net>
Date: Tue, 26 Sep 2017 16:10:59 -0700
MIME-Version: 1.0
In-Reply-To: <20170926183318.12995-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/6] s390x/tcg: fix some accesses using
 low address
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

On 09/26/2017 11:33 AM, David Hildenbrand wrote:
> David Hildenbrand (6):
>   s390x/tcg: fix checking for invalid memory check
>   s390x/tcg: add MMU for real addresses
>   s390x/tcg: make lura(g) use the new _real mmu.
>   s390x/tcg: make stora(g) use the new _real mmu
>   s390x/tcg: make testblock use the new _real mmu
>   s390x/tcg: make idte/ipte use the new _real mmu

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Watch out for a couple of blank lines left over while deleting stuff.
E.g.

{

  code
}


r~
