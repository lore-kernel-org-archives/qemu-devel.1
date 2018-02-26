Received: from eggs.gnu.org ([2001:4830:134:3::10]:48157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqHxp-0002en-LC
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqHxo-00022A-TC
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:33:05 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:36215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqHxo-00021z-NU
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:33:04 -0500
Received: by mail-ot0-x235.google.com with SMTP id 108so7311259otv.3
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 04:33:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180226120344.GN14196@redhat.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
	<20180223101032.GA31076@redhat.com>
	<CAHNT7NvMMAD6sAT60RnLgFXwdFPWHEXtysMQt04Qejnpw30Bkg@mail.gmail.com>
	<20180226104723.GH14196@redhat.com>
	<CAFEAcA_Gwh3EpVVhZ_zU3LuogZXjh8cpRWrvtHbNdfgQmdzgJg@mail.gmail.com>
	<20180226120344.GN14196@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2018 12:32:43 +0000
Message-ID: <CAFEAcA8kj_anJKOccobs25+dcENQ1Oc0DhiFFbb4A=wuJnk8UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 26 February 2018 at 12:03, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> Eeek, I totally missed that as the top level LICENSE file only mentions
> GPL and BSD licenses :-(  I guess that's a trigger for a patch to improve
> the text in the LICENSE file to better reflect reality...

Paragraph (2) says "Parts of QEMU have specific licenses which are
compatible with the GNU General Public License, version 2", which
is what this is. Paragraph (3) isn't saying "BSD license is special",
it's saying "the TCG codegen code is special" -- it's a theoretically
well-defined reusable subset of code that has its own tighter standards
for what license we accept (see also tcg/LICENSE).

thanks
-- PMM
