Received: from eggs.gnu.org ([2001:4830:134:3::10]:33205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1camOe-0007oJ-Pg
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1camOe-0001sg-3N
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:44:08 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1camOd-0001sG-SQ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:44:08 -0500
Received: by mail-wm0-x229.google.com with SMTP id c85so128210083wmi.1
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 08:44:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170206153113.27729-23-alex.bennee@linaro.org>
References: <20170206153113.27729-1-alex.bennee@linaro.org>
	<20170206153113.27729-23-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Feb 2017 16:43:46 +0000
Message-ID: <CAFEAcA87KWmWZa6PHis8MzBWobdGdUiChiNH9856ogHkinN6Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 22/23] target-arm: ensure all cross
 vCPUs TLB flushes complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 6 February 2017 at 15:31, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Previously flushes on other vCPUs would only get serviced when they
> exited their TranslationBlocks. While this isn't overly problematic it
> violates the semantics of TLB flush from the point of view of source
> vCPU.
>
> To solve this we call the cputlb *_all_cpus_synced() functions to do
> the flushes which ensures all flushes are completed by the time the
> vCPU next schedules its own work. As the TLB instructions are modelled
> as CP writes the TB ends at this point meaning cpu->exit_request will
> be checked before the next instruction is executed.
>
> Deferring the work until the architectural sync point is a possible
> future optimisation.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
