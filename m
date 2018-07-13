Received: from eggs.gnu.org ([2001:4830:134:3::10]:39370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1fdzRS-0002AO-NR
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1fdzRO-0006iU-NJ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:53:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1fdzRO-0006i7-Bx
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:53:02 -0400
Date: Fri, 13 Jul 2018 10:52:54 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20180713145254.GA1374@char.US.ORACLE.com>
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
	<830fab17-5ddf-fdcc-266c-27d40529b859@oracle.com>
	<29327ae2-9331-07a4-2345-4fa4b74a62db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <29327ae2-9331-07a4-2345-4fa4b74a62db@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/5] i386: Add support for IA32_PRED_CMD
 and IA32_ARCH_CAPABILITIES MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com, robert.hu@intel.com

On Fri, Jul 13, 2018 at 04:44:49PM +0200, Paolo Bonzini wrote:
> On 13/07/2018 16:11, konrad.wilk@oracle.com wrote:
> > (Apologies if this comes out as HTML, using Thunderbird instead of mu=
tt
> > here)..
> >=20
> >> +=A0=A0=A0 uint64_t pred_cmd;
> >> +=A0=A0=A0 uint64_t arch_capabilities;
> >=20
> > Could this be 'arch_cap' ?
> >=20
>=20
> Why?  Intel chose a verbose name, we should not abbrev. it unnecessaril=
y. :)

Oh you are right. Gosh, so many more characters to type :-(
>=20
> Paolo
