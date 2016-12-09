Received: from eggs.gnu.org ([2001:4830:134:3::10]:33733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cFAQy-0001Ws-T5
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 20:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cFAQu-0008LG-2q
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 20:57:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cFAQt-0008L6-TS
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 20:57:08 -0500
Date: Fri, 9 Dec 2016 09:56:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161209015659.GG28693@pxdev.xzpeter.org>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
	<1481020588-4245-12-git-send-email-peterx@redhat.com>
	<f8541994-4a68-add3-6378-36dc9e37219f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8541994-4a68-add3-6378-36dc9e37219f@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 11/13] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, alex.williamson@redhat.com, jasowang@redhat.com

On Thu, Dec 08, 2016 at 11:01:53AM +0800, Lan Tianyu wrote:
> On 2016=E5=B9=B412=E6=9C=8806=E6=97=A5 18:36, Peter Xu wrote:
> > +/**
> > + * vtd_page_walk - walk specific IOVA range, and call the hook
> > + *
> > + * @ce: context entry to walk upon
> > + * @start: IOVA address to start the walk
> > + * @end: size of the IOVA range to walk over
>=20
>=20
> *=C2=B7@end:=C2=B7IOVA=C2=B7range=C2=B7end=C2=B7address=C2=B7(start=C2=B7=
<=3D=C2=B7addr=C2=B7<=C2=B7end)
> This comment for vtd_page_walk_level() maybe more accurate here?

You are right, thanks. :)

-- peterx
