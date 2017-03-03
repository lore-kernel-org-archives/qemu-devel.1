Received: from eggs.gnu.org ([2001:4830:134:3::10]:48894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjmj8-0000cD-C6
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjmj3-0000be-Np
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:54:30 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:34149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjmj3-0000bY-HI
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:54:25 -0500
Received: by mail-wm0-x22c.google.com with SMTP id 196so8010290wmm.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 04:54:25 -0800 (PST)
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-10-alex.bennee@linaro.org>
	<5a5bfbf9-4935-7b21-ce93-77887581642b@imgtec.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <5a5bfbf9-4935-7b21-ce93-77887581642b@imgtec.com>
Date: Fri, 03 Mar 2017 12:54:26 +0000
Message-ID: <87o9xi1px9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Aurelien Jarno <aurelien@aurel32.net>


Yongbok Kim <yongbok.kim@imgtec.com> writes:

> On 02/03/2017 19:53, Alex Bennée wrote:
>> We should hold the BQL before we transition to HW emulation. This is
>> because all HW emulation needs to be serialised under MTTCG
>> conditions. This is picked up by asserts that fire when
>> cpu_mips_get_count triggers and IRQ.
>>
>> Reported-by: Yongbok Kim <yongbok.kim@imgtec.com>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>
> Hi Alex,
>
> Thanks for this but it is required to have few more locks.
> I will send the patch shortly. Please merge it into your patchset.

Thanks, I'll look out for it.

Have you been tracking the MTTCG work? Once the BQL issues are sorted as
long as atomics, barriers and tlb flushes are updated you can turn on
mttcg by default.

>
> Regards,
> Yongbok


--
Alex Bennée
