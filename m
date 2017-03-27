Received: from eggs.gnu.org ([2001:4830:134:3::10]:56856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csStC-000582-Jh
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csSt8-0006yS-Mk
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:32:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csSt8-0006xz-Ht
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:32:42 -0400
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e274d249-806e-473b-2a44-0ce26fd847cb@redhat.com>
Date: Mon, 27 Mar 2017 13:32:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>



On 25/03/2017 17:52, Pranith Kumar wrote:
> * Implement an LRU translation block code cache.
> 
>   In the current TCG design, when the translation cache fills up, we flush all
>   the translated blocks (TBs) to free up space. We can improve this situation
>   by not flushing the TBs that were recently used i.e., by implementing an LRU
>   policy for freeing the blocks. This should avoid the re-translation overhead
>   for frequently used blocks and improve performance.

IIRC, Emilio measured one flush every roughly 10 seconds with 128 MB
cache in system emulation mode---and "never" is a pretty accurate
estimate for user-mode emulation.  This means that a really hot block
would be retranslated very quickly.

Paolo
