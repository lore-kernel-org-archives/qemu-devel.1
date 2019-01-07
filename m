Received: from eggs.gnu.org ([209.51.188.92]:33633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggXHw-0001A7-5b
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggXHv-0004Id-Bc
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:58:04 -0500
Date: Mon, 7 Jan 2019 16:57:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190107165748.442cc0c1.cohuck@redhat.com>
In-Reply-To: <CAFEAcA_BzQaZM01_q29q+RfnqF2_YDSM0zfqKYDFwzRQOq7now@mail.gmail.com>
References: <20190103151612.51399-1-liq3ea@163.com>
	<20190104151005.42b6f111.cohuck@redhat.com>
	<5C2F6ED2.33D0D1.16460@m12-13.163.com>
	<20190107164801.32e9d6dc.cohuck@redhat.com>
	<CAFEAcA_BzQaZM01_q29q+RfnqF2_YDSM0zfqKYDFwzRQOq7now@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] s390: avoid potential null dereference
 ins390_pcihost_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Li Qiang <liq3ea@163.com>, "walling@linux.ibm.com" <walling@linux.ibm.com>, "rth@twiddle.net" <rth@twiddle.net>, "david@redhat.com" <david@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, 7 Jan 2019 15:54:21 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 7 Jan 2019 at 15:48, Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > On Fri, 4 Jan 2019 22:33:51 +0800
> > Li Qiang <liq3ea@163.com> wrote:
> > =20
> > > What do you think of =E2=80=98g_assert_not_reached();=E2=80=99. For e=
xample:
> > >
> > > else {
> > >      g_assert_not_reached();
> > > } =20
> >
> > Sounds good. But please return anyway in the unplug case, so that the
> > code is fine if asserts have been configured out. =20
>=20
> Hopefully that won't cause the compiler to complain about
> unreachable code :-)

BTW: Is there a common configuration where asserts are configured out?
Not that this is an accident waiting to happen...
