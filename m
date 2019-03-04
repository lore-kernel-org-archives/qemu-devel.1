Received: from eggs.gnu.org ([209.51.188.92]:51279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qhB-0000wF-Ka
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qhA-0007iw-Rc
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:44:05 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0qhA-0007gs-Le
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:44:04 -0500
Received: by mail-oi1-x243.google.com with SMTP id i8so4341904oib.10
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 08:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20190304154739.758486-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20190304154739.758486-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2019 16:43:51 +0000
Message-ID: <CAFEAcA98oP70F9xDKwr8_9w4ATOmZvzbDuYHZF8MLH0paRHPyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/2] Merge tpm 2019/02/25 v1
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

On Mon, 4 Mar 2019 at 15:47, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> The 1st patch in this series fixes a bug in the TPM TIS emulator that
> skipped a locality when resetting the seize flag when a higher locality
> seized access from a lower locality. The 2nd patch converts debugging
> code to tracing.
>
>    Stefan
>
>
> The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190221.0' into staging (2019-02-22 15:48:04 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2019-02-25-1
>
> for you to fetch changes up to cd38cc519b60bbe5dd8d85f6aaa72b2d7902930b:
>
>   tpm_tis: convert tpm_tis_show_buffer() to use trace event (2019-02-24 14:46:14 -0500)
>
> ----------------------------------------------------------------
> Liam Merwick (2):
>       tpm_tis: fix loop that cancels any seizure by a lower locality
>       tpm_tis: convert tpm_tis_show_buffer() to use trace event

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
