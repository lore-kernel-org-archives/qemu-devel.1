Received: from eggs.gnu.org ([2001:4830:134:3::10]:49110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOgig-0001XF-MA
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOgie-00031J-Or
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:23:54 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gOgid-00030U-5R
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:23:51 -0500
Received: by mail-ot1-x343.google.com with SMTP id k98so27154082otk.3
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 02:23:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181116213045.19825-1-palmer@sifive.com>
References: <20181116213045.19825-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 10:23:29 +0000
Message-ID: <CAFEAcA8BZmJnmeQTnorKnscZKQQd2EXvRJZ2Xa_LCShEvQ04hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V Patches for 3.1-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On 16 November 2018 at 21:30, Palmer Dabbelt <palmer@sifive.com> wrote:
> The following changes since commit cb968d275c145467c8b385a3618a207ec111eab1:
>
>   Update version for v3.1.0-rc1 release (2018-11-13 18:16:14 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/riscv/riscv-qemu.git tags/riscv-for-master-3.1-rc2
>
> for you to fetch changes up to 3502dc824a7b0218abb49f4350e80a49829748cf:
>
>   RISC-V: Respect fences for user-only emulators (2018-11-13 15:12:15 -0800)
>
> ----------------------------------------------------------------
> RISC-V Patches for 3.1-rc2
>
> This pull request contains four patches that aren't really related to
> each other aside from all being bug fixes that I think should go in for
> 3.1.0:
>
> * The second half of Alistair's memory leak patch set that I missed last
>   week.
> * A fix to make fclass.d availiable only on RV64IFD systems (without
>   this it's availiable on RV32IFD systems, truncating the result).
> * A fix to make sfence.vm availiable only in priv-1.9.1, and sfence.vma
>   only availiable in priv-1.10.
> * A change to respect fences in user-mode emulators, which were
>   previously treated as NOPs.
>
> As usual, this builds and boot Linux for me.  I don't think I have
> anything else planned for 3.1.0, but I may be wrong as things are a bit
> hectic this week.
>

Applied, thanks.

-- PMM
