Received: from eggs.gnu.org ([2001:4830:134:3::10]:35741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da102-0000Jt-K5
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da0zy-0008JP-EF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:39:50 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1da0zy-0008Is-6D
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:39:46 -0400
Received: by mail-wm0-x22b.google.com with SMTP id m85so44123698wma.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:39:44 -0700 (PDT)
References: <20170725133425.436-1-alex.bennee@linaro.org>
	<20170725133425.436-6-alex.bennee@linaro.org>
	<37c12235-eec1-b960-6053-0414ebac0aae@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <37c12235-eec1-b960-6053-0414ebac0aae@amsat.org>
Date: Tue, 25 Jul 2017 15:39:41 +0100
Message-ID: <87inigeg2a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 5/6] docker: don't install
 device-tree-compiler build-deps in travis.docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: famz@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> On 07/25/2017 10:34 AM, Alex Bennée wrote:
>> Installing the device-tree-compiler build-deps is a little extreme. We
>> only actually need the binary so include it with the other packages.
>>
>> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>
> before:
>
> $ docker images qemu:travis --no-trunc
> --format="{{.Repository}}:{{.Tag}}\t{{.Size}}"
>
> qemu:travis	6.16GB
>
> after:
>
> qemu:travis	5.92GB
>
> not a big win :(
>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>
> (not a "bugfix" btw)

It's arguable - it was certainly wrong as we just need the compiler and
I'm not sure build-dep actually would have pulled it on (although the
qemu build-dep probably does).

>
>> ---
>>   tests/docker/dockerfiles/travis.docker | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
>> index 636fa590a5..57ac8e1419 100644
>> --- a/tests/docker/dockerfiles/travis.docker
>> +++ b/tests/docker/dockerfiles/travis.docker
>> @@ -1,6 +1,5 @@
>>   FROM quay.io/travisci/travis-ruby
>>   RUN apt-get update
>>   RUN apt-get -y build-dep qemu
>> -RUN apt-get -y build-dep device-tree-compiler
>> -RUN apt-get -y install python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools
>> +RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools
>>   ENV FEATURES pyyaml
>>


--
Alex Bennée
