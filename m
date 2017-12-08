Received: from eggs.gnu.org ([2001:4830:134:3::10]:37510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eNFkh-00051W-U5
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eNFke-00027p-Pq
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:19:31 -0500
Date: Fri, 8 Dec 2017 11:19:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171208111919.2d5322b9.cohuck@redhat.com>
In-Reply-To: <49485e7e-f950-58c5-af56-b336b4d4f0e3@linux.vnet.ibm.com>
References: <49485e7e-f950-58c5-af56-b336b4d4f0e3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Interactive Boot Menu: New Fields in IPLB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

On Thu, 7 Dec 2017 18:56:16 -0500
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:


>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 --- The Fields We Need To Store ---
>=20
> Currently, we're utilizing 3 bytes out of a 77 byte reserved field in=20
> the IPLB for
> CCW and SCSI. We do this because need a way to pass the Qemu command=20
> line options
> for a boot menu (on/off and timeout) to the s390-ccw bios. We require=20
> only two
> fields in the IPLB, totaling 3 bytes:

Hm, are we actually that constrained with space?

>=20
>  =C2=A0* uint8_t boot_menu_flag
>  =C2=A0=C2=A0=C2=A0=C2=A0 o determines if we should show the menu or not

Should be fine. I'd recommend something along the lines of
- bit 0: show a boot menu
- bit 1-7: reserved [for future use]

>=20
>  =C2=A0* uint16_t boot_menu_timeout
>  =C2=A0=C2=A0=C2=A0=C2=A0 o stored as milliseconds
>  =C2=A0=C2=A0=C2=A0=C2=A0 o A max value of approx 65,000 gives us 65 seco=
nds -- should be=20
> plenty

65 seconds should be enough for everyone?

:)

>  =C2=A0=C2=A0=C2=A0=C2=A0 o could potentially be reduced to one byte, and=
 we store the value
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as seconds instead

As said, do we really need to worry about the space this is using up
here?

>=20
> Note: these fields *only*have value in a QEMU environment.
