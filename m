Received: from eggs.gnu.org ([2001:4830:134:3::10]:58753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fK0AY-0003fU-Q9
	for qemu-devel@nongnu.org; Sat, 19 May 2018 07:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fK0AX-0002ST-Va
	for qemu-devel@nongnu.org; Sat, 19 May 2018 07:37:02 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:40857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fK0AX-0002SG-Qf
	for qemu-devel@nongnu.org; Sat, 19 May 2018 07:37:01 -0400
Received: by mail-oi0-x22e.google.com with SMTP id c203-v6so9359378oib.7
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 04:37:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dd2d19de-eba5-90be-5f01-ff9fd268685f@redhat.com>
References: <20180518091440.1559-1-alex.bennee@linaro.org>
	<20180518091440.1559-3-alex.bennee@linaro.org>
	<CAFEAcA968HDBJiBRCBEu+hV=fUx5HzHbnn6GDGKYzusEtjHGUQ@mail.gmail.com>
	<dd2d19de-eba5-90be-5f01-ff9fd268685f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 19 May 2018 12:36:40 +0100
Message-ID: <CAFEAcA-9miwQ_JK4VFcFMgWc=XCb_Qf3W4ZFk59csXUGdnAMDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] tests/Makefile: comment out flakey
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 19 May 2018 at 07:10, Thomas Huth <thuth@redhat.com> wrote:
> On 18.05.2018 20:31, Peter Maydell wrote:
>> Another flaky test for the collection:
>>
>> TEST: tests/boot-serial-test... (pid=25144)
>>   /sparc64/boot-serial/sun4u:                                          **
>> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/boot-serial-test.c:140:check_guest_output:
>> assertion failed: (output_ok)
>> FAIL
>>
>> Probably another "overly optimistic timeout" setting. (Failed
>> for me on x86-64 host just now.)
>
> That test normally finishes within 3 seconds on my machine. The test
> timeout is 60 seconds. How much load did you have on that machine to go
> from 3s to 60s ?

The machine is my desktop box; I didn't notice anything too
terrible while I was using it interactively at the same time
the test build was running. The test build will run at -j8;
it might also have been during a different -j8 build/test
on the same machine for a different source tree.

60s is quite a long time, so maybe there's an intermittent
deadlock in there instead...

thanks
-- PMM
