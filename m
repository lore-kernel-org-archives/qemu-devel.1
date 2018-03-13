Received: from eggs.gnu.org ([2001:4830:134:3::10]:43800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evkAD-0004mz-Du
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evkA9-0005gE-Iq
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:40:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evkA9-0005fa-DL
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:40:21 -0400
Date: Tue, 13 Mar 2018 13:40:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180313134017.GA24191@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180209141514.18840-1-alex.bennee@linaro.org>
	<20180209141514.18840-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180209141514.18840-2-alex.bennee@linaro.org>
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

On Fri, Feb 09, 2018 at 02:15:14PM +0000, Alex Benn=C3=A9e wrote:
> The modules and co-routine builds are only really relevant to softmmu
> builds and regularly timeout on Travis. Let's disable linux-user
> builds here for more headroom.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 01a57399b5..0dd5020552 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -52,9 +52,9 @@ env:
>      - CONFIG=3D""
>      - CONFIG=3D"--enable-debug --enable-debug-tcg --enable-trace-backe=
nds=3Dlog"
>      - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr --=
disable-brlapi --disable-uuid --disable-libusb"
> -    - CONFIG=3D"--enable-modules"
> -    - CONFIG=3D"--with-coroutine=3Ducontext"
> -    - CONFIG=3D"--with-coroutine=3Dsigaltstack"
> +    - CONFIG=3D"--enable-modules --disable-linux-user"
> +    - CONFIG=3D"--with-coroutine=3Ducontext --disable-linux-user"
> +    - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-linux-user"

Since this merged, the 4th, 5th & 6th jobs are now reliably completing in
time, but the 1st and 3rd jobs are hitting timeouts on the majority of
runs :-(

We've already got a lot of jobs, but for sake of reliability should we
consider splitting the 1st & 3rd jobs. Add --disable-linux-user to both
of the existing jobs, and then adding 2 new jobs with --disable-system
and --disable-tools set ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
