Received: from eggs.gnu.org ([2001:4830:134:3::10]:38388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euhj7-000785-PN
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 11:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euhj6-0004eW-PT
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 11:52:09 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:36238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euhj6-0004eF-Kh
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 11:52:08 -0500
Received: by mail-ot0-x234.google.com with SMTP id 108so11543494otv.3
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 08:52:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NsbNYtRtug9=gv1tPg7_XLs4b=BwK+95_3zpvy5yTVriw@mail.gmail.com>
References: <1520627374-93719-1-git-send-email-mjc@sifive.com>
	<CAHNT7NsbNYtRtug9=gv1tPg7_XLs4b=BwK+95_3zpvy5yTVriw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 10 Mar 2018 16:51:46 +0000
Message-ID: <CAFEAcA9b+uwdrnTK1-3qRLps3GsJR2Yx-xvuhMFuzn2DwicyNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V: Fix riscv_isa_string g_new0 size
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, RISC-V Patches <patches@groups.riscv.org>

On 9 March 2018 at 20:54, Michael Clark <mjc@sifive.com> wrote:
> Apologies for jumping the gun again with a PR before a review. It was most
> likely because I thought it was a critical bug fix.
>
> I'm incorporating Eric Blake's feedback.

For one-off "this is a build fix" bugfix patches, the simplest
thing is just to cc me on them and note (either in the commit
message or after the '---' separator) that it's a build fix.
Then I can just apply them directly to master once they've
been reviewed.

thanks
-- PMM
