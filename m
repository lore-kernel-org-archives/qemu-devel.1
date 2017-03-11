Received: from eggs.gnu.org ([2001:4830:134:3::10]:54772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cmiY4-0005zf-Pu
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 10:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cmiY3-0005mv-J8
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 10:03:12 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cmiY3-0005m7-D6
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 10:03:11 -0500
Received: by mail-wm0-x22d.google.com with SMTP id n11so13433227wma.1
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 07:03:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170311022506.GB26530@flamenco>
References: <20170310012339.GA7400@flamenco> <20170310114531.GB2480@work-vm>
	<CAFEAcA9s0tHLYFwm+SP22ecB9uw1oyXdJSf5iG0iKzwRQuoGpQ@mail.gmail.com>
	<20170311022506.GB26530@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 11 Mar 2017 16:02:47 +0100
Message-ID: <CAFEAcA-dnCGHnh2LCP0Z2=f_ip9DKQTz4gqVC0KrraatcEbeXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Benchmarking linux-user performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=EF=BF=BDe?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On 11 March 2017 at 03:25, Emilio G. Cota <cota@braap.org> wrote:
> On Fri, Mar 10, 2017 at 12:48:31 +0100, Peter Maydell wrote:
>> Given the scale on the LHS is from 1.74 to 1.88 my guess is that the
>> variation is in large part noise and the major thing is "our fp
>> performance is bounded by softfloat, which doesn't change and is
>> always very slow".
>
> It isn't "measurement noise" -- if you look at the PNGs the measurements
> are very stable (all points have error bars): http://imgur.com/a/nF7Ls
>
> It's true that performance here varies very little. This is just the
> result of Amdahl's law, as you point out. (upon re-reading your message,
> I see that perhaps what you meant by "noise" is exactly this.)

Yes, sorry, I wasn't really using the right terminology there.
I just meant that the release-to-release variation is not as
significant as it appears from the graph, because the LHS axis
scale is covering such a small range.

thanks
-- PMM
