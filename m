Received: from eggs.gnu.org ([2001:4830:134:3::10]:60036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYva9-000700-DJ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYva3-0000Os-Pz
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:12:53 -0500
Date: Tue, 9 Jan 2018 16:12:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180109161240.29b2c460.cohuck@redhat.com>
In-Reply-To: <82678d4e-234a-79a5-7e1d-d66da7460f1c@linux.vnet.ibm.com>
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
	<1513030760-26245-3-git-send-email-walling@linux.vnet.ibm.com>
	<20171214184157.21fbe3b8.cohuck@redhat.com>
	<82678d4e-234a-79a5-7e1d-d66da7460f1c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 2/5] s390-ccw: ipl structs
 for eckd cdl/ldl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, david@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org

On Mon, 18 Dec 2017 17:11:52 -0500
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:

> On 12/14/2017 12:41 PM, Cornelia Huck wrote:
> > On Mon, 11 Dec 2017 17:19:17 -0500
> > "Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:
> > =20
> >> ECKD DASDs have different IPL structures for CDL and LDL
> >> formats. The current Ipl1 and Ipl2 structs follow the CDL
> >> format, so we prepend "EckdCdl" to them. Boot info for LDL
> >> has been moved to a new struct: EckdLdlIpl1.
> >>
> >> Also introduce structs for IPL stages 1 and 1b and for
> >> disk geometry.
> >>
> >> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> >> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> >> ---
> >>   pc-bios/s390-ccw/bootmap.c | 24 ++++++++++----------
> >>   pc-bios/s390-ccw/bootmap.h | 55 +++++++++++++++++++++++++++++++++---=
----------
> >>   2 files changed, 53 insertions(+), 26 deletions(-)
> >>
> >> +    mbr_block_nr =3D
> >> +        eckd_block_num((void *)&(ipl1->boot_info.bp.ipl.bm_ptr.eckd.b=
ptr)); =20
> > Let me nominate this as "crazy nested struct of the week".
> >
> > (Just kidding, your patch certainly improves things in general :) =20
>=20
>=20
> FWIW: we can reduce it to just ipl1->boot_info.bp-- the way the structs=20
> are unioned
> and the ordering of the fields make this possible.=C2=A0 Thoughts?

Ah, missed that one. I'd prefer to be explicit here, even if it is long.
