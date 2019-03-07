Received: from eggs.gnu.org ([209.51.188.92]:51468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1h1xa4-0000eb-Pi
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1h1xa4-0007E5-5H
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:17:20 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:34057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1h1xa4-0007Dl-0u
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:17:20 -0500
Received: by mail-qt1-f182.google.com with SMTP id x20so584207qto.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:17:19 -0800 (PST)
MIME-Version: 1.0
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
In-Reply-To: <62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 7 Mar 2019 19:17:08 +0100
Message-ID: <CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Thu, Mar 7, 2019 at 7:13 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/03/19 14:09, Peter Maydell wrote:
> > On Thu, 7 Mar 2019 at 12:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> In any case, this wouldn't change; as you suggest below, configure could
> >> remain as a front-end (well, in-srcdir builds are not supported by
> >> Meson, so "../configure && ninja" perhaps).
> >
> > As an aside, it might be a nice idea to drop the in-srcdir
> > build altogether for QEMU anyway -- it's not really a very
> > good idea and it means our build system has to cope with two
> > different ways of working to no particularly useful end.
>
> I was actually going to propose that, but I was afraid of throwing two
> bombs in the same day. :)

As someone who has also been annoyed having to support in-tree and
out-of-tree, I support that move. I used to be a pretty happy use of
in-tree builds, but out-of-tree his generally equally convenient.

Who is volunteering to do patches to deprecate the support? warning in
4.0, and error in 4.1?

thanks
