Received: from eggs.gnu.org ([2001:4830:134:3::10]:59373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cpw4B-00076s-3L
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cpw47-0003tq-VI
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:05:39 -0400
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:35417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cpw47-0003tS-NX
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:05:35 -0400
Received: by mail-vk0-x22a.google.com with SMTP id x75so68742223vke.2
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 05:05:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKPgXcFwSHgb+sLimF=+En_fHM1rYnV1+jX3Tg_hP07EmzyiJg@mail.gmail.com>
References: <CAKPgXcFwSHgb+sLimF=+En_fHM1rYnV1+jX3Tg_hP07EmzyiJg@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 20 Mar 2017 14:05:34 +0200
Message-ID: <CAKPgXcG+P5MCiDyvAmAiRxPGf0XgTCvwCuC5f_DiadEZ5OgXVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu-ga static compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

ping.

On Tue, Mar 14, 2017 at 6:51 PM, Sameeh Jubran <sameeh@daynix.com> wrote:

> Hi all,
>
> I am trying to compile qemu-ga for Windows statically using the following
> commands:
>
> ./configure --disable-docs --target-list=x86_64-softmmu
> --cross-prefix=x86_64-w64-mingw32- --static --enable-guest-agent-msi
> --with-vss-sdk=/path/to/VSSSDK72
>
> make -j8 qemu-ga
>
>
> And I keep getting this error:
>
> /home/sameeh/Builds/q/stubs/error-printf.c:7: undefined reference to
> `__imp_g_test_config_vars'
> collect2: error: ld returned 1 exit status
> Makefile:444: recipe for target 'qemu-ga.exe' failed
> make: *** [qemu-ga.exe] Error 1
>
>
> Notes to consider:
> * without --static I can compile it successfully
> * Build machine is running Fedora 25
> * I have upgraded all of the tools to their latest version
> * If I comment out the function which is causing the issue
> (g_test_initialized()), qemu ga compiles statically and runs successfully
> without the need of any dlls.
>
> Can anyone reproduce this? Do you have any idea why is this happening?
>
> --
> Respectfully,
> *Sameeh Jubran*
> *Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
> *Software Engineer @ Daynix <http://www.daynix.com>.*
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
