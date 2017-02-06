Received: from eggs.gnu.org ([2001:4830:134:3::10]:41372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1caod1-0004y7-MC
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1caod0-0002Vw-Gf
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:07:07 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1caod0-0002Vn-C4
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:07:06 -0500
Received: by mail-ot0-x244.google.com with SMTP id f9so11484103otd.0
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 11:07:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170206153113.27729-1-alex.bennee@linaro.org>
References: <20170206153113.27729-1-alex.bennee@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 6 Feb 2017 14:06:35 -0500
Message-ID: <CAJhHMCCHhZ6JnH=NaZ=htb259pCCp4ooHixuj-UxWywF0ug8mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, MTTCG Devel <mttcg@listserver.greensocs.com>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, nikunj@linux.vnet.ibm.com, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Sergey Fedorov <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>

Hi Alex,

On Mon, Feb 6, 2017 at 10:30 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> Hi Richard/Peter,
>
> This is a mostly ARM focused update to last weeks v9.
>
> It has necessitated one change to the cputlb API. It was pointed out
> that translators often have to special case a bunch of things if you
> longjmp() out of a helper. As a result the cputlb _synched() calls are
> no longer QEMU_NORETURN but do document the importance of the guest to
> exit the block as soon as synchronisation is required. In ARM's case
> this is already done as the TLB flushes are treated as CP write
> operation which ends the block by default. This means I was able to
> drop the two patches that dealt with ARM_CP_PC, simplifying the code.
>
> The other moderate change was fixing up target-arm/powerctl to
> properly model the ON_PENDING powerstate which is key to vCPUs
> handling otherwise race-prone start-up sequences. The power off and
> reset methods where also updated to update the CPUState structures in
> the targets context.
>
> Otherwise there is the usual array of review tags and a few minor
> fixes documented as normal bellow the --- line.
>
> A version of the tree can be found at:
>
>   https://github.com/stsquad/qemu/tree/mttcg/base-patches-v10
>

I've sent my Reviewed-by/tested-by for v9 but those seem to be lost.
I've tested v10 too.

So please add my tested and reviewed tags:

Tested-and-Reviewed-by: Pranith Kumar <bobby.prani@gmail.com>

Thanks,
--=20
Pranith
