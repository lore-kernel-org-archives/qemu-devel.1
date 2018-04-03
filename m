Received: from eggs.gnu.org ([2001:4830:134:3::10]:52942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3NP5-0007Wd-9Y
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3NOz-0007JI-Ei
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:59:19 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3NOz-0007J8-8x
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:59:13 -0400
Received: by mail-oi0-x241.google.com with SMTP id c3-v6so16249080oib.5
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 07:59:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522368777-32742-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522368777-32742-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Apr 2018 15:58:52 +0100
Message-ID: <CAFEAcA_adR5vAKO7=Bt2CE8Hu6Dh==uNf-JOvEbG76ZdSqiX6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/4] Merge tpm 2018/03/29 v1
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

On 30 March 2018 at 01:12, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> The following patches fix the handling of some more flags of the TPM CRB
> interface and extend the existing TPM CRB test program with tests of more
> flags.
>
>     Stefan
>
> The following changes since commit 043289bef4d9c0d277c45695c676a6cc9fca48a0:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180328' into staging (2018-03-28 13:30:10 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-03-29-1
>
> for you to fetch changes up to 4d0d1c077e5622da95fd0f6a8e7efb72e0f222b4:
>
>   tests: Tests more flags of the CRB interface (2018-03-29 17:41:03 -0400)
>
> ----------------------------------------------------------------
> Stefan Berger (4):
>       tpm: CRB: set the Idle flag by default
>       tpm: CRB: Reset Granted flag when relinquishing locality
>       tpm: CRB: Enforce locality is requested before processing buffer
>       tests: Tests more flags of the CRB interface
>
>  hw/tpm/tpm_crb.c     | 18 +++++++++++++++++-
>  tests/tpm-crb-test.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 89 insertions(+), 3 deletions(-)
>

Applied, thanks.

-- PMM
