Received: from eggs.gnu.org ([2001:4830:134:3::10]:52892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cjlE1-0003KP-I4
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cjlDx-0007Fv-5v
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:18:17 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:7412)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cjlDw-0007Fl-VF
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:18:13 -0500
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-10-alex.bennee@linaro.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <5a5bfbf9-4935-7b21-ce93-77887581642b@imgtec.com>
Date: Fri, 3 Mar 2017 11:18:05 +0000
MIME-Version: 1.0
In-Reply-To: <20170302195337.31558-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/11] target/mips/op_helper: hold BQL
 before calling cpu_mips_get_count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Aurelien Jarno <aurelien@aurel32.net>



On 02/03/2017 19:53, Alex Benn=C3=A9e wrote:
> We should hold the BQL before we transition to HW emulation. This is
> because all HW emulation needs to be serialised under MTTCG
> conditions. This is picked up by asserts that fire when
> cpu_mips_get_count triggers and IRQ.
>=20
> Reported-by: Yongbok Kim <yongbok.kim@imgtec.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Hi Alex,

Thanks for this but it is required to have few more locks.
I will send the patch shortly. Please merge it into your patchset.

Regards,
Yongbok
