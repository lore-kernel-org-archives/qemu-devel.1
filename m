Received: from eggs.gnu.org ([2001:4830:134:3::10]:38375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crNMV-0008Ux-F6
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crNMQ-0002Ns-Hr
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:26:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1crNMQ-0002Ni-Cd
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:26:26 -0400
References: <CAFEAcA_sboyuxUo9b_WAc18Ov9ehfUnura7C5r5ZzfDmjd-XLw@mail.gmail.com>
	<ff8093ef-78ee-b2ab-99d4-6957cbeac07d@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fcb69c2f-cee4-7acc-b396-0cfc193cff59@redhat.com>
Date: Fri, 24 Mar 2017 12:26:20 +0100
MIME-Version: 1.0
In-Reply-To: <ff8093ef-78ee-b2ab-99d4-6957cbeac07d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 24.03.2017 12:11, Christian Borntraeger wrote:
> On 03/24/2017 11:57 AM, Peter Maydell wrote:
>> Hi; qemu-system-s390x seems to have an intermittent failure at
>> the moment -- it's been causing our Travis builds to flap. I actually
>> caught it doing this on one of my local test builds (which happens
>> to be aarch64 but I don't think that matters, since Travis is doing
>> x86 builds):
>>
>> while  QTEST_QEMU_BINARY=s390x-softmmu/qemu-system-s390x
>> QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM %
>> 255 + 1))} gtester -k --verbose -m=quick tests/boot-serial-test ; do
>> true; done
>>  TEST: tests/boot-serial-test... (pid=1122)
>>   /s390x/boot-serial/s390-ccw-virtio:                                  OK
>> PASS: tests/boot-serial-test
>> TEST: tests/boot-serial-test... (pid=1135)
>>   /s390x/boot-serial/s390-ccw-virtio:                                  OK
>> [skip lots more successes]
>> TEST: tests/boot-serial-test... (pid=1582)
>>   /s390x/boot-serial/s390-ccw-virtio:
>> Broken pipe
>> FAIL
>> GTester: last random seed: R02Se94f36f305f2edd8391a22749ec91143
>> (pid=1635)
>> FAIL: tests/boot-serial-test
>>
>> Any ideas?

I was not able to reproduce this issue so far (on my x86 laptop since I
don't have an aarch64 host) ... can you reproduce it by running the test
directly, too, e.g. something like:

QTEST_QEMU_BINARY=s390x-softmmu/qemu-system-s390x tests/boot-serial-test

?

> Adding Thomas who did the s390 version.
> 
> One idea. Maybe qemu exits before the other side is ready.

Or could this be a timeout issue again? Is the host very loaded?
(however, I don't really believe that this could be the issue here,
since the test is rather fast)

 Thomas
