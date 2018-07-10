Received: from eggs.gnu.org ([2001:4830:134:3::10]:57621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fczoJ-0005aN-8l
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 17:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fczoF-0007T6-4M
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 17:04:35 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fczoE-0007R8-T7
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 17:04:31 -0400
Received: by mail-wm0-x241.google.com with SMTP id v128-v6so361607wme.5
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 14:04:30 -0700 (PDT)
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-11-alex.bennee@linaro.org>
	<a90bec68-bce0-f25c-dd28-c36a1a7d2b4f@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <a90bec68-bce0-f25c-dd28-c36a1a7d2b4f@amsat.org>
Date: Tue, 10 Jul 2018 22:04:28 +0100
Message-ID: <87y3eidcpv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.0 10/10] docker: add expansion for
 docker-test-FOO to Makefile.include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 07/09/2018 12:21 PM, Alex Benn=C3=A9e wrote:
>> This allows us to run a particular test on all docker images. For
>> example:
>>
>>   make docker-test-unit
>>
>> Will run the unit tests on every supported image.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/docker/Makefile.include | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.inclu=
de
>> index fe63aacf69..765b2c36f2 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -152,6 +152,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(=
DOCKER_IMAGES) $(DOCKER_DEPR
>>  	) \
>>  	$(foreach t,$(DOCKER_TESTS), \
>>  		$(eval docker-test: docker-$t@$i) \
>> +		$(eval docker-$t: docker-$t@$i) \
>>  	) \
>>  )
>>
>> @@ -162,6 +163,7 @@ docker:
>>  	@echo
>>  	@echo '    docker:              Print this help.'
>>  	@echo '    docker-test:         Run all image/test combinations.'
>
> Can we rename "docker-test" -> "docker-tests" or is it too late?

Probably, I don't know how many people were actively using it. Fam?

>
>> +	@echo '    docker-TEST:         Run TEST on all image combinations.'
>>  	@echo '    docker-clean:        Kill and remove residual docker testin=
g containers.'
>>  	@echo '    docker-TEST@IMAGE:   Run "TEST" in container "IMAGE".'
>>  	@echo '                         Note: "TEST" is one of the listed test=
 name,'
>>


--
Alex Benn=C3=A9e
