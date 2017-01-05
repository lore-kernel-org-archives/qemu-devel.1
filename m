Received: from eggs.gnu.org ([2001:4830:134:3::10]:52640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cP55H-0004JT-Gv
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cP55C-0004Fc-GX
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:15:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:37853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cP55C-0004Ei-3W
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:15:42 -0500
From: "Li, Liang Z" <liang.z.li@intel.com>
Date: Thu, 5 Jan 2017 10:15:37 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C34C20B@shsmsx102.ccr.corp.intel.com>
References: <1463570440-29685-1-git-send-email-jitendra.kolhe@hpe.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C34811E@shsmsx102.ccr.corp.intel.com>
	<ebc6d79a-833d-5413-8617-b3252bc45a07@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C34BC76@shsmsx102.ccr.corp.intel.com>
	<a21b2517-08ec-653a-2e1e-9b8c325d3267@redhat.com>
In-Reply-To: <a21b2517-08ec-653a-2e1e-9b8c325d3267@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 0/4] migration: skip scanning and
 migrating ram pages released by virtio-balloon driver.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Jitendra Kolhe <jitendra.kolhe@hpe.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "simhan@hpe.com" <simhan@hpe.com>, "JBottomley@Odin.com" <JBottomley@Odin.com>, "armbru@redhat.com" <armbru@redhat.com>, "lcapitulino@redhat.com" <lcapitulino@redhat.com>, "renganathan.meenakshisundaram@hpe.com" <renganathan.meenakshisundaram@hpe.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mst@redhat.com" <mst@redhat.com>, "mohan_parthasarathy@hpe.com" <mohan_parthasarathy@hpe.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "den@openvz.org" <den@openvz.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

> >> If we want to actually host enforce (disallow) access to inflated
> >> pages, having
> >
> > Is that a new feature?
>=20
> Still in the design phase. Andrea Arcangeli briefly mentioned in in his r=
eply to
> v5 of your patch series
>=20
> "We also plan to use userfaultfd to make the balloon driver host enforced
> (will work fine on hugetlbfs 2M and tmpfs too) but that's going to be inv=
isible
> to the ABI so it's not strictly relevant for this discussion."
>=20

Looking forward to see more details. Is there any thread about the design?

Thanks!

Liang

> >
> >> such a bitmap in QEMU is required. Getting them from the guest
> >> doesn't make sense in that context anymore.
> >
> > Even a bitmap is required, we should avoid to send it in the stop & cop=
y
> stage.
>=20
> yes, I agree.
>=20
> Thanks!
