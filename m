Received: from eggs.gnu.org ([2001:4830:134:3::10]:49312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evkXl-0007Wb-Pg
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evkXg-0002Rs-1t
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:04:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evkXf-0002RX-Tr
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:04:40 -0400
Date: Tue, 13 Mar 2018 14:04:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180313140426.GY3048@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180209141514.18840-1-alex.bennee@linaro.org>
	<20180209141514.18840-2-alex.bennee@linaro.org>
	<20180313134017.GA24191@redhat.com> <87fu54rs35.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fu54rs35.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 1/1] .travis.yml: add --disable-linux-user
 for some jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Tue, Mar 13, 2018 at 02:02:54PM +0000, Alex Benn=C3=A9e wrote:
>=20
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Fri, Feb 09, 2018 at 02:15:14PM +0000, Alex Benn=C3=A9e wrote:
> >> The modules and co-routine builds are only really relevant to softmm=
u
> >> builds and regularly timeout on Travis. Let's disable linux-user
> >> builds here for more headroom.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> >>
> >> diff --git a/.travis.yml b/.travis.yml
> >> index 01a57399b5..0dd5020552 100644
> >> --- a/.travis.yml
> >> +++ b/.travis.yml
> >> @@ -52,9 +52,9 @@ env:
> >>      - CONFIG=3D""
> >>      - CONFIG=3D"--enable-debug --enable-debug-tcg --enable-trace-ba=
ckends=3Dlog"
> >>      - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr=
 --disable-brlapi --disable-uuid --disable-libusb"
> >> -    - CONFIG=3D"--enable-modules"
> >> -    - CONFIG=3D"--with-coroutine=3Ducontext"
> >> -    - CONFIG=3D"--with-coroutine=3Dsigaltstack"
> >> +    - CONFIG=3D"--enable-modules --disable-linux-user"
> >> +    - CONFIG=3D"--with-coroutine=3Ducontext --disable-linux-user"
> >> +    - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-linux-user=
"
> >
> > Since this merged, the 4th, 5th & 6th jobs are now reliably completin=
g in
> > time, but the 1st and 3rd jobs are hitting timeouts on the majority o=
f
> > runs :-(
>=20
> Yeah it's certainly a problem as QEMU has grown. The original
> .travis.yml split things up across architecture lines but we removed
> that in favour of "feature" selection.
>=20
> > We've already got a lot of jobs, but for sake of reliability should w=
e
> > consider splitting the 1st & 3rd jobs. Add --disable-linux-user to bo=
th
> > of the existing jobs, and then adding 2 new jobs with --disable-syste=
m
> > and --disable-tools set ?
>=20
> Good idea. I don't suppose you've already tried this?

No, I've not gone beyond quickly writing this previous mail  :-)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
