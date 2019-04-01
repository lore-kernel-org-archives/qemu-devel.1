Received: from eggs.gnu.org ([209.51.188.92]:44521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1hAvSr-0002DU-Rj
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1hAvSo-00079j-TN
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:50:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1hAvSf-000753-9s
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:50:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31BdJpU140974
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 07:50:42 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkfb18a31-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 07:50:42 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Mon, 1 Apr 2019 12:50:39 +0100
Date: Mon, 1 Apr 2019 13:50:31 +0200
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190329111104.17223-13-berrange@redhat.com>
References: <20190329111104.17223-1-berrange@redhat.com>
	<20190329111104.17223-13-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20190401135031.3a5bc366@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 12/14] hw/s390/css: avoid
 taking address members in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>, qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Fri, 29 Mar 2019 11:11:02 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> The GCC 9 compiler complains about many places in s390 code
> that take the address of members of the 'struct SCHIB' which
> is marked packed:
>=20
> hw/s390x/css.c: In function =E2=80=98sch_handle_clear_func=E2=80=99:
> hw/s390x/css.c:698:15: warning: taking address of packed member of =E2=80=
=98struct SCHIB=E2=80=99 may result in an unaligned pointer val\
> ue [-Waddress-of-packed-member]
>   698 |     PMCW *p =3D &sch->curr_status.pmcw;
>       |               ^~~~~~~~~~~~~~~~~~~~~~
> hw/s390x/css.c:699:15: warning: taking address of packed member of =E2=80=
=98struct SCHIB=E2=80=99 may result in an unaligned pointer val\
> ue [-Waddress-of-packed-member]
>   699 |     SCSW *s =3D &sch->curr_status.scsw;
>       |               ^~~~~~~~~~~~~~~~~~~~~~
>=20
> ...snip many more...
>=20
> Almost all of these are just done for convenience to avoid
> typing out long variable/field names when referencing struct
> members. We can get most of this convenience by taking the
> address of the 'struct SCHIB' instead, avoiding triggering
> the compiler warnings.
>=20
> In a couple of places we copy via a local variable which is
> a technique already applied elsewhere in s390 code for this
> problem.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Thanks!
