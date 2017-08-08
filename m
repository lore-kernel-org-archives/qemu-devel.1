Received: from eggs.gnu.org ([2001:4830:134:3::10]:43029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1df0IQ-0005gb-KN
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1df0IN-0008PB-Gy
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:55:26 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1df0IN-0008Ow-A1
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:55:23 -0400
Received: by mail-wm0-x22a.google.com with SMTP id m85so1604897wma.0
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 01:55:23 -0700 (PDT)
References: <20170807153934.29477-1-alex.bennee@linaro.org>
	<20170807153934.29477-2-alex.bennee@linaro.org>
	<20170808013846.GO14780@lemon>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170808013846.GO14780@lemon>
Date: Tue, 08 Aug 2017 09:55:20 +0100
Message-ID: <87r2wmv3pj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 v3 1/6] docker: ensure NOUSER for
 travis images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Ma?= =?utf-8?Q?thieu-Daud=C3=A9?= <f4bug@amsat.org>


Fam Zheng <famz@redhat.com> writes:

> On Mon, 08/07 16:39, Alex Bennée wrote:
>> While adding the current user is a useful default behaviour for
>> creating new images it is not appropriate for Travis which already has
>> a default user.
>
> Target docker-travis@travis will not have NOUSER=1 automatically, right? Is that
> a problem?

It doesn't until this patch. In fact it would be better if we ran travis
tests with the travis user rather than the mapped local user.

>
> Fam
>
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/docker/Makefile.include | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index aaab1a4208..d7dafdbd27 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -71,6 +71,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
>>  docker-image-debian-s390x-cross: docker-image-debian9
>>  docker-image-debian-win32-cross: docker-image-debian8-mxe
>>  docker-image-debian-win64-cross: docker-image-debian8-mxe
>> +docker-image-travis: NOUSER=1
>>
>>  # Expand all the pre-requistes for each docker image and test combination
>>  $(foreach i,$(DOCKER_IMAGES), \
>> --
>> 2.13.0
>>
>>


--
Alex Bennée
