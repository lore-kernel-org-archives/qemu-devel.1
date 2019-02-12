Received: from eggs.gnu.org ([209.51.188.92]:39509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtY7I-0004Qp-P3
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtY3j-0001xF-Hr
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:25:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gtY3h-0001r2-Ed
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:25:10 -0500
Date: Tue, 12 Feb 2019 08:24:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212082336-mutt-send-email-mst@kernel.org>
References: <20190204142638.27021-1-mst@redhat.com>
	<CAFEAcA8VGhubZk5HFEjNm5f9xdsgO2RdRR6Vcxzmzzyuj-b5JQ@mail.gmail.com>
	<20190204205105-mutt-send-email-mst@kernel.org>
	<CAFEAcA_m8Ebz8NTKM19FV-APQCOJpXVwyWm48uHRdfdKsHu7Bg@mail.gmail.com>
	<20190205110518-mutt-send-email-mst@kernel.org>
	<20190212071114.GM1011@xz-x1>
	<bb1175b1-6b51-2df2-047d-b625413ea3dc@redhat.com>
	<20190212080349-mutt-send-email-mst@kernel.org>
	<5716364b-da70-e134-4ed0-d3d136d9ba8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5716364b-da70-e134-4ed0-d3d136d9ba8a@redhat.com>
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
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Changpeng Liu <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

On Tue, Feb 12, 2019 at 02:15:36PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/12/19 2:04 PM, Michael S. Tsirkin wrote:
> > On Tue, Feb 12, 2019 at 11:39:21AM +0100, Philippe Mathieu-Daud=E9 wr=
ote:
> >> On 2/12/19 8:11 AM, Peter Xu wrote:
> >>> On Tue, Feb 05, 2019 at 11:06:42AM -0500, Michael S. Tsirkin wrote:
> >>>>
> >>>> OK I reverted the whole part dealing with vhost-user and reposted.
> >>>
> >>> I noticed that the merged pull request could possibly have squashed
> >>> the below two patches (in previous pull) into one super patch
> >>> (a56de056c91f87e1e):
> >>>
> >>>         i386/kvm: ignore masked irqs when update msi routes
> >>>         contrib/vhost-user-blk: fix the compilation issue
> >>>
> >>> Here, the first patch lost its commit message, and the last patch l=
ost
> >>> its real author. ;)
> >>
> >> I suggest we revert a56de056c9 ASAP and reapply the both patches, th=
is
> >> will ease cherry-picking/downstream workflow.
> >=20
> > I don't see why does it help upstream.
>=20
> I'd have suggested the same if I had no idea what 'downstream workflow'
> mean, simply to keep the tree clear and avoid to have unrelated changes
> squashed altogether.
> Commit a56de056c9 really looks messy. MSI/MSIX changes described by "fi=
x
> vhost-user-blk compilation".
> Hopefully it won't trigger any problem which requires bisecting to it,
> then contact Changpeng Liu asking him what he intented to do with his
> commit.
> Your call anyway :)
>=20
> Regards,
>=20
> Phil.


OK these are good points. I'm not sure what happened but it looks like I
screwed up when resolving some conflicts.  Care posting a patchset
looking sane?

--=20
MST
