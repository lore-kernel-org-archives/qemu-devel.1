Received: from eggs.gnu.org ([2001:4830:134:3::10]:50158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dYKBX-00032P-2C
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 18:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dYKBU-0003K5-09
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 18:44:43 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dYKBT-0003FN-Ns
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 18:44:39 -0400
Received: by mail-lf0-f52.google.com with SMTP id l200so17431350lfb.2
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 15:44:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8UKme8frW6-4J+CSj8yiBDX4V39GVtQ18i+0QRWJDY3g@mail.gmail.com>
References: <20170719044522.21114-1-rth@twiddle.net>
	<CAFEAcA_rx1UyVBrS1WaE6FZMvQPsb=RJJCZgnfS2AjWR+hsFsg@mail.gmail.com>
	<e590ae65-f18f-7ced-c141-8833a3df38ca@twiddle.net>
	<CAFEAcA8UKme8frW6-4J+CSj8yiBDX4V39GVtQ18i+0QRWJDY3g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 21 Jul 2017 00:44:34 +0200
Message-ID: <CABgObfYZXzuNDZyn5WQ-qtHdYufnD0rZEoo+_Cc+EutYdR1TPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] target/alpha cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maydell, Peter" <peter.maydell@linaro.org>
Cc: rth <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>

I am planning to refresh the series for 2.11.

Paolo

Il 20/lug/2017 11:07, "Peter Maydell" <peter.maydell@linaro.org> ha scritto:

> On 19 July 2017 at 22:52, Richard Henderson <rth@twiddle.net> wrote:
> > On 07/19/2017 06:57 AM, Peter Maydell wrote:
> >>
> >> On 19 July 2017 at 05:45, Richard Henderson <rth@twiddle.net> wrote:
> >>>
> >>> The new title holder for perf top is helper_lookup_tb_ptr.
> >>> Those targets that have a complicated cpu_get_tb_cpu_state
> >>> function are going to regret that.
> >>
> >>
> >> Yeah, Paolo's pointed out (and had some patches for)
> >> ARM's rather complicated cpu_get_tb_cpu_state(). My
> >> issue with his suggested fixes was that they were
> >> pretty fragile in terms of not having any guarantee
> >> that the change always produced the right tb cpu
> >> state flags answer...
> >
> >
> > Oh?  I must have missed seeing this one.
> > A quick patchwork search doesn't pull it up;
> > do either of you have a link?
>
> It was back in September:
> https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg03133.html
>
> thanks
> -- PMM
>
>
