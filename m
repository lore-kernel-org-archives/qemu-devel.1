Received: from eggs.gnu.org ([2001:4830:134:3::10]:36084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1euFF4-00029I-70
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:27:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1euFF0-0001h1-8t
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:27:14 -0500
Date: Fri, 9 Mar 2018 11:27:03 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180309112703.5edfb386.cohuck@redhat.com>
In-Reply-To: <9fdc51f3-edcb-1811-2501-da1e17e52c97@linux.vnet.ibm.com>
References: <20180307162958.11232-1-nia.alarie@gmail.com>
	<9fdc51f3-edcb-1811-2501-da1e17e52c97@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390x/virtio: Convert virtio-ccw from
 *_exit to *_unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Nia Alarie <nia.alarie@gmail.com>, qemu-devel@nongnu.org, jim@groklearning.com, stefanha@gmail.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, joel@jms.id.au

On Fri, 9 Mar 2018 10:23:31 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 07/03/2018 17:29, Nia Alarie wrote:
> > Signed-off-by: Nia Alarie <nia.alarie@gmail.com> =20
>=20
> What you do seems right to me, naming seems more logical, but=C2=A0 can y=
ou=20
> please
> add a little commit message explaining why you change the interface?

I had asked Nia to do this; see the comments in qdev-core.h regarding
usage of exit vs. unrealize.

(I have already queued this for a pull request, since I'll be out
starting tomorrow.)

>=20
> Thanks,
>=20
> Pierre
>=20
> > ---
> >   hw/s390x/virtio-ccw.c | 34 +++++++++++++++++-----------------
> >   hw/s390x/virtio-ccw.h |  2 +-
> >   2 files changed, 18 insertions(+), 18 deletions(-)
