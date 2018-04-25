Received: from eggs.gnu.org ([2001:4830:134:3::10]:58998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fBIOh-00026i-8I
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fBIOg-0007Q6-F1
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:15:39 -0400
Date: Wed, 25 Apr 2018 13:15:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180425111515.GE4652@localhost.localdomain>
References: <20180424220157.177385-1-eblake@redhat.com>
	<20180425080659.GD30024@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180425080659.GD30024@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block: Merge .bdrv_co_writev{,
 _flags} in drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "open list:GLUSTER" <qemu-block@nongnu.org>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Xie Changlong <xiechanglong.d@gmail.com>

Am 25.04.2018 um 10:06 hat Daniel P. Berrang=E9 geschrieben:
> On Tue, Apr 24, 2018 at 05:01:57PM -0500, Eric Blake wrote:
> > We have too many driver callback interfaces; simplify the mess
> > somewhat by merging the flags parameter of .bdrv_co_writev_flags()
> > into .bdrv_co_writev_flags().  Note that as long as a driver doesn't
>=20
> Typo - this should be just  .bdrv_co_writev

Thanks, fixed up the typo and applied to block-next.

Kevin
