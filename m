Received: from eggs.gnu.org ([2001:4830:134:3::10]:37278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cb2gc-00085N-Iy
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cb2gY-00054u-KO
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:07:46 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cb2gY-00054i-E1
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:07:42 -0500
Received: by mail-wm0-x230.google.com with SMTP id r141so145486325wmg.1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 02:07:42 -0800 (PST)
References: <20170206153113.27729-1-alex.bennee@linaro.org>
	<CAJhHMCCHhZ6JnH=NaZ=htb259pCCp4ooHixuj-UxWywF0ug8mw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAJhHMCCHhZ6JnH=NaZ=htb259pCCp4ooHixuj-UxWywF0ug8mw@mail.gmail.com>
Date: Tue, 07 Feb 2017 10:07:44 +0000
Message-ID: <878tpixqj3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v10 00/23] MTTCG Base enabling patches with
 ARM enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, MTTCG Devel <mttcg@listserver.greensocs.com>, qemu-devel <qemu-devel@nongnu.org>, KONRAD =?utf-8?B?RnLDqWTDqXJpYw==?= <fred.konrad@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, nikunj@linux.vnet.ibm.com, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Sergey Fedorov <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>


Pranith Kumar <bobby.prani@gmail.com> writes:

> Hi Alex,
>
> On Mon, Feb 6, 2017 at 10:30 AM, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Hi Richard/Peter,
>>
>> This is a mostly ARM focused update to last weeks v9.
>>
>> It has necessitated one change to the cputlb API. It was pointed out
>> that translators often have to special case a bunch of things if you
>> longjmp() out of a helper. As a result the cputlb _synched() calls are
>> no longer QEMU_NORETURN but do document the importance of the guest to
>> exit the block as soon as synchronisation is required. In ARM's case
>> this is already done as the TLB flushes are treated as CP write
>> operation which ends the block by default. This means I was able to
>> drop the two patches that dealt with ARM_CP_PC, simplifying the code.
>>
>> The other moderate change was fixing up target-arm/powerctl to
>> properly model the ON_PENDING powerstate which is key to vCPUs
>> handling otherwise race-prone start-up sequences. The power off and
>> reset methods where also updated to update the CPUState structures in
>> the targets context.
>>
>> Otherwise there is the usual array of review tags and a few minor
>> fixes documented as normal bellow the --- line.
>>
>> A version of the tree can be found at:
>>
>>   https://github.com/stsquad/qemu/tree/mttcg/base-patches-v10
>>
>
> I've sent my Reviewed-by/tested-by for v9 but those seem to be lost.
> I've tested v10 too.
>
> So please add my tested and reviewed tags:
>
> Tested-and-Reviewed-by: Pranith Kumar <bobby.prani@gmail.com>

Sorry I missed that as it was applied to the cover letter (everyone
keeps finding corner cases for my tooling ;-). I'll apply it to patch 23
where we default on.

>
> Thanks,


--
Alex Bennée
