Received: from eggs.gnu.org ([2001:4830:134:3::10]:51851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dZylS-0005Ft-CW
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dZylP-0005PB-7h
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:16:38 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:38750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dZylO-0005NN-WF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:16:35 -0400
Received: by mail-wr0-x231.google.com with SMTP id f21so61752400wrf.5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 05:16:34 -0700 (PDT)
References: <20170720134716.13049-1-alex.bennee@linaro.org>
	<20170720134716.13049-2-alex.bennee@linaro.org>
	<e9ce578f-65aa-a369-fc11-2d4a03a3f483@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <e9ce578f-65aa-a369-fc11-2d4a03a3f483@amsat.org>
Date: Tue, 25 Jul 2017 13:16:32 +0100
Message-ID: <87tw20d84f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 1/3] docker: ensure NOUSER for
 travis images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: peter.maydell@linaro.org, famz@redhat.com, qemu-devel@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> On 07/20/2017 10:47 AM, Alex Bennée wrote:
>> While adding the current user is a useful default behaviour for
>> creating new images it is not appropriate for Travis which already has
>> a default user.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   tests/docker/Makefile.include | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index aaab1a4208..d7dafdbd27 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -71,6 +71,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
>>   docker-image-debian-s390x-cross: docker-image-debian9
>>   docker-image-debian-win32-cross: docker-image-debian8-mxe
>>   docker-image-debian-win64-cross: docker-image-debian8-mxe
>> +docker-image-travis: NOUSER=1
>
> Cool you kept it ordered :)
>
> I'm surprised we need to install the full LaTeX stack to be able to
> compile the device-tree-compiler...

Hmm I think installing build-deps is a little extreme as we are not
re-building the device-tree-compiler but using it.

>
> Reading
> https://docs.travis-ci.com/user/environment-variables#default-environment-variables
> I think it'd be a better match if we also use those default
> environment variables, at least:
>
> DEBIAN_FRONTEND=noninteractive
> LANG=en_US.UTF-8
> LC_ALL=en_US.UTF-8
>
> what do you think?

Sure - it does reduce the noise somewhat.

>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>
>>     # Expand all the pre-requistes for each docker image and test
>> combination
>>   $(foreach i,$(DOCKER_IMAGES), \
>>


--
Alex Bennée
