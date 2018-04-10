Received: from eggs.gnu.org ([2001:4830:134:3::10]:40642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f5uBd-0007Ul-HZ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f5uBZ-0007ju-Ij
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:23:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37098
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1f5uBZ-0007jT-EF
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:23:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3AEH7DL078705
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 10:23:48 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h8vxnxgfc-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 10:23:47 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 10 Apr 2018 10:23:46 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA-_CW1w+XXAxWo93t8L+5zAcBRM6v7wF9xw1_EBd5FibA@mail.gmail.com>
References: <20180410005724.10059-1-mdroth@linux.vnet.ibm.com>
	<CAFEAcA-_CW1w+XXAxWo93t8L+5zAcBRM6v7wF9xw1_EBd5FibA@mail.gmail.com>
Date: Tue, 10 Apr 2018 09:23:31 -0500
Message-Id: <152337021185.15508.13282518954009351050@sif>
Subject: Re: [Qemu-devel] [PATCH for-2.12] make-release: add skiboot
 .version file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, qemu-stable <qemu-stable@nongnu.org>

Quoting Peter Maydell (2018-04-10 02:31:04)
> On 10 April 2018 at 01:57, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > This is needed to build skiboot from tarball-distributed sources
> > since the git data the make_release.sh script relies on to generate
> > it is not available.
> >
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > ---
> >  scripts/make-release | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/make-release b/scripts/make-release
> > index 04fa9defdc..c14f75b12c 100755
> > --- a/scripts/make-release
> > +++ b/scripts/make-release
> > @@ -19,6 +19,7 @@ pushd ${destination}
> >  git checkout "v${version}"
> >  git submodule update --init
> >  (cd roms/seabios && git describe --tags --long --dirty > .version)
> > +(cd roms/skiboot && ./make_version.sh > .version)
> >  # FIXME: The following line is a workaround for avoiding filename coll=
isions
> >  # when unpacking u-boot sources on case-insensitive filesystems. Once =
we
> >  # update to something with u-boot commit 610eec7f0 we can drop this li=
ne.
> =

> Seeing this comment in the context part of this patch reminds me:
> have we updated to a u-boot that lets us drop the workaround yet?

Not yet, we need:

  https://github.com/u-boot/u-boot/commit/610eec7f0

which was committed Oct 2017, but QEMU master is still using the
v2017.07 July release, via:

  https://github.com/qemu/qemu/commit/73663d71

> =

> thanks
> -- PMM
>=20
