Received: from eggs.gnu.org ([2001:4830:134:3::10]:39059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cemAp-0004hc-H5
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cemAo-0002qK-Mh
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:18:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170213121017.12907-22-alex.bennee@linaro.org>
References: <20170213121017.12907-1-alex.bennee@linaro.org>
	<20170213121017.12907-22-alex.bennee@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 17 Feb 2017 12:17:51 -0500
Message-ID: <CAJhHMCCcxJgtfC98ox69cNiaPwyKPNZ9pYcm1qz1+5MNcEx7AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 21/24] target-arm: don't generate
 WFE/YIELD calls for MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, MTTCG Devel <mttcg@listserver.greensocs.com>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, nikunj@linux.vnet.ibm.com, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Sergey Fedorov <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On Mon, Feb 13, 2017 at 7:10 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> The WFE and YIELD instructions are really only hints and in TCG's case
> they were useful to move the scheduling on from one vCPU to the next. In
> the parallel context (MTTCG) this just causes an unnecessary cpu_exit
> and contention of the BQL.
>

I think something similar needs to be done for 'pause' on x86.

--=20
Pranith
