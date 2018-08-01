Received: from eggs.gnu.org ([2001:4830:134:3::10]:38062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fktaY-0005FV-Ar
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fktaU-0002yM-Hn
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:03:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57202 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fktaU-0002y1-Ai
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:02:58 -0400
References: <20180801151417.23655-1-pbonzini@redhat.com>
	<CAFEAcA8WXLyAgesP6n2X7D-Uj46uZbY0209xaLLTJ1M2GojA2Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <536ca511-baf6-0f16-3239-0de7743109f3@redhat.com>
Date: Wed, 1 Aug 2018 18:02:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8WXLyAgesP6n2X7D-Uj46uZbY0209xaLLTJ1M2GojA2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fix "Missing break in switch" coverity
 reports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 01/08/2018 17:59, Peter Maydell wrote:
> 
> We could improve the somewhat cryptic comment:
>     /*
>      * 0x41 is documented as setting the output sample rate,
>      * and 0x42 the input sample rate, but in fact SB16 hardware
>      * seems to have only a single sample rate under the hood,
>      * and some (buggy) guest programs such as FT2 will set the
>      * output rate using 0x42. Compare:
>      * http://homepages.cae.wisc.edu/~brodskye/sb16doc/sb16doc.html#SamplingRate
>      */

I sometimes enjoy keeping little bits of "old-style QEMU" in these more
historical devices, but your improvement is just too good, so I'll
replace it.  Thanks!

Paolo
