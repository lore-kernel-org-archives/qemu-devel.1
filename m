Received: from eggs.gnu.org ([2001:4830:134:3::10]:43201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crNkY-0006Rw-EJ
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crNkX-0003U8-F7
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:51:22 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:32943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crNkX-0003Tr-8h
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:51:21 -0400
Received: by mail-wr0-x22e.google.com with SMTP id y90so73223wrb.0
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 04:51:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ff8093ef-78ee-b2ab-99d4-6957cbeac07d@de.ibm.com>
References: <CAFEAcA_sboyuxUo9b_WAc18Ov9ehfUnura7C5r5ZzfDmjd-XLw@mail.gmail.com>
	<ff8093ef-78ee-b2ab-99d4-6957cbeac07d@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 11:50:59 +0000
Message-ID: <CAFEAcA-o8-GvgoJ6PyRx0ycSibQNvJT8_wHfXMA3MOG0oJs5vw@mail.gmail.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>

On 24 March 2017 at 11:11, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> One idea. Maybe qemu exits before the other side is ready.
> Does reverting
>
> commit 864111f422babcf8ce837fb47f7f9e1948446f22
> Author:     Christian Borntraeger <borntraeger@de.ibm.com>
> AuthorDate: Tue Oct 18 09:29:54 2016 +0200
> Commit:     Paolo Bonzini <pbonzini@redhat.com>
> CommitDate: Wed Nov 2 09:28:56 2016 +0100
>
>     vl: exit qemu on guest panic if -no-shutdown is not set
>
> help?

I didn't test this...

> If yes, does
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 57edf6a..11f48b0 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -79,8 +79,8 @@ static void test_machine(const void *data)
>      g_assert(fd != -1);
>
>      args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
> -                           " -serial chardev:serial0 %s", test->machine,
> -                           tmpname, test->extra);
> +                           " -no-shutdown -serial chardev:serial0 %s",
> +                           test->machine, tmpname, test->extra);

...but this doesn't help.

thanks
-- PMM
