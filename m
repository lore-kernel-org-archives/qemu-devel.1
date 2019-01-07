Received: from eggs.gnu.org ([209.51.188.92]:58486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggX8P-00040j-BT
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggX8O-0002OF-PH
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:48:13 -0500
Date: Mon, 7 Jan 2019 16:48:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190107164801.32e9d6dc.cohuck@redhat.com>
In-Reply-To: <5C2F6ED2.33D0D1.16460@m12-13.163.com>
References: <20190103151612.51399-1-liq3ea@163.com>
	<20190104151005.42b6f111.cohuck@redhat.com>
	<5C2F6ED2.33D0D1.16460@m12-13.163.com>
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
To: Li Qiang <liq3ea@163.com>
Cc: "walling@linux.ibm.com" <walling@linux.ibm.com>, "rth@twiddle.net" <rth@twiddle.net>, "david@redhat.com" <david@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

On Fri, 4 Jan 2019 22:33:51 +0800
Li Qiang <liq3ea@163.com> wrote:

> What do you think of =E2=80=98g_assert_not_reached();=E2=80=99. For examp=
le:
>=20
> else {
>      g_assert_not_reached();
> }

Sounds good. But please return anyway in the unplug case, so that the
code is fine if asserts have been configured out.
