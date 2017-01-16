Received: from eggs.gnu.org ([2001:4830:134:3::10]:37549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cSzhb-0008SC-NX
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 00:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cSzhY-0002MO-Hk
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 00:19:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:55508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cSzhY-0002Li-6R
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 00:19:28 -0500
From: "Li, Liang Z" <liang.z.li@intel.com>
Date: Mon, 16 Jan 2017 05:19:20 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C352A73@shsmsx102.ccr.corp.intel.com>
References: <F2CBF3009FA73547804AE4C663CAB28E3C34F194@shsmsx102.ccr.corp.intel.com>
	<20170112115804.GA2513@work-vm>
In-Reply-To: <20170112115804.GA2513@work-vm>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] about post copy recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> * Li, Liang Z (liang.z.li@intel.com) wrote:
> >
> > Hi David,
> >
> > I remembered some guys wanted to solve the issue of post copy recovery
> when network broken down, do you know latest status?
>=20
> Hi Liang,
>   Yes, Haris looked at it as part of GSoC, the latest version is what was=
 posted:
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2016-08/msg03468.html
>=20
> I've not done any work on it since then;  there are a couple of hard prob=
lems
> to be solved.  The simpler is making sure that we always correctly detect=
 a
> migration error due to networking (rather than some other non-recoverable
> error); there's lots of migration code that doesn't check for a file erro=
r
> straight away and only hits the error code later on when it's too late to
> recover.
>=20
> The harder problem is that we often end up with the case where the main
> thread is blocked trying to access postcopied-RAM, e.g. an emulated
> network driver tries to write an incoming packet to guest RAM but finds t=
he
> guest RAM hasn't arrived yet.
> With the main thread blocked it's very difficult to recover - we can't is=
sue any
> commands to trigger the recovery and even if we could we'll have to be ve=
ry
> careful about what things those commands need the main thread to do.
>=20
> Dave

Thanks for your information!
I will take a look first, maybe get back to you later.

Liang
