Received: from eggs.gnu.org ([2001:4830:134:3::10]:59783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cj1dP-00088s-5y
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 05:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cj1dM-0004OV-40
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 05:37:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cj1dL-0004OL-UQ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 05:37:24 -0500
Date: Wed, 1 Mar 2017 10:37:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170301103718.GA2429@work-vm>
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<20170228205247.GC4090@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170228205247.GC4090@noname.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] intermittent make check failure:
 "tcg_handle_interrupt: assertion failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 28.02.2017 um 20:10 hat Peter Maydell geschrieben:
> > I got a make check failure on aarch64 host running a sparc64 test:
>=20
> Probably completely unrelated, but while we're at it...
>=20
> For me, tests/vhost-user-test has been hanging for check-qtest-i386
> occasionally in the past few days. Has anyone else seen this?

Yes, there's a fix from Marc-Andr=E9 for that.

Dave

> Kevin
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
