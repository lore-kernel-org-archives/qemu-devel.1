Received: from eggs.gnu.org ([2001:4830:134:3::10]:35991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGQyU-0000nx-NZ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGQyQ-0007ab-2e
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:21:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGQyP-0007aH-TS
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:21:14 -0400
Date: Thu, 1 Jun 2017 17:21:06 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170601172020-mutt-send-email-mst@kernel.org>
References: <20170529151047.85390-1-ben@skyportsystems.com>
	<CAJ+F1C+QFS5YDw7He-p0eEObYbGcq6ra3wwVMVdEu88C0tRqQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+QFS5YDw7He-p0eEObYbGcq6ra3wwVMVdEu88C0tRqQQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: ben@skyportsystems.com, qemu-devel@nongnu.org, imammedo@redhat.com, lersek@redhat.com

On Thu, Jun 01, 2017 at 08:10:27AM +0000, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Mon, May 29, 2017 at 7:18 PM Ben Warren via Qemu-devel <
> qemu-devel@nongnu.org> wrote:
>=20
>     From: Ben Warren <ben@skyportsystems.com>
>=20
>     The following tests are implemented:
>     * test that a GUID passed in by command line is propagated to the g=
uest.
>     =A0 Read the GUID from guest memory
>     * test that the "auto" argument to the GUID generates a valid GUID,=
 as
>     =A0 seen by the guest.
>     * test that a GUID passed in can be queried from the monitor
>=20
>     =A0 This patch is loosely based on a previous patch from:
>     =A0 Gal Hammer <ghammer@redhat.com>=A0 and Igor Mammedov <imammedo@=
redhat.com>
>=20
>     Signed-off-by: Ben Warren <ben@skyportsystems.com>
>     Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>     ---

What happened to indentation here?

>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0* in order to implement the "OVMF SDT H=
eader probe
>     suppressor"
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0* see docs/specs/vmgenid.txt for more d=
etails
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>     +=A0 =A0 =A0 =A0 =A0 =A0 return vgid_table.vgia_val + VMGENID_GUID_=
OFFSET;
>     +=A0 =A0 =A0 =A0 }
>=20
>=20
> It leaks tables
> =A0
> Other than that:
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Ben, are you going to post a version that doesn't leak?
