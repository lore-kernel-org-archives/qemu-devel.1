Received: from eggs.gnu.org ([2001:4830:134:3::10]:58492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjred-0003gg-If
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrec-0006P1-Lu
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:10:11 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:34027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjrec-0006OM-Fb
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:10:10 -0500
Received: by mail-wm0-x233.google.com with SMTP id 196so9566409wmm.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 10:10:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170302195337.31558-12-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-12-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 18:09:48 +0000
Message-ID: <CAFEAcA_q7vr59B7Oz2pk8iWp6FtbP_9b7f2z9QsTBf9FE6fNQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/11] hw/intc/arm_gic: modernise the
 DPRINTF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, MTTCG Devel <mttcg@listserver.greensocs.com>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "open list:ARM cores" <qemu-arm@nongnu.org>

On 2 March 2017 at 19:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> While I was debugging the icount issues I realised a bunch of the
> messages look quite similar. I've fixed this by including __func__ in
> the debug print. At the same time I move the a modern if (GATE) style
> printf which ensures the compiler can check for format string errors
> even if the code gets optimised away in the non-DEBUG_GIC case.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
