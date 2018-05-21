Received: from eggs.gnu.org ([2001:4830:134:3::10]:57747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKiGO-0004fh-C1
	for qemu-devel@nongnu.org; Mon, 21 May 2018 06:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKiGK-0001CN-EP
	for qemu-devel@nongnu.org; Mon, 21 May 2018 06:42:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fKiGK-0001BU-97
	for qemu-devel@nongnu.org; Mon, 21 May 2018 06:41:56 -0400
Date: Mon, 21 May 2018 18:41:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180521104147.GA17282@xz-mi>
References: <20180521084249.10640-1-peterx@redhat.com>
	<20180521085907.GE23090@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180521085907.GE23090@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] monitor: turn on Out-Of-Band by default again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Mon, May 21, 2018 at 09:59:07AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Mon, May 21, 2018 at 04:42:49PM +0800, Peter Xu wrote:
> > We turned Out-Of-Band feature of monitors off for 2.12 release.  Now =
we
> > try to turn that on again.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > --
> > Now OOB should be okay with all known tests (except iotest qcow2, sin=
ce
> > it is still broken on master), and AFAIK now we should also be okay w=
ith
> > ARM+Libvirt (not testsed, but Eric Auger helped to verify that before
> > the release).  So I think it's now safe to turn OOB on again.  Please
> > feel free to test this against any of existing testsuites to see whet=
her
> > it'll still break any stuff.  Thanks,
>=20
> Can you remind us what the problem was with ARM+Libvirt that this
> caused ?

Sure.  The regression reported by Eric Auger is:

http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html

The fix is:

https://patchwork.kernel.org/patch/10332289/

And the fix is in master already.

Regards,

--=20
Peter Xu
