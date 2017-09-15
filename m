Received: from eggs.gnu.org ([2001:4830:134:3::10]:51766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dseb8-000861-NN
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 20:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dseb4-0007bS-0Q
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 20:35:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dseb3-0007b1-O7
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 20:35:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8F0YObq053802
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 20:35:03 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cyypsax85-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 20:35:03 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 20:35:02 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAJ+F1CKm=2FmxUdiz44vtuUz3B2LQ6WUVgdjdBqy5qTQxziycw@mail.gmail.com>
References: <20170829152751.3174-1-marcandre.lureau@redhat.com>
	<20170829183303-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKm=2FmxUdiz44vtuUz3B2LQ6WUVgdjdBqy5qTQxziycw@mail.gmail.com>
Date: Thu, 14 Sep 2017 19:07:44 -0500
Message-Id: <150543406487.22700.15054030640393601199@loki>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH v2 0/2] vhost-user-bridge
 reconnect regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Victor Kaplansky <victork@redhat.com>, QEMU <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

Quoting Marc-Andr=C3=A9 Lureau (2017-08-29 10:57:01)
> Hi
> =

> On Tue, Aug 29, 2017 at 5:34 PM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> > On Tue, Aug 29, 2017 at 05:27:49PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> >> Hi,
> >>
> >> libvhost-user doesn't support resuming with the same trick vubr had
> >> since commit 523b018dde3b7650fe5401d0499b30cf2f117515. The following
> >> two patches fix that regression.
> >
> >
> > Thanks! Do we need this in 2.10? If not pls ping after 2.10 is out.
> =

> I think it's not necessary since the regression appeared in 2.9
> already, and it's a manual test.
> =

> I'll ping after 2.10

FYI I'm looking to get v2.10.1 out this month, freeze will likely be set for
Sep. 25th if you're looking to get this in.

> =

> >
> >> Thanks
> >>
> >> Marc-Andr=C3=A9 Lureau (2):
> >>   libvhost-user: support resuming vq->last_avail_idx based on used_idx
> >>   vhost-user-bridge: fix resume regression (since 2.9)
> >>
> >>  contrib/libvhost-user/libvhost-user.h |  7 +++++++
> >>  contrib/libvhost-user/libvhost-user.c | 13 +++++++++++++
> >>  tests/vhost-user-bridge.c             |  7 +++++++
> >>  3 files changed, 27 insertions(+)
> >>
> >> --
> >> 2.14.1.146.gd35faa819
> >
> =

> =

> =

> -- =

> Marc-Andr=C3=A9 Lureau
>=20
