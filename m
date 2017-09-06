Received: from eggs.gnu.org ([2001:4830:134:3::10]:56678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dpW7G-0000YN-Dm
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dpW7D-0007IE-Sq
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:55:22 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dpW7D-0007HB-Jw
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:55:19 -0400
Received: by mail-wm0-x22f.google.com with SMTP id f199so6831338wme.0
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 01:55:17 -0700 (PDT)
References: <20170829172326.1131-1-bobby.prani@gmail.com>
	<efa7f1f6-af37-a06b-10b0-d40be2a502f0@twiddle.net>
	<CAJhHMCBoOGrts1UvNVbC+g6fxLf_9MCYssNQ4nmqiTyzTLFXuQ@mail.gmail.com>
	<8ea5a586-4d19-82db-f4b7-058229dc4124@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8ea5a586-4d19-82db-f4b7-058229dc4124@twiddle.net>
Date: Wed, 06 Sep 2017 09:55:15 +0100
Message-ID: <87ingwmcjw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/softmmu: Increase size of TLB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Pranith Kumar <bobby.prani@gmail.com>, qemu-devel <qemu-devel@nongnu.org>


Richard Henderson <rth@twiddle.net> writes:

> On 09/05/2017 05:33 PM, Pranith Kumar wrote:
>>> This significantly degrades performance of alpha-softmmu.
>>> It spends about 25% of all cpu time in memset.
>>
>> What workload does it degrade for? I will try to reproduce and see
>> which memset is causing this.
>
> emerge --update --ask @world
>
> which is a lot of python, iirc.
>
> It is the tlb flush memset that is causing this.
> The tlb has grown from a few kB to 300kB with your patch.

Hmm I wonder if this is QEMU doing global flushes which could actually
be partial TLB flushes? emerge is quite a memory hog though so its
conceivable we are generating a lot of churn as it runs.

--
Alex Bennée
