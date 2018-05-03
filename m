Received: from eggs.gnu.org ([2001:4830:134:3::10]:33455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fE71W-0002j5-US
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fE71T-000079-Pm
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:43:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:44870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fE71T-00006Z-HX
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:43:19 -0400
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Date: Thu, 3 May 2018 05:42:28 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D352697E78@SHSMSX103.ccr.corp.intel.com>
References: <1525406253-54846-1-git-send-email-jingqi.liu@intel.com>
	<20180503030457.GB25013@localhost.localdomain>
In-Reply-To: <20180503030457.GB25013@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] x86/cpu: Enable CLDEMOTE(Demote Cache
 Line) cpu feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

Yes.  The corresponding patch in KVM refers to the following link:
https://www.spinics.net/lists/kernel/msg2792864.html
Thanks.

-----Original Message-----
From: Eduardo Habkost [mailto:ehabkost@redhat.com]=20
Sent: Thursday, May 3, 2018 11:05 AM
To: Liu, Jingqi <jingqi.liu@intel.com>
Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; rth@twiddle.net
Subject: Re: [PATCH] x86/cpu: Enable CLDEMOTE(Demote Cache Line) cpu featur=
e

On Fri, May 04, 2018 at 11:57:33AM +0800, Jingqi Liu wrote:
> The CLDEMOTE instruction hints to hardware that the cache line that=20
> contains the linear address should be moved("demoted") from the=20
> cache(s) closest to the processor core to a level more distant from=20
> the processor core. This may accelerate subsequent accesses to the=20
> line by other cores in the same coherence domain, especially if the=20
> line was written by the core that demotes the line.
>=20
> Intel Snow Ridge has added new cpu feature, CLDEMOTE.
> The new cpu feature needs to be exposed to guest VM.
>=20
> The bit definition:
> CPUID.(EAX=3D7,ECX=3D0):ECX[bit 25] CLDEMOTE
>=20
> The release document ref below link:
> https://software.intel.com/sites/default/files/managed/c5/15/\
> architecture-instruction-set-extensions-programming-reference.pdf
>=20
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>

Thanks.  Do you have a pointer to the corresponding GET_SUPPORTED_CPUID pat=
ch in KVM?

--
Eduardo
