Received: from eggs.gnu.org ([209.51.188.92]:60179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBLzV-00021D-Cf
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBLzU-0006gw-G4
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:10:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hBLzU-0006ev-8G
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:10:24 -0400
Date: Tue, 2 Apr 2019 18:10:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190402161020.GD5352@localhost.localdomain>
References: <20190328165648.76c5527d@kitsune.suse.cz>
	<20190328214807.65f99b94@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190328214807.65f99b94@kitsune.suse.cz>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'share-rw'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: qemu-devel@nongnu.org

Am 28.03.2019 um 21:48 hat Michal Such=E1nek geschrieben:
> On Thu, 28 Mar 2019 16:56:48 +0100
> Michal Such=E1nek <msuchanek@suse.de> wrote:
>=20
> > Hello,
> >=20
> > I tried to update my machine definitions to work with current qemu.
> >=20
> > Unfortunately, while qemu 2.11 supports disk sharing with raw images
> > qemu 3.1 does not. That looks bogus to me. What is not supported abou=
t
> > writing random block into a file in parallel?
>=20
> And of course it is because the option is supported on a different
> option (yes, options that have options get convoluted) and the error
> message is quite unhelpful in diagnosing that.
>=20
> Now if different formats can register new option handlers which
> magically make an option supported I don't see how the diagnostic can
> do much better, unfortunately.

That's not really what happens. This is an option of the virtual device,
not of the format driver. The format driver is not involved at all,
which is why it's just an unknown option for it.

Kevin
