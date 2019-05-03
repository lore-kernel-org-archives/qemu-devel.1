Received: from eggs.gnu.org ([209.51.188.92]:50251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hMf6L-0007T6-BV
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hMf6J-0003rt-Gd
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:48:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1hMf6J-0003pM-BP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:48:11 -0400
Date: Fri, 3 May 2019 22:47:57 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190503204757.GF4675@paraplu>
References: <20190503154613.4192-1-kchamart@redhat.com>
	<20190503154613.4192-2-kchamart@redhat.com>
	<20190503154905.GJ17905@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190503154905.GJ17905@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] VirtIO-RNG: Update default entropy source
 to `/dev/urandom`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, amit@kernel.org, armbru@redhat.com, rjones@redhat.com, peter.maydell@linaro.org

On Fri, May 03, 2019 at 04:49:05PM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, May 03, 2019 at 05:46:13PM +0200, Kashyap Chamarthy wrote:
> > When QEMU exposes a VirtIO-RNG device to the guest, that device needs=
 a
> > source of entropy, and that source needs to be "non-blocking", like
> > `/dev/urandom`.  However, currently QEMU defaults to the problematic
> > `/dev/random`, which is "blocking" (as in, it waits until sufficient
> > entropy is available).
> >=20
> > So change the entropy source to the recommended `/dev/urandom`.
> >=20
> > Related discussion in these[1][2] past threads.
> >=20
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335=
.html
> >     -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
> > [2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02724=
.html
> >     -- "[RFC] Virtio RNG: Consider changing the default entropy sourc=
e to
> >        /dev/urandom"
> >=20
> > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> > ---
> >  backends/rng-random.c | 2 +-
> >  qemu-options.hx       | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>

I'm wondering if this needs to be mentioned on a Release Notes wiki
somewhere -- because we're changing the default.

--=20
/kashyap
