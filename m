Received: from eggs.gnu.org ([209.51.188.92]:57537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtXkC-0000FF-AK
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtXkA-0005Bg-Pd
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:05:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gtXjy-0004fO-W4
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:04:49 -0500
Date: Tue, 12 Feb 2019 08:04:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212080349-mutt-send-email-mst@kernel.org>
References: <20190204142638.27021-1-mst@redhat.com>
	<CAFEAcA8VGhubZk5HFEjNm5f9xdsgO2RdRR6Vcxzmzzyuj-b5JQ@mail.gmail.com>
	<20190204205105-mutt-send-email-mst@kernel.org>
	<CAFEAcA_m8Ebz8NTKM19FV-APQCOJpXVwyWm48uHRdfdKsHu7Bg@mail.gmail.com>
	<20190205110518-mutt-send-email-mst@kernel.org>
	<20190212071114.GM1011@xz-x1>
	<bb1175b1-6b51-2df2-047d-b625413ea3dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <bb1175b1-6b51-2df2-047d-b625413ea3dc@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/25] pci, pc, virtio: fixes, cleanups,
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Feb 12, 2019 at 11:39:21AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/12/19 8:11 AM, Peter Xu wrote:
> > On Tue, Feb 05, 2019 at 11:06:42AM -0500, Michael S. Tsirkin wrote:
> >>
> >> OK I reverted the whole part dealing with vhost-user and reposted.
> >=20
> > I noticed that the merged pull request could possibly have squashed
> > the below two patches (in previous pull) into one super patch
> > (a56de056c91f87e1e):
> >=20
> >         i386/kvm: ignore masked irqs when update msi routes
> >         contrib/vhost-user-blk: fix the compilation issue
> >=20
> > Here, the first patch lost its commit message, and the last patch los=
t
> > its real author. ;)
>=20
> I suggest we revert a56de056c9 ASAP and reapply the both patches, this
> will ease cherry-picking/downstream workflow.

I don't see why does it help upstream.

--=20
MST
