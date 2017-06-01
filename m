Received: from eggs.gnu.org ([2001:4830:134:3::10]:54961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGULD-0006lQ-Jn
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGULC-0000zX-WF
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:56:59 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGULC-0000zH-PL
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:56:58 -0400
Received: by mail-wm0-x233.google.com with SMTP id 7so167142400wmo.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 10:56:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Yteb5jsB2AJhuhx1Ejg+nwrF8PgetRWv+yFPduLHOgg@mail.gmail.com>
References: <20170601170733.13080-1-pbonzini@redhat.com>
	<CAFEAcA9Yteb5jsB2AJhuhx1Ejg+nwrF8PgetRWv+yFPduLHOgg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2017 18:56:37 +0100
Message-ID: <CAFEAcA9zPWDQ8Y6ugAut5WobLXzP3zrUeUUH7RcSUMqdLkkndA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/34] Misc patches for 2016-06-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 June 2017 at 18:53, Peter Maydell <peter.maydell@linaro.org> wrote:
> Test failure on OSX:
>
> TEST: tests/device-introspect-test... (pid=66373)
>   /aarch64/device/introspect/list:                                     OK
>   /aarch64/device/introspect/none:                                     OK
>   /aarch64/device/introspect/abstract:                                 OK
>   /aarch64/device/introspect/concrete:                                 **
> ERROR:/root/qemu/qom/object.c:364:object_initialize_with_type:
> assertion failed: (type != NULL)
> Broken pipe

Got those the wrong way round -- this is the FreeBSD failure
and the other lot are OSX. Pretty sure it's the same error,
though -- it's just that for some reason my OSX setup doesn't
actually cause make to exit with an error when a test fails,
so it goes on to hit what's probably the same bug in all the
other check-qtest-$ARCH targets rather than bailing out.

thanks
-- PMM
