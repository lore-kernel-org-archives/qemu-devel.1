Received: from eggs.gnu.org ([2001:4830:134:3::10]:51360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cjmpX-0005L6-LD
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cjmpP-0002dK-3t
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:01:03 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:23109)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cjmpO-0002bq-MA
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:00:58 -0500
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-10-alex.bennee@linaro.org>
	<5a5bfbf9-4935-7b21-ce93-77887581642b@imgtec.com>
	<87o9xi1px9.fsf@linaro.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <0e41c5e6-b8b2-3d83-79c9-873f1a7c96bd@imgtec.com>
Date: Fri, 3 Mar 2017 13:00:49 +0000
MIME-Version: 1.0
In-Reply-To: <87o9xi1px9.fsf@linaro.org>
Content-Type: text/plain; charset="windows-1252"
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Aurelien Jarno <aurelien@aurel32.net>



On 03/03/2017 12:54, Alex Benn=E9e wrote:
>=20
> Yongbok Kim <yongbok.kim@imgtec.com> writes:
>=20
>> On 02/03/2017 19:53, Alex Benn=E9e wrote:
>>> We should hold the BQL before we transition to HW emulation. This is
>>> because all HW emulation needs to be serialised under MTTCG
>>> conditions. This is picked up by asserts that fire when
>>> cpu_mips_get_count triggers and IRQ.
>>>
>>> Reported-by: Yongbok Kim <yongbok.kim@imgtec.com>
>>> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>>
>> Hi Alex,
>>
>> Thanks for this but it is required to have few more locks.
>> I will send the patch shortly. Please merge it into your patchset.
>=20
> Thanks, I'll look out for it.
>=20
> Have you been tracking the MTTCG work? Once the BQL issues are sorted a=
s
> long as atomics, barriers and tlb flushes are updated you can turn on
> mttcg by default.
>=20
>=20

Yes I have MIPS patches for MTTCG but it has not been rebased to the late=
st
version yet. I will send it after 2.9.

Regards,
Yongbok
