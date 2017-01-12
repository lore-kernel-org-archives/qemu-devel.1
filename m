Received: from eggs.gnu.org ([2001:4830:134:3::10]:52604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRibT-0005uE-EV
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRibO-0004y4-VX
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:51:55 -0500
Date: Thu, 12 Jan 2017 14:51:36 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112165136.GB27893@thinpad.lan.raisama.net>
References: <20170112154731.1028-1-alex.bennee@linaro.org>
	<20170112154731.1028-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170112154731.1028-2-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qom/cpu: move tlb_flush to
 cpu_common_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: rth@twiddle.net, Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Aurelien Jarno <aurelien@aurel32.net>, Jia Liu <proljc@gmail.com>

On Thu, Jan 12, 2017 at 03:47:29PM +0000, Alex Benn=E9e wrote:
> It is a common thing amongst the various cpu reset functions want to
> flush the SoftMMU's TLB entries. This is done either by calling
> tlb_flush directly or by way of a general memset of the CPU
> structure (sometimes both).
>=20
> This moves the tlb_flush call to the common reset function and
> additionally ensures it is only done for the CONFIG_SOFTMMU case and
> when tcg is enabled.
>=20
> In some target cases we add an empty end_of_reset_fields structure to t=
he
> target vCPU structure so have a clear end point for any memset which
> is resetting value in the structure before CPU_COMMON (where the TLB
> structures are).
>=20
> While this is a nice clean-up in general it is also a precursor for
> changes coming to cputlb for MTTCG where the clearing of entries
> can't be done arbitrarily across vCPUs. Currently the cpu_reset
> function is usually called from the context of another vCPU as the
> architectural power up sequence is run. By using the cputlb API
> functions we can ensure the right behaviour in the future.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

For i386:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
