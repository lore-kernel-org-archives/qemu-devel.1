Received: from eggs.gnu.org ([2001:4830:134:3::10]:46773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gaOOd-0006r8-IQ
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 12:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gaOOa-00031Z-D6
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 12:15:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gaOOa-00031I-7N
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 12:15:32 -0500
Date: Fri, 21 Dec 2018 12:15:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181221120657-mutt-send-email-mst@kernel.org>
References: <20181218074104-mutt-send-email-mst@kernel.org>
	<20181218134540.2q43v6fpvzbsam6h@linux.intel.com>
	<20181218094527-mutt-send-email-mst@kernel.org>
	<20181219034006.d4drqoz5b6r6h3mn@linux.intel.com>
	<20181218233451-mutt-send-email-mst@kernel.org>
	<20181219055743.okeszdqlqkg7tagk@linux.intel.com>
	<20181219100355-mutt-send-email-mst@kernel.org>
	<20181220054921.sk5wnmlo2vvjgcs6@linux.intel.com>
	<20181220132644-mutt-send-email-mst@kernel.org>
	<20181221161920.45fnlmcp7aqu6ibi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181221161920.45fnlmcp7aqu6ibi@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] intel-iommu: extend VTD emulation
 to allow 57-bit IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Sat, Dec 22, 2018 at 12:19:20AM +0800, Yu Zhang wrote:
> > I'd like to avoid poking at the CPU from VTD code. That's all.
>=20
> OK. So for the short term=EF=BC=8Chow about I remove the check of host =
cpu, and add a TODO
> in the comments in vtd_decide_config()?=20

My question would be what happens on an incorrect use?
And how does user figure out which values to set?

> As to the check against hardware IOMMU, Peter once had a proposal in
> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg02281.html
>=20
> Do you have any comment or suggestion on Peter's proposal?

Sounds reasonable to me. Do we do it on vfio attach or unconditionally?


> I still do not quite know
> how to do it for now...
>=20
> [...]
>=20
>=20
> B.R.
> Yu



--=20
MST
