Received: from eggs.gnu.org ([209.51.188.92]:36956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1goBEi-000396-9M
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1goB2i-0002X4-UX
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:49:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1goB2g-0002Tg-Ta
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:49:56 -0500
Date: Mon, 28 Jan 2019 12:49:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190128124924-mutt-send-email-mst@kernel.org>
References: <20190125210058.1092551-1-stefanb@linux.ibm.com>
	<20190128154553.583f79a3@redhat.com>
	<f7fc884b-0a7f-17d5-ada4-fc44c08bfba1@linux.ibm.com>
	<f93f5ab2-8b51-ca05-c4c3-902743e4b13e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f93f5ab2-8b51-ca05-c4c3-902743e4b13e@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] acpi: Make TPM 2.0 with TIS available as
 MSFT0101
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com

On Mon, Jan 28, 2019 at 12:19:37PM -0500, Stefan Berger wrote:
> On 1/28/19 11:14 AM, Stefan Berger wrote:
> > On 1/28/19 9:45 AM, Igor Mammedov wrote:
> > > On Fri, 25 Jan 2019 16:00:58 -0500
> > > Stefan Berger <stefanb@linux.ibm.com> wrote:
> > >=20
> > > > This patch makes the a TPM 2.0 with TIS interface available under=
 the
> > > > HID 'MSF0101'. This is supported by Linux and also Windows now
> > > MSF0101 is relatively recent addition to Linux,
> > > are there in wild (old) kernels that worked with PNP0C31 but won't =
work
> > > with MSF0101?
> >=20
> >=20
> > Linux 4.3.4 and later references this HID here:
> > https://elixir.bootlin.com/linux/v4.3.4/source/drivers/char/tpm/tpm_t=
is.c
> > . I don't see it before that. A 3.10 kernel works with this patch as
> > well.
>=20
>=20
> ... that 3.10 kernel from el7 has been patched, though.
>=20
> =A0=A0 Stefan

.. and supports the new HID.

--=20
MST
