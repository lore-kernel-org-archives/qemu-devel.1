Received: from eggs.gnu.org ([2001:4830:134:3::10]:40855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cshU2-0001tQ-60
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 23:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cshU1-00017o-F5
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 23:07:46 -0400
Received: from mail-yw0-x230.google.com ([2607:f8b0:4002:c05::230]:35820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cshU1-00017i-Al
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 23:07:45 -0400
Received: by mail-yw0-x230.google.com with SMTP id d191so44949793ywe.2
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 20:07:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e274d249-806e-473b-2a44-0ce26fd847cb@redhat.com>
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
	<e274d249-806e-473b-2a44-0ce26fd847cb@redhat.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 27 Mar 2017 23:07:14 -0400
Message-ID: <CAJhHMCCiEAiOTNhOqMB+ycqz7USKvFkH2vbHR1begtFQ=OMtkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

Hi Paolo,

On Mon, Mar 27, 2017 at 7:32 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 25/03/2017 17:52, Pranith Kumar wrote:
>> * Implement an LRU translation block code cache.
>>
>>   In the current TCG design, when the translation cache fills up, we flush all
>>   the translated blocks (TBs) to free up space. We can improve this situation
>>   by not flushing the TBs that were recently used i.e., by implementing an LRU
>>   policy for freeing the blocks. This should avoid the re-translation overhead
>>   for frequently used blocks and improve performance.
>
> IIRC, Emilio measured one flush every roughly 10 seconds with 128 MB
> cache in system emulation mode---and "never" is a pretty accurate
> estimate for user-mode emulation.  This means that a really hot block
> would be retranslated very quickly.
>

OK. The problem with re-translation is that it is a serializing step
in the current design. All the cores have to wait for the translation
to complete. I think it will be a win if we could avoid it, although,
I should admit that I am not sure how much that benefit would be.

-- 
Pranith
