Received: from eggs.gnu.org ([2001:4830:134:3::10]:60435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqCTP-0003KV-SG
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqCTL-0002rO-80
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:09:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqCTL-0002qz-2S
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:08:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EECBD37E88
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 06:08:57 +0000 (UTC)
Date: Fri, 8 Sep 2017 14:08:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170908060855.GB4511@lemon>
References: <20170907083552.17725-1-famz@redhat.com>
	<285ebeab-ccce-4339-f782-2a5a39139777@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <285ebeab-ccce-4339-f782-2a5a39139777@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] buildsys: Move vde cflags/libs to per
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, 09/08 09:59, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B409=E6=9C=8807=E6=97=A5 16:35, Fam Zheng wrote:
> > Hi Jason,
> >=20
> > this is the net/ part of the conversion of library cflags/libs from g=
lobal
> > QEMU_CFLAGS and libs_softmmu to per object variables. Please review.
> >=20
> > Fam Zheng (2):
> >    vl: Don't include vde header
> >    buildsys: Move vde libs to per object
> >=20
> >   configure         | 3 +--
> >   net/Makefile.objs | 2 ++
> >   vl.c              | 4 ----
> >   3 files changed, 3 insertions(+), 6 deletions(-)
> >=20
>=20
> Reviewed-by: Jason Wang <jasowang@redhat.com>
>=20

Thanks, I will send a pull request later.

Fam
