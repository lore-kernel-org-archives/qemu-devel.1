Received: from eggs.gnu.org ([2001:4830:134:3::10]:35204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fG3DT-0000js-2u
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fG3DN-0004cn-Ff
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:03:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54754 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fG3DN-0004cj-BO
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:03:37 -0400
Date: Tue, 8 May 2018 15:03:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180508140327.GY5967@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <65983efd-e68f-76f5-bfb1-a8d14045df76@amsat.org>
	<20180508134831.GV5967@redhat.com>
	<CAFEAcA_L3fy+MFh72=zX3pHtXP634Uhu0+G=nz-fMWaGC8muNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_L3fy+MFh72=zX3pHtXP634Uhu0+G=nz-fMWaGC8muNw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] tpm_emu_test_wait_cond: code should not be reached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Tue, May 08, 2018 at 02:54:39PM +0100, Peter Maydell wrote:
> On 8 May 2018 at 14:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:
> > This test has a couple of threads running, and passes &error_abort to
> > the qio_channel_socket_readv() function. So I expect that one thread
> > is closing the socket connection, and the other thread has not yet
> > shutdown cleanly, so tries to readv on a dead socket triggering the
> > error_abort.  IOW,  qio_channel_socket_readv is likely just the sympt=
om
> > of brokeness somewhere else in the test, not the cause.
>=20
> That sounds familiar...didn't we have a thread about this a while back?

Yeah, I don't recall if it was related to this particular test, or
another similar situation in a different test.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
