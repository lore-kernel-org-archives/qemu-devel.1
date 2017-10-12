Received: from eggs.gnu.org ([2001:4830:134:3::10]:37281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e2kA1-0003Dj-97
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e2k9y-0007QV-5U
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:32:53 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:46979)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e2k9x-0007PZ-QU
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:32:50 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20171010214540.30970-1-richard.henderson@linaro.org>
	<87k200sw7c.fsf@frigg.lan>
	<888cfe83-7c47-5673-7b1b-8280cc50d8ba@linaro.org>
Date: Thu, 12 Oct 2017 23:32:39 +0300
In-Reply-To: <888cfe83-7c47-5673-7b1b-8280cc50d8ba@linaro.org> (Richard
	Henderson's message of "Thu, 12 Oct 2017 07:45:30 -0700")
Message-ID: <87vajkgl94.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: Initialize cpu_env generically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

Richard Henderson writes:

> On 10/11/2017 11:43 PM, Llu=C3=ADs Vilanova wrote:
>>> /* Track which vCPU triggers events */
>>> CPUState *cpu;                      /* *_trans */
>>> -    TCGv_env tcg_env;                   /* *_exec  */
>>=20
>> I would rather keep it here instead of making a new global variable, sin=
ce that
>> should make it easier in the future to have multiple translation context=
s.

> Why do you believe this prevents it?  The variable is literally identical=
 for
> *all* targets.

If someone decides to make tcg_ctx thread-local or have one per target
architecture (supporting multiple target archs concurrently), having all th=
at
info on the tcg_ctx object is easier to track and modify, compared to having
multiple global variables.


> r~

> PS: Everyone, please trim context that you don't care about.  If you just=
 add
> two lines in the middle of 1000, I'll not always find it.

So true; I just went with the flow of the list, sorry.


Cheers,
  Lluis
