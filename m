Received: from eggs.gnu.org ([2001:4830:134:3::10]:47616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eDD2f-0006lG-Pd
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eDD2f-0003lu-1V
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:24:33 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:55476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eDD2e-0003lC-RU
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:24:32 -0500
Received: by mail-wr0-x244.google.com with SMTP id l8so9182287wre.12
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:24:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171108133612.16471-1-berrange@redhat.com>
References: <20171108133612.16471-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Nov 2017 17:24:11 +0000
Message-ID: <CAFEAcA8M4_f=5vz+iM1F5kuWBEbkpFav-LoCpk4LAo5=M8oqEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/2] Merge qcrypto 2017/11/8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 November 2017 at 13:36, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:
>
>   Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qcrypto-2017-11-08-1
>
> for you to fetch changes up to f1710638edb2e98008c2a733ffda63ef32b50411:
>
>   crypto: afalg: fix a NULL pointer dereference (2017-11-08 11:05:09 +0000)
>
> ----------------------------------------------------------------
> Merge qcrypto 2017/11/08 v1
>
> ----------------------------------------------------------------
> Longpeng (1):
>   crypto: afalg: fix a NULL pointer dereference
>
> Thomas Huth (1):
>   tests: Run the luks tests in test-crypto-block only if encryption is
>     available
>
>  crypto/cipher.c           |  5 +----
>  crypto/hash.c             | 13 +++++--------
>  crypto/hmac.c             |  4 +---
>  tests/test-crypto-block.c |  3 ++-
>  4 files changed, 9 insertions(+), 16 deletions(-)
>

Applied, thanks.

-- PMM
