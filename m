Received: from eggs.gnu.org ([2001:4830:134:3::10]:58694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crOlz-0005wT-Ss
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crOlz-0003JH-6d
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:56:55 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crOly-0003JB-Vj
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:56:55 -0400
Received: by mail-wr0-x22a.google.com with SMTP id u1so1156764wra.2
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 05:56:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-o8-GvgoJ6PyRx0ycSibQNvJT8_wHfXMA3MOG0oJs5vw@mail.gmail.com>
References: <CAFEAcA_sboyuxUo9b_WAc18Ov9ehfUnura7C5r5ZzfDmjd-XLw@mail.gmail.com>
	<ff8093ef-78ee-b2ab-99d4-6957cbeac07d@de.ibm.com>
	<CAFEAcA-o8-GvgoJ6PyRx0ycSibQNvJT8_wHfXMA3MOG0oJs5vw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 12:56:33 +0000
Message-ID: <CAFEAcA9rG11UXqxr1fRnGyGq8fNFdgDNa57dg+EpanKJCUiLhQ@mail.gmail.com>
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

On 24 March 2017 at 11:50, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 24 March 2017 at 11:11, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
>> index 57edf6a..11f48b0 100644
>> --- a/tests/boot-serial-test.c
>> +++ b/tests/boot-serial-test.c
>> @@ -79,8 +79,8 @@ static void test_machine(const void *data)
>>      g_assert(fd != -1);
>>
>>      args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
>> -                           " -serial chardev:serial0 %s", test->machine,
>> -                           tmpname, test->extra);
>> +                           " -no-shutdown -serial chardev:serial0 %s",
>> +                           test->machine, tmpname, test->extra);
>
> ...but this doesn't help.

I think I must have got the testing wrong here somehow, because
trying it again, it does seem to cause the failures to stop.
So I guess this must be the bug...

thanks
-- PMM
