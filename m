Received: from eggs.gnu.org ([2001:4830:134:3::10]:41898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evFKr-0005ad-QJ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evFKo-0002I4-Km
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:45:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evFKo-0002Hu-DZ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:45:18 -0400
Date: Mon, 12 Mar 2018 12:45:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180312044504.GF5234@xz-mi>
References: <20180309091535.13315-1-peterx@redhat.com>
	<808d1efc-2db7-01a2-23ba-3af108d9d1e7@redhat.com>
	<235748d9-3bc2-637b-f926-6436d11f4f61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <235748d9-3bc2-637b-f926-6436d11f4f61@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/23] Migration: postcopy failure
 recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Mar 09, 2018 at 10:59:03AM -0600, Eric Blake wrote:
> On 03/09/2018 10:54 AM, Eric Blake wrote:
> > On 03/09/2018 03:15 AM, Peter Xu wrote:
> > > Based-on: <20180309090006.10018-1-peterx@redhat.com>
> > >=20
> > > This series is based on the series:
> > >=20
> > > =C2=A0=C2=A0 [PATCH v8 00/23] QMP: out-of-band (OOB) execution supp=
ort
> >=20
> > Let's spell that in a way patchew understands:
> >=20
> > Based-on: <20180309090006.10018-1-peterx@redhat.com>
> >=20
>=20
> Never mind - I missed that you snuck that in on the very first line (wh=
ich
> I'm used to overlooking because it's often a 'From:' author attribution=
,
> instead of a patchew directive).  I saw the patchew failure messages, b=
ut
> didn't read them closely to see why it is failing, and merely assumed i=
t was
> because of the missing dependency...

Yeh, but there still seems to be something wrong elsewhere since the
series can pass compilation and docker tests on my host...

Fam, what would happen if I firstly post OOB series, then postcopy
series (which will have "based-on" on OOB series) right away?  Could
Patchew just ignore the "based-on" if I post the 2nd series too fast
since Patchew may have not yet went through the first one?

Thanks,

--=20
Peter Xu
