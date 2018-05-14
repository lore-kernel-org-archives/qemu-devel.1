Received: from eggs.gnu.org ([2001:4830:134:3::10]:46290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fI6UO-00028O-5g
	for qemu-devel@nongnu.org; Mon, 14 May 2018 01:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fI5ww-00072j-Q3
	for qemu-devel@nongnu.org; Mon, 14 May 2018 01:23:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:16658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fI5ww-0006y4-Hc
	for qemu-devel@nongnu.org; Mon, 14 May 2018 01:23:06 -0400
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Date: Mon, 14 May 2018 05:22:58 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D35269DDFB@SHSMSX103.ccr.corp.intel.com>
References: <1525854989-14165-1-git-send-email-jingqi.liu@intel.com>
	<20180511143300.GL25013@localhost.localdomain>
In-Reply-To: <20180511143300.GL25013@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v1 4/7] numa: Classify the numa nodes as
 memory initiators and memory targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Friday, May 11, 2018 10:33 PM
> To: Liu, Jingqi <jingqi.liu@intel.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; mst@redhat.com;
> imammedo@redhat.com; marcel.apfelbaum@gmail.com; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH v1 4/7] numa: Classify the numa nodes as memory initi=
ators
> and memory targets
>=20
> On Wed, May 09, 2018 at 04:36:29PM +0800, Liu Jingqi wrote:
> > An initiator proximity domain (memory initiator) is any device such as
> > a CPU or a separate memory I/O device that can initiate a memory
> > request. A target proximity domain (memory target) is a CPU-accessible
> > physical address range.
> >
> [...]
> > +    if (node->cpus) {
> > +        initiator_pxm[num_initiator++] =3D nodenr;
> > +    }
> [...]
> > +        target_pxm[num_target++] =3D nodenr;
>=20
> I suggest NumaNode::is_initiator and NumaNode::is_target boolean fields
> instead of a separate global table.
>=20
> Or numa.c could simply provide
>   bool numa_node_is_initiator(int node) and
>   bool numa_node_is_target(int node)
> helpers.
>=20
> --
> Eduardo

Hi Eduardo,=20
Thanks for your reviewing. It's a good suggestion. I will improve in the ne=
xt version.
Jingqi
