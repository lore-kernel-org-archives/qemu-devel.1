Received: from eggs.gnu.org ([2001:4830:134:3::10]:60180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dp8hC-0007TK-Bp
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dp8h7-0001C6-NE
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:54:54 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dp8h7-0001At-FA
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:54:49 -0400
Received: by mail-wm0-x22c.google.com with SMTP id 187so14823508wmn.1
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 00:54:47 -0700 (PDT)
References: <20170725133425.436-1-alex.bennee@linaro.org>
	<20170831065959.GC14896@lemon.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170831065959.GC14896@lemon.lan>
Date: Tue, 05 Sep 2017 08:54:44 +0100
Message-ID: <87o9qpmvgb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 0/6] Various docker fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Tue, 07/25 14:34, Alex Bennée wrote:
>> Hi,
>>
>> Phillipe pointed out a few anomalies with the travis.docker image
>> during review which has led to a couple more patches. As they are bug
>> fixes I didn't race to get a pull-req out today for hard-freeze. I
>> will roll a pull-req by the end of the week if there are no objections
>> as I'll be away for the rc1/2 cycles.
>>
>> Alex Bennée (6):
>>   docker: ensure NOUSER for travis images
>>   docker: fix dirty/stash detection on some systems
>>   docker: ignore submodules when checking diff
>>   docker: docker.py make --no-cache skip checksum test
>>   docker: don't install device-tree-compiler build-deps in travis.docker
>>   docker: reduce noise when building travis.docker
>
> Thanks, I've queued patches 1, 4, 5, 6 for 2.11. I intend to drop the code
> touched by 2 and 3 with a dedicated script:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06349.html
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06358.html
>
> (It would be great if you can give some test/review there :)

Cool - I shall have a look.

>
> Fam
>
>>
>>  tests/docker/Makefile.include          | 3 ++-
>>  tests/docker/docker.py                 | 3 ++-
>>  tests/docker/dockerfiles/travis.docker | 6 ++++--
>>  3 files changed, 8 insertions(+), 4 deletions(-)
>>
>> --
>> 2.13.0
>>


--
Alex Bennée
