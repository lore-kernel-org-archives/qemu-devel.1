Received: from eggs.gnu.org ([2001:4830:134:3::10]:38323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez04V-0006JT-Vp
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez04V-0002Nq-20
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:15:59 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ez04U-0002NE-S7
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:15:58 -0400
Received: by mail-oi0-x244.google.com with SMTP id u141-v6so7285626oif.1
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 06:15:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521634071-16519-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1521634071-16519-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 13:15:37 +0000
Message-ID: <CAFEAcA-AAB1YB40+oG=PjnVAdFzCpfaYgraw76RUatvHvFGX8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/4] Merge tpm 2018/03/21
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

On 21 March 2018 at 12:07, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> This series of patches fixes the initialization and setting of a few
> flags of the TPM CRB interface.
>
> The following changes since commit f1a63fcfcd92c88be8942b5ae71aef9749a4f135:
>
>   Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-03-21-1
>
> for you to fetch changes up to ffbf24bdb223914d5805fef15bfe9c4489868fad:
>
>   tpm: CRB: query backend for TPM established flag (2018-03-21 08:01:03 -0400)
>
> ----------------------------------------------------------------
> Stefan Berger (4):
>       tpm: CRB: Set tpmRegValidSts flag to '1' in device reset
>       tpm: CRB: set registers to 0 by default
>       tpm: CRB: reset locAssigned upon relinquishing locality
>       tpm: CRB: query backend for TPM established flag
>
>  hw/tpm/tpm_crb.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
