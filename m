Received: from eggs.gnu.org ([2001:4830:134:3::10]:58613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dG8wY-0000PU-G1
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dG8wV-0005OW-5J
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:06:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dG8wU-0005OE-Uh
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:06:03 -0400
References: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
	<c5d963e7-ef71-0ed5-aaae-01d492e4fd8b@redhat.com>
	<CABoDooMMWkkPJ+5DxBYd0BwQ_q9rJXuUyf0PL50zdG6T89JD-Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <941d0659-648f-d0f6-bf35-4838bca20768@redhat.com>
Date: Wed, 31 May 2017 21:05:57 +0200
MIME-Version: 1.0
In-Reply-To: <CABoDooMMWkkPJ+5DxBYd0BwQ_q9rJXuUyf0PL50zdG6T89JD-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tcg: move the tcg files into tcg/
 subdirectory.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: Yang Zhong <yang.zhong@intel.com>, Eric Blake <eblake@redhat.com>, anthony.xu@intel.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 31/05/2017 18:24, Laurent Desnogues wrote:
> All source files have an explicit BSD license except tcg-runtime.h
> which has none and aarch64 files which are licensed under GPL.  So we
> are already not following the rule expressed in LICENSE.
> 
> tcg-runtime.c is BSD
> tci.c is GPL
> translate-all.[ch] are GPL
> translate-common.c is GPL
> cpu-exec.c cpu-exec-common.c cputlb.c are GPL
> 
> I guess the LICENSE file has become obsolete and so should be removed
> (and Fabrice Bellard should perhaps be let know about that just in
> case).

We can change it to "The TCG backend files", followed by a list of
files.  But even then, aarch64 files are GPL...

Paolo
