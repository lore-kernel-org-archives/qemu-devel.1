Received: from eggs.gnu.org ([2001:4830:134:3::10]:46521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evkMi-000233-MF
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evkMf-0003la-Ki
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:53:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47346 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evkMf-0003lK-FM
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:53:17 -0400
Date: Tue, 13 Mar 2018 13:53:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180313135305.GX3048@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180209141514.18840-1-alex.bennee@linaro.org>
	<20180209141514.18840-2-alex.bennee@linaro.org>
	<20180313134017.GA24191@redhat.com>
	<2f452164-d9d7-80ae-c5fe-bdc1889633f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f452164-d9d7-80ae-c5fe-bdc1889633f8@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Tue, Mar 13, 2018 at 02:49:42PM +0100, Paolo Bonzini wrote:
> On 13/03/2018 14:40, Daniel P. Berrang=C3=A9 wrote:
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
> > Since this merged, the 4th, 5th & 6th jobs are now reliably completin=
g in
> > time, but the 1st and 3rd jobs are hitting timeouts on the majority o=
f
> > runs :-(
> >=20
> > We've already got a lot of jobs, but for sake of reliability should w=
e
> > consider splitting the 1st & 3rd jobs. Add --disable-linux-user to bo=
th
> > of the existing jobs, and then adding 2 new jobs with --disable-syste=
m
> > and --disable-tools set ?
>=20
> Out of curiosity, why do we need the third job at all?  And
> --enable-trace-backends=3Dlog is the default, so "--enable-debug
> --enable-debug-tcg" should be enough.

Presumably that is intended to validate that code still builds correctly
when various optional features are turned off, by exercising different
codepaths in the countless #ifdef HAVE_$FEATURE  conditionals we have.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
