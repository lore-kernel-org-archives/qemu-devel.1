Received: from eggs.gnu.org ([2001:4830:134:3::10]:44051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1caj7K-0003ID-PW
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 08:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1caj7G-0006yS-MM
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 08:14:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51235)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1caj7G-0006yK-GA
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 08:13:58 -0500
Date: Mon, 6 Feb 2017 13:13:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170206131352.GD2524@work-vm>
References: <1483596532-14552-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<6a928d63-59c5-a763-0156-40e5958512c5@cn.fujitsu.com>
	<71bda662-8a14-01d4-9db6-ce96640dfee9@cn.fujitsu.com>
	<61ae330c-b431-fff3-dd58-ba24b081dc60@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61ae330c-b431-fff3-dd58-ba24b081dc60@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V6 0/2] Add new qmp commands to suppurt Xen
 COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Bian Naimeng <biannm@cn.fujitsu.com>

* Jason Wang (jasowang@redhat.com) wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8826=E6=97=A5 11:04, Zhang Chen wrote:
> > Hi~
> >=20
> > No news for a week.
> >=20
> > We need comments ~~
> >=20
> > Ping...
> >=20
>=20
> Cc David who is one of the maintainer of migration.

My difficulty is I don't know any Xen and I don't understand
the block replication code much either; so I hadn't really looked at it.

Dave

>=20
> >=20
> > Thanks
> >=20
> > Zhang Chen
> >=20
> >=20
> > On 01/19/2017 05:57 PM, Zhang Chen wrote:
> > > Hi~~
> > >=20
> > > Anyone have any comments?
> > >=20
> > > Ping....
> > >=20
> > >=20
> > > Thanks
> > >=20
> > > Zhang Chen
> > >=20
> > >=20
> > > On 01/05/2017 02:08 PM, Zhang Chen wrote:
> > > > Xen COLO depend on qemu COLO replication function.
> > > > So, We need new qmp commands for Xen to use qemu replication.
> > > >=20
> > > > Corresponding libxl patches already in xen.git.
> > > > Commit ID:
> > > >=20
> > > > ed37ef1f91c20f0ab162ce60f8c38400b917fa64
> > > > COLO: introduce new API to prepare/start/do/get_error/stop replic=
ation
> > > >=20
> > > > a0ddc0b359375b2418213966dfbdbfab593ecc6f
> > > > tools/libxl: introduction of libxl__qmp_restore to load qemu stat=
e
> > > >=20
> > > >=20
> > > > Zhang Chen (2):
> > > >    Add a new qmp command to start/stop replication
> > > >    Add a new qmp command to do checkpoint, query xen replication =
status
> > > >=20
> > > >   docs/qmp-commands.txt | 42 +++++++++++++++++++++++++++++++
> > > >   migration/colo.c      | 40 +++++++++++++++++++++++++++++
> > > >   qapi-schema.json      | 69
> > > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >   3 files changed, 151 insertions(+)
> > > >=20
> > >=20
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
