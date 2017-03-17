Received: from eggs.gnu.org ([2001:4830:134:3::10]:54660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1corqT-0001fx-CX
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1corqS-0003RD-4i
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:23:05 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1corqR-0003Qz-TC
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:23:04 -0400
Received: by mail-wm0-x233.google.com with SMTP id t189so15834963wmt.1
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 06:23:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <95e695ba-3ecc-5254-721e-b35ed08b8074@redhat.com>
References: <1489748902-21765-1-git-send-email-peter.maydell@linaro.org>
	<20170317114953.GF8050@redhat.com>
	<CAFEAcA8Sky0cX+7U257AdG=imYYcdqRgL--o=86xCHMY6Kr3zw@mail.gmail.com>
	<95e695ba-3ecc-5254-721e-b35ed08b8074@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Mar 2017 13:22:42 +0000
Message-ID: <CAFEAcA8g3iitbHPCWq9a0TrRC2Q-DiTi3ORUy_Uvt2jHjwYB8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

On 17 March 2017 at 13:19, Thomas Huth <thuth@redhat.com> wrote:
> On 17.03.2017 12:52, Peter Maydell wrote:
>> On 17 March 2017 at 11:49, Daniel P. Berrange <berrange@redhat.com> wrote:
>>> On Fri, Mar 17, 2017 at 11:08:22AM +0000, Peter Maydell wrote:
>>>> We plan to drop support in a future QEMU release for host OSes
>>>> and host architectures for which we have no test machine where
>>>> we can build and run tests. For the 2.9 release, make configure
>>>> print a warning if it is run on such a host, so that the user
>>>> has some warning of the plans and can volunteer to help us
>>>> maintain the port if they need it to continue to function.
>
> I like your patch! ... but instead of completely aborting with
> "Unsupported host OS" when an unexpected host operating system has been
> detected, I'd maybe only print a warning and continue the configure
> process - in case it is a POSIX-compatible system, there is at least a
> small chance that QEMU can be compiled there.

That code path tries to enable all the Linux specific stuff
(including KVM and linux-user and so on) and puts linux-headers/
on the include path. It seems very unlikely that it will actually
work even if in theory a generic-POSIX OS might be able to build
QEMU somehow.

This kind of tiny-corner-case stuff is exactly why I want
to drop any attempt to build on an OS or architecture we don't
actually know about. The 99.9% probability is that no user of
QEMU has successfully gone down that code path in configure for
anything that isn't Linux; and yet here we are arguing about what
its behaviour should be.

thanks
-- PMM
