Received: from eggs.gnu.org ([2001:4830:134:3::10]:58140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cayxj-0003tQ-Hb
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cayxg-0000Al-Bd
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:09:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cayxg-00009r-3j
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:09:08 -0500
Date: Tue, 7 Feb 2017 14:08:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170207060859.GU5151@pxdev.xzpeter.org>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-8-git-send-email-peterx@redhat.com>
	<a743f890-9c55-1edc-e9a6-783bbd5a179b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a743f890-9c55-1edc-e9a6-783bbd5a179b@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 07/18] intel_iommu: fix trace for inv
 desc handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

On Tue, Feb 07, 2017 at 01:38:30PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B402=E6=9C=8803=E6=97=A5 16:22, Peter Xu wrote:
> >VT-d codes are still using static DEBUG_INTEL_IOMMU macro. That's not
> >good, and we should end the day when we need to recompile the code
> >before getting useful debugging information for vt-d. Time to switch t=
o
> >the trace system.
>=20
> Looks like we end up with using debug macros and tracepoints at the sam=
e
> time (even with patch 8), this will cause even more troubles.

I was converting debug macros into traces gradually rather than in a
single big patch. Those ones that were converted are possibly useful
for debugging of current series. I can do the rest of convertion in
another standalone patch after this series.

>=20
>=20
> >This is the first patch to do it.
> >
> >Generally, the rule of mine is:
> >
> >- for the old GENERAL typed message, I use trace_vtd_err*() in general=
.
> >
> >- for the non-GENERAL typed messages, convert into specified trace_*()=
.
> >
> >- for useless DPRINTFs, I removed them.
> >
> >Signed-off-by: Peter Xu<peterx@redhat.com>
> >---
>=20
> The title is a little bit confusing, this in fact convert from debug ma=
cros
> to tracepoints.

I'll find a better subject. Thanks,

-- peterx
