Received: from eggs.gnu.org ([2001:4830:134:3::10]:55137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnoBo-0001yn-U0
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnoBk-0006PP-29
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:49:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnoBj-0006PH-Rw
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:48:55 -0400
Date: Fri, 1 Sep 2017 12:48:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170901154850.GP7570@localhost.localdomain>
References: <20170830225225.27925-1-f4bug@amsat.org>
	<20170901151850.GD17184@localhost.localdomain>
	<e5407d61-b21c-8ff5-1051-f75a6221e222@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e5407d61-b21c-8ff5-1051-f75a6221e222@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/7] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

On Fri, Sep 01, 2017 at 12:44:42PM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 09/01/2017 12:18 PM, Eduardo Habkost wrote:
> > On Wed, Aug 30, 2017 at 07:52:18PM -0300, Philippe Mathieu-Daud=E9 wr=
ote:
> > > Hi,
> > >=20
> > > This series is based on Igor's "complete cpu QOMification" [1] but =
only modify
> > > the MIPS part. Igor posted an updated series [2], both series shoul=
d apply
> > > separately.
> > >=20
> > > Igor suggested on IRC this series could enter via the Machine core =
tree, so
> > > I added Eduardo and Marcel.
> >=20
> > I would do that only if the MIPS maintainers (CCed) aren't
> > willing to merge the series themselves.
>=20
> Aurelien told me he looked at the series but isn't comfortable with
> reviewing QOM code. Anyway since all patches are reviewed/tested and th=
is is
> MIPS only series it also makes sens to me this enters via their tree.
>=20
> Eduardo can you Ack this series from the QOM part to help Aurelien?

Absolutely:

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

I will try to review the QOM code more closely and send
Reviewed-by lines too.

--=20
Eduardo
