Received: from eggs.gnu.org ([2001:4830:134:3::10]:38712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1emLpY-0007EA-8h
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1emLpV-0001nz-4H
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:52:16 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1emLpV-0001nt-06
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:52:13 -0500
Received: by mail-qk0-f195.google.com with SMTP id i184so58037qkf.10
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 07:52:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518703835-10361-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1518703835-10361-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Thu, 15 Feb 2018 16:52:11 +0100
Message-ID: <CAMxuvazADP_A87y24=vQsVcrs+S0094VsqhwEEmqp2fNd1Gw7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Add tests for the TPM TIS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>

On Thu, Feb 15, 2018 at 3:10 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> This series of patches adds tests for the TPM TIS.
>
>    Stefan
>
> v1->v2:
>  - moved common TPM test code into tpm-emu.c
>  - clearified a few comments in tpm-tis-test.c, no code changes
>
> Stefan Berger (2):
>   tests: Move common TPM test code into tpm-emu.c
>   tests: add test for TPM TIS device

series:

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




>
>  MAINTAINERS            |   1 +
>  hw/tpm/tpm_tis.c       | 101 ----------
>  include/hw/acpi/tpm.h  | 105 +++++++++++
>  tests/Makefile.include |   4 +-
>  tests/tpm-crb-test.c   | 174 +-----------------
>  tests/tpm-emu.c        | 175 ++++++++++++++++++
>  tests/tpm-emu.h        |  38 ++++
>  tests/tpm-tis-test.c   | 486 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  8 files changed, 811 insertions(+), 273 deletions(-)
>  create mode 100644 tests/tpm-emu.c
>  create mode 100644 tests/tpm-emu.h
>  create mode 100644 tests/tpm-tis-test.c
>
> --
> 2.5.5
>
