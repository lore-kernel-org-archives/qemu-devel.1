Received: from eggs.gnu.org ([2001:4830:134:3::10]:38106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdXA1-0003BG-CT
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdX9y-0003S8-7E
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:41:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdX9y-0003Rs-0H
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:41:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id m1-v6so8076837wrg.5
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 01:41:09 -0700 (PDT)
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-11-alex.bennee@linaro.org>
	<a90bec68-bce0-f25c-dd28-c36a1a7d2b4f@amsat.org>
	<87y3eidcpv.fsf@linaro.org>
	<20180711013123.GA29996@lemon.usersys.redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180711013123.GA29996@lemon.usersys.redhat.com>
Date: Thu, 12 Jul 2018 09:41:07 +0100
Message-ID: <87wou0dexo.fsf@linaro.org>
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
To: Fam Zheng <famz@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, cota@braap.org, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Tue, 07/10 22:04, Alex Benn=C3=A9e wrote:
>>
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>
>> > On 07/09/2018 12:21 PM, Alex Benn=C3=A9e wrote:
>> >> This allows us to run a particular test on all docker images. For
>> >> example:
>> >>
>> >>   make docker-test-unit
>> >>
>> >> Will run the unit tests on every supported image.
>> >>
>> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> ---
>> >>  tests/docker/Makefile.include | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >>
>> >> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.in=
clude
>> >> index fe63aacf69..765b2c36f2 100644
>> >> --- a/tests/docker/Makefile.include
>> >> +++ b/tests/docker/Makefile.include
>> >> @@ -152,6 +152,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES)=
,$(DOCKER_IMAGES) $(DOCKER_DEPR
>> >>  	) \
>> >>  	$(foreach t,$(DOCKER_TESTS), \
>> >>  		$(eval docker-test: docker-$t@$i) \
>> >> +		$(eval docker-$t: docker-$t@$i) \
>> >>  	) \
>> >>  )
>> >>
>> >> @@ -162,6 +163,7 @@ docker:
>> >>  	@echo
>> >>  	@echo '    docker:              Print this help.'
>> >>  	@echo '    docker-test:         Run all image/test combinations.'
>> >
>> > Can we rename "docker-test" -> "docker-tests" or is it too late?
>>
>> Probably, I don't know how many people were actively using it. Fam?
>
> I don't know either. Maybe because I'm not native English speaker, but why
> bother? "Docker test" sounds like a generic "cover all" test, whereas "do=
cker
> tests" sounds like a set of many independent tests based on Docker. Both =
make
> sense to me, though I agree the latter describes it better.
>
> On the other hand, maybe we should create a selection instead of "all
> combinations" and call it docker-test, to make it a bit more useful.

Well allowing the individual docket-test-FOO expansion is a halfway
house to that.

> Then we can
> rename the current docker-test to "docker-all" or "docker-test-all".

docker-all-tests might be better in case we ever create and test-all
test script...

>
> Fam
>
>>
>> >
>> >> +	@echo '    docker-TEST:         Run TEST on all image combinations.'
>> >>  	@echo '    docker-clean:        Kill and remove residual docker tes=
ting containers.'
>> >>  	@echo '    docker-TEST@IMAGE:   Run "TEST" in container "IMAGE".'
>> >>  	@echo '                         Note: "TEST" is one of the listed t=
est name,'
>> >>
>>
>>
>> --
>> Alex Benn=C3=A9e


--
Alex Benn=C3=A9e
