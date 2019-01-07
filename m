Received: from eggs.gnu.org ([209.51.188.92]:60643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXEc-0007Bu-Lg
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXEb-0007ej-MF
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:54:38 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXEb-0007c3-DV
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:54:37 -0500
Received: by mail-ot1-x342.google.com with SMTP id 81so732021otj.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 07:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20190103151612.51399-1-liq3ea@163.com>
	<20190104151005.42b6f111.cohuck@redhat.com>
	<5C2F6ED2.33D0D1.16460@m12-13.163.com>
	<20190107164801.32e9d6dc.cohuck@redhat.com>
In-Reply-To: <20190107164801.32e9d6dc.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 15:54:21 +0000
Message-ID: <CAFEAcA_BzQaZM01_q29q+RfnqF2_YDSM0zfqKYDFwzRQOq7now@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, "walling@linux.ibm.com" <walling@linux.ibm.com>, "rth@twiddle.net" <rth@twiddle.net>, "david@redhat.com" <david@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, 7 Jan 2019 at 15:48, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Fri, 4 Jan 2019 22:33:51 +0800
> Li Qiang <liq3ea@163.com> wrote:
>
> > What do you think of =E2=80=98g_assert_not_reached();=E2=80=99. For exa=
mple:
> >
> > else {
> >      g_assert_not_reached();
> > }
>
> Sounds good. But please return anyway in the unplug case, so that the
> code is fine if asserts have been configured out.

Hopefully that won't cause the compiler to complain about
unreachable code :-)

thanks
-- PMM
