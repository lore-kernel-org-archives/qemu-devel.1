Received: from eggs.gnu.org ([2001:4830:134:3::10]:49775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJXkX-0005FT-4W
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 22:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJXkS-0003FE-JX
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 22:39:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cJXkS-0003Es-Db
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 22:39:24 -0500
Date: Wed, 21 Dec 2016 11:39:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161221033915.GE22006@pxdev.xzpeter.org>
References: <1482158486-18597-1-git-send-email-peterx@redhat.com>
	<148227827741.76.7554914085415662156@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148227827741.76.7554914085415662156@790289a7ca88>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: allow dynamic switch of IOMMU
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com, david@gibson.dropbear.id.au

On Tue, Dec 20, 2016 at 03:57:59PM -0800, no-reply@patchew.org wrote:

[...]

> /tmp/qemu-test/src/hw/i386/intel_iommu.c: In function =E2=80=98vtd_swit=
ch_address_space=E2=80=99:
> /tmp/qemu-test/src/hw/i386/intel_iommu.c:1196: warning: implicit declar=
ation of function =E2=80=98trace_vtd_switch_address_space=E2=80=99
> /tmp/qemu-test/src/hw/i386/intel_iommu.c:1196: warning: nested extern d=
eclaration of =E2=80=98trace_vtd_switch_address_space=E2=80=99
> /tmp/qemu-test/src/hw/i386/intel_iommu.c: In function =E2=80=98vtd_find=
_add_as=E2=80=99:
> /tmp/qemu-test/src/hw/i386/intel_iommu.c:2412: error: =E2=80=98name=E2=80=
=99 undeclared (first use in this function)
> /tmp/qemu-test/src/hw/i386/intel_iommu.c:2412: error: (Each undeclared =
identifier is reported only once
> /tmp/qemu-test/src/hw/i386/intel_iommu.c:2412: error: for each function=
 it appears in.)

I believe I have got something missing for the rebase on the
trace-event file... Will repost a cleaner v2 with existing comments.

-- peterx
