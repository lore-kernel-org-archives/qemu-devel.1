Received: from eggs.gnu.org ([2001:4830:134:3::10]:50518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUCrA-00009Y-B2
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUCr9-00034G-9P
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:43:28 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:37998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUCr9-00033b-1l
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:43:27 -0500
Received: by mail-oi1-x230.google.com with SMTP id a77so14606556oii.5
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 07:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20181204153447.2462189-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20181204153447.2462189-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 15:43:14 +0000
Message-ID: <CAFEAcA-072D9uYgFAS-mSC+uFrybFZR_DeoDHYaFMM8njmBuVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Merge tpm 2018/12/04 v1
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

On Tue, 4 Dec 2018 at 15:34, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
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

Hi -- can you provide a justification for why this is rc4 material,
please? This wasn't on the list of "things that maybe or must go
into rc4", and the commit messages and pull request cover letter
don't suggest that there's anything particularly urgent here
that couldn't wait for 4.0.

thanks
-- PMM
