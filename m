Received: from eggs.gnu.org ([2001:4830:134:3::10]:33970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6ZI8-0005mi-T0
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6ZI3-00015J-VR
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:12:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d6ZI3-00015A-Ob
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:12:43 -0400
Date: Fri, 5 May 2017 17:12:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170505091240.GF21435@lemon.lan>
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-4-famz@redhat.com>
	<8737cjogio.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8737cjogio.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] docker: Use unconfined security profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Fri, 05/05 09:27, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > Some by default blocked syscalls are required to run tests for exampl=
e
> > userfaultfd.
>=20
> Is there any way the tests could DoS the host? I guess you could achiev=
e
> the same running the iotests directly from make but it does seem we
> should confine the docker guest as much as possible.

I don't know the answer to the security question, but if a confined docke=
r
environment is full of pitfalls and unpleasant to work with, it won't gro=
w that
much.

Patchew runs this in a VM, so it's not a big problem to me.

>=20
> >
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/docker/Makefile.include | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.in=
clude
> > index 0ed8c3d..09d157c 100644
> > --- a/tests/docker/Makefile.include
> > +++ b/tests/docker/Makefile.include
> > @@ -127,6 +127,7 @@ docker-run: docker-qemu-src
> >  	$(call quiet-command,						\
> >  		$(SRC_PATH)/tests/docker/docker.py run 			\
> >  			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
> > +			--security-opt seccomp=3Dunconfined		\
> >  			$(if $V,,--rm) 					\
> >  			$(if $(DEBUG),-i,--net=3Dnone) 			\
> >  			-e TARGET_LIST=3D$(TARGET_LIST) 			\
>=20
>=20
> --
> Alex Benn=E9e
