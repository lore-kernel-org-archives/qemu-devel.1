Received: from eggs.gnu.org ([2001:4830:134:3::10]:40857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crNXG-00035E-3T
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crNXE-0006Qe-Oy
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:37:38 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:33728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crNXE-0006P6-Iq
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:37:36 -0400
Received: by mail-wm0-x22c.google.com with SMTP id v203so6979696wmg.0
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 04:37:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fcb69c2f-cee4-7acc-b396-0cfc193cff59@redhat.com>
References: <CAFEAcA_sboyuxUo9b_WAc18Ov9ehfUnura7C5r5ZzfDmjd-XLw@mail.gmail.com>
	<ff8093ef-78ee-b2ab-99d4-6957cbeac07d@de.ibm.com>
	<fcb69c2f-cee4-7acc-b396-0cfc193cff59@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 11:37:14 +0000
Message-ID: <CAFEAcA9H6vah+ogTsc+TYaZ_X=ncW9frCK5QYBvorN8rQ1EshA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu-system-s390x tests/boot-serial-test
 intermittent failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 24 March 2017 at 11:26, Thomas Huth <thuth@redhat.com> wrote:
> I was not able to reproduce this issue so far (on my x86 laptop since I
> don't have an aarch64 host) ... can you reproduce it by running the test
> directly, too, e.g. something like:
>
> QTEST_QEMU_BINARY=s390x-softmmu/qemu-system-s390x tests/boot-serial-test
>
> ?

Yes, you can.

>> Adding Thomas who did the s390 version.
>>
>> One idea. Maybe qemu exits before the other side is ready.
>
> Or could this be a timeout issue again? Is the host very loaded?
> (however, I don't really believe that this could be the issue here,
> since the test is rather fast)

The timeout is 60 seconds, right? When the test fails it
fails immediately, not after hanging for 60s.

thanks
-- PMM
