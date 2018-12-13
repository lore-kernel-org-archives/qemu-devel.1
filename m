Received: from eggs.gnu.org ([2001:4830:134:3::10]:48806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXPFG-0006w9-82
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXPFF-00085w-GE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:33:34 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:46556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXPFF-00081M-AT
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:33:33 -0500
Received: by mail-oi1-x22d.google.com with SMTP id x202so1319062oif.13
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 03:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20181211205654.3550341-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20181211205654.3550341-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 11:33:21 +0000
Message-ID: <CAFEAcA-Ao54gvA631bcOrMAK2s0x+PtpE6M5MQ1AFpAz-g8PdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/3] Merge tpm 2018/12/04 v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 11 Dec 2018 at 20:57, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> This series of patches removes an unnecessary parameter from tpm_tis_abort()
> and adds a locality range check (using assert()) to tpm_tis_prep_abort() and
> tpm_tis_request_completed().
>
>    Stefan
>
> The following changes since commit 83ea23cd207a03c5736be0231acbf7f8b05dbf52:
>
>   i386: hvf: Fix overrun of _decode_tbl1 (2018-12-03 15:09:55 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-12-04-1
>
> for you to fetch changes up to a639f96111eadb3b8e3021fd3f27e2948ad1c640:
>
>   tpm: Make sure the locality received from backend is valid (2018-12-04 10:21:25 -0500)
>
> ----------------------------------------------------------------
> Stefan Berger (3):
>       tpm: Remove unused locty parameter from tpm_tis_abort()
>       tpm: Make sure new locality passed to tpm_tis_prep_abort() is valid
>       tpm: Make sure the locality received from backend is valid
>

Applied, thanks.

-- PMM
