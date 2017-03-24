Received: from eggs.gnu.org ([2001:4830:134:3::10]:60528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1crOre-00005B-4h
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1crOrY-0005c8-CA
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:02:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41269
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1crOrY-0005bQ-5K
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:02:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2OCwmrX046699
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 09:02:38 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29cg2rqb0q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 09:02:38 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 24 Mar 2017 07:02:37 -0600
References: <CAFEAcA_sboyuxUo9b_WAc18Ov9ehfUnura7C5r5ZzfDmjd-XLw@mail.gmail.com>
	<ff8093ef-78ee-b2ab-99d4-6957cbeac07d@de.ibm.com>
	<CAFEAcA-o8-GvgoJ6PyRx0ycSibQNvJT8_wHfXMA3MOG0oJs5vw@mail.gmail.com>
	<CAFEAcA9rG11UXqxr1fRnGyGq8fNFdgDNa57dg+EpanKJCUiLhQ@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 Mar 2017 14:02:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9rG11UXqxr1fRnGyGq8fNFdgDNa57dg+EpanKJCUiLhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <7beb8fe2-f24b-5f00-b593-0e0f30cd0384@de.ibm.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>

On 03/24/2017 01:56 PM, Peter Maydell wrote:
> On 24 March 2017 at 11:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 24 March 2017 at 11:11, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
>>> index 57edf6a..11f48b0 100644
>>> --- a/tests/boot-serial-test.c
>>> +++ b/tests/boot-serial-test.c
>>> @@ -79,8 +79,8 @@ static void test_machine(const void *data)
>>>      g_assert(fd != -1);
>>>
>>>      args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
>>> -                           " -serial chardev:serial0 %s", test->machine,
>>> -                           tmpname, test->extra);
>>> +                           " -no-shutdown -serial chardev:serial0 %s",
>>> +                           test->machine, tmpname, test->extra);
>>
>> ...but this doesn't help.
> 
> I think I must have got the testing wrong here somehow, because
> trying it again, it does seem to cause the failures to stop.
> So I guess this must be the bug...

Will send a proper patch.
