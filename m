Received: from eggs.gnu.org ([2001:4830:134:3::10]:47260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eb5w7-0008P1-FB
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eb5w6-00043t-CT
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:40:31 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-7-vsementsov@virtuozzo.com>
	<a0096cf0-8bec-dedb-e637-f29c71e46fbb@redhat.com>
	<624f9181-d57c-4029-e3e8-7f6f4fea3963@virtuozzo.com>
	<fedadb51-af71-82b1-ee73-135a7ce689eb@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <39f16940-1b62-5054-d872-80e9ce0fc560@virtuozzo.com>
Date: Mon, 15 Jan 2018 17:40:16 +0300
MIME-Version: 1.0
In-Reply-To: <fedadb51-af71-82b1-ee73-135a7ce689eb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 6/6] iotest 201: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

12.01.2018 19:54, Eric Blake wrote:
> On 01/12/2018 05:43 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>>> +++ b/tests/qemu-iotests/201.out
>>>> @@ -0,0 +1,5 @@
>>>> +.......
>>>> +---------------------------------------------------------------------=
-
>>>> +Ran 7 tests
>>> I'm not a fan of python tests that are difficult to debug.=C2=A0 Your
>>> additions to 147 in patch 4/6 are okay (hard to debug, but an
>>> incremental addition); but is it possible to rewrite this test in a bit
>>> more verbose manner?=C2=A0 See test 194 and this message for more detai=
ls:
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00234.html
>> hmm, what do you mean by "difficult to debug"? This is a usual python
>> unittest based test.
> And the list archives show several threads of people complaining that
> ./check failing with a diff that merely shows:
>
> -.....
> +..E..

didn't see that. usually, for failed iotests I see

-.....
+..E..

+ some kind of assert-fail in one of testcases

so we know in which testcase and in which line it was failed.

>
> makes it rather hard to see WHAT test 2 was doing that caused an error
> instead of a pass, let alone set up a reproduction scenario on JUST the
> failing test.  Yes, a lot of existing iotests use this unittest layout,
> and on that grounds, I'm not opposed to adding another one; but test 194
> really IS easier to debug when something goes wrong.
>
>> And there 3 test cases, sharing same setUp. Do not you say that unittest
>> becomes
>> deprecated in qemu? I think, if we have only one testcase, we may use
>> 194-like approach,
>> but if we have more, it's better to use unittest.
> Yes, I think a nice goal for improved testing is to write more
> python-based iotests in the style that uses actual output, and not just
> the unittest framework, in the test log.  It's not a hard requirement as
> long as no one has converted existing tests, but is food for thought.
>

I think, it doesn't mean that we should not use unittest at all, we just=20
need more output with
it.

--=20
Best regards,
Vladimir
