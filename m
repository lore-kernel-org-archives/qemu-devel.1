Received: from eggs.gnu.org ([2001:4830:134:3::10]:49929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fd3yd-0000SX-H2
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 21:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fd3yZ-0007Ju-4X
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 21:31:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fd3yY-0007Jc-Vr
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 21:31:27 -0400
Date: Wed, 11 Jul 2018 09:31:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180711013123.GA29996@lemon.usersys.redhat.com>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-11-alex.bennee@linaro.org>
	<a90bec68-bce0-f25c-dd28-c36a1a7d2b4f@amsat.org>
	<87y3eidcpv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87y3eidcpv.fsf@linaro.org>
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
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, cota@braap.org, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Tue, 07/10 22:04, Alex Benn=E9e wrote:
>=20
> Philippe Mathieu-Daud=E9 <f4bug@amsat.org> writes:
>=20
> > On 07/09/2018 12:21 PM, Alex Benn=E9e wrote:
> >> This allows us to run a particular test on all docker images. For
> >> example:
> >>
> >>   make docker-test-unit
> >>
> >> Will run the unit tests on every supported image.
> >>
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >> ---
> >>  tests/docker/Makefile.include | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.i=
nclude
> >> index fe63aacf69..765b2c36f2 100644
> >> --- a/tests/docker/Makefile.include
> >> +++ b/tests/docker/Makefile.include
> >> @@ -152,6 +152,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES=
),$(DOCKER_IMAGES) $(DOCKER_DEPR
> >>  	) \
> >>  	$(foreach t,$(DOCKER_TESTS), \
> >>  		$(eval docker-test: docker-$t@$i) \
> >> +		$(eval docker-$t: docker-$t@$i) \
> >>  	) \
> >>  )
> >>
> >> @@ -162,6 +163,7 @@ docker:
> >>  	@echo
> >>  	@echo '    docker:              Print this help.'
> >>  	@echo '    docker-test:         Run all image/test combinations.'
> >
> > Can we rename "docker-test" -> "docker-tests" or is it too late?
>=20
> Probably, I don't know how many people were actively using it. Fam?

I don't know either. Maybe because I'm not native English speaker, but wh=
y
bother? "Docker test" sounds like a generic "cover all" test, whereas "do=
cker
tests" sounds like a set of many independent tests based on Docker. Both =
make
sense to me, though I agree the latter describes it better.

On the other hand, maybe we should create a selection instead of "all
combinations" and call it docker-test, to make it a bit more useful. Then=
 we can
rename the current docker-test to "docker-all" or "docker-test-all".

Fam

>=20
> >
> >> +	@echo '    docker-TEST:         Run TEST on all image combinations=
.'
> >>  	@echo '    docker-clean:        Kill and remove residual docker te=
sting containers.'
> >>  	@echo '    docker-TEST@IMAGE:   Run "TEST" in container "IMAGE".'
> >>  	@echo '                         Note: "TEST" is one of the listed =
test name,'
> >>
>=20
>=20
> --
> Alex Benn=E9e
